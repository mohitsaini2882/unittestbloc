import 'package:bloc/bloc.dart';
import 'package:learnunittest/bloc/user/user_event.dart';
import 'package:learnunittest/bloc/user/user_repository.dart';
import 'package:learnunittest/bloc/user/user_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    // Register event handlers in the constructor
    on<UserFetched>((event, emit) async {
      emit(UserLoadInProgress());
      try {
        final user = await userRepository.fetchUser(event.id);
        emit(UserLoadSuccess(user));
      } catch (e) {
        emit(UserLoadFailure('Failed to load user'));
      }
    });
  }

  // Optionally override the close method to clean up resources
  @override
  Future<void> close() {
    // Clean up resources here if needed
    return super.close();
  }
}
