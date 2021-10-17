import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/modules/business/business_screen.dart';
import 'package:news_app/news_app/modules/science/science_screen.dart';
import 'package:news_app/news_app/modules/setting_screen/settings_screen.dart';
import 'package:news_app/news_app/modules/sports/sport_screen.dart';
import 'package:news_app/news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_app/shared/cubit/states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    if (index == 1) getDataSports();
    if (index == 2) getDataScience();
    emit(NewsBottomNavState());
  }

// business states

  List<dynamic> businessData = [];

  void getDataBusiness() {
    emit(NewsGetBusinessLoadingState());

    if (businessData.length == 0) {
      DioHelper.getDat(url:'v2/top-headlines',query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        businessData = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
        print(businessData[0]['title']);
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error.toString()));
        print(error.toString());
      });
    } else
      emit(NewsGetBusinessSuccessState());
  }

  // Sports states

  List<dynamic> sportsData = [];

  void getDataSports() {
    emit(NewsGetSportsLoadingState());
    if (sportsData.length == 0) {
      DioHelper.getDat(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        sportsData = value.data['articles'];
        emit(NewsGetSportsSuccessState());
        // print(sportsData[0]['title']);
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        //print(error.toString());
      });
    } else
      emit(NewsGetSportsSuccessState());
  }

// Science states

  List<dynamic> scienceData = [];

  void getDataScience() {
    emit(NewsGetScienceLoadingState());

    if (scienceData.length == 0) {
      DioHelper.getDat(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        scienceData = value.data['articles'];
        emit(NewsGetScienceSuccessState());
        // print(scienceData[0]['title']);
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        // print(error.toString());
      });
    } else
      emit(NewsGetScienceSuccessState());
  }
  
  bool isDark=false;
  void changeAppMode(){
    isDark=!isDark;
    emit(ChangeModeState());
  }
  
  
  
}
