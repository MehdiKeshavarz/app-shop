import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/bloc/basket_bloc/basket_bloc.dart';
import 'package:shop_app/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/constants/color_palette.dart';
import 'package:shop_app/data/models/cart_item_model.dart';
import 'package:shop_app/screens/main_wrapper.dart';

import 'bloc/authentication_bloc/auth_bloc.dart';
import 'di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModeAdapter());
  await Hive.openBox<CartItemMode>('cartBox');
  await setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<AuthBloc>()),
        BlocProvider(create: (context) => locator<CategoryBloc>()),
        BlocProvider(create: (context) => locator<HomeCubit>()),
        BlocProvider(create: (context) => locator<BasketBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        body: MainWrapper(),
      ),
    );
  }
}
