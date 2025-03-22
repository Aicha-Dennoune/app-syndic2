import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;

  EditProfilePage({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    addressController = TextEditingController(text: widget.address);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    Navigator.pop(context, {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'address': addressController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Modifier le profil",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Nom")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: "Téléphone")),
            TextField(controller: addressController, decoration: InputDecoration(labelText: "Adresse")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text("Enregistrer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ],
        ),
      ),
    );
  }
}
