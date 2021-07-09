import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing_app/bloc/character_bloc.dart';
import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';

import 'package:flutter_testing_app/services/remote/character_remote_service.dart';
import 'package:google_fonts/google_fonts.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late CharacterBloc characterBloc;

  @override
  void initState() {
    final characterRemoteService = CharacterRemoteService(dio: Dio());

    final characterRepository =
        CharacterRepositoryImpl(characterRemoteService: characterRemoteService);
    characterBloc = CharacterBloc(characterRepository: characterRepository)
      ..allCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: StreamBuilder(
          stream: characterBloc.subject,
          builder: _streamBuilder,
        ),
      ),
    );
  }

  Widget _streamBuilder(context, AsyncSnapshot<CharacterBlocState> snapshot) {
    if (!snapshot.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (snapshot.hasError) {
      return const Center(
        child: Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }

    switch (snapshot.data!.status) {
      case CharacterBlocStatus.error:
        return const Center(
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        );

      case CharacterBlocStatus.initial:
      case CharacterBlocStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case CharacterBlocStatus.loaded:
        return CharactersGridView(
          list: snapshot.data!.list!,
        );
    }
  }
}

class CharactersGridView extends StatelessWidget {
  const CharactersGridView({
    required this.list,
    Key? key,
  }) : super(key: key);

  final List<CharacterModel> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    list[index].img,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    loadingBuilder: (context, child, progress) {
                      var widget = child;
                      if (progress != null) {
                        widget = Icon(
                          Icons.image,
                          key: UniqueKey(),
                          color: Colors.grey,
                          size: 48,
                        );
                      }

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 750),
                        layoutBuilder: (current, previous) {
                          var children = previous;
                          if (current != null) {
                            children = children.toList()..add(current);
                          }
                          return Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: children,
                          );
                        },
                        child: widget,
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      width: double.infinity,
                      color: Colors.white54,
                      child: Text(
                        list[index].name,
                        style: GoogleFonts.vt323(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
