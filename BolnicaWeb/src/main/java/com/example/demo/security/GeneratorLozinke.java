package com.example.demo.security;

import org.passay.CharacterRule;
import org.passay.EnglishCharacterData;
import org.passay.PasswordGenerator;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class GeneratorLozinke {
	public String generisiLozinku() {
        PasswordGenerator gen = new PasswordGenerator();

        List<CharacterRule> rules = Arrays.asList(
            new CharacterRule(EnglishCharacterData.UpperCase, 2), // Barem 2 velika slova
            new CharacterRule(EnglishCharacterData.LowerCase, 2), // Barem 2 mala slova
            new CharacterRule(EnglishCharacterData.Digit, 2)     // Barem 2 broja
        );

        return gen.generatePassword(12, rules);
    }
}
