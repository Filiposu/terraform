package az.phonebook.backend.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ChannelAppStatus {
    APPRBYALTSALES,
    CUST_REJECTED,
    REJECTEDBYALTSALES,
    CANCELED,
    ACTIVE_CRM
}
