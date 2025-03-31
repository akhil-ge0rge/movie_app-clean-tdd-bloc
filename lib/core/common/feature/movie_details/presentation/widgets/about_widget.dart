import 'package:flutter/material.dart';

import 'package:movie_app/core/extensions/media_query_extensions.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = context.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
      child: Text("Hello", style: textTheme.bodySmall?.copyWith(fontSize: 13)),
    );
  }
}
