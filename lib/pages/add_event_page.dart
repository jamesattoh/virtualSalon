import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>(); // garder le statut (grace à FormState)  du formulaire avec toutes ses informations

  // creation de controleurs : associent chaque champ a une mini-base qui, lorsqu'on écrit dans le champ, contiendra la valeur modifiée automatiquement
  final confNameController = TextEditingController();
  final speakerNameController = TextEditingController();

  String selectedConfType = 'talk';
  DateTime selectedConfDate = DateTime.now();

  // quand on cree de la memoire il faut aussi penser a la liberer
  @override
  void dispose() {
    super.dispose();

    confNameController.dispose();
    speakerNameController.dispose();
  }

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
                controller: confNameController, // affectation du controleur au champ correspondant
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
                validator: (value){ // il faut que ce validator s'enclenche (grace à un systeme de globalkey) defini plus haut
                  if (value == null || value.isEmpty){
                    return "Tu dois entrer quelque chose";
                  }
                  return null;
                },
                controller: speakerNameController, // une sorte de lien entre la boite qui memorise le contenu et le champ sur lequel on va ecrire
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(value: 'talk', child: Text("Talk Show")),
                    DropdownMenuItem(value: 'demo', child: Text("Demo Code")),
                    DropdownMenuItem(value: 'partner', child: Text("Partner Time"))
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                  value: selectedConfType, // valeur par defaut pour eviter le validator pour le cas nul
                  onChanged: (value){
                    setState(() { // mettre a jour le state de l'ecran
                      selectedConfType = value!; // le ! car cette valeur peut etre nulle
                    });
                  },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Choisir une date',
                  border: OutlineInputBorder()
                ),
                firstDate: DateTime.now().add(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 40)),
                initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                onChanged: (DateTime? value) {
                  setState(() {
                    var selectedConfDate  = value;
                  });
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
                      final confName = confNameController.text; // on recupere le contenu des champs
                      final speakerName = speakerNameController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Envoi en cours…'))
                      );
                      FocusScope.of(context).requestFocus(FocusNode()); // lorsqu'on clique sur le bouton Envoyer, cette ligne de code ferme le clavier
                      

                    }
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
