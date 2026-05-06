package com.landselling.Online_land_sales_portal.validation;

import com.landselling.Online_land_sales_portal.Util.BadWordFilter;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class NoProfanityValidator implements ConstraintValidator<NoProfanity, String> {

    @Override
    public void initialize(NoProfanity constraintAnnotation) {
    }

    @Override
    public boolean isValid(String text, ConstraintValidatorContext context) {
        if (text == null) {
            return true;
        }
        return !BadWordFilter.containsBadWords(text);
    }
}
