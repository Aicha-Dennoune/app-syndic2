class Owner {
  int id;
  String name;
  int numImm;
  int numApp;
  double amount;

  Owner({
    required this.id,
    required this.name,
    required this.numImm,
    required this.numApp,
    required this.amount, // Montant devient obligatoire
  });
}


  get amount => null;