import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'news_app/network/remote/dio_helper.dart';
import 'news_app/new_layout.dart';
import 'news_app/shared/cubit/cubit.dart';
import 'news_app/shared/cubit/my_bloc_observer.dart';
import 'news_app/shared/cubit/states.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit()..getDataBusiness(),
        child: BlocConsumer<NewsCubit, NewsStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      titleSpacing: 20,
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      iconTheme: IconThemeData(color: Colors.black),
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20.0,
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ))),
              darkTheme: ThemeData(
                  primaryColor: Colors.deepOrange,
                  scaffoldBackgroundColor: HexColor('333739'),
                  appBarTheme: AppBarTheme(
                      titleSpacing: 20,
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light,
                      ),
                      backgroundColor: HexColor('333739'),
                      elevation: 0.0,
                      iconTheme: IconThemeData(color: Colors.white),
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: HexColor('333739'),
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    elevation: 20.0,
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ))),
              themeMode: NewsCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              //ThemeMode.light,
              home: Directionality(
                  textDirection: TextDirection.ltr,
                  child: NewsLayout()), //HomeLayout(),
            );
          },
          listener: (context, state) {},
        ));
  }
}
