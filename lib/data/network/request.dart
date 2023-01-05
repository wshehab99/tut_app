class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String username;

  String email;
  String password;
  String phoneNumber;

  String profileImage;

  RegisterRequest(this.username, this.email, this.password, this.phoneNumber,
      this.profileImage);
}

class ForgetPasswordRequest {
  String email;

  ForgetPasswordRequest(
    this.email,
  );
}
