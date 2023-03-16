import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab09/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _tel = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          children: [
            buildEmail(),
            buildPassword(),
            buildName(),
            buildTel(),
            registerButton(),
          ],
        ),
      )),
    );
  }

  TextFormField buildTel() {
    return TextFormField(
      controller: _tel,
      decoration: InputDecoration(hintText: "phone"),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกอีเมล์";
        }
        return null;
      },
    );
  }

  TextFormField buildName() {
    return TextFormField(
      controller: _name,
      decoration: InputDecoration(hintText: "Enter your name"),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกอีเมล์";
        }
        return null;
      },
    );
  }

  ElevatedButton registerButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Ok");
            print(_emailController.text);
            AuthService.registerUser(
                    _emailController.text, _passwordController.text)
                .then((value) {
              if (value == 1) {
                final uid = FirebaseAuth.instance.currentUser!.uid;
                users.doc(uid).set({
                  "fullname": _name.text,
                  "telephone": _tel.text,
                });
                Navigator.pop(context);
              }
            });
          }
        },
        child: const Text("Register"));
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกรหัสผ่่าน";
        }
        return null;
      },
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณากรอกอีเมล์";
        }
        return null;
      },
    );
  }
}
