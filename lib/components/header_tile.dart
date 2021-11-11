import 'package:cinexa/constants.dart';
import 'package:flutter/material.dart';

class HeaderTile extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  const HeaderTile({
    Key? key,
    required this.leadingText,
    required this.trailingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          Text(
            leadingText,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          Spacer(),
          TextButton(
            child: Text(
              trailingText,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
