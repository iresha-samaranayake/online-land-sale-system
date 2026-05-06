package com.landselling.Online_land_sales_portal.entity;


import jakarta.persistence.Column;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;


public enum PayementStatus {
        PROPOSED("Proposed"),
        ACCEPTED("Accepted"),
        REJECTED("Rejected"),
        ACTIVE("Active"),
        COMPLETED("Completed"),
        DEFAULTED("Defaulted");

        private final String displayName;

        PayementStatus(String displayName){
            this.displayName = displayName;
        }
        public String getDisplayName(){
            return displayName;
        }

}
