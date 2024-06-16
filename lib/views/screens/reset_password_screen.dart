import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/services/auth_http_services.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _authHttpServices = AuthHttpServices();
  String? emailError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/hotels_logo.png",
              width: 150.w,
            ),
            SizedBox(height: 30.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border:const OutlineInputBorder(),
                  labelText: "Elektron pochta",
                  errorText: emailError),
            ),
            SizedBox(height: 20.h),
            FilledButton(
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  emailError = "Email kiriting";
                  setState(() {});
                } else {
                  _authHttpServices.sendPasswordEmail(emailController.text);
                  await showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      content: Text(
                          "Emailingizga parolni qayta tiklash uchun link yuborildi"),
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              child: const Text("Parolni qayta tiklash"),
            ),
          ],
        ),
      ),
    );
  }
}
