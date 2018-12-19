package com.spring.jwt.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ldap.core.AttributesMapper;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.query.LdapQuery;
import org.springframework.ldap.query.SearchScope;
import org.springframework.ldap.support.LdapUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.spring.jwt.model.ADUser;

import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;

import java.util.ArrayList;
import java.util.List;
import static org.springframework.ldap.query.LdapQueryBuilder.query;

@Service
public class ADService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
    private LdapTemplate ldapTemplate;
	
	@Value("${ldap.domainName}")
    private String ldapDomainName;

    public List<String> getAllObjectNames() {
        return ldapTemplate.search(
                query().where("objectclass").is("person"),
                new AttributesMapper<String>() {
                    public String mapFromAttributes(Attributes attrs)
                            throws NamingException {
                        return (String) attrs.get("cn").get();
                    }
                });
    }
    
    public ADUser findByUsername(String username, String password) throws NamingException {

		ADUser adUser = new ADUser();
		if (authenticate(username, password)) {
			// 如果驗證成功根據sAMAccountName屬性查詢用戶名和使用者所屬的群組
			adUser = ldapTemplate.search(query().where("objectclass").is("person").and("sAMAccountName").is(username),
					new ADUserAttributesMapper()).get(0);
		}
		return adUser;
     }    
    
	public List<ADUser> findByAttribute(String username, String password, String attributeName, String attributeValue) {
		List<ADUser> adUsers = new ArrayList<>();

		if (authenticate(username, password)) {
			LdapQuery query = query().searchScope(SearchScope.SUBTREE).timeLimit(3000).where("objectclass").is("person")
					.and(attributeName).is(attributeValue);

			adUsers = ldapTemplate.search(query, new ADUserAttributesMapper());
		}

		return adUsers;
	}
    
	public boolean authenticate(String username, String password) {
		boolean isAuthenticated = false;
		DirContext ctx = null;
		try {
			// userDn格式：username@domainName.com
			String userDn = username + ldapDomainName;
			// 驗證用戶
			ctx = ldapTemplate.getContextSource().getContext(userDn, password);
			isAuthenticated = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// close LDAP connect
			LdapUtils.closeContext(ctx);
		}
		return isAuthenticated;
	}
	
	/**
	 * Custom AD User attributes mapper, maps the attribute to the ADUser POJO
	 * @author polin.wei
	 *
	 */
	private class ADUserAttributesMapper implements AttributesMapper<ADUser> {
		public ADUser mapFromAttributes(Attributes attributes) throws NamingException {
			ADUser adUser = new ADUser();
			adUser.setName(attributes.get("cn").get().toString());
			adUser.setSAMAccountName(attributes.get("sAMAccountName").get().toString());
			
			if (!StringUtils.isEmpty(attributes.get("manager"))) {
				String manager = attributes.get("manager").toString().trim().replace("manager: ", "");
				adUser.setManager(manager);
			}
			if (!StringUtils.isEmpty(attributes.get("mail"))) {
				adUser.setMail(attributes.get("mail").get().toString());
			}			
			if (!StringUtils.isEmpty(attributes.get("ipPhone"))) {
				adUser.setIpPhone(attributes.get("ipPhone").toString().replace("ipPhone: ", ""));
			}
			if (!StringUtils.isEmpty(attributes.get("department"))) {
				adUser.setDepartment(attributes.get("department").toString().replace("department: ", ""));
			}
			if (!StringUtils.isEmpty(attributes.get("title"))) {
				adUser.setTitle(attributes.get("title").toString().replace("title: ", ""));
			}

			if (!StringUtils.isEmpty(attributes.get("memberOf"))) {
				String memberOf = attributes.get("memberOf").toString().replace("memberOf: ", "");
				List<String> list = new ArrayList<>();
				String[] roles = memberOf.split(",");
				for (String role : roles) {
					if (StringUtils.startsWithIgnoreCase(role.trim(), "CN=")) {
						list.add(role.trim().replace("CN=", ""));
					}
				}
				adUser.setRole(list);
			}


			return adUser;
		}
	}
	
	
}
