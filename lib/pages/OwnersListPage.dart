import 'package:flutter/material.dart';
import 'Owner.dart';
import 'OwnerFormPage.dart';

class OwnersListPage extends StatefulWidget {
  @override
  _OwnersListPageState createState() => _OwnersListPageState();
}

class _OwnersListPageState extends State<OwnersListPage> {
  List<Owner> owners = [];

  void _addOrUpdateOwner(Owner owner) {
    setState(() {
      int index = owners.indexWhere((o) => o.id == owner.id);
      if (index >= 0) {
        owners[index] = owner; // Mise à jour
      } else {
        owners.add(owner); // Ajout
      }
    });
  }

  void _editOwner(Owner owner) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerFormPage(
          owner: owner,
          onSave: _addOrUpdateOwner,
        ),
      ),
    );
  }

  void _deleteOwner(Owner owner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmer la suppression"),
          content: Text("Voulez-vous vraiment supprimer ${owner.name} ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  owners.removeWhere((o) => o.id == owner.id);
                });
                Navigator.pop(context);
              },
              child: Text("Supprimer", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _addOwner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerFormPage(
          onSave: _addOrUpdateOwner,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Propriétaires"),
        backgroundColor: Colors.blue[900],
      ),
      body: owners.isEmpty
          ? Center(
              child: Text(
                "Aucun propriétaire ajouté.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: owners.length,
              itemBuilder: (context, index) {
                final owner = owners[index];
                return Card(
                  color: Colors.blue.withOpacity(0.6), // Bleu transparent
                  margin: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      owner.name,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Immeuble ${owner.numImm}, Appartement ${owner.numApp}\nMontant à payer: ${owner.amount.toStringAsFixed(2)} MAD",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _editOwner(owner),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteOwner(owner),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOwner,
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add),
      ),
    );
  }
}
