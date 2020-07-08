import 'package:flutter/material.dart';
import 'package:planthai/user_repository.dart';
import 'package:planthai/register/register.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            'Don\'t have an Account ?',
            style: TextStyle(color: Color.fromRGBO(221, 221, 221, 1)),
          ),
        ),
        FlatButton(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.all(0) ,
          child: Text(
            'Create an Account',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return RegisterScreen(userRepository: _userRepository);
              }),
            );
          },
        ),
      ],
    );
  }
}
