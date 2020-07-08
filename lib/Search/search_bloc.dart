import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:planthai/screen/search.dart';
import 'package:planthai/tatapi/tat_retrive_data.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => SearchStateLoading();

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! SearchChanged && event is! LoadData);
    });
    final debounceStream = events.where((event) {
      return (event is SearchChanged && event is LoadData);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    print(event.toString());
    if (event is LoadData) {
      print('in map state');
      yield* _mapLoadDataToState();
    } else if (event is SearchChanged) {
      yield* _mapSearchChangedToState(event.searchText);
    }
  }

  Stream<SearchState> _mapLoadDataToState() async* {
    print('ggg');
    try {
      TatHttp tatreceiveData = new TatHttp();
      print('after try');
      var list = await tatreceiveData.retrieveData();
      print('aasdsad');
      yield SearchStateLoaded(list);
    } catch (e) {}
  }

  Stream<SearchState> _mapSearchChangedToState(String searchText) async* {
    yield SearchStateLoading();
    try {
      // ถ้าเวลาเหลือจะสร้าง เลขมา random เอาค่า แบบสุ่ม จากlist ทั้งหมด
      TatHttp tatreceiveData = new TatHttp();
      var list = await tatreceiveData.retrieveData();

      yield SearchStateSuccess(list);
    } catch (e) {}
  }
}
