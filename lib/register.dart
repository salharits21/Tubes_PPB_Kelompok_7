import 'package:flutter/material.dart';
import 'database.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController(); 

  @override
  void dispose() {
    // Pastikan untuk membuang controller saat halaman dihapus
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Variabel untuk mengontrol skala tombol
  double scale = 1.0;
  double opact = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/suBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 65, right: 330),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('asset/backArr.png'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              child: const Text(
                'Mari bersama kita menjaga lingkungan',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color.fromRGBO(85, 132, 122, 100),
                ),
              ),
            ),
            const SizedBox(height: 60),
            textField(hintText: "Masukan nama", controller: nameController),
            const SizedBox(height: 30),
            textField(hintText: "Masukan email", controller: emailController),
            const SizedBox(height: 30),
            textField(
                hintText: "Masukan password",
                isPassword: true,
                controller: passwordController),
            const SizedBox(height: 30),
            textField(
                hintText: "Konfirmasi password",
                isPassword: true,
                controller:
                    confirmPasswordController), // Field konfirmasi password
            const SizedBox(height: 180),
            button(),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sudah memiliki akun? ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  // Method untuk membangun TextField
  Widget textField(
      {required String hintText,
      bool isPassword = false,
      required TextEditingController controller}) {
    return Container(
      height: 40,
      width: 335,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller, 
        obscureText: isPassword,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
    );
  }

  // Method untuk membangun tombol dengan gambar
  Widget button() {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scale = 0.9;
          opact = 0.7;
        });
      },
      onTapUp: (_) {
        setState(() {
          scale = 1.0;
          opact = 1.0;
        });
        register(); // Panggil fungsi register ketika tombol ditekan
      },
      child: AnimatedOpacity(
        opacity: opact,
        duration: const Duration(milliseconds: 100),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 100),
          child: Image.asset(
            'asset/buttondft.png', // Ganti dengan path gambar Anda
          ),
        ),
      ),
    );
  }

  void register() {
    String name = nameController.text; // Ambil nama dari TextField
    String email = emailController.text; // Ambil email dari TextField
    String password = passwordController.text; // Ambil password dari TextField
    String confirmPassword =
        confirmPasswordController.text; // Ambil konfirmasi password

    // Validasi input
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      // Tampilkan pesan kesalahan jika ada field yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password harus terdiri dari minimal 6 karakter')),
      );
      return; // Hentikan eksekusi fungsi jika password kurang dari 6 karakter
    }

    if (password != confirmPassword) {
      // Tampilkan pesan kesalahan jika password dan konfirmasi password tidak cocok
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password dan konfirmasi password harus sama')),
      );
      return;
    }

    bool isValidEmail(String email) {
      // Ekspresi reguler untuk memvalidasi email
      String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      RegExp regex = RegExp(pattern);
      return regex.hasMatch(email);
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email tidak valid')),
      );
      return; // Hentikan eksekusi fungsi jika email tidak valid
    }

    // Mendaftar user baru ke database
    userDatabase.registerUser(name, email, password);
    // Tampilkan pesan sukses dan navigasi ke halaman login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi berhasil! Silakan login')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const LoginPage())); // Kembali ke halaman login setelah registrasi
    });

    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
