import 'package:digiquran/app/pages/splash/splash-permissions.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(32, 84, 32, 12),
            child: Column(
              children: [
                Text(
                  'DigiQur\'an',
                  style: defaultText.copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  'Belajar, membaca Al-Quran dan melacak aktifitas spiritual setiap hari',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Image(
            image: AssetImage('assets/splash.png'),
            fit: BoxFit.contain,
            height: 240,
          ),
          // const Expanded(
          //   child: SizedBox(),
          // )
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        child: Material(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SplashPermissions()));
            },
            child: Container(
              width: 162,
              height: 42,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                // borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Mulai',
                style: defaultText.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
