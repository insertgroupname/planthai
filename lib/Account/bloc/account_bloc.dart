import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:planthai/validators.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  @override
  AccountState get initialState => AccountState.initial();

  @override
  Stream<Transition<AccountEvent, AccountState>> transformEvents(
    Stream<AccountEvent> events,
    TransitionFunction<AccountEvent, AccountState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! UploadPictureChanged &&
          event is! UsernameChanged &&
          event is! GenderChanged &&
          event is! BirthdayChanged);
    });
    final debounceStream = events.where((event) {
      return (event is UploadPictureChanged ||
          event is UsernameChanged ||
          event is GenderChanged ||
          event is BirthdayChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is UploadPictureChanged) {
      yield* _mapUploadPictureChangedToState(event.picture);
    } else if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } else if (event is GenderChanged) {
      yield* _mapGenderChangedToState(event.gender);
    } else if (event is BirthdayChanged) {
      yield* _mapBirthdayChangedToState(event.birthday);
    } else if (event is SaveChanged) {
      yield* _mapSaveChangedToState(event.uid, event.picture, event.username,
          event.gender, event.birthday);
    }
  }

  Stream<AccountState> _mapUploadPictureChangedToState(File picture) async* {
    yield state.update(isPictureValid: picture != null ? true : false);
  }

  Stream<AccountState> _mapUsernameChangedToState(String username) async* {
    yield state.update(
        isUsernameValid: Validators.isValidUsernameAndGender(username));
  }

  Stream<AccountState> _mapGenderChangedToState(String gender) async* {
    yield state.update(
        isGenderValid: Validators.isValidUsernameAndGender(gender));
  }

  Stream<AccountState> _mapBirthdayChangedToState(String birthday) async* {
    yield state.update(isBirthdayValid: Validators.isValidDate(birthday));
  }

  Stream<AccountState> _mapSaveChangedToState(String uid, File picture,
      String username, String gender, String birthday) async* {
    yield AccountState.loading();
    try {
      final firestoreInstance = Firestore.instance;
      String pictureUrl;
      if (picture != null) {
        final FirebaseStorage _storage =
            FirebaseStorage(storageBucket: 'gs://planthai-840fa.appspot.com');
        StorageUploadTask _uploadTask;
        String filePath = 'profileImages/${uid}.png';
        _uploadTask = _storage.ref().child(filePath).putFile(picture);
        StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
        pictureUrl = await taskSnapshot.ref.getDownloadURL();
      } else {
        var oldFile =
            await firestoreInstance.collection('users').document(uid).get();
        pictureUrl = oldFile.data['picture'];
      }

      await firestoreInstance.collection("users").document(uid).setData({
        "gender": gender,
        "Birthday": birthday,
        "username": username,
        "picture": pictureUrl != null ? pictureUrl : '',
      }, merge: true);
      yield AccountState.success();
    } catch (_) {
      yield AccountState.failure();
    }
  }
}
