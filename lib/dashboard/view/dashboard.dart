import 'package:badge_system/authentication/bloc/auth_bloc.dart';
import 'package:badge_system/authentication/view/sign_in.dart';
import 'package:badge_system/dashboard/bloc/badge_bloc.dart';
import 'package:badge_system/dashboard/model/character_comics_model.dart';
import 'package:badge_system/dashboard/service/badge_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignIn()),
                (route) => false,
              );
            }
          },
          child: Center(
            child: BlocProvider<BadgeBloc>(
              create: (context) => BadgeBloc(box: BadgeDatabase()),
              child: BlocBuilder<BadgeBloc, BadgeState>(builder: (context, state) {
                if (state is BadgeInitial) {
                  context.read<BadgeBloc>().add(BadgeLoadedEvent());
                }
                if (state is BadgeLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is BadgeLoadedState) {
                  return ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          int newBadge = state.characters[index].badge;
                          context.read<BadgeBloc>().add(BageEditedEvent(
                              index: index,
                              character: CharacterComicsModel(
                                badge: ++newBadge,
                                name: state.characters[index].name,
                              )));
                        },
                        title: Text(state.characters[index].name),
                        subtitle: Text(state.characters[index].badge.toString()),
                      );
                    },
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email: \n ${user.email}',
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    user.displayName != null ? Text("${user.displayName}") : Container(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      child: const Text('Sign Out'),
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutRequested());
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ));
  }
}
