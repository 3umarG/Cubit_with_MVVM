import 'package:cubit_tutorial/business/cubit/characters_cubit.dart';
import 'package:cubit_tutorial/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCharactersScreen extends StatefulWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  State<AllCharactersScreen> createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends State<AllCharactersScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        await BlocProvider.of<CharactersCubit>(context).fetchAllCharacters();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick And Morty Characters"),
        backgroundColor: yellow,
      ),
      body: Container(
        color: grey,
        child: BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
          if (state is CharactersStateLoading) {
            return const Center(
              child: CircularProgressIndicator(color: yellow,),
            );
          } else if (state is CharactersStateError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text(
                "Loaded Successfully !!",
                style: TextStyle(fontSize: 35),
              ),
            );
          }
        }),
      ),
    );
  }
}
