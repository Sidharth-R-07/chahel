import 'package:ecommerceadminweb/provider/get_all_product_provider.dart';
import 'package:ecommerceadminweb/provider/banner_search_product_provider.dart';
import 'package:ecommerceadminweb/provider/offer_search_product_provider.dart';
import 'package:ecommerceadminweb/provider/get_product_provider.dart';
import 'package:ecommerceadminweb/provider/sub_category_provider.dart';
import 'package:ecommerceadminweb/screens/login_screen.dart';
import 'package:ecommerceadminweb/widgets/side_navigation_bar.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'general/app_details.dart';
import 'provider/banner_products_provider.dart';
import 'provider/get_catergory_provider.dart';
import 'provider/image_pick.provider.dart';
import 'provider/offer_product_provider.dart';
import 'provider/order_provider.dart';
import 'provider/product_parameters_provider.dart';
import 'provider/product_unit_provider.dart';
import 'provider/side_navigation_provider.dart';
import 'provider/users_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBN6Az152NwMkjGma0jVrjK7Kxwtd47Pz8",
        authDomain: "chahel-a9620.firebaseapp.com",
        projectId: "chahel-a9620",
        storageBucket: "chahel-a9620.appspot.com",
        messagingSenderId: "16617071482",
        appId: "1:16617071482:web:34ffa88711670af4a66cc3"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomPickImageProvider()),
        ChangeNotifierProvider(create: (_) => GetCatergoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductParametersProvider()),
        ChangeNotifierProvider(create: (_) => ProductUnitProvider()),
        ChangeNotifierProvider(create: (_) => GetProductProvider()),
        ChangeNotifierProvider(create: (_) => GetAllProductProvider()),
        ChangeNotifierProvider(create: (_) => BannerSearchProductProvider()),
        ChangeNotifierProvider(create: (_) => GetOfferSearchProductProvider()),
        ChangeNotifierProvider(create: (_) => OfferProductProvider()),
        ChangeNotifierProvider(create: (_) => BannerProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => SideNavigationProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => SubCategoryProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appname,
          theme: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            primarySwatch: Colors.blue,
          ),
            home: const LoginScreen(),
          )
       //   home: const CustomSideNavigationBar()),
      //  CustomSideNavigationBar(),//
    );
  }
}
