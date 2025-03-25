import 'package:flutter/material.dart';
import 'Owner.dart';

class OwnerFormPage extends StatefulWidget {
  final Owner? owner;
  final Function(Owner) onSave;

  OwnerFormPage({this.owner, required this.onSave});

  @override
  _OwnerFormPageState createState() => _OwnerFormPageState();
}

class _OwnerFormPageState extends State<OwnerFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numImmController = TextEditingController();
  final TextEditingController numAppController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.owner != null) {
      nameController.text = widget.owner!.name;
      numImmController.text = widget.owner!.numImm.toString();
      numAppController.text = widget.owner!.numApp.toString();
      amountController.text = widget.owner!.amount.toString();
    }
  }

  void _saveOwner() {
    if (!_formKey.currentState!.validate()) return;

    final owner = Owner(
      id: widget.owner?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: nameController.text,
      numImm: int.parse(numImmController.text),
      numApp: int.parse(numAppController.text),
      amount: double.parse(amountController.text),
    );

    widget.onSave(owner);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.owner != null; // Vérifie si c'est une modification

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modifier Propriétaire" : "Ajouter Propriétaire"),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nom du propriétaire"),
                validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
              ),
              TextFormField(
                controller: numImmController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Numéro d'immeuble"),
                validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
              ),
              TextFormField(
                controller: numAppController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Numéro d'appartement"),
                validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Montant à payer"),
                validator: (value) {
                  if (value!.isEmpty) return "Champ obligatoire";
                  final num? parsedValue = double.tryParse(value);
                  if (parsedValue == null) return "Valeur invalide";
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _saveOwner,
                    child: Text(isEditing ? "Modifier" : "Enregistrer"), // Changement ici
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text("Annuler"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
