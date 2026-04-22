package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.example.demo.service.RevizijskiTragService;

import jakarta.servlet.DispatcherType;

@EnableWebSecurity
@Configuration
public class SecurityConfig {

	@Autowired
	@Lazy
	RevizijskiTragService revizijskiTragService;

	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests(requests -> requests
				.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
				.requestMatchers("/login").permitAll()
				.requestMatchers("/uploads/**").permitAll()
				.requestMatchers("/css/**").permitAll()
				.requestMatchers("/js/**").permitAll()
				.requestMatchers("/images/**").permitAll()
				.requestMatchers("/admin/**").hasRole("ADMIN")
				.requestMatchers("/doktor/**").hasRole("DOKTOR")
				.requestMatchers("/sestra/**").hasRole("SESTRA")
				.requestMatchers("/pacijent/**").hasRole("PACIJENT")
				.anyRequest().authenticated())
			.csrf(csrf -> csrf.disable())
			.formLogin(form -> form
				.loginPage("/login")
				.loginProcessingUrl("/login")
				.successHandler((request, response, auth) -> {
					revizijskiTragService.log(auth.getName(), "LOGIN");
					String uloga = auth.getAuthorities().iterator().next().getAuthority();
					String ctx = request.getContextPath();
					switch (uloga) {
						case "ROLE_ADMIN"    -> response.sendRedirect(ctx + "/admin/pocetna");
						case "ROLE_DOKTOR"   -> response.sendRedirect(ctx + "/doktor/pocetna");
						case "ROLE_SESTRA"   -> response.sendRedirect(ctx + "/sestra/pocetna");
						case "ROLE_PACIJENT" -> response.sendRedirect(ctx + "/pacijent/pocetna");
						default              -> response.sendRedirect(ctx + "/login?error");
					}
				})
				.failureUrl("/login?error")
				.permitAll())
			.logout(logout -> logout
				.logoutUrl("/logout")
				.addLogoutHandler((request, response, auth) -> {
					if (auth != null && auth.getName() != null) {
						revizijskiTragService.log(auth.getName(), "LOGOUT");
					}
				})
				.logoutSuccessUrl("/login?logout")
				.invalidateHttpSession(true)
				.deleteCookies("JSESSIONID")
				.permitAll());

		return http.build();
	}

	@Bean
	AuthenticationManager authenticationManager(UserDetailsService userDetailsService, PasswordEncoder passwordEncoder) {
		DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider(userDetailsService);
		authenticationProvider.setPasswordEncoder(passwordEncoder);
		return new ProviderManager(authenticationProvider);
	}

	@Bean
	PasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
}