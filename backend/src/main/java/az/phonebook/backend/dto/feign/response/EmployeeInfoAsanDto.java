package az.phonebook.backend.dto.feign.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("Employee info taken from ASAN Finance service")
public class EmployeeInfoAsanDto {
    @ApiModelProperty("Employer Tax ID")
    private String employerVoen;

    @ApiModelProperty(value = "Employer name", example = "AZƏRBAYCAN BEYNƏLXALQ BANKI AÇIQ SƏHMDAR CƏMİYYƏTİ")
    private String employerName;

    @ApiModelProperty(value = "Employer worker count", example = "2661")
    private Integer employerWorkerCount;

    @ApiModelProperty(value = "Employer phone", example = "4988535")
    private String employerPhone;

    @ApiModelProperty(value = "Employee legal address")
    private String employerLegalAddress;

    private String employeeName;

    private String employeeSurname;

    private String employeePatronymic;

    private String employeePhone;

    @ApiModelProperty(value = "Label of work place type", example = "1")
    private String workPlaceTypeLabel;

    @ApiModelProperty(value = "Description of work place type", example = "Əsas")
    private String workPlaceTypeDescription;

    private String workplace;

    private String position;

    @ApiModelProperty(value = "Position labour", example = "Şöbə müdiri")
    private String positionLabourContract;

    private String salary;

    private String workCasualTypeLabel;
    @ApiModelProperty(value = "Type of working hour division", example = "Vaxtamuzd/işəmuzd")
    private String workCasualTypeDescription;

    @ApiModelProperty(value = "Social security number", example = "306198400789")
    private String ssn;

    private String contractBeginDate;

    private String contractSignDate;

    private String contractInsertDate;

    private String contractEndDate;

    private String contractNextEndDate;

    private String contractPeriodTypeLabel;

    @ApiModelProperty(value = "Description about contract period", example = "Müddətli")
    private String contractPeriodTypeDescription;

    private String contractNumber;

    private String contractStatusLabel;

    @ApiModelProperty(value = "Description about contract status", example = "Qüvvədədir")
    private String contractStatusDescription;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String dfgIdEmployer;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String dfgIdEmployee;


}
