package com.example.phonebook;

import com.example.phonebook.client.PhonebookClient;
import com.example.phonebook.dto.UserEntity;
import com.example.phonebook.dto.UserOperation;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.Inet4Address;
import java.util.List;

@RestController
public class StatusController {

	private PhonebookClient phonebookClient;

	public StatusController(PhonebookClient phonebookClient) {
		this.phonebookClient = phonebookClient;
	}


	@GetMapping("/status")
	public String listUsers(Model model) {
		phonebookClient.getStatus("myapp.example.com");
		return "ok";
	}

}
