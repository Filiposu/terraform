package service;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import az.phonebook.backend.dto.UserOperation;
import az.phonebook.backend.entity.UserEntity;
import az.phonebook.backend.exceptions.FailedToGetSuccessfulResponseException;
import az.phonebook.backend.repository.UserRepository;
import az.phonebook.backend.service.impl.UserServiceImpl;
import java.util.Optional;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class UserServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserServiceImpl userService;

    @BeforeEach
    public void setup() {
        doReturn(new UserEntity()).when(userRepository).save(any());
        doNothing().when(userRepository).delete(any());

    }

    @Test
    void testPostWhenUserCanNotBeSaved() {
        when(userRepository.save(any())).thenThrow(FailedToGetSuccessfulResponseException.class);
        UserOperation userOperation = userService.postUser(UserEntity.builder()
                .name("Toghrul").user_id("user_id").build());
        Assertions.assertTrue(userOperation.getOperation_status().contains("fail"));
    }

    @Test
    void testPostHappyPath() {
        UserOperation userOperation = userService.postUser(UserEntity.builder()
                .name("Toghrul").user_id("user_id").build());
        Assertions.assertTrue(userOperation.getOperation_status().contains("success"));
    }

    @Test
    void testEditWhenUserIdIsNull() {
        UserOperation userOperation = userService.editUser(UserEntity.builder()
                .name("Toghrul").build());
        Assertions.assertEquals("fail", userOperation.getOperation_status());
    }

    @Test
    void testEditWhenUserNotFoundInDb() {
        doReturn(Optional.empty()).when(userRepository).findById(any());
        UserOperation userOperation = userService.editUser(UserEntity.builder()
                .name("Toghrul").user_id("user_id").build());
        Assertions.assertEquals("fail-user does not exist", userOperation.getOperation_status());
    }

    @Test
    void testEditWhenUserCanNotBeEdited() {
        doReturn(Optional.of(UserEntity.builder().user_id("user_id").build())).when(userRepository).findById(any());
        when(userRepository.save(any())).thenThrow(new FailedToGetSuccessfulResponseException("can't edit"));
        UserOperation userOperation = userService.editUser(UserEntity.builder()
                .name("Toghrul").user_id("user_id").build());
        verify(userRepository, times(1)).findById(any());
        Assertions.assertEquals("fail-can't edit", userOperation.getOperation_status());
    }

    @Test
    void testEditHappyPath() {
        doReturn(Optional.of(UserEntity.builder().user_id("user_id").build())).when(userRepository).findById(any());
        UserOperation userOperation = userService.editUser(UserEntity.builder()
                .name("Toghrul").user_id("user_id").build());
        verify(userRepository, times(1)).findById(any());
        verify(userRepository, times(1)).save(any());
        Assertions.assertEquals("success", userOperation.getOperation_status());
    }

    @Test
    void testDeleteWhenUserIdIsNull() {
        doReturn(Optional.of(UserEntity.builder().user_id("user_id").build())).when(userRepository).findById(any());
        UserOperation userOperation = userService.deleteUser(UserEntity.builder()
                .name("Toghrul").build());
        Assertions.assertEquals("fail-user id is null", userOperation.getOperation_status());
    }

    @Test
    void testDeleteWhenDbThrowException() {
        doReturn(Optional.of(UserEntity.builder().user_id("user_id").build())).when(userRepository).findById(any());
        when(userRepository.findById(any())).thenThrow(new FailedToGetSuccessfulResponseException("can't delete"));
        verify(userRepository, times(0)).delete(any());
        UserOperation userOperation = userService.editUser(UserEntity.builder()
                .name("Toghrul").user_id("user_id").build());
        Assertions.assertEquals("fail-can't delete", userOperation.getOperation_status());
    }

    @Test
    void testDeleteHappyPath() {
        doReturn(Optional.of(UserEntity.builder().user_id("user_id").build())).when(userRepository).findById(any());
        UserOperation userOperation = userService.deleteUser(UserEntity.builder()
                .name("Toghrul").user_id("user_id").build());
        verify(userRepository, times(1)).delete(any());
        Assertions.assertEquals("success", userOperation.getOperation_status());
    }


}
