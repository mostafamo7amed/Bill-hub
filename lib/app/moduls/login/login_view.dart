import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
      ),
      body: Center(child: Image.asset(ImageAssets.photo)),
    );
  }
}
