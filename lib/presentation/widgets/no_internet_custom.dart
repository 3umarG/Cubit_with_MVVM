import 'package:cubit_tutorial/core/constants/colors.dart';
import 'package:flutter/material.dart';

class NoInternetCustomWidget extends StatelessWidget {
  const NoInternetCustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [

          Image.asset(
            "assets/images/no_internet.png",
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "No Internet Connection",
            style: TextStyle(
              fontSize: 25,
              color: yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const CircularProgressIndicator(
            color: yellow,
          ),
        ],
      ),
    );
  }
}
