import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planthai/Search/search_bloc.dart';
import 'package:planthai/tatapi/tat_retrive_data.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchTextController = TextEditingController();
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc.add(LoadData());
    searchTextController.addListener(_onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: TextField(
              controller: searchTextController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Search for place to travel",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.filter_list),
              )
            ],
          )
        ];
      },
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
          if (state is SearchStateLoaded) {
            return state.list.isEmpty
                ? Container(
                    child: Text('No result'),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
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
                                    state.list[index].thumbnailUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.0, 12.0, 16.0, 8.0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          state.list[index].placeName,
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
              child: Text("..." +
                  state.toString() +
                  "||" +
                  _searchBloc.initialState.toString() +
                  "||" +
                  _searchBloc.state.toString()),
            );
          }
        },
      ),
    )));
  }

  void _onSearchTextChanged() {
    _searchBloc.add(SearchChanged(
      searchText: searchTextController.text,
    ));
  }

  Future<List<dynamic>> retrieveData() async {
    // ถ้าเวลาเหลือจะสร้าง เลขมา random เอาค่า แบบสุ่ม จากlist ทั้งหมด
    TatHttp tatreceiveData = new TatHttp();
    var list = await tatreceiveData.retrieveData();
    return list;
  }
}
