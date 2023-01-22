import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/resources/theme_manager.dart';
import 'package:bill_hub/shared/network/local/cache_helper.dart';
import 'package:bill_hub/shared/observer/blocObserver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'app/modules/admin/home/home_cubit/cubit.dart';
import 'app/modules/chat_bloc/cubit.dart';
import 'app/modules/vendor/invoice/invoice_build_components.dart';
import 'app/resources/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await initFont();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InvoiceCubit(),),
        BlocProvider(create: (context) => AdminCubit()..getUser()..getVendor(),),
        BlocProvider(create: (context) => ChatCubit(),),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales:const [
          Locale("ar", "DZ")
        ] ,
        locale:const Locale("ar", "DZ") ,
        debugShowCheckedModeBanner: false,
        title: 'BillHub',
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}
