package com.spring.jwt.authentication.security;

import java.io.IOException;
import java.net.InetAddress;
import java.util.Enumeration;
import java.util.Objects;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.model.CityResponse;

import io.jsonwebtoken.ExpiredJwtException;

public class JwtAuthorizationTokenFilter extends OncePerRequestFilter {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	static final String UNKNOWN = "Unknown";
    private UserDetailsService userDetailsService;
    private JwtTokenUtil jwtTokenUtil;
    private String tokenHeader;
	private DatabaseReader reader;

	@Autowired
	public JwtAuthorizationTokenFilter(DatabaseReader reader) {
		this.reader = reader;
	}
    
	public JwtAuthorizationTokenFilter(UserDetailsService userDetailsService, JwtTokenUtil jwtTokenUtil,
			String tokenHeader) {		
		this.userDetailsService = userDetailsService;
		this.jwtTokenUtil = jwtTokenUtil;
		this.tokenHeader = tokenHeader;
	}


	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
		logger.debug("processing authentication for '{}'", request.getRequestURL());
        String username = null;
        String authToken = null;
		HttpSession session = request.getSession(false);
		if (session != null) {
			String remoteAddr  = getRemoteAddress(request);
			String geoLocation = getGeoLocation(remoteAddr);

			SessionDetails details = new SessionDetails();
			details.setAccessType(request.getHeader("User-Agent"));
			details.setLocation(remoteAddr + " " + geoLocation);
			authToken = (String) session.getAttribute("jwtToken");
			session.setAttribute("SESSION_DETAILS", details);
		}
		
		
        //final String requestHeader = Objects.isNull(request.getHeader(this.tokenHeader)) ? request.getParameter("Authorization"): request.getHeader(this.tokenHeader) ;
		final String requestHeader = Objects.isNull(authToken)? request.getHeader(this.tokenHeader) : authToken;
		
        if (requestHeader != null && requestHeader.startsWith("Bearer ")) {
            authToken = requestHeader.substring(7);
            try {
                username = jwtTokenUtil.getUsernameFromToken(authToken);
            } catch (IllegalArgumentException e) {
                logger.error("an error occured during getting username from token", e);
            } catch (ExpiredJwtException e) {
                logger.warn("the token is expired and not valid anymore", e);
            }
        } else {
            logger.warn("couldn't find bearer string, will ignore the header");
        }

        logger.debug("checking authentication for user '{}'", username);
        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            logger.debug("security context was null, so authorizating user");

            // It is not compelling necessary to load the use details from the database. You could also store the information
            // in the token and read it from it. It's up to you ;)
            UserDetails userDetails = this.userDetailsService.loadUserByUsername(username);

            // For simple validation it is completely sufficient to just check the token integrity. You don't have to call
            // the database compellingly. Again it's up to you ;)
            if (jwtTokenUtil.validateToken(authToken, userDetails)) {
                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                logger.info("authorizated user '{}', setting security context", username);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        }

        filterChain.doFilter(request, response);

	}

	public String getGeoLocation(String remoteAddr) {
		String cityName = null;
		String countryName = null;
		
		try {
			if ( remoteAddr.equals("0:0:0:0:0:0:0:1") || remoteAddr.equals("127.0.0.1") ) {
				cityName = "localhost";
				countryName = "localhost";
			} else {
				CityResponse city = this.reader.city(InetAddress.getByName(remoteAddr));
				cityName = city.getCity().getName();
				countryName = city.getCountry().getName();
				if (cityName == null && countryName == null) {
					return null;
				}
				else if (cityName == null) {
					return countryName;
				}
				else if (countryName == null) {
					return cityName;
				}
			}

			return cityName + ", " + countryName;
		}
		catch (Exception ex) {
			return UNKNOWN;

		}
	}

	private String getRemoteAddress(HttpServletRequest request) {
		String remoteAddr = request.getHeader("X-FORWARDED-FOR");
		if (remoteAddr == null) {
			remoteAddr = request.getRemoteAddr();
		}
		else if (remoteAddr.contains(",")) {
			remoteAddr = remoteAddr.split(",")[0];
		}
		return remoteAddr;
	}	
	
	
}
