import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_technical_task/configuration/app_colors.dart';
import 'package:flutter_technical_task/screens/cart/controller/cart_controller.dart';
import 'package:flutter_technical_task/screens/cart/repository/cart_repository.dart';
import 'package:flutter_technical_task/screens/product/controller/product_controller.dart';
import 'package:flutter_technical_task/screens/product/repository/product_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_technical_task/screens/splash/splash_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ProductController>(
              create: (_) {
                final ProductController controller = ProductController(
                  repository: ProductRepository(),
                );

                controller.loadFavorites();
                controller.getProducts();

                return controller;
              },
            ),
            ChangeNotifierProvider<CartController>(
              create: (_) {
                final CartController controller = CartController(
                  repository: CartRepository(),
                );

                controller.loadCart();

                return controller;
              },
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shoply',
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.backgroundColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.backgroundColor,
                elevation: 0,
                centerTitle: true,
                foregroundColor: AppColors.textPrimary,

              ),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
