import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserFetched extends UserEvent {
  final int id;

  const UserFetched(this.id);

  @override
  List<Object> get props => [id];
}
