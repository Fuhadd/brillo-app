// import 'package:escort/config/blocs/bloc/auth_bloc/auth_bloc.dart';
// import 'package:escort/screens/bottom_navigation.dart';
// import 'package:escort/screens/conversation_screen.dart';
// import 'package:escort/screens/login_screens.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AuthScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthenticationSuccessState) {
//           print(state);
//           return BottomNavigation();
//         } else if (state is AuthenticationFailedState) {
//           print(state);
//           return LoginScreen();
//         }
//         print(state);
//         return Container(
//           color: Colors.red,
//         );
//       },
//     );
//   }
// }
