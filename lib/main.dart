import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String newPassword = '';
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('images/flutter.png'),
                ),
              ),
              Form(
                key: formKey,
                child: buildFormFields(),
              ),
              ElevatedButton(
                onPressed: validateAndSubmit,
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ForgotPasswordPage(onPasswordChanged: onPasswordChanged),
                    ),
                  );
                },
                child: Text("Forgot Password?"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFormFields() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Masukkan email Anda',
              suffixIcon: email.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  clearEmail();
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              updateEmail(value);
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Masukkan password Anda',
              suffixIcon: IconButton(
                icon: Icon(
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off),
                onPressed: togglePasswordVisibility,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: isPasswordHidden,
            onChanged: (value) {
              updatePassword(value);
            },
          ),
        ],
      ),
    );
  }

  void clearEmail() {
    emailController.clear();
    updateEmail('');
  }

  void updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  void updatePassword(String value) {
    setState(() {
      password = value;
    });
  }

  void validateAndSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (email.isNotEmpty && password.isNotEmpty) {
        if (password == newPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomePage(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Password salah/tidak ditemukan."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }



  void onPasswordChanged(String newPassword) {
    setState(() {
      this.newPassword = newPassword;
    });
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  final Function(String) onPasswordChanged;

  ForgotPasswordPage({required this.onPasswordChanged});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String passwordBaru = '';
  String konfirmasiPassword = '';
  final TextEditingController passwordBaruController = TextEditingController();
  final TextEditingController konfirmasiPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password Page"),
      ),
      body: SingleChildScrollView( // Wrap the body in SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('images/flutter.png'),
                ),
              ),
              buildFormFields(),
              ElevatedButton(
                onPressed: validateAndSubmit,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFormFields() {
    return Container(
      width: 350,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: passwordBaruController,
            decoration: InputDecoration(
              labelText: 'New Password',
              hintText: 'Masukkan password baru Anda',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              updatePasswordBaru(value);
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: konfirmasiPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Konfirmasi password baru Anda',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              updateKonfirmasiPassword(value);
            },
          ),
        ],
      ),
    );
  }

  void updatePasswordBaru(String value) {
    setState(() {
      passwordBaru = value;
    });
  }

  void updateKonfirmasiPassword(String value) {
    setState(() {
      konfirmasiPassword = value;
    });
  }

  void validateAndSubmit() {
    if (passwordBaru.isNotEmpty && konfirmasiPassword.isNotEmpty) {
      if (passwordBaru == konfirmasiPassword) {
        widget.onPasswordChanged(passwordBaru);
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Konfirmasi Password Baru Tidak Cocok."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
