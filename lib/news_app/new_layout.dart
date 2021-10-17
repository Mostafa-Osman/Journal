import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/shared/cubit/cubit.dart';
import 'package:news_app/news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (BuildContext context) => NewsCubit()
    //     ..getDataBusiness()
    //     ..getDataScience()
    //     ..getDataSports(),
    //   child:
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var myCubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.brightness_4),
                onPressed: () {
                  myCubit.changeAppMode();
                },
              )
            ],
          ),
          body: myCubit.screens[myCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: myCubit.currentIndex,
            onTap: (index) {
              myCubit.changeIndex(index);
            },
            items: myCubit.bottomItems,
          ),
        );
      },
      listener: (context, state) {},
      //),
    );
  }
}
