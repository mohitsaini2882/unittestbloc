import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnunittest/bloc/models/user_model.dart';
import 'package:learnunittest/bloc/user/user_bloc.dart';
import 'package:learnunittest/bloc/user/user_event.dart';
import 'package:learnunittest/bloc/user/user_repository.dart';
import 'package:learnunittest/bloc/user/user_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('UserBloc', () {
    late MockUserRepository mockUserRepository;
    late UserBloc userBloc;

    setUp(() {
      mockUserRepository = MockUserRepository();
      userBloc = UserBloc(userRepository: mockUserRepository);
    });

    tearDown(() {
      print("tearDown run for UserBloc");
      userBloc.close();
    });

    blocTest<UserBloc, UserState>(
      'emits [UserLoadInProgress, UserLoadSuccess] when UserFetched is added and fetch is successful',
      //wait: Duration(seconds: 10),
      build: () {
        when(mockUserRepository.fetchUser(2)).thenAnswer((_) async => User(
          id: 2,
          email: 'janet.weaver@reqres.in',
          firstName: 'Janet',
          lastName: 'Weaver',
          avatar: 'https://reqres.in/img/faces/2-image.jpg',
        ));
        return userBloc;
      },
      act: (bloc) {
        bloc.add(UserFetched(2));
      },
      expect: () => [
        UserLoadInProgress(),
        UserLoadSuccess(User(
          id: 2,
          email: 'janet.weaver@reqres.in',
          firstName: 'Janet',
          lastName: 'Weaver',
          avatar: 'https://reqres.in/img/faces/2-image.jpg',
        )),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoadInProgress, UserLoadFailure] when UserFetched is added and fetch fails',
      build: () {
        when(mockUserRepository.fetchUser(2)).thenThrow(Exception('Failed to load user'));
        return userBloc;
      },
      act: (bloc) => bloc.add(UserFetched(2)),
      expect: () => [
        UserLoadInProgress(),
        UserLoadFailure('Failed to load user'),
      ],
    );
  });
}
