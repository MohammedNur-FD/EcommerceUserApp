import 'package:ecom_boni_user/auth/firebase_auth_service.dart';
import 'package:ecom_boni_user/custom_widgets/screen.dart';
import 'package:ecom_boni_user/pages/product_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formlKey = GlobalKey<FormState>();
  bool _isSecurePassword = true;
  String? _email;
  String? _password;
  String errorMsg = '';
  bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Form(
            key: _formlKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                _loginImage(context),
                const SizedBox(
                  height: 16,
                ),
                _headLineTitle(),
                _subTitle(),
                const SizedBox(
                  height: 50,
                ),
                _inputfield(context),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _isLogin = true;
                        _loginUser();
                      },
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _loginButton(),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.login)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _forgetPassword(context),
                _signUp(context),
                _errorMsg(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _inputfield(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'this filed must not be empty';
            }
            return null;
          },
          onSaved: (value) {
            _email = value;
          },
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: 'Email',
            suffixIcon: Icon(
              Icons.email,
              color: Colors.black,
            ),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: _isSecurePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your correct password';
            }
            return null;
          },
          onSaved: (value) {
            _password = value;
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: 'Password',
            suffixIcon: _togglePassword(),
            prefixIcon: const Icon(Icons.key),
          ),
        ),
      ],
    );
  }

  Text _loginButton() {
    return const Text(
      'Login',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }

  Center _errorMsg() {
    return Center(
        child: Text(
      errorMsg,
      style: const TextStyle(color: Colors.red, fontSize: 18),
    ));
  }

  Center _headLineTitle() {
    return const Center(
      child: Text(
        'WELCOME BACK',
        style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    );
  }

  Center _subTitle() {
    return const Center(
      child: Text(
        'Enter your credebtial to login',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    );
  }

  void _loginUser() async {
    if (_formlKey.currentState!.validate()) {
      _formlKey.currentState!.save();
      try {
        User? user;
        if (_isLogin) {
          user = await FirebaseAuthService.loginUser(_email!, _password!);
        } else {
          user = await FirebaseAuthService.registerUser(_email!, _password!);
        }
        if (user != null) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, ProductListPage.routeName);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMsg = e.message!;
        });
      }
    }
  }

  Widget _togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(
              Icons.visibility_off,
              color: Colors.grey,
            )
          : const Icon(
              Icons.visibility,
            ),
    );
  }

  _forgetPassword(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 17,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  _signUp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
            onPressed: () {
              _isLogin = false;
              _loginUser();
              // Navigator.pushNamed(context, SignUpPage.routeName);
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  _loginImage(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/login_image.png'),
        fit: BoxFit.cover,
      )),
    );
  }
}
