package com.example.demo.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import model.Korisnik;

public class CustomUserDetail implements UserDetails {

	private static final long serialVersionUID = 1L;

	private Korisnik kor;

	public CustomUserDetail(Korisnik k) {
		this.kor = k;
	}

	public Korisnik getKorisnik() {
		return kor;
	}

	public void setKorisnik(Korisnik k) {
		this.kor = k;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("ROLE_" + kor.getUloga()));
		return authorities;
	}

	@Override
	public String getPassword() {
		return kor.getLozinka();
	}

	@Override
	public String getUsername() {
		return kor.getKorisnickoIme();
	}

	@Override
	public boolean isEnabled() {
		return kor.getAktivan() == (byte) 1;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
}