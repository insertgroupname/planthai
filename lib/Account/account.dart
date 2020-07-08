import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:planthai/Account/bloc/account_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Account extends StatefulWidget {
  final String uid;
  Account({Key key, @required this.uid}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  File _imageFile;
  String pictureUrl = '';
  final ImagePicker _picker = ImagePicker();
  final firestoreInstance = Firestore.instance;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();
  final String imageDemo =
      'https://firebasestorage.googleapis.com/v0/b/planthai-840fa.appspot.com/o/profileImages%2Favatar.png?alt=media&token=bbbe9518-1509-4418-973b-f4d1111e9c25';

  AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    usernameController.addListener(_onUsernameChanged);
    genderController.addListener(_onGenderChanged);
    dobController.addListener(_onDobChanged);
    pictureController.addListener(_onPictureChanged);
    loadData();
    print('file' + _imageFile.toString());
    print('picurl' + pictureUrl);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _accountBloc,
      listener: (BuildContext context, AccountState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('save Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSaving) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Savingggggg ...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AccountBloc>(context).add(SavingChanged());
        }
      },
      child: BlocBuilder(
          bloc: _accountBloc,
          builder: (BuildContext context, AccountState state) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('PlanThai Account'),
                ),
                backgroundColor: Color.fromRGBO(68, 74, 88, 1),
                body: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListView(children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (_imageFile != null) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: FileImage(_imageFile),
                              ),
                            ),
                          )
                        ] else if (pictureUrl == '' && _imageFile == null) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage:
                                    AssetImage('assets/avatar.png'),
                              ),
                            ),
                          )
                        ] else if (pictureUrl != '' && _imageFile == null) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: NetworkImage(pictureUrl),
                              ),
                            ),
                          )
                        ],
                        Center(
                          child: GestureDetector(
                            child: AbsorbPointer(
                              child: Text(
                                'Upload your picture',
                                style: GoogleFonts.lato(
                                    textStyle:
                                        TextStyle(color: Hexcolor('#DCDCDC')),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20),
                              ),
                            ),
                            onTap: () {
                              _choseImage(ImageSource.gallery);
                              print('Choose Button');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 30),
                          child: Text(
                            'Username',
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(color: Colors.white),
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 30, right: 30),
                          child: TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                filled: true,
                                fillColor: Hexcolor('#C4C4C4')),
                            autocorrect: false,
                            autovalidate: true,
                            validator: (_) {
                              return !state.isUsernameValid
                                  ? 'Invalid username'
                                  : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 30),
                          child: LimitedBox(
                            maxHeight: 91.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Gender',
                                      style: GoogleFonts.lato(
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: SizedBox(
                                        width: 180,
                                        child: TextFormField(
                                          controller: genderController,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(),
                                            filled: true,
                                            fillColor: Hexcolor('#C4C4C4'),
                                          ),
                                          autocorrect: false,
                                          autovalidate: true,
                                          validator: (_) {
                                            return !state.isGenderValid
                                                ? 'Invalid Gender'
                                                : null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Birthday',
                                        style: GoogleFonts.lato(
                                            textStyle:
                                                TextStyle(color: Colors.white),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          width: 150,
                                          child: GestureDetector(
                                            child: AbsorbPointer(
                                              child: TextFormField(
                                                controller: dobController,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  filled: true,
                                                  fillColor:
                                                      Hexcolor('#C4C4C4'),
                                                ),
                                              ),
                                            ),
                                            onTap: () => {showCalendar()},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 150,
                            height: 90,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)),
                                  textColor: Colors.white,
                                  color: Hexcolor('#DB4A39'),
                                  child: Text(
                                    'Save Profile',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: _formSubmitted),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ));
          }),
    );
  }

  Future _choseImage(ImageSource imageSource) async {
    PickedFile selected = await _picker.getImage(source: imageSource);
    setState(() {
      _imageFile = selected != null ? File(selected.path) : null;
    });
  }

  // Future<void> _upload() async {
  //   String filePath = 'profileImages/${widget.uid}.png';
  //   _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
  //   StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
  //   String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //   print(downloadUrl);
  //   setState(() {
  //     pictureUrl = downloadUrl;
  //     pictureController.text = pictureUrl;
  //   });
  // }

  @override
  void dispose() {
    usernameController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    _accountBloc.add(
      UsernameChanged(username: usernameController.text),
    );
  }

  void _onGenderChanged() {
    _accountBloc.add(GenderChanged(gender: genderController.text));
  }

  void _onDobChanged() {
    _accountBloc.add(BirthdayChanged(birthday: dobController.text));
  }

  void _onPictureChanged() {
    _accountBloc.add(UploadPictureChanged(picture: _imageFile));
  }

  void _formSubmitted() {
    _accountBloc.add(SaveChanged(
        picture: _imageFile,
        username: usernameController.text,
        uid: widget.uid,
        gender: genderController.text,
        birthday: dobController.text));
  }

  void loadData() async {
    String username;
    String picture;
    String gender;
    String date;
    try {
      var value = await firestoreInstance
          .collection("users")
          .document(widget.uid)
          .get();
      print(value.data);
      username = value.data['username'];
      //email = widget.name;
      picture = value.data['picture'];
      gender = value.data['gender'];
      date = value.data['Birthday'];
      setState(() {
        // accountEmail = email;
        usernameController.text = username;
        pictureUrl = picture;
        genderController.text = gender;
        dobController.text = date != null ? date : '';
        print(value.data);
      });
    } catch (e) {
      print(e);
    }
  }

  void showCalendar() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));

    setState(() {
      dobController.text = date != null
          ? DateFormat.yMd().format(date).toString()
          : dobController.text;
      // _date = date!=null?date:DateTime.now();
    });
  }

// this will be not use if fluke finish implement;
  void goBack() {
    Navigator.pop(context);
  }
}
