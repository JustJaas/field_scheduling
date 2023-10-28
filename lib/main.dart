import 'package:field_scheduling/ui/blocs/NewBookingBloc/new_booking_bloc.dart';
import 'package:field_scheduling/ui/pages/home_page.dart';
import 'package:field_scheduling/ui/pages/new_booking_page.dart';
import 'package:field_scheduling/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await loadEnvVars();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewBookingBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Scheduling',
        initialRoute: 'splash',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ),
        ),
        routes: {
          'home': (context) => const HomePage(),
          'new_booking': (context) => const NewBookingPage(),
          'splash': (context) => const SplashPage(),
        },
        home: const SplashPage(),
      ),
    );
  }
}

Future loadEnvVars() async {
  await dotenv.load(
    fileName: '.env',
  );
}
