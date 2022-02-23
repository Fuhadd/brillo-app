import 'package:brilloapp/config/blocs/bloc/auth_bloc/auth_bloc.dart';
import 'package:brilloapp/config/blocs/bloc/image_storage_bloc/image_bloc.dart';
import 'package:brilloapp/config/blocs/bloc/login_bloc/login_bloc.dart';
import 'package:brilloapp/config/blocs/bloc/signup_bloc/signup_bloc.dart';
import 'package:brilloapp/config/repositories/firease_storage_repository.dart';
import 'package:brilloapp/config/repositories/firestore_repository.dart';
import 'package:brilloapp/config/repositories/user_repository.dart';
import 'package:brilloapp/config/theme.dart';
import 'package:brilloapp/screens/auth_screen.dart';
import 'package:brilloapp/screens/bottom_navigation.dart';
//import 'package:brilloapp/screens/discover_screen.dart';
import 'package:brilloapp/screens/forgot_password_screen.dart';
import 'package:brilloapp/screens/home_screen.dart';
import 'package:brilloapp/screens/login_screen.dart';
import 'package:brilloapp/screens/signup_screen.dart';
import 'package:brilloapp/screens/signup_second_screen.dart';
import 'package:brilloapp/screens/splash_screen.dart';
import 'package:brilloapp/screens/test_screen.dart';
import 'package:brilloapp/screens/user_profile_screen.dart';
import 'package:brilloapp/screens/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'brilloApp1',
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD46Pyf-jTY6cjAh9Jv5-3-jyRbA1D9i8s',
        appId: '1:307408133228:android:e508ea546c867c7e760c49',
        messagingSenderId: '',
        projectId: 'brilloapp-2a43f',
        storageBucket: 'gs://brilloapp-2a43f.appspot.com/', // Your projectId
      ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final firestoreRepository = FirestoreRepository();
    final firebaseStorage = FirebaseStorageRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userRepository),
        ),
        BlocProvider(
          create: (context) => AuthBloc(userRepository),
        ),
        BlocProvider(
          create: (context) => SignupBloc(userRepository, firestoreRepository),
        ),
        BlocProvider(
          create: (context) => ImageBloc(firebaseStorage, firestoreRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme()
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        ,
        home: //SignUpScreen(),
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  } else if (snapshot.hasData) {
                    return VerifyEmailScreen();
                  } else {
                    return LoginScreen();
                  }
                }),
        routes: {
          SignUpScreen.routeName: (context) => SignUpScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          ForgotPassword.routeName: (context) => ForgotPassword(),
          SignUpSecondScreen.routeName: (context) => SignUpSecondScreen(),
          VerifyEmailScreen.routeName: (context) => VerifyEmailScreen(),
          BottomNavigation.routeName: (context) => BottomNavigation(),
          ProfileScreen.routeName: ((context) => ProfileScreen())
        },
      ),
    );
  }
}
