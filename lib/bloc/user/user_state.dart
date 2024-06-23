import 'package:equatable/equatable.dart';

import '../models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserLoadInProgress;

  @override
  int get hashCode => runtimeType.hashCode;
}

class UserLoadSuccess extends UserState {
  final User user;

  const UserLoadSuccess(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is UserLoadSuccess && other.user == user);

  @override
  int get hashCode => user.hashCode;
}

class UserLoadFailure extends UserState {
  final String error;

  const UserLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
