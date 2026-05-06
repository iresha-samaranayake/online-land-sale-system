package com.landselling.Online_land_sales_portal.Util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class BadWordFilter {
    private static final Set<String> BAD_WORDS = new HashSet<>(Arrays.asList(
        "bitch", "bastard", "idiot", "stupid", "dumb", "fuck"
    ));

    public static boolean containsBadWords(String text) {
        if (text == null || text.trim().isEmpty()) {
            return false;
        }
        
        // Convert to lowercase for case-insensitive comparison
        String lowercaseText = text.toLowerCase();
        
        // Check if any bad word is present in the text
        return BAD_WORDS.stream()
                .anyMatch(badWord -> lowercaseText.contains(badWord.toLowerCase()));
    }
}
