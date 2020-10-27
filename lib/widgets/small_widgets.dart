import 'package:flutter/material.dart';

import 'themeData.dart';

class BackMonthButton extends StatelessWidget {
  const BackMonthButton({Key key, @required this.month, this.onTap})
      : super(key: key);

  final String month;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_outlined),
              Icon(Icons.arrow_back_ios_outlined),
              Icon(Icons.arrow_back_ios_outlined),
            ],
          ),
          Text(month, style: CustomTextTheme.smallBold),
        ],
      ),
    );
  }
}

class UpMonthButton extends StatelessWidget {
  const UpMonthButton({Key key, @required this.month, this.onTap})
      : super(key: key);

  final String month;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_forward_ios_outlined),
              Icon(Icons.arrow_forward_ios_outlined),
              Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
          Text(month, style: CustomTextTheme.smallBold),
        ],
      ),
    );
  }
}
