import 'package:eauctionandroid/Screens/Listings.dart';
import 'package:eauctionandroid/Screens/home_screen.dart';
import 'package:eauctionandroid/Screens/profile_page.dart';
import 'package:eauctionandroid/Screens/wallet_page.dart';
import 'package:eauctionandroid/const.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Listings(),
    WalletPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: primaryColor,
              hoverColor: secondaryColor,
              haptic: true, // haptic feedback
              tabBorderRadius: 20,
              curve: Curves.easeOutExpo, // tab animation curves
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
              tabBackgroundColor: secondaryColor.withOpacity(0.1), // selected tab background color
              duration: const Duration(milliseconds: 400),
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  iconActiveColor: secondaryColor,
                  text: 'Home',
                  textColor: secondaryColor,
                ),
                GButton(
                  icon: LineIcons.heart,
                  iconActiveColor: secondaryColor,
                  text: 'Listings',
                  textColor: secondaryColor,

                ),
                GButton(
                  icon: LineIcons.wallet,
                  iconActiveColor: secondaryColor,
                  text: 'Wallet',
                  textColor: secondaryColor,

                ),
                GButton(
                  icon: LineIcons.user,
                  iconActiveColor: secondaryColor,
                  text: 'Profile',
                  textColor: secondaryColor,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
