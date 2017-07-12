package org.khmeracademy.auction.configuration;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

@Configuration
public class MvcConfiguration extends WebMvcConfigurerAdapter {
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/home").setViewName("/home");
		registry.addViewController("/").setViewName("/index");
		registry.addViewController("/index").setViewName("/index");
		//registry.addViewController("/login").setViewName("/login");
		registry.addViewController("/register").setViewName("/register");
		registry.addViewController("/admin").setViewName("/admin/dashboard");
		registry.addViewController("/admin/dashboard").setViewName("/admin/dashboard");
		registry.addViewController("/admin/viewuser").setViewName("/admin/viewuser");
		registry.addViewController("/admin/adduser").setViewName("/admin/adduser");
		registry.addViewController("/admin/addsupplier").setViewName("/admin/addsupplier");
		registry.addViewController("/admin/viewsupplier").setViewName("/admin/viewsupplier");
		registry.addViewController("/admin/addcategory").setViewName("/admin/addcategory");
		registry.addViewController("/admin/viewbrand").setViewName("/admin/viewbrand");
		registry.addViewController("/admin/viewcategory").setViewName("/admin/viewcategory");
		registry.addViewController("/admin/addproduct").setViewName("/admin/addproduct");
		registry.addViewController("/admin/viewproduct").setViewName("/admin/viewproduct");
		registry.addViewController("/admin/addauction").setViewName("/admin/addauction");
		registry.addViewController("/admin/viewauction").setViewName("/admin/viewauction");
		registry.addViewController("/admin/updateauction").setViewName("/admin/update-auction");
		registry.addViewController("/admin/bidhistory").setViewName("/admin/bidhistory");
		registry.addViewController("/admin/viewtopup").setViewName("/admin/viewtopup");
		registry.addViewController("/admin/uploadImage").setViewName("/admin/uploadImage");
		registry.addViewController("/admin/update-supplier").setViewName("/admin/update-supplier");
		registry.addViewController("/admin/saleinvoice").setViewName("/admin/saleinvoice");
		registry.addViewController("/itemlist").setViewName("/itemlist");
		registry.addViewController("/group-items").setViewName("/group-items");
		registry.addViewController("/viewtranslate").setViewName("/viewtranslate");
		registry.addViewController("/detail").setViewName("/detail");
		registry.addViewController("/detail/{id}").setViewName("/detail");
		registry.addViewController("/access-denied").setViewName("error/access-denied");
		registry.addViewController("/viewbidhistory").setViewName("/viewbidhistory");
		registry.addViewController("/contactus").setViewName("/contactus");
		registry.addViewController("/aboutus").setViewName("/aboutus");
		registry.addViewController("/userprofile").setViewName("/user/userprofile");
		registry.addViewController("/bestbid").setViewName("/bestbid");
		
		registry.addViewController("/viewbidhistory/{id}").setViewName("/viewbidhistory");
		registry.addViewController("/detail2").setViewName("/detail2");
		registry.addViewController("/register/confirm/{id}").setViewName("/confirm-email");
		registry.addViewController("/admin/view_all_bid_winners").setViewName("/admin/view_all_bid_winners");
		
	}

}
