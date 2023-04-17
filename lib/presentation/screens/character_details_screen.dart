import 'package:cubit_tutorial/core/constants/colors.dart';
import 'package:cubit_tutorial/data/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  final CharacterModel character;

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: yellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            floating: false,
            backgroundColor: grey,
            expandedHeight: 600,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(character.name),
              background: Image.asset("assets/images/rick.jpeg"),
            )
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo("Name:", character.name),
                      buildDivider(315),
                      characterInfo("Status: ", character.status),
                      buildDivider(25),
                      characterInfo("Gender: ", character.gender),
                      buildDivider(65),
                      characterInfo("Species: ", character.species),
                      buildDivider(200),
                      characterInfo("Created: ", character.created),
                      buildDivider(96),
                    ],
                  ),
                ),
                const SizedBox(height: 500,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
