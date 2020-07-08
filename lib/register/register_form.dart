import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planthai/register/register.dart';
import 'package:planthai/Authentication/authentication_bloc.dart';
import 'bloc/bloc.dart';

import 'package:planthai/screen/test_write_db.dart' as t;

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterBloc _registerBloc;
  // me write new na
  bool get isPasswordSame =>
      _confirmPasswordController.text == _confirmPasswordController.text;
  //555
  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
          t.testfunctionn(); //testfunction
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 90),
                    child: Text('New Account \nWith PlanThai',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Hexcolor('#ffffff'),
                            ),
                            fontWeight: FontWeight.w700,
                            fontSize: 40)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50.0, left: 30, right: 30),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 30,
                        ),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.lato(
                            textStyle: TextStyle(color: Hexcolor('#DCDCDC')),
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 30,
                        ),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.lato(
                            textStyle: TextStyle(color: Hexcolor('#DCDCDC')),
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.offline_pin,
                          color: Colors.white,
                          size: 30,
                        ),
                        labelText: 'Confirm password',
                        labelStyle: GoogleFonts.lato(
                            textStyle: TextStyle(color: Hexcolor('#DCDCDC')),
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordConfirmed
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 30, right: 30),
                    child: RegisterButton(
                      onPressed: isRegisterButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Center(
                        child: Text(
                      'Already have an Account?',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(color: Hexcolor('#DCDCDC')),
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
                    )),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AbsorbPointer(
                          child: Text(
                        'Back to Sign in',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(color: Hexcolor('#DCDCDC')),
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onConfirmPasswordChanged() {
    _registerBloc.add(
      RegisterConfirmPasswordChanged(
          confirmPassword: _confirmPasswordController.text,
          password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
