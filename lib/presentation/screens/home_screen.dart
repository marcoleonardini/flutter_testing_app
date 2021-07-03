import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing_app/bloc/character_bloc.dart';
import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/remote/character_remote_service.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterRemoteService = CharacterRemoteService(dio: Dio());

    final characterRepository =
        CharacterRepositoryImpl(characterRemoteService: characterRemoteService);
    final characterBloc =
        CharacterBloc(characterRepository: characterRepository);

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: StreamBuilder(
          stream: characterBloc.subject,
          builder: (context, snapshot) {
            return Container();
          },
        ),
      ),
    );
  }
}
