import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/config/repositories/firestore_repository.dart';
import 'package:brilloapp/models/models.dart' as app_user;

import 'package:brilloapp/screens/splash_screen.dart';
import 'package:brilloapp/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //FirestoreRepository? firestoreRepository;
  @override
  Widget build(BuildContext context) {
    FirestoreRepository firestoreRepository = FirestoreRepository();
    // CollectionReference users =
    //     FirebaseFirestore.instance.collection('UserData');
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder<app_user.User?>(
          future: firestoreRepository.getUsersCredentials(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            // if (snapshot.hasData && !snapshot.data!.exists) {
            //   return Text("Document does not exist");
            // }

            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final user = snapshot.data;
              return buildUserPage(context, user);
            }

            return SplashScreen();
          },
        ));
  }
}

Widget buildUserPage(BuildContext context, app_user.User? user) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      user!.imageUrl,
                    ),
                  ),
                  vericalSpacer(5),
                  Text(
                    user.userName,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purple, Colors.pink],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    // topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(20.0),
                    //topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(20.0)),
                // image: DecorationImage(
                //     image: NetworkImage(
                //       'https://images.unsplash.com/photo-1639928758287-db12413453c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
                //     ),
                //     fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: (() {
                  showBottomSheet(context,
                      gender: user.gender,
                      userName: user.userName,
                      userEmail: user.email,
                      userPhone: user.phone);
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Edit Profile',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      horizontalSpacer(5),
                      const Icon(Icons.edit),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        vericalSpacer(20),
        UserFields(
          context,
          icon: Icons.mail,
          title: 'Email',
          details: user.email,
        ),
        vericalSpacer(20),
        UserFields(context,
            icon: Icons.phone, title: 'Phone Number', details: user.phone),
        vericalSpacer(20),
        UserFields(
          context,
          icon: Icons.people,
          title: 'Gender',
          details: user.gender,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Icon(
                Icons.data_usage,
                size: 17,
              ),
              horizontalSpacer(10),
              vericalSpacer(20),
              const Text(
                'Interests',
                textAlign: TextAlign.left,
              ),
              vericalSpacer(40),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
              children: user.interests
                  .map((interest) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.pink],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(interest),
                        ),
                      ))
                  .toList()),
        )
      ],
    ),
  );
}

Widget UserFields(BuildContext context,
    {required IconData icon, required String title, required String details}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      children: [
        Container(
          child: Column(
            children: [
              (Row(
                children: [
                  Icon(
                    icon,
                    size: 17,
                  ),
                  horizontalSpacer(10),
                  vericalSpacer(20),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                  ),
                  vericalSpacer(40),
                ],
              )),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 35),
                  child: Text(
                    details,
                    style: Theme.of(context).textTheme.headline5,
                  )),
              vericalSpacer(15)
            ],
          ),
          width: double.infinity - 50,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> showBottomSheet(BuildContext context,
    {var phoneNumber,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? gender}) {
  final _formKey = GlobalKey<FormBuilderState>();
  FirestoreRepository firestoreRepository = FirestoreRepository();
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    customFormBuilderTextField(
                      'username',
                      Icons.person,
                      null,
                      'User Name',
                      initialValue: userName,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.minLength(context, 4,
                              errorText:
                                  'A valid username should be greater than 4 characters '),
                        ],
                      ),
                    ),
                    vericalSpacer(25),
                    customFormBuilderTextField(
                      'email',
                      Icons.mail,
                      null,
                      'Email',
                      initialValue: userEmail,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.email(context,
                              errorText: 'Provided email not valid '),
                          FormBuilderValidators.required(context,
                              errorText: 'Email field cannot be empty '),
                        ],
                      ),
                    ),
                    vericalSpacer(25),
                    IntlPhoneField(
                      initialValue: userPhone,
                      //controller: phoneController,
                      decoration:
                          customFormDecoration('Phone Number', null, null),
                      initialCountryCode: 'NG',
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber;
                        print(phone.completeNumber);
                      },
                    ),

                    vericalSpacer(25),

                    vericalSpacer(30),

                    CustomButton(
                      formKey: _formKey,
                      onPressed: () {
                        var validate = _formKey.currentState?.validate();
                        if (validate == true) {
                          _formKey.currentState?.save();
                          var username =
                              _formKey.currentState?.fields['username']?.value;
                          var email =
                              _formKey.currentState?.fields['email']?.value;

                          var phone = phoneNumber;

                          firestoreRepository.saveUserCredentials(
                              username, email, phone, gender);

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Update details',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    vericalSpacer(20),
                    // BlocListener<SignupBloc, SignupState>(
                    //     listener: (context, state) {
                    //   if (state is SignupSuccessful) {
                    //     Navigator.pushReplacementNamed(
                    //         context, SignUpSecondScreen.routeName);
                    //   }
                    // }, child: BlocBuilder<SignupBloc, SignupState>(
                    //   builder: ((context, state) {
                    //     if (state is SignupInProgress) {
                    //       return const SpinKitRotatingPlain(
                    //         color: Colors.red,
                    //       );
                    //       print(state);
                    //     } else if (state is SignupFailed) {
                    //       return Text(state.message);
                    //       print(state);
                    //     } else if (state is SignupInProgress) {
                    //       return Container();
                    //       print(state);
                    //     }
                    //     return Container();
                    // }),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
