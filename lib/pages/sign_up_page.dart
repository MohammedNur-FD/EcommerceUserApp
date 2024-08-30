import 'package:ecom_boni_user/custom_widgets/screen.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = '/signUpPage';
  @override
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formlKey = GlobalKey<FormState>();
  bool _isSecurePassword = true;
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
              _headding(),
              const SizedBox(
                height: 40,
              ),
              _textInputfeild(context),
              _signUpButton(),
            ],
          ),
        ),
      ),
    ));
  }

  _textInputfeild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this filed must not be empty';
              }
              return null;
            },
            onSaved: (value) {},
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
                hintText: 'First Name',
                prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this filed must not be empty';
              }
              return null;
            },
            onSaved: (value) {},
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
              hintText: 'Last Name',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this filed must not be empty';
              }
              return null;
            },
            onSaved: (value) {},
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
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this filed must not be empty';
              }
              return null;
            },
            onSaved: (value) {},
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
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: _isSecurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this filed must not be empty';
              }
              return null;
            },
            onSaved: (value) {},
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
              prefixIcon: const Icon(Icons.key),
              suffixIcon: _togglePassword(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: _isSecurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this filed must not be empty';
              }
              return null;
            },
            onSaved: (value) {},
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
              hintText: 'Comfirm password',
              prefixIcon: const Icon(Icons.key),
              suffixIcon: _togglePassword(),
            ),
          ),
        ],
      ),
    );
  }

  _headding() {
    return const Center(
        child: Column(
      children: [
        Text(
          'Sign up',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "Create an account,it's free",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    ));
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

  _signUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
      child: SizedBox(
        height: 50,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.login_rounded),
          label: const Text('CONFIRM'),
        ),
      ),
    );
  }
}
