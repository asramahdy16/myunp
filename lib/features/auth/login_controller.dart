class LoginController {
  /// simulasi proses login (dummy)
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    // simulasi request ke server
    await Future.delayed(const Duration(seconds: 1));

    // validasi sederhana
    if (username.isEmpty || password.isEmpty) {
      return false;
    }

    // dummy akun (sementara)
    if (username == '22076030' && password == '111') {
      return true;
    }

    // jika ingin semua input dianggap valid, bisa pakai ini:
    // return true;

    return false;
  }
}
