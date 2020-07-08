part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class UploadPictureChanged extends AccountEvent {
  final File picture;
  const UploadPictureChanged({@required this.picture});

  @override
  List<Object> get props => [picture];

  @override
  String toString() => 'UploadPictureChanged { picture :$picture }';
}

class UsernameChanged extends AccountEvent {
  final String username;
  const UsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username :$username }';
}

class GenderChanged extends AccountEvent {
  final String gender;
  const GenderChanged({@required this.gender});

  @override
  List<Object> get props => [gender];

  @override
  String toString() => 'GenderChanged { gender :$gender }';
}

class BirthdayChanged extends AccountEvent {
  final String birthday;
  const BirthdayChanged({@required this.birthday});

  @override
  List<Object> get props => [birthday];

  @override
  String toString() => 'BirthdayChanged { birthday :$birthday }';
}

class SaveChanged extends AccountEvent {
  final File picture;
  final String username;
  final String gender;
  final String birthday;
  final String uid;
  const SaveChanged(
      {this.picture,
      @required this.username,
      @required this.uid,
      @required this.gender,
      @required this.birthday});

  @override
  List<Object> get props => [picture, username, gender, birthday, uid];

  @override
  String toString() =>
      'SaveChanged { picture :$picture, username :$username,uid :$uid ,gender :$gender, birthday :$birthday }';
}

class SavingChanged extends AccountEvent {
  @override
  String toString() => 'SaveChanged';
}
