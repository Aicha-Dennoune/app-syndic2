import 'package:flutter/material.dart';
import 'versement.dart';

class GestionSyndicScreen extends StatefulWidget {
  @override
  _GestionSyndicScreenState createState() => _GestionSyndicScreenState();
}

class _GestionSyndicScreenState extends State<GestionSyndicScreen> {
  String? selectedImmeuble = '8';
  String? selectedAppartement = '8';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion de Syndic"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedImmeuble,
                    items: ["8", "9", "10"].map((e) => DropdownMenuItem(value: e, child: Text("Immeuble $e"))).toList(),
                    onChanged: (val) => setState(() => selectedImmeuble = val),
                    decoration: InputDecoration(labelText: "Num_IMM", border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedAppartement,
                    items: ["8", "9", "10"].map((e) => DropdownMenuItem(value: e, child: Text("Appt $e"))).toList(),
                    onChanged: (val) => setState(() => selectedAppartement = val),
                    decoration: InputDecoration(labelText: "Num_Appt", border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: buildButton("Chercher", () {})),
                SizedBox(width: 10),
                Expanded(child: buildButton("Générer un avis client", () {})),
                SizedBox(width: 10),
                Expanded(child: buildButton("Versement", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VersementScreen()),
                  );
                })),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildTextField("État"),
                    buildTextField("Copropriétaire"),
                    buildTextField("Téléphone"),
                    buildTextField("Email"),
                    buildTextField("Mnt impayé"),
                    buildTextField("Mnt réglé"),
                    buildTextField("Date signature contrat"),
                    buildTextField("Mnt à payer"),
                    buildTextField("Prochaines échéances"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget buildTextField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.blue.shade50,
        ),
      ),
    );
  }
}
