import 'package:flutter/material.dart';
import 'package:lab09/pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        ),
        body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildEmail(),
              buildPassword(),
              loginButton(),
              registerButton(),
            ],
          ),
        )),
    );
  }

  ElevatedButton registerButton() => ElevatedButton(onPressed: () {
    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
  }, child: const Text("Register"));

  ElevatedButton loginButton() {
    return ElevatedButton(onPressed: () {
              
            }, child: const Text("Login"));
  }

  TextFormField buildPassword() {
    return TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (value) {
                if(value!.isEmpty){
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
                if(value!.isEmpty){
                  return "กรุณากรอกอีเมล์";
                }
                  return null;
                
              },
            );
  }
}