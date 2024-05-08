import 'package:app/Cubits/RegisterCubit.dart';
import 'package:app/Cubits/cubit/location_cubit.dart';
import 'package:app/Cubits/cubit/log_in_cubit.dart';
import 'package:app/Cubits/cubit/resturant_cubit.dart';
import 'package:app/Screens/GoogleMapScreen.dart';
import 'package:app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [BlocProvider(create: (context) => SignUpCubit(),),
                                          BlocProvider(create: (context)=>LogInCubit()),
                                          BlocProvider(create: (Context)=>ResturantCubit()),
                                          BlocProvider( create: (context) =>  LocationCubit(),  
                                          )
                                         ]                                          ,
     child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home://GoogleMapPage(),
      Login(),
    ),
    );
  }
}

