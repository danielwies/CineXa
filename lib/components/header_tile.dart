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
      margin: EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Popular",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Spacer(flex: 4),
          Expanded(
            child: TextButton(
              child: Text(
                "See all",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
