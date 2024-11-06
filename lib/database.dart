class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});
}

class UserDatabase {
  List<User> users = []; // Menyimpan daftar user

  // Fungsi untuk mendaftar user baru
  void registerUser(String name, String email, String password) {
    // Tambahkan user baru ke dalam daftar
    users.add(User(name: name, email: email, password: password));
    print('User registered: $name'); // Log untuk debug
  }

  // Fungsi untuk login user
  User? loginUser(String name, String password) {
    // Mencari user berdasarkan nama dan password
    for (var user in users) {
      if (user.name == name && user.password == password) {
        return user; // Jika ditemukan, kembalikan user
      }
    }
    return null; // Jika tidak ditemukan, kembalikan null
  }
}

// Instance dari UserDatabase untuk digunakan di seluruh aplikasi
final userDatabase = UserDatabase();
