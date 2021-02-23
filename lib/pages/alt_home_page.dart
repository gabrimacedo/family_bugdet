import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AltHomePage extends StatelessWidget {
  const AltHomePage({Key key}) : super(key: key);

  static const routeName = '/alt_home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff535353),
                Color(0xff4E4A67),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => print('ha'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, right: 8.0),
                      child: Text(
                        'Olá,\nMarcos',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: AppColors.darkAccent),
                      ),
                    ),
                    Text('FINANÇA'),                    
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
