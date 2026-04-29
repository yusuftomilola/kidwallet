import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class KidWalletApp extends StatelessWidget {
  const KidWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidWallet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
