import 'package:cinex_movie_app/routes/app_pages.dart';
import 'package:cinex_movie_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Cinex',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            getPages: AppPages.routes,
            defaultTransition:Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 300),
            theme: ThemeData(
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: Colors.black,
                canvasColor: Colors.black
            ),
          );
        },
      ),
    );
  }
}