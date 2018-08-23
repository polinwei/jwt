package com.spring.session;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.maxmind.geoip2.DatabaseReader;
import com.spring.jwt.authentication.security.JwtAuthorizationTokenFilter;
import com.spring.jwt.config.GeoConfig;




@RunWith(SpringRunner.class)
@ContextConfiguration(classes = GeoConfig.class)
public class SessionDetailsFilterTests {

	@Autowired
	DatabaseReader reader;

	JwtAuthorizationTokenFilter filter;

	@Before
	public void setup() {
		this.filter = new JwtAuthorizationTokenFilter(this.reader);
	}

	@Test
	public void getGeoLocationHanldesInvalidIp() {
		assertThat(this.filter.getGeoLocation("a"))
				.isEqualTo("Unknown");
	}

	@Test
	public void getGeoLocationNullCity() {
		assertThat(this.filter.getGeoLocation("22.231.113.64"))
				.isEqualTo("United States");
	}

	@Test
	public void getGeoLocationBoth() {
		assertThat(this.filter.getGeoLocation("184.154.83.119"))
				.isEqualTo("Chicago, United States");
	}
}
