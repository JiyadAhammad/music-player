import 'package:flutter/material.dart';
import 'package:music/navbar/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    screenEnter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF911BEE),
              Colors.black.withOpacity(0.94),
              Colors.black,
              Colors.black.withOpacity(0.94),
              const Color(0xFF911BEE),
            ],
            stops: const [
              0.01,
              0.3,
              0.5,
              0.7,
              1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'jMUSIC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/img/musiclogo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> screenEnter() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (contxt) => const NavBar(),
      ),
    );
  }
}
