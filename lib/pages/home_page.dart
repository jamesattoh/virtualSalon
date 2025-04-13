import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'event_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center( // on met le contenu du body au centre de l'ecran
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // on centre le contenu du body par rapport à son axe vertical
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
              textAlign: TextAlign.center, // pour forcer le texte d'être au centre de l'écran
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton.icon(
              style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                  backgroundColor: WidgetStatePropertyAll(Colors.green) //MaterialStatePropertyAll est dépréciée
              ),
              onPressed: () { // ici debute l'ensemble des fonctions qui vont se déclencher lorsqu'on clique sur le bouton
                Navigator.push(
                    context,
                    PageRouteBuilder( // décrit comment créer la redirection
                        pageBuilder: (_, __, ___) => EventPage()
                    )
                );
              },
              label: Text("Afficher le planning",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              icon: Icon(Icons.calendar_month),
            )
          ],
        )
    );
  }
}