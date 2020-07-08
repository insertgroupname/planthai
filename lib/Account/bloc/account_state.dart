part of 'account_bloc.dart';

class AccountState {
  final bool isPictureValid;
  final bool isUsernameValid;
  final bool isGenderValid;
  final bool isBirthdayValid;
  final bool isSaving;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isUsernameValid && isGenderValid && isBirthdayValid;

  AccountState({
    @required this.isPictureValid,
    @required this.isUsernameValid,
    @required this.isGenderValid,
    @required this.isBirthdayValid,
    @required this.isSaving,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory AccountState.initial() {
    return AccountState(
      isPictureValid: true,
      isUsernameValid: true,
      isGenderValid: true,
      isBirthdayValid: true,
      isSaving: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AccountState.loading() {
    return AccountState(
      isPictureValid: true,
      isUsernameValid: true,
      isGenderValid: true,
      isBirthdayValid: true,
      isSaving: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AccountState.failure() {
    return AccountState(
      isPictureValid: true,
      isUsernameValid: true,
      isGenderValid: true,
      isBirthdayValid: true,
      isSaving: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory AccountState.success() {
    return AccountState(
      isPictureValid: true,
      isUsernameValid: true,
      isGenderValid: true,
      isBirthdayValid: true,
      isSaving: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  AccountState update({
    bool isPictureValid,
    bool isUsernameValid,
    bool isGenderValid,
    bool isBirthdayValid,
  }) {
    return copyWith(
      isPictureValid: isPictureValid,
      isUsernameValid: isUsernameValid,
      isGenderValid: isGenderValid,
      isBirthdayValid: isBirthdayValid,
      isSaving: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AccountState copyWith({
    bool isPictureValid,
    bool isUsernameValid,
    bool isGenderValid,
    bool isBirthdayValid,
    bool isSaving,
    bool isSuccess,
    bool isFailure,
  }) {
    return AccountState(
      isPictureValid: isPictureValid ?? this.isPictureValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isGenderValid: isGenderValid ?? this.isGenderValid,
      isBirthdayValid: isBirthdayValid ?? this.isBirthdayValid,
      isSaving: isSaving ?? this.isSaving,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''AccountState {
      isPictureValid: $isPictureValid,
      isUsernameValid: $isUsernameValid,
      isGenderValid: $isGenderValid.
      isBirthbayValid: $isBirthdayValid,
      isSaving: $isSaving,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
