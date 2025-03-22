import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String username;
  final double textSize; // Nouvelle variable pour la taille du texte

  UserAvatar({this.imageUrl, this.username = "Syndic", this.textSize = 18}); // Par défaut à 18

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          backgroundColor: imageUrl == null ? const Color.fromRGBO(68, 138, 255, 1) : Colors.blueAccent,
          child: imageUrl == null ? Icon(Icons.person, color: const Color.fromARGB(255, 255, 255, 255)) : null,
        ),
        SizedBox(width: 8),
        Text(username, style: TextStyle(color: Colors.white, fontSize: textSize)), // Utilisation du textSize
      ],
    );
  }
}
