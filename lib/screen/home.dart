import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:planthai/tatapi/tat_retrive_data.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: FutureBuilder(
                future: retrieveRouteData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  return CarouselSlider.builder(
                    itemCount: 10,
                    options: CarouselOptions(
                        height: 240.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3)),
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data != null) {
                        return Container(
                            child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: snapshot
                                                  .data[index].thumbnailUrl !=
                                              null
                                          ? NetworkImage(
                                              snapshot.data[index].thumbnailUrl)
                                          : Text('Loading Image'))),
                            ),
                            Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: Center(child: Text(snapshot.data[index].routeName)),
                            ),
                          ],
                        ));
                      } else {
                        return Text('Loading Data');
                      }
                    },
                  );
                }),
          )
        ];
      },
      body: FutureBuilder<List>(
        future: retrieveAttractionData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.data != null) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  padding: EdgeInsets.all(16),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: Card(
                      color: Colors.black12,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 20.0 / 11.0,
                            child: Image.network(
                              snapshot.data[index].thumbnailUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                            child: Wrap(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    snapshot.data[index].placeName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
                  }),
            );
          } else {
            return Container(
              child: Text('Loading Data'),
            );
          }
        },
      ),
    ));
  }

  Future<List<dynamic>> retrieveAttractionData() async {
    // ถ้าเวลาเหลือจะสร้าง เลขมา random เอาค่า แบบสุ่ม จากlist ทั้งหมด
    TatHttp tatreceiveData = new TatHttp();
    var list = await tatreceiveData.retrieveAttractionData();
    return list;
  }

  Future<List<dynamic>> retrieveRouteData() async {
    // ถ้าเวลาเหลือจะสร้าง เลขมา random เอาค่า แบบสุ่ม จากlist ทั้งหมด
    TatHttp tatreceiveData = new TatHttp();
    var list = await tatreceiveData.getRecommendedRouteList(null);
    print(list);
    return list;
  }
}
