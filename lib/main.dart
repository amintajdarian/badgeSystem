import 'dart:io';

import 'package:badge_system/authentication/view/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages, library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'authentication/bloc/auth_bloc.dart';
import 'authentication/model/user_repository.dart';
import 'dashboard/model/character_comics_model.dart';
import 'dashboard/view/dashboard.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CharacterComicsModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          home: ScreenUtilInit(
              designSize: ScreenUtil.defaultSize,
              minTextAdapt: true,
              builder: (parentContext, widget) {
                return StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const Dashboard();
                      }
                      return SignIn();
                    });
              }),
        ),
      ),
    );
  }
}
