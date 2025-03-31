import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions/media_query_extensions.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = context.textTheme;
    return GridView.builder(
      padding: const EdgeInsets.only(top: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder:
          (context, index) => Column(
            spacing: 10,
            children: [
              CircleAvatar(radius: 60),
              Text(
                "data",
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
    );
  }
}
