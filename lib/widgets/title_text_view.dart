import 'package:flutter/material.dart';
import 'package:movie_db_app/resources/colors.dart';

class TitleTextWithMoreView extends StatelessWidget {
  final String title;
  String? moreLabel;

  TitleTextWithMoreView({required this.title, this.moreLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: TITLE_TEXT_COLOR,
            fontWeight: FontWeight.w500,
          ),
        ),
        Visibility(
          visible: moreLabel != null,
          child: Text(
            moreLabel ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
