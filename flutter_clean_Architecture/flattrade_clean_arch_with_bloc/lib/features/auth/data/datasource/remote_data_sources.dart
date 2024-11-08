abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> logIN(
    String factor, {
    required String userId,
    required String password,
  });

 Future<Map<String, dynamic>>logInWithOtp({
    required String userId,
    required String password,
  });

  Future<Map<String, dynamic>>forgetPassword({
    required String userid,
    required String pan,
    required String dob,
  });

  Future<void> changePassword({
    required String userid,
    required String oldPassword,
    required String newPassword,
  });
}
