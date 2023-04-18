import 'package:cubit_tutorial/business/cubit/characters_cubit.dart';
import 'package:cubit_tutorial/core/constants/colors.dart';
import 'package:cubit_tutorial/data/models/character_model.dart';
import 'package:cubit_tutorial/presentation/widgets/character_item.dart';
import 'package:cubit_tutorial/presentation/widgets/no_internet_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class AllCharactersScreen extends StatefulWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  State<AllCharactersScreen> createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends State<AllCharactersScreen> {
  final _searchEditingController = TextEditingController();
  bool _isSearching = false;
  List<CharacterModel> _searchedList = [];
  late List<CharacterModel> _allCharacters;

  Widget _buildAppBarTitle() => const Text(
        "Rick And Morty Characters",
        style: TextStyle(
          color: grey,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _buildSearchBar() => TextField(
        controller: _searchEditingController,
        style: const TextStyle(
          color: grey,
          fontSize: 18,
        ),
        onChanged: (searchQuery) {
          setState(() {
            _searchedList = _allCharacters
                .where((character) => character.name
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .toList();
          });
        },
        decoration: const InputDecoration(
          hintText: "Search Character ...",
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: grey,
            fontSize: 18,
          ),
        ),
        cursorColor: grey,
        maxLines: 1,
      );

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

  List<Widget> _buildActionsForAppBar() {
    if (_isSearching) {
      // X button
      return [
        IconButton(
          onPressed: () {
            setState(() {
              // Clear and Close
              _searchEditingController.clear();
            });
          },
          icon: const Icon(
            Icons.clear,
            color: grey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearching,
          icon: const Icon(
            Icons.search,
            color: grey,
          ),
        ),
      ];
    }
  }

  void _startSearching() {
    setState(() {
      _isSearching = true;
      ModalRoute.of(context)!
          .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchBar() : _buildAppBarTitle(),
        leading: _isSearching
            ? const BackButton(
                color: grey,
              )
            : const SizedBox(),
        backgroundColor: yellow,
        actions: _buildActionsForAppBar(),
      ),
      body: Container(
        color: grey,
        child: BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
          if (state is CharactersStateLoading) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 8,
              color: yellow,
            ));
          } else if (state is CharactersStateError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CharactersStateLoaded) {
            _allCharacters = state.characters;
            return OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return Center(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(6),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: _searchEditingController.text.isEmpty
                          ? _allCharacters.length
                          : _searchedList.length,
                      itemBuilder: (context, index) {
                        return CharacterItem(
                          character: _searchEditingController.text.isEmpty
                              ? _allCharacters[index]
                              : _searchedList[index],
                        );
                      },
                    ),
                  );
                } else {
                  return child;
                }
              },
              child: const NoInternetCustomWidget(),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
