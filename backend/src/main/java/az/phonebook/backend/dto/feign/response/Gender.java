package az.phonebook.backend.dto.feign.response;

import io.swagger.annotations.ApiModel;

@ApiModel("Genders")
public enum Gender {
    MALE, FEMALE, UNKNOWN
}
