import 'package:flutter/material.dart';

import 'package:movie_app/core/extensions/media_query_extensions.dart';

class ReviewListWidget extends StatelessWidget {
  const ReviewListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double scrWidth = context.mediaQueryWidth;
    TextTheme textTheme = context.textTheme;
    return ListView.separated(
      itemCount: 10,
      padding: const EdgeInsets.only(left: 40, right: 10),
      itemBuilder:
          (context, index) => Row(
            spacing: 20,
            children: [
              Column(
                spacing: 10,
                children: [
                  const CircleAvatar(radius: 30),
                  Text(
                    "data",
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: textTheme.bodyMedium?.copyWith(fontSize: 15),
                  ),
                  Container(
                    width: scrWidth * 0.6,
                    child: Text(
                      "details dae details dae details dae details dae detailsasd asd asd as d asd as fds fs ferw fads  dae details dae details dae",
                      maxLines: 4,
                      style: textTheme.bodySmall?.copyWith(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
      separatorBuilder: (context, index) => SizedBox(height: 10),
    );
  }
}
