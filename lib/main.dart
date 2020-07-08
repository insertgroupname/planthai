import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planthai/Account/account.dart';
import 'package:planthai/Authentication/authentication_bloc.dart';
import 'package:planthai/simple_bloc_delegate.dart';
import 'package:planthai/user_repository.dart';
import 'package:planthai/home_screen.dart';
import 'package:planthai/login/login.dart';
import 'package:planthai/splash_screen.dart';

import 'Search/search_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(userRepository: userRepository));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;
  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(userRepository: _userRepository)
                ..add(AuthenticationStarted());
            },
          ),
          BlocProvider<SearchBloc>(lazy:false,create: (context) {
            return SearchBloc()..add(LoadData());
          })
        ],
        child: MaterialApp(
          title: 'PlanThai',
          theme: ThemeData(
              primaryColor: Hexcolor('#333333'),
              scaffoldBackgroundColor: Color.fromRGBO(68, 74, 88, 1)),
          initialRoute: '/',
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return SplashScreen();
                }
                if (state is AuthenticationFailure) {
                  return LoginScreen(
                    userRepository: _userRepository,
                  );
                }
                if (state is AuthenticationSuccess) {
                  return HomeScreen(
                    name: state.displayName,
                    uid: state.uid,
                  );
                }
              });
            }
          },
        ));
  }
}
// main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   BlocSupervisor.delegate = SimpleBlocDelegate();
//   final UserRepository userRepository = UserRepository();
//   runApp(BlocProvider(
//     create: (context) => AuthenticationBloc(userRepository: userRepository)
//       ..add(AuthenticationStarted()),
//     child: App(userRepository: userRepository),
//   ));
// }

// class App extends StatelessWidget {
// final UserRepository _userRepository;
// App({Key key, @required UserRepository userRepository})
//     : assert(userRepository != null),
//       _userRepository = userRepository,
//       super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//             primaryColor: Hexcolor('#333333'),
//             scaffoldBackgroundColor: Color.fromRGBO(68, 74, 88, 1)),
//         home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//           builder: (context, state) {
//             if (state is AuthenticationInitial) {
//               return SplashScreen();
//             }
//             if (state is AuthenticationFailure) {
//               return LoginScreen(
//                 userRepository: _userRepository,
//               );
//             }
//             if (state is AuthenticationSuccess) {
// return HomeScreen(
//   name: state.displayName,
//   uid: state.uid,
// );
//             }
//           },
//         ));
//   }
// }
