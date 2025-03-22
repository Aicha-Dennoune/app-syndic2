import 'package:flutter/material.dart';
import 'home_screen.dart'; // Assurez-vous d'importer votre HomeScreen

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset("assets/backgroundlogin.jpg", fit: BoxFit.cover),
          ),
          // Logo en haut
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/logoapp.jpg",
                height: 100,
              ),
            ),
          ),
          // Formulaire de connexion
          Positioned(
            top: 320,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  // Champ utilisateur
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Nom d'utilisateur",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Champ mot de passe
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Mot de passe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Bouton de connexion
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Rediriger vers HomeScreen après connexion
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: const Text(
                        "Se Connecter",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Lien "Mot de passe oublié ?"
                  Center(
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Vérifiez votre Gmail"),
                          ),
                        );
                      },
                      child: const Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
