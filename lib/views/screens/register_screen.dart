import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/services/auth_http_services.dart';
import 'package:imtihon3_clon/views/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;

  const RegisterScreen({super.key, required this.themChanged});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String? email, password, passwordConfirm;
  bool isLoading = false;

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //? Register
      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.register(email!, password!);

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return LoginScreen(
                themChanged: widget.themChanged,
              );
            },
          ),
        );
      } catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email mavjud";
        }
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/hotels_logo.png",
                width: 150.w,
              ),
              SizedBox(height: 30.h),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Elektron pochta",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos elektron pochtangizni kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  //? save email
                  email = newValue;
                },
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Parol",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos parolingizni kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  //? save password
                  password = newValue;
                },
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: _passwordConfirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Parolni tasdiqlash",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos parolingizni tasdiqlang";
                  }

                  if (_passwordController.text !=
                      _passwordConfirmController.text) {
                    return "Parollar bir xil emas";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  //? save password confirm
                  passwordConfirm = newValue;
                },
              ),
              SizedBox(height: 20.h),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(
                      onPressed: submit,
                      child: const Text("Ro'yxatdan O'tish"),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return LoginScreen(
                          themChanged: widget.themChanged,
                        );
                      },
                    ),
                  );
                },
                child: const Text("Tizimga kirish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
