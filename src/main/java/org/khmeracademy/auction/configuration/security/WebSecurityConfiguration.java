package org.khmeracademy.auction.configuration.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;

@Configuration
@EnableWebSecurity
@PropertySource(
		value={"classpath:configuration.properties"}
)
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private Environment environment;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		http
			.authorizeRequests()
			.antMatchers("/" , "/index" , "/about", "/contact", "/ui-itemlist", "error/**", "/detail", "/login" ).permitAll()
			.antMatchers("/admin/**").hasRole("ADMIN")
			.antMatchers("/user/**").hasRole("BIDDER");

		http
			.formLogin()
			.loginPage(environment.getProperty("ACCOUNT_LOGIN_URL")+environment.getProperty("ACCOUNT_CONTINUE_SITE"))
			.usernameParameter("username")
			.passwordParameter("password")
			.permitAll();
		http
			.sessionManagement()
			.sessionAuthenticationErrorUrl(environment.getProperty("ACCOUNT_LOGIN_URL")+environment.getProperty("ACCOUNT_CONTINUE_SITE"))
			.maximumSessions(1)
			.maxSessionsPreventsLogin(true)
			.expiredUrl(environment.getProperty("ACCOUNT_LOGIN_URL")+environment.getProperty("ACCOUNT_CONTINUE_SITE"))
			.sessionRegistry(sessionRegistryImpl());
		http
			.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl(environment.getProperty("ACCOUNT_LOGOUT_URL"))
			.invalidateHttpSession(true)
			.deleteCookies("JESSIONID",environment.getProperty("ACCOUNT_KNONG_DAI_COOKIE_NAME"))
			.permitAll();
		
		http.csrf().disable();
		http.exceptionHandling().accessDeniedPage("/access-denied");
	}

	@Bean
	protected SessionRegistry sessionRegistryImpl(){
		return new SessionRegistryImpl();
	}
	
	
	
	/*
	@Autowired
	@Qualifier(value="CustomUserDetailService")
	private UserDetailsService userDetailsService;
	
	@Autowired
	@Qualifier("ajaxAuthenticationFailureHandler")
	private AjaxAuthenticationFailureHandler ajaxAuthenticationFailureHandler;
	
	@Autowired
	@Qualifier("ajaxAuthenticationSuccessHandler")
	private AjaxAuthenticationSuccessHandler ajaxAuthenticationSuccessHandler;
	
	@Autowired
	protected void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {

		
		auth.userDetailsService(userDetailsService);
		
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()
			.antMatchers("/" , "/index" , "/about", "/contact", "/ui-itemlist", "error/**", "/detail", "/login" ).permitAll()
			.antMatchers("/admin/**").hasRole("ADMIN")
			.antMatchers("/user/**").hasRole("BIDDER");
		http
		.formLogin()
		.loginPage("/login")
		.usernameParameter("username")
		.passwordParameter("password")
		.successHandler(ajaxAuthenticationSuccessHandler)
		.failureHandler(ajaxAuthenticationFailureHandler)
		.permitAll();
		
		http
		.logout()
		.logoutUrl("/logout")
		.logoutSuccessUrl("/")
		.invalidateHttpSession(true)
		.deleteCookies("JESSIONID")
		.permitAll();	
		
		http
		.exceptionHandling()
		.accessDeniedPage("/access-denied");
		
		http.csrf().disable();
	}
	
//	@Bean
//	public PasswordEncoder passwordEncoder(){
//		return new BCryptPasswordEncoder();
//	}
 */
 
}
