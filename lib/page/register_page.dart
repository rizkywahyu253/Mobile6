import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../app_routes.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final usernameC = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 8, 9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 90, bottom: 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 218, 189, 6),
                    Color.fromARGB(255, 233, 178, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: const [
                  Icon(Icons.person_add_alt_1,
                      color: Color.fromARGB(255, 4, 4, 4), size: 85),
                  SizedBox(height: 15),
                  Text(
                    "Create Account",
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 13, 13),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Daftar untuk mulai belanja",
                    style: TextStyle(color: Color.fromARGB(179, 8, 8, 8)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // FORM CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // USERNAME
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: usernameC,
                      decoration: InputDecoration(
                        hintText: "Masukkan username",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // EMAIL
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: emailC,
                      decoration: InputDecoration(
                        hintText: "Masukkan email",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // PASSWORD
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: passC,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Masukkan password",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ERROR MESSAGE
                    if (errorText != null)
                      Text(
                        errorText!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    const SizedBox(height: 20),

                    userProv.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final errorMessage = await userProv.register(
                                  emailC.text,
                                  passC.text,
                                  usernameC.text,
                                );

                                if (errorMessage == null && mounted) {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.home);
                                } else {
                                  setState(() {
                                    errorText = errorMessage;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                backgroundColor: const Color.fromARGB(255, 218, 189, 6),
                              ),
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    usernameC.dispose();
    super.dispose();
  }
}
