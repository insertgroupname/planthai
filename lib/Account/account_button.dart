import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountButton extends StatelessWidget {
  final VoidCallback _onPressed;

  AccountButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: _onPressed,
        child: Text(
          'go back',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.white,
              ),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ));
  }
}
