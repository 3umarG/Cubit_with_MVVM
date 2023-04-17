import 'package:cubit_tutorial/data/models/character_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  final CharacterModel character;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: yellow, width: 2.0),
        borderRadius: BorderRadius.circular(12),
        color: white,
      ),
      child: GridTile(
        footer: Container(
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 12),
          child: Text(
            character.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: Container(
          child: character.imageUrl.isEmpty
              ? Image.asset("assets/images/failed.gif")
              : FadeInImage.assetNetwork(
            placeholder: "assets/images/loading.gif",
            fit: BoxFit.cover,
            imageErrorBuilder: (_, ob, stack) =>
                Image.asset("assets/images/failed.gif"),
            height: double.infinity,
            width: double.infinity,
            image: character.imageUrl,
          ),
        ),
      ),
    );
  }
}
