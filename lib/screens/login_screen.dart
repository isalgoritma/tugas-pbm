import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final formKey =
      GlobalKey<FormState>();

  final authService =
      AuthService();

  bool isLoading = false;

  Future<void> handleLogin() async {

    if (!formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool success =
        await authService.login(

      usernameController.text,

      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {

      if (!mounted) return;

      showDialog(

        context: context,

        builder: (context) {

          return AlertDialog(

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            title: const Text(
              "Berhasil",
            ),

            content: const Text(
              "Login berhasil!",
            ),

            actions: [

              TextButton(

                onPressed: () {

                  Navigator.pop(
                    context,
                  );

                  Navigator.pushReplacement(

                    context,

                    MaterialPageRoute(

                      builder:
                          (context) =>
                              const HomeScreen(),
                    ),
                  );
                },

                child: const Text(
                  "Lanjut",
                ),
              )
            ],
          );
        },
      );

    } else {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor:
              const Color(0xff7F2020),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              15,
            ),
          ),

          behavior:
              SnackBarBehavior.floating,

          content: const Text(
            "Login gagal",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF6F3EB),

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            padding:
                const EdgeInsets.all(24),

            child: Container(

              padding:
                  const EdgeInsets.all(
                24,
              ),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        // ignore: deprecated_member_use
                        .withOpacity(
                      0.08,
                    ),

                    blurRadius: 20,

                    offset:
                        const Offset(
                      0,
                      10,
                    ),
                  )
                ],
              ),

              child: Form(

                key: formKey,

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    CircleAvatar(

                      radius: 40,

                      backgroundColor:
                          const Color(
                        0xffC9CAAC,
                      ),

                      child: Icon(

                        Icons.menu_book,

                        size: 40,

                        color:
                            const Color(
                          0xff7F2020,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(

                      "Buy-Books",

                      style: TextStyle(

                        fontSize: 28,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Color(0xff7F2020),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    const Text(

                      "Online Book Store",

                      style: TextStyle(

                        color:
                            Colors.grey,
                      ),
                    ),

                    const SizedBox(
                      height: 35,
                    ),

                    TextFormField(

                      controller:
                          usernameController,

                      keyboardType:
                          TextInputType.number,

                      decoration:
                          InputDecoration(

                        labelText:
                            "Username / NIM",

                        prefixIcon:
                            const Icon(
                          Icons.person,
                        ),

                        filled: true,

                        fillColor:
                            const Color(
                          0xffF6F3EB,
                        ),

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                              BorderSide.none,
                        ),
                      ),

                      validator: (value) {

                        if (value == null ||
                            value.isEmpty) {

                          return "Username wajib diisi";
                        }

                        if (value.length <
                            12) {

                          return "Minimal 12 karakter";
                        }

                        if (!RegExp(
                          r'^[0-9]+$',
                        ).hasMatch(value)) {

                          return "Hanya angka";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(

                      controller:
                          passwordController,

                      obscureText: true,

                      keyboardType:
                          TextInputType.number,

                      decoration:
                          InputDecoration(

                        labelText:
                            "Password",

                        prefixIcon:
                            const Icon(
                          Icons.lock,
                        ),

                        filled: true,

                        fillColor:
                            const Color(
                          0xffF6F3EB,
                        ),

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                              BorderSide.none,
                        ),
                      ),

                      validator: (value) {

                        if (value == null ||
                            value.isEmpty) {

                          return "Password wajib diisi";
                        }

                        if (value.length <
                            12) {

                          return "Minimal 12 karakter";
                        }

                        if (!RegExp(
                          r'^[0-9]+$',
                        ).hasMatch(value)) {

                          return "Hanya angka";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    SizedBox(

                      width:
                          double.infinity,

                      height: 55,

                      child:
                          ElevatedButton(

                        onPressed:
                            isLoading
                                ? null
                                : handleLogin,

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              const Color(
                            0xff7F2020,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        child: isLoading

                            ? const CircularProgressIndicator(
                                color:
                                    Colors.white,
                              )

                            : const Text(

                                "LOGIN",

                                style:
                                    TextStyle(

                                  fontSize:
                                      16,

                                  fontWeight:
                                      FontWeight.bold,

                                  color:
                                      Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}