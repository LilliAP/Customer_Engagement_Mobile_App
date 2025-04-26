import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se330_project_2/widgets/app_bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String par1Start = """At KAG's Coffee & Bagels, we believe in slow mornings, warm conversations, 
                                and the simple joy of a good cup of coffee paired with a fresh bagel. Since 
                                opening our doors in 2007, we've""";
  static const String par1End = """been serving the Brookings community with a smile, a cozy atmosphere, 
                                   and plenty of delicious moments.""";
  static const String par2Start = """Every bagel is made from scratch right here in our kitchen — golden on the 
                                 outside, soft and"""; 
  static const String par2End = """chewy on the inside — just the way they're meant to be. 
                                 Our coffee beans are thoughtfully sourced and carefully roasted, bringing 
                                 you that perfect, comforting cup every time."""; 
  static const String par3 = """More than just a coffee shop, KAG's is a place to pause, connect, and 
                                recharge. Whether you're studying for finals, catching up with an old friend, 
                                or starting your day with a little quiet time, you'll always have a cozy corner 
                                waiting for you here.""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2.0,
          horizontal: 20.0
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20.0),
            Text(
              "About the Company", 
              style: GoogleFonts.lora(
                fontWeight: FontWeight.bold, 
                fontSize: 30.0
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Image.asset(
                  "assets/images/croppedKagLogo.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(par1Start.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' '),),
                ),
              ],
            ),
            Text(
              par1End.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' '),
            ),
            const SizedBox(height: 15.0),
            Text(
              par2Start.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' '),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(
                  child: Text(par2End.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' '),),
                ),
                const SizedBox(width: 15.0),
                Image.asset(
                  "assets/images/stockBagelCoffee1.jpg",
                  width: 185,
                  height: 185,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              par3.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), ' '),
            ),
            const SizedBox(height: 15.0),
            const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'KAG\'s Coffee & Bagels',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' - Where quality meets community.',
                    )
                  ]
                )
              ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(selectedIndex: 0)
    );
  }
}
