import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'auth/auth_bloc.dart';
import 'auth/auth_repository.dart';
import 'constants/colors.dart';
import 'constants/constants.dart';
import 'pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO setup firebase for iOs
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          fontFamily: 'Metropolis',
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        theme: ThemeData(
          fontFamily: 'Metropolis',
          iconTheme: IconThemeData(color: AppColors.primaryColor),
        ),
        routes: {
          Home.routeName: (context) => Home(),
          LoginPage.routeName: (context) => LoginPage(),
          AltHomePage.routeName: (context) => AltHomePage(),
        },
        initialRoute: AltHomePage.routeName,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            ScreenUtil.init(context, designSize: Size(1080, 1920));

            if (state is UnknowState) {
              return SplashScreen();
            } else if (state is LoggedInState) {
              return Home();
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
