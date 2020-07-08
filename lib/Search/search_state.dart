part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SearchState {}

class SearchStateLoading extends SearchState {
  @override
  String toString() => 'Loading Search';
}

class SearchStateLoaded extends SearchState {
  final List list;
  const SearchStateLoaded(this.list);
  @override
  List<Object> get props => [list];
  @override
  String toString() => 'TodosLoaded { todos: $list }';
}

class SearchStateSuccess extends SearchState {
  final List<dynamic> items;

  const SearchStateSuccess(this.items);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}
