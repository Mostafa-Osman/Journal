import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/shared/components/components.dart';
import 'package:news_app/news_app/shared/cubit/cubit.dart';
import 'package:news_app/news_app/shared/cubit/states.dart';

class SportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).sportsData;
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) => articleBuilder(list,context),
        listener: (context, state) {});
  }
}
