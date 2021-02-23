import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../constants/colors.dart';
import '../widgets/themeData.dart';

final _emailFormKey = GlobalKey<FormState>();
final _passwordFormKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  static const routeName = '/login_page';

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Color(0xFFfbf7f0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monetization_on,
                size: 200.w,
              ),
              const SizedBox(height: 60.0),
              EmailBox(),
              const SizedBox(height: 30.0),
              PasswordBox(),
              const SizedBox(height: 30.0),
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _signIn() {
      _emailFormKey.currentState.validate();
      _passwordFormKey.currentState.validate();
    }

    return Container(
      child: RaisedButton(
        color: AppColors.graphBlue,
        onPressed: _signIn,
        child: Text(
          'SIGN IN',
          style: CustomTextTheme.smallNames.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class EmailBox extends StatelessWidget {
  const EmailBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextFormField(
        key: _emailFormKey,
        style: CustomTextTheme.textField,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: 'Email',
          hintStyle: CustomTextTheme.textFieldHint,
          focusColor: Colors.black26,
          filled: true,
          fillColor: Colors.black12,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.0, color: Colors.black45),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.0, color: Colors.black45),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        validator: (value) {},
      ),
    );
  }
}

class PasswordBox extends StatelessWidget {
  const PasswordBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextFormField(
        key: _passwordFormKey,
        style: CustomTextTheme.textField,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          hintText: 'Password',
          hintStyle: CustomTextTheme.textFieldHint,
          focusColor: Colors.black26,
          filled: true,
          fillColor: Colors.black12,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.0, color: Colors.black45),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.0, color: Colors.black45),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
