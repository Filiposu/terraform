package az.phonebook.backend.dto.feign.response;

import io.swagger.annotations.ApiModel;

@ApiModel("Marital statuses")
public enum MaritalStatus {
    UNKNOWN,
    MARRIED,
    SINGLE,
    WIDOWED,
    DIVORCED
}
