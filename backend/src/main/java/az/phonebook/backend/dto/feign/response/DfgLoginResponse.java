package az.phonebook.backend.dto.feign.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DfgLoginResponse {

    @JsonProperty("id_token")
    String idToken;

}
