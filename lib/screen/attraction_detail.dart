import 'package:flutter/material.dart';
import 'package:planthai/tatapi/tat_retrive_data.dart';

class AttractionDetail extends StatefulWidget {
  @override
  _AttractionDetailState createState() => _AttractionDetailState();
  final String placeId;
  AttractionDetail({Key key, @required this.placeId}) : super(key: key);
}

class _AttractionDetailState extends State<AttractionDetail> {
  List a;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.placeId != null ? Text(widget.placeId) : Text('gg'),
        ),
        body: FutureBuilder(
            future: retrieveAccommodationPlace(widget.placeId),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Center(child: Text(snapshot.data[0].placeName)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Image.network(
                          snapshot.data[0].thumbnailUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Text('Lorem ipsum dolor sit, amet appetere consequi constituit quales. Contentam dialectica extremo labore, malivoli sapientem verbi. Antiquitate honestatis orci statuam. Alia cepisse firmam perfecto sentio.'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: '1',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: '1',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Future<List> retrieveAccommodationPlace(String placeId) async {
    TatHttp tatreceiveData = new TatHttp();
    var list = await tatreceiveData.getAccommodationPlace(placeId);
    print(list);
    return list;
  }
}
