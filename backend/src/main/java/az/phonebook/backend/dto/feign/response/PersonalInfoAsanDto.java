package az.phonebook.backend.dto.feign.response;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("Personal info taken from ASAN Finance service")
@Builder
public class PersonalInfoAsanDto {

    @ApiModelProperty("Personal identification number")
    private String pin;

    @ApiModelProperty("Id card seria")
    private String documentSeria;

    @ApiModelProperty("Id card number")
    private String documentNumber;

    @ApiModelProperty("Name")
    private String name;

    @ApiModelProperty("Surname")
    private String surname;

    @ApiModelProperty("NameEn")
    private String nameEn;

    @ApiModelProperty("SurnameEn")
    private String surnameEn;

    @ApiModelProperty("Father name")
    private String patronymic;

    @ApiModelProperty("Date of birth")
    private LocalDate birthDate;

    @ApiModelProperty("Blood Type")
    private String bloodType;

    @ApiModelProperty("Eye Color")
    private String eyeColor;

    @ApiModelProperty("Sign")
    private String sign;

    @ApiModelProperty("Height")
    private String height;

    @ApiModelProperty("Place of birth")
    private Address birthAddress;

    @ApiModelProperty("Activation Date")
    private LocalDate activationDate;

    @ApiModelProperty("Gender")
    private Gender gender;

    @ApiModelProperty("Registration address")
    private Address registrationAddress;

    @ApiModelProperty("ID card expiration date")
    private LocalDate expireDate;

    @ApiModelProperty("ID card given date")
    private LocalDate givenDate;

    @ApiModelProperty("Martial status")
    private MaritalStatus maritalStatus;

    @ApiModelProperty("Military status")
    private String militaryStatus;

    @ApiModelProperty("ID card give organization name")
    private String givenOrganization;

    @ApiModelProperty("Citizenship")
    private String citizenship;

    @ApiModelProperty("Photo in base64 format")
    private String image;

    @ApiModelProperty("Document type for non residents")
    private String nonResidentDocumentType;
}
