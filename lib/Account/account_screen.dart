import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planthai/Account/account.dart';
import 'package:planthai/Account/bloc/account_bloc.dart';

class AccountScreen extends StatefulWidget {
  final String uid;
  const AccountScreen({Key key, @required this.uid}) : super(key: key);

  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();
    _accountBloc = AccountBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<AccountBloc>(
      create: (context) => AccountBloc(),
      child: Account(uid: widget.uid),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
