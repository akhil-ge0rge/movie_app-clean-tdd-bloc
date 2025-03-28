import 'package:flutter/material.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.yellowAccent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent),
      ),
    );
  }
}
