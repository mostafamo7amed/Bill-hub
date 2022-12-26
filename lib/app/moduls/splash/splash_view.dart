import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/components/component.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(child: Image.asset(ImageAssets.splashLogo)),
    );
  }

  _splashDelay() {
    _timer = Timer( const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    navigateAndFinish(context, LoginView());
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
