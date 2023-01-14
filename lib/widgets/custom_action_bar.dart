import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {

  final Widget cityChild, statusChild;

  const CustomActionBar({Key? key, required this.cityChild, required this.statusChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 24.0,
          left: 20.0,
          right: 24.0,
          bottom: 42.0
      ),

      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0)
              ],
              begin: const Alignment(0, 0),
              end: const Alignment(0, 1)
          )
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

            Container(
              child: cityChild,
            ),

          Container(
            child: statusChild
            ),
        ],
      ),
    );
  }
}
