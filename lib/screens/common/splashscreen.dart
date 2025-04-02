import 'package:domicilios_uno/screens/business/businesscard.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:domicilios_uno/screens/common/homepage.dart';
import 'package:domicilios_uno/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playSound();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      User? user = FirebaseAuth.instance.currentUser;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:
              (context) =>
                  user != null ? const BusinessCard() : const LoginScreen(),
        ),
      );
    });
  }

  Future<void> playSound() async {
    try {
      await audioPlayer.play(AssetSource('audio/sonido.mp3'));
    } catch (e) {
      debugPrint('Error reproduciendo sonido: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252526),
      body: Center(child: Image.asset('assets/images/logo.png', width: 200)),
    );
  }
}
