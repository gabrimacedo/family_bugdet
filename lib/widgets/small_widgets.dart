import 'package:flutter/material.dart';

class BackMonthButton extends StatelessWidget {
  const BackMonthButton({Key key, @required this.month}) : super(key: key);

  final String month;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(month, style: Theme.of(context).textTheme.caption),
      ],
    );
  }
}

class UpMonthButton extends StatelessWidget {
  const UpMonthButton({Key key, @required this.month}) : super(key: key);

  final String month;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(month, style: Theme.of(context).textTheme.caption),
      ],
    );
  }
}
