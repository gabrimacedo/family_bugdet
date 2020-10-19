import 'package:family_bugdet/widgets/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'widgets/widgets.dart';
import 'constants/constants.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeDataDelay>(
      create: (context) => ThemeDataDelay(),
      child: Consumer<ThemeDataDelay>(
        //child: Home(),
        builder: (context, themeData, child) => MaterialApp(
          theme: ThemeData(
            textTheme: themeData.customTextTheme,
          ),
          home: Builder(
            builder: (context) {
              ScreenUtil.init(context, designSize: Size(1080, 1920));
              return Home();
            },
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeDataDelay>()
      ..textTheme = ThemeData.light().textTheme.copyWith(
            headline3: TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: 48,
              color: AppColors.primaryColor,
            ),
            headline4: TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: 88.sp,
              color: AppColors.primaryColor,
            ),
            caption: TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: 33.sp,
              color: AppColors.primaryColor,
            ),
            subtitle1: TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w500,
              fontSize: 38.sp,
              color: AppColors.primaryColor,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FINANÇAS'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(40.w),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackMonthButton(month: 'setembro'),
                  Text('OUTUBRO', style: Theme.of(context).textTheme.headline4),
                  const UpMonthButton(month: 'novembro'),
                ],
              ),
              DashBoard(),
            ],
          ),
        ),
      ),
    );
  }
}

class DashBoard extends StatelessWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
      width: double.infinity,
      //height: 350.h,
      child: Card(
        color: AppColors.secondaryColor,
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Row(
            children: [
              GastosTotais(),
              BudgetBomb(),
            ],
          ),
        ),
      ),
    );
  }
}

class GastosTotais extends StatelessWidget {
  const GastosTotais({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('54%', style: Theme.of(context).textTheme.headline3),
        Text('do orçamento', style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}

class BudgetBomb extends StatelessWidget {
  const BudgetBomb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        foregroundPainter: BombPainter(),
      ),
    );
  }
}

class BombPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bombCenter = Offset(size.width / 2, size.height / 2);

    final bombPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(193, 106, 106, 1);

    canvas.drawCircle(bombCenter, size.height / 2, bombPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
