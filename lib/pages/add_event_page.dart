import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>(); // garder le statut (grace à FormState)  du formulaire avec toutes ses informations

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey, // associer le statut du formulaire et cela permettra de declencher le validator
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Nom Conference",
                  hintText: 'Entrez le nom de la conference',
                  border: OutlineInputBorder()
                ),
                validator: (value){ // il faut que ce validator s'enclenche (grace à un systeme de globalkey)
                  if (value == null || value.isEmpty){
                    return "Tu dois entrer quelque chose";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Nom Speaker",
                    hintText: 'Entrez le nom du speaker',
                    border: OutlineInputBorder()
                ),
                validator: (value){ // il faut que ce validator s'enclenche (grace à un systeme de globalkey)
                  if (value == null || value.isEmpty){
                    return "Tu dois entrer quelque chose";
                  }
                  return null;
                },
              ),
            ),
            //SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Envoi en cours…'))
                      );
                    }
                    FocusScope.of(context).requestFocus(FocusNode()); // lorsqu'on clique sur le bouton Envoyer, cette ligne de code ferme le clavier
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.lightGreen)
                  ),
                  child: Text("Envoyer",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
