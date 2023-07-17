import 'package:flutter/material.dart';

import 'package:side_navigation/side_navigation.dart';

import '../general/app_colors.dart';
import '../screens/banner_display_screen.dart';
import '../screens/category_display_screen.dart';
import '../screens/delivery_screen.dart';
import '../screens/manage_products_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/offer_display_screen.dart';
import '../screens/order_screen.dart';
import '../screens/payment_gateway_screen.dart';
import '../screens/user_screen.dart';

class CustomSideNavigationBar extends StatefulWidget {
  const CustomSideNavigationBar({super.key});

  @override
  State<CustomSideNavigationBar> createState() =>
      _CustomSideNavigationBarState();
}

class _CustomSideNavigationBarState extends State<CustomSideNavigationBar> {
  int selectedIndex = 0;
  List screens = [
    const OrderScreen(),
    const CategoryDisplyScreen(),
    const BannerDisplayScreen(),
    const OfferDisplayScreen(),
    const UserScreen(),
    const ManageProductsScreen(),
    const DeliveryScreen(),
    const PaymentGatewayScreen(),
    const NotificationScreen(),
    ////
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          /// Pretty similar to the BottomNavigationBar!
          SideNavigationBar(
            selectedIndex: selectedIndex,
            theme: SideNavigationBarTheme(
              backgroundColor: const Color(0XFF1E2640),
              togglerTheme: SideNavigationBarTogglerTheme.standard(),
              itemTheme: SideNavigationBarItemTheme(
                  selectedBackgroundColor:
                      Colors.white.withOpacity(.5), //const Color(0XFF353C54),
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey.shade500,
                  labelTextStyle: const TextStyle(
                    fontFamily: "pop",
                    fontSize: 14,
                  )),
              dividerTheme: SideNavigationBarDividerTheme.standard(),
            ),
            items: const [
              SideNavigationBarItem(
                icon: Icons.assignment_outlined, //Icons.shopping_cart,
                label: 'Orders',
              ),
              SideNavigationBarItem(
                icon: Icons.backup_outlined,
                label: 'Upload',
              ),
              SideNavigationBarItem(
                icon: Icons.view_carousel_outlined,
                label: 'Add banner',
              ),
              SideNavigationBarItem(
                icon: Icons.web_stories_outlined,
                label: 'Create offer',
              ),
              SideNavigationBarItem(
                icon: Icons.group_outlined,
                label: 'Users',
              ),
              SideNavigationBarItem(
                icon: Icons.grid_view,
                label: 'Manage products',
              ),
              SideNavigationBarItem(
                icon: Icons.local_shipping_outlined,
                label: 'Delivery',
              ),
              SideNavigationBarItem(
                icon: Icons.payment_rounded,
                label: 'Delivery type',
              ),
              SideNavigationBarItem(
                icon: Icons.notifications_none_rounded,
                label: 'Notification',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          /// Make it take the rest of the available width
          Expanded(
            child: screens[selectedIndex],
          )
        ],
      ),
    );
  }
}
