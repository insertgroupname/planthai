import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planthai/tatapi/tat_retrive_data.dart' as tat;

class TestDb extends StatefulWidget {
  @override
  _TestDbState createState() => _TestDbState();
}

class _TestDbState extends State<TestDb> {
  final firestoreInstance = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What do people call you?',
              labelText: 'Name *',
            ),
            onSaved: (String value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String value) {
              return value.contains('@') ? 'Do not use the @ char.' : null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'what sex are you ?',
              labelText: 'SEX',
            ),
            onSaved: (String value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String value) {
              return value.contains('@') ? 'Do not use the @ char.' : null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'when you birth in format DD/MM/YYYY ?',
              labelText: 'Date of birth',
            ),
            onSaved: (String value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String value) {
              return value.contains('@') ? 'Do not use the @ char.' : null;
            },
          ),
          TextFormField(
            enabled: false,
            initialValue: 'email',
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: '',
              labelText: 'Email',
            ),
            onSaved: (String value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String value) {
              return value.contains('@') ? 'Do not use the @ char.' : null;
            },
          ),
          RaisedButton(
              child: Text("Press to test TAT query"),
              onPressed: () async {
                tat.TatHttp x = tat.TatHttp();
                var data = await x.retrieveData();
                int count = 0;
                for (var i in data) {
                  print("Data number: " + count.toString());
                  print(i.toString());
                  count++;
                  print(
                      "---------------------------------------------------------------------");
                }
                print(data[0].placeId);
              }),
          RaisedButton(
            child: Text("Press to query custom search(Edit in code)"),
            onPressed: () async {
              tat.TatHttp x = tat.TatHttp();
              var _queryParameter = {
                'keyword': 'สยาม',
                'geolocation': '', //userGeolocation
                'category_code': 'restaurant',
                'provincename': 'กรุงเทพมหานคร',
                'searchradius': '',
                'numberofresult': '20', //should be 20
                'pagenumber': '1', // User selected page number
                'destination': 'กรุงเทพมหานคร', // province name
              };
              var data = await x.searchPlace(_queryParameter);
              int count = 0;
              for (var i in data) {
                print("Data number: " + count.toString());
                print(i.toString());
                count++;
                print(
                    "---------------------------------------------------------------------");
              }
            },
          ),
          RaisedButton(
            child: Text("Test GetAttention place"),
            onPressed: () async {
              tat.TatHttp x = tat.TatHttp();
              var _pathPlaceId = "P03002579"; //edit place id here
              var data = await x.getAttractionPlace(_pathPlaceId);
              print("________________________________");
              print(data[0].mobilePictureUrls.toString());
              print(data[0].attractionPlaceInformation.detail);
              print(data[0].attractionPlaceInformation.detail.length);
              print(data.toString());
            },
          ),
          RaisedButton(
            child: Text("TestRouteList"),
            onPressed: () async {
              var _queryParameter = {
                "numberofday": "2",
                "geolocation": "13.67,100.76",
                "region": "C",
              };
              tat.TatHttp x = tat.TatHttp();
              var data = await x.getRecommendedRouteList(_queryParameter);
              int count = 0;
              for (var i in data) {
                print("Data number: " + count.toString());
                print(i.toString());
                count++;
                print(
                    "---------------------------------------------------------------------");
              }
            },
          ),
          RaisedButton(
              child: Text("Get accommodation detail [EDit id in code]"),
              onPressed: () async {
                var _pathPlaceId = "P02000001";
                tat.TatHttp x = new tat.TatHttp();
                var data = await x.getAccommodationPlace(_pathPlaceId);
                int count = 0;
                for (var i in data) {
                  print("Data number: " + count.toString());
                  print(i.toString());
                  count++;
                  print(
                      "---------------------------------------------------------------------");
                }
              }),
          RaisedButton(
              child: Text("Get restaurant Detail [EDit id in code]"),
              onPressed: () async {
                var _pathPlaceId = "P08009171";
                tat.TatHttp result = new tat.TatHttp();
                var data = await result.getRestaurantPlace(_pathPlaceId);
                for (var i in data) {
                  print("------------------------------");
                  print(i.toString());
                }
              })
        ],
      ),
    );
  }

  Future<String> getEmail() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var email = firebaseUser.email;
    return email;
  }

  void db() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var email = firebaseUser.email;
    firestoreInstance.collection("users").document(firebaseUser.uid).setData({
      "name": "john",
      "age": 50,
      "email": email,
      "address": {"street": "street 24", "city": "new york"}
    }, merge: true).then((_) {
      print("success!");
    });

    firestoreInstance
        .collection("users")
        .document(firebaseUser.uid)
        .get()
        .then((value) {
      print(value.data);
    });
  }

  void dbx() async {
    var firebaseAuth = await FirebaseAuth.instance.currentUser();
    var email = firebaseAuth.email;
    print("current email: " + email);
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email.toString())
        .getDocuments()
        .then((value) {
      print("value : ");
      if (value.documents.length == 0) {
        firestoreInstance
            .collection("users")
            .document()
            .setData({"email": email, "name": "no name set", "age": 0});
      }
      print((value.documents.length));
      value.documents.forEach((element) {
        print("retrive success");
        print(element.data);
      });
    });
  }
}

void testfunctionn() async {
  var firebaseAuth = await FirebaseAuth.instance.currentUser();
  var email = firebaseAuth.email;
  Firestore.instance
      .collection("users")
      .where("email", isEqualTo: email.toString())
      .getDocuments()
      .then((value) {
    value.documents.forEach((element) {
      print("retrive success");
      print(element.data);
    });
  });
}
