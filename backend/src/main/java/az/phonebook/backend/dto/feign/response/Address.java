package az.phonebook.backend.dto.feign.response;

import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel("Class containing separated street, city and country")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    private String country;
    private String city;
    private String street;
}
