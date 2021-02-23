import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import '../widgets/themeData.dart';
import '../widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(1080, 1920));

    return Scaffold(
      backgroundColor: Color(0xFFfbf7f0),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () => FirebaseAuth.instance.signOut(),
              child: Icon(Icons.logout),
            ),
          )
        ],
        elevation: 8,
        title: RichText(
            text: TextSpan(
                text: 'FINANÇA',
                style: CustomTextTheme.title,
                children: [
              TextSpan(
                  text: '\$',
                  style: CustomTextTheme.title
                      .copyWith(fontWeight: FontWeight.w700))
            ])),
        centerTitle: true,
        backgroundColor: Color(0xffcdc9c3),
      ),
      body: ListView(
        padding: EdgeInsets.all(40.w),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackMonthButton(
                month: 'setembro',
                onTap: () => print('hello'),
              ),
              Text('OUTUBRO', style: CustomTextTheme.bigText1),
              const UpMonthButton(
                month: 'novembro',
                onTap: null,
              ),
            ],
          ),
          DashBoard(),
          PersonalProgress(),
          Container(
            margin: EdgeInsets.only(top: 60.h),
            alignment: Alignment.topLeft,
            child: Text('PROGRESSO ORÇAMENTO POR CATEGORIA',
                style: CustomTextTheme.subtitle2),
          ),
          SizedBox(height: 40.h),
          CategoriaBars(),
        ],
      ),
    );
  }
}

class CategoriaBars extends StatelessWidget {
  const CategoriaBars({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                  intensity: 1,
                  depth: -8,
                ),
                child: CircleAvatar(
                    radius: 15, backgroundColor: Color(0xFFd9e4dd)),
              ),
              SizedBox(width: 30.w),
              Text('CATEGORIA', style: CustomTextTheme.smallBold),
              SizedBox(width: 30.w),
              Expanded(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    //lightSource: LightSource.topRight,
                    intensity: 10,
                    //depth: -5,
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.rect(),
                  ),
                  child: Container(
                    color: Color(0xFFfbf7f0),
                    height: 60.h,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.rect(),
                          //depth: 8,
                        ),
                        child: Container(
                          color: Color(0xFFd9e4dd),
                          width: 400.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DashBoard extends StatelessWidget {
  DashBoard({Key key}) : super(key: key);

  final bombSize = Size(300.w, 350.h);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
          width: double.infinity,
          height: 300.h,
          child: Card(
            elevation: 8,
            color: Color(0xFFd9e4dd),
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _ladoEsquerdoBomba(context),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: bombSize.width,
                    ),
                  ),
                  Expanded(
                    child: _ladoDireitoBomba(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        BudgetBomb(),
      ],
    );
  }

  Widget _ladoEsquerdoBomba(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('54%', style: CustomTextTheme.bigText2),
        Text('DO ORÇAMENTO', style: CustomTextTheme.subtitle1),
      ],
    );
  }

  Widget _ladoDireitoBomba(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ORÇAMENTO', style: CustomTextTheme.subtitle2),
        Divider(
          height: 16.h,
          color: AppColors.primaryColor,
          indent: 16.w,
          endIndent: 16.w,
        ),
        Text('R\$ 10.000,00', style: CustomTextTheme.subtitle1),
        const Spacer(),
        Text('DISPONÍVEL', style: CustomTextTheme.subtitle2),
        SizedBox(height: 14.h),
        Text(
          'R\$ 4.129,81',
          style: TextStyle(
              color: AppColors.moneyGreen,
              fontFamily: 'Metropolis',
              fontSize: 50.sp,
              fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
