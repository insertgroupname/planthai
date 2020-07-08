import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planthai/Account/account_screen.dart';
import 'package:planthai/Authentication/authentication_bloc.dart';
import 'package:planthai/screen/home.dart';
import 'package:planthai/screen/search.dart';
import 'package:planthai/screen/test_write_db.dart';
import 'package:planthai/screen/attraction_detail.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String uid;
  HomeScreen({Key key, @required this.name, @required this.uid})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bottom navigation
  String currentAccountPicture;
  String accountName;
  String accountEmail;
  final String imageDemo =
      'https://firebasestorage.googleapis.com/v0/b/planthai-840fa.appspot.com/o/profileImages%2Favatar.png?alt=media&token=bbbe9518-1509-4418-973b-f4d1111e9c25';
  final firestoreInstance = Firestore.instance;
  int _selectedPage = 0;
  final _pageOptions = [Home(), TestDb(), Text('PlanList')];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName:
                    accountName != null ? Text(accountName) : Text('No data'),
                accountEmail: accountEmail != null
                    ? Text(accountEmail)
                    : Text('This is from firebase${widget.name}'),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: currentAccountPicture != null
                        ? NetworkImage(currentAccountPicture)
                        : NetworkImage(imageDemo)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountScreen(uid: widget.uid),
                      )).then((value) {
                    setState(() {
                      loadData();
                    });
                  });
                },
                child: ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text("Account"),
                ),
              ),
              GestureDetector(
                child: ListTile(
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationLoggedOut(),
                    );
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Logout"),
                ),
              ),
              Divider(),
              Expanded(
                child: Align(
                    alignment: FractionalOffset(0.5, 0.88),
                    child: SizedBox(
                      width: 250,
                      child: RaisedButton(
                          color: Colors.red,
                          onPressed: () {
                            print("Upgrade your account");
                          },
                          child: const Text(
                            'Upgrade Account',
                            style: TextStyle(color: Colors.white),
                          )),
                    )),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('PlanThai'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AttractionDetail(placeId: 'P02000001'),
                    ));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ));
              },
            )
          ],
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2)]),
          child: BottomNavigationBar(
            backgroundColor: Hexcolor('#333333'),
            fixedColor: Hexcolor('#FFFFFF'),
            unselectedItemColor: Hexcolor('#FFFFFF'),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedPage,
            elevation: 20.0,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('Planning'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark),
                title: Text('Plan list'),
              ),
            ],
          ),
        ));
  }

  void loadData() async {
    String username;
    String picture;
    String email;
    try {
      var value = await firestoreInstance
          .collection("users")
          .document(widget.uid)
          .get();
      print('load Data');
      print(value.data);
      username = value.data['username'];
      email = widget.name;
      picture = value.data['picture'];

      setState(() {
        accountEmail = email;
        accountName = username;
        currentAccountPicture = picture;
      });
    } catch (e) {
      return null;
    }
  }
}
