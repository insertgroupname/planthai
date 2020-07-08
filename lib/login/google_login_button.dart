import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planthai/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(bottom:2.0),
        child: Icon(FontAwesomeIcons.google, color: Colors.white),
      ),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
      label: Padding(
        padding: const EdgeInsets.only(left:3.0),
        child: Text('Sign in with Google',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                ),
                fontSize: 18,
                fontWeight: FontWeight.w400)),
      ),
      color: Colors.redAccent,
    );
  }
}
