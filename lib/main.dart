import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { // build assemble les elements mis à l'interieur de l'app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold( // on definit la page d'accueil avec home, Scaffold est une pre - construction
        appBar: AppBar(
          title: Text("Dolgen 2025"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/logo.svg",
                  colorFilter: ColorFilter.mode(Colors.lightGreen, BlendMode.srcIn),
                  //color: Colors.lightGreen, cette utilisation est dépréciée
                ),
                Text("Dolgen 2025",
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'Poppins'
                  ),
                ),
                Text("Salon virtuel de l'informatique du 27 au 29 octobre 2025",
                  style: TextStyle(
                    fontSize: 24
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            )
        ),
      ),
    );
  }
}
