import 'package:flutter/material.dart';

class Meeting {
  final String date;
  final String time;
  final String agenda;
  final String location;

  Meeting({
    required this.date,
    required this.time,
    required this.agenda,
    required this.location,
  });
}

class MeetingProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _agenda = "";
  String _location = "";
  final List<Meeting> _meetings = [];

  final TextEditingController agendaController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  String get agenda => _agenda;
  String get location => _location;
  List<Meeting> get meetings => _meetings;

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setAgenda(String agenda) {
    _agenda = agenda;
    agendaController.text = agenda;
    notifyListeners();
  }

  void setLocation(String location) {
    _location = location;
    locationController.text = location;
    notifyListeners();
  }

  /// Enregistrer la réunion après vérification des champs
  Future<void> saveMeeting(BuildContext context) async {
    if (_selectedDate == null ||
        _selectedTime == null ||
        _agenda.isEmpty ||
        _location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez remplir tous les champs"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Ajouter la réunion à la liste
    final meeting = Meeting(
      date:
          "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}",
      time: _selectedTime!.format(context),
      agenda: _agenda,
      location: _location,
    );
    _meetings.add(meeting);
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Veuillez attendre..."),
        backgroundColor: const Color.fromARGB(255, 43, 47, 43),
      ),
    );

    clearFields();
  }

  /// Réinitialiser les champs après l'enregistrement
  void clearFields() {
    _selectedDate = null;
    _selectedTime = null;
    _agenda = "";
    _location = "";
    agendaController.clear();
    locationController.clear();
    notifyListeners();
  }

  /// Supprimer une réunion spécifique
  void deleteMeeting(int index) {
    _meetings.removeAt(index);
    notifyListeners();
  }

  void updateMeeting(int index, BuildContext context) {
  if (_selectedDate == null || _selectedTime == null || _agenda.isEmpty || _location.isEmpty) {
    return;
  }

  _meetings[index] = Meeting(
    date: "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}",
    time: _selectedTime!.format(context),
    agenda: _agenda,
    location: _location,
  );
  notifyListeners();
}

}
