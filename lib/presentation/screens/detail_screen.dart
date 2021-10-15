import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_testing_app/bloc/detail_character_bloc.dart';
import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:flutter_testing_app/services/remote/character_remote_service.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailCharacterBloc characterBloc;

  @override
  void initState() {
    // TODO: Extract using Dependency Injection
    final characterRemoteService = CharacterRemoteService(dio: Dio());

    final characterRepository = CharacterRepositoryImpl(characterRemoteService: characterRemoteService);
    characterBloc = DetailCharacterBloc(characterRepository: characterRepository)..charactersById(widget.id);
    // END TODO
    super.initState();
  }

  @override
  void dispose() {
    characterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(12),
          child: StreamBuilder(
            stream: characterBloc.subject,
            builder: _streamBuilder,
          ),
        ),
      ),
    );
  }

  Widget _streamBuilder(context, AsyncSnapshot<DetailCharacterBlocState> snapshot) {
    if (snapshot.hasError) {
      return const Center(
        child: Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
    if (!snapshot.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    switch (snapshot.data!.status) {
      case DetailCharacterBlocStatus.error:
        return const Center(
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        );

      case DetailCharacterBlocStatus.initial:
      case DetailCharacterBlocStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case DetailCharacterBlocStatus.loaded:
        return DetailScreenWidget(character: snapshot.data!.character!);
    }
  }
}

class DetailScreenWidget extends StatelessWidget {
  final CharacterModel character;

  const DetailScreenWidget({
    required this.character,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _CustomText(text: character.name, fontSize: 40),
          _CustomText(text: character.nickname),
          const SizedBox(height: 12),
          _CharacterImage(character: character),
          const Divider(color: Colors.black45),
          _CustomText(text: 'Appearences: ${character.appearance.length} Seasons'),
          _CustomText(text: 'Birthday: ${character.birthday}'),
          _CustomText(text: 'Occupation: ${character.occupation[0]} '),
          _CustomText(text: 'Portrayed: ${character.portrayed}'),
          _CustomText(text: 'Category: ${character.category}'),
          _CustomText(text: 'Status: ${character.status}'),
        ],
      ),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  const _CharacterImage({
    required this.character,
    Key? key,
  }) : super(key: key);

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        character.img,
        height: 250,
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    required this.text,
    this.fontSize = 28,
    Key? key,
  }) : super(key: key);

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          text,
          style: GoogleFonts.vt323(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      );
}
