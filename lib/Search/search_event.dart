part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends SearchEvent {
  @override
  String toString() => 'Access Load Data';
}

class SearchChanged extends SearchEvent {
  final String searchText;

  const SearchChanged({
    @required this.searchText,
  });

  @override
  List<Object> get props => [searchText];

  @override
  String toString() => 'SearchChanged { searchText :$searchText }';
}
