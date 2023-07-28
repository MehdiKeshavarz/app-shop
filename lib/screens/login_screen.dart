import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/color_palette.dart';

import '../Widgets/Text_field_widget.dart';
import '../bloc/authentication_bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _usernameTextEditingController =
      TextEditingController(text: 'mehdi1402');
  final _passwordTextEditingController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorPalette.blue,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_application.png',
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'اپل شاپ',
                      style: TextStyle(
                          fontSize: 24, fontFamily: 'sb', color: Colors.white),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      TextFieldWidget(
                        labelText: "نام کاربری",
                        controller: _usernameTextEditingController,
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        labelText: "رمز عبور",
                        controller: _passwordTextEditingController,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthStateInitial) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorPalette.blue,
                                  minimumSize: const Size(150, 60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'sb',
                                      color: Colors.white)),
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthLoginRequest(
                                      _usernameTextEditingController.text,
                                      _passwordTextEditingController.text,
                                    ));
                              },
                              child: const Text('ورود به حساب کاربری'),
                            );
                          }
                          if (state is AuthStateLoading) {
                            return const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator());
                          }
                          if (state is AuthStateLoaded) {
                            Text widget = Text('');
                            state.response.fold(
                              (l) {
                                widget = Text(l);
                              },
                              (r) {
                                widget = Text(r);
                              },
                            );
                            return widget;
                          }

                          return const Text('خطایی نا مشخص!!');
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
