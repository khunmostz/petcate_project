import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcare_project/controllers/auth_controller.dart';
import 'package:petcare_project/utils/constant.dart';
import 'package:petcare_project/widget/custom_button.dart';
import 'auth_textfield.dart';

class SignUpContainer extends StatefulWidget {
  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  final AuthController _authController = Get.find<AuthController>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _dropdownValue = ['User', 'Doctor'];
  Object? _iniialValue = 'User';
  // String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefualtPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // username textfield
              AuthTextField(
                hintText: 'John Doe',
                controller: _authController.usernameController,
                validator: (value) {},
                onSaved: (value) {
                  _authController.usernameController.text = value!;
                },
              ),
              SizedBox(height: 10),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // email textfield
              AuthTextField(
                hintText: 'example@gmail.com',
                controller: _authController.emailController,
                validator: (value) {
                  return _authController.EmailValidator(value!);
                },
                onSaved: (value) {
                  _authController.emailController.text = value!;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // password textfield
              AuthTextField(
                obscureText: true,
                hintText: '**************',
                controller: _authController.passwordController,
                validator: (value) {
                  return _authController.PasswordValidator(value!);
                },
                onSaved: (value) {
                  _authController.passwordController.text = value!;
                },
              ),
              SizedBox(height: 10),
              Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              AuthTextField(
                obscureText: true,
                hintText: '**************',
                controller: _authController.confirmPasswordController,
                validator: (value) {
                  return _authController.checkPassword(value!);
                },
                onSaved: (value) {},
              ),
              SizedBox(height: 10),
              Text(
                'Types',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // type dropdown
              DropdownButton(
                value: _iniialValue,
                isExpanded: true,
                items: _dropdownValue.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _iniialValue = value as String;
                    // print(_iniialValue);
                  });
                },
              ),
              SizedBox(height: 25),
              CustomButton(
                text: 'SignUp',
                onPressed: () async {
                  await _authController.signUp(
                      _iniialValue.toString(), _formKey);
                },
              ),
              SizedBox(height: 20),
              // Forgot Password ?
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Already have an account ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signin');
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: kDefualtColorMain,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
