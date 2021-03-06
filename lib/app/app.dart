import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_efficom/authentication_bloc/authentication_bloc.dart';
import 'package:projet_efficom/authentication_bloc/bloc.dart';
import 'package:projet_efficom/login/login_page.dart';
import 'package:projet_efficom/pages/caloriepage.dart';
import 'package:projet_efficom/pages/homepage.dart';
import 'package:projet_efficom/repositories/user_repository.dart';
import 'package:projet_efficom/splash_screen.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationInitial){
            return SplashScreen();
          }
          if(state is AuthenticationSuccess){
            return CaloriePage(title: state.displayName);
          }
          if(state is AuthenticationFailure){
            return LoginScreen(userRepository: _userRepository);
          }
          return Container();
        },
      ),
    );
  }
}