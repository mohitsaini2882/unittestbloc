import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_event.dart';
import '../bloc/user/user_state.dart';



class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  late UserBloc userBloc;

  void fetchUser(){
    userBloc.add(UserFetched(2));
  }

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Info')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserInitial) {
                  return Text('Press the button to fetch user data');
                } else if (state is UserLoadInProgress) {
                  return CircularProgressIndicator();
                } else if (state is UserLoadSuccess) {
                  return Column(
                    children: <Widget>[
                      Image.network(state.user.avatar),
                      Text('${state.user.firstName} ${state.user.lastName}'),
                      Text(state.user.email),
                    ],
                  );
                } else if (state is UserLoadFailure) {
                  return Text('Failed to fetch user: ${state.error}');
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=>fetchUser(),
              child: const Text('Fetch User'),
            ),
          ],
        ),
      ),
    );
  }
}