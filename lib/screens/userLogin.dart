import 'package:applist2/screens/product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/login_provider.dart';

class UserLogin extends StatefulWidget {
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _firstTimeOpened = true;

  void _performLogin() {
    var loginModel = context.read<LoginModel>();
    String email = emailController.text;
    String password = passwordController.text;

    if (_firstTimeOpened && loginModel.validateCredentials(email, password)) {
      _firstTimeOpened = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductListScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login Gagal', style: TextStyle(color: Colors.red))
              ],
            ),
            content: Text('Username atau Password Salah.'),
            actions: <Widget>[
              TextButton(
                child: Text('Kembali'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Login',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Email',
                  hintStyle: TextStyle(
                      color: Colors.black12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Password',
                  hintStyle: TextStyle(
                      color: Colors.black12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _performLogin();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
