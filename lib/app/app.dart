import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/bloc/network/network_bloc.dart';
import '../presentation/bloc/network/network_event.dart';
import '../presentation/bloc/visit/visit_bloc.dart';
import 'di/injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (_) => getIt<NetworkBloc>()
            ..add(const CheckNetworkStatus()),
        ),
        BlocProvider<VisitBloc>(
          create: (_) => getIt<VisitBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Visit Log',
        home: const Scaffold(
          body: Center(
            child: Text('Field Visit Log'),
          ),
        ),
      ),
    );
  }
}