package com.example.phonebook;

import com.example.phonebook.client.PhonebookClient;
import com.example.phonebook.dto.UserEntity;
import com.example.phonebook.dto.UserOperation;

import java.net.Inet4Address;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UsersController {

	private PhonebookClient phonebookClient;

	public UsersController(PhonebookClient phonebookClient) {
		this.phonebookClient = phonebookClient;
	}


	@GetMapping("/")
	public String listUsers(Model model) {
		List<UserEntity> users = phonebookClient.getAllUsers("myapp.example.com");
		try{
			model.addAttribute("hostname",Inet4Address.getLocalHost().getHostName());
		}
		catch (Exception e){
			System.out.println(e.getMessage());
		}
		model.addAttribute("users", users);
		model.addAttribute("userEntity",new UserEntity());
		return "user.html";
	}

//	@GetMapping("/status")
//	public String getStatus(Model model) {
//		List<UserEntity> users = phonebookClient.getStatus("myapp.example.com");
//		try{
//			model.addAttribute("hostname",Inet4Address.getLocalHost().getHostName());
//		}
//		catch (Exception e){
//			System.out.println(e.getMessage());
//		}
//		model.addAttribute("users", users);
//		model.addAttribute("userEntity",new UserEntity());
//		return "user.html";
//	}

	@PostMapping("/user/add")
	public String addUser(@ModelAttribute UserEntity userEntity, Model model) {
		UserOperation userOperation = phonebookClient.postUser(userEntity,"myapp.example.com");
		try{
			model.addAttribute("hostname",Inet4Address.getLocalHost().getHostName());
		}
		catch (Exception e){
			System.out.println(e.getMessage());
		}
		model.addAttribute("operation", userOperation);
		return "operation";
	}

	@PostMapping("/user/edit")
	public String editUser(@ModelAttribute UserEntity userEntity, Model model) {
		UserOperation userOperation = phonebookClient.editUser(userEntity,"myapp.example.com");
		try{
			model.addAttribute("hostname",Inet4Address.getLocalHost().getHostName());
		}
		catch (Exception e){
			System.out.println(e.getMessage());
		}
		model.addAttribute("operation", userOperation);
		return "operation";
	}

	@PostMapping("/user/delete")
	public String deleteUser(@ModelAttribute UserEntity userEntity, Model model) {
		UserOperation userOperation = phonebookClient.deleteUser(userEntity,"myapp.example.com");
		try{
			model.addAttribute("hostname",Inet4Address.getLocalHost().getHostName());
		}
		catch (Exception e){
			System.out.println(e.getMessage());
		}
		model.addAttribute("operation", userOperation);
		return "operation";
	}

}
