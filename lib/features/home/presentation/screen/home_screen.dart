import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_dispenser/features/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._({Key? key}) : super(key: key);

  static Widget create() => BlocProvider<HomeBloc>(
        create: (_) => GetIt.I.get()..add(const HomeEvent.loadData()),
        child: const HomeScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>();
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
