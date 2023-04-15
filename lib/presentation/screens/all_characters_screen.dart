import 'package:flutter/material.dart';

class AllCharactersScreen extends StatelessWidget {
  const AllCharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick And Morty"),
      ),
      body: const Center(
        child: Text("Rick and Morty"),
      ),
    );
  }
}
