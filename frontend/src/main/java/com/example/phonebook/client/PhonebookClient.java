package com.example.phonebook.client;

import com.example.phonebook.dto.UserEntity;
import com.example.phonebook.dto.UserOperation;
import java.util.List;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(value = "phonebook-api", url = "${endpoints.phonebook-api}")
public interface PhonebookClient {

    @GetMapping(value = "/user/list",
            produces = MediaType.APPLICATION_JSON_VALUE)
    List<UserEntity> getAllUsers();

    @PostMapping(value = "/user/add",
            produces = MediaType.APPLICATION_JSON_VALUE)
    UserOperation postUser(@RequestBody UserEntity userEntity);

    @PutMapping(value = "/user/edit",
            produces = MediaType.APPLICATION_JSON_VALUE)
    UserOperation editUser(@RequestBody UserEntity userEntity);

    @DeleteMapping(value = "/user/delete",
            produces = MediaType.APPLICATION_JSON_VALUE)
    UserOperation deleteUser(@RequestBody UserEntity userEntity);

}
