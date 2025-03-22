import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'pages/loginPage.dart'; // Assurez-vous que ce fichier existe
import 'pages/meeting_provider.dart';
import 'pages/schedule_meeting_page.dart';

void main() {

  runApp(GestionSyndicApp());
}

class GestionSyndicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MeetingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: LoginPage(), // Démarre avec la page de connexion
      ),
    );
  }
}
