import 'package:flutter/material.dart';
import 'meeting_provider.dart';
import 'package:provider/provider.dart';

class EditMeetingPage extends StatefulWidget {
  final int index;

  const EditMeetingPage({super.key, required this.index});

  @override
  _EditMeetingPageState createState() => _EditMeetingPageState();
}

class _EditMeetingPageState extends State<EditMeetingPage> {
  late TextEditingController agendaController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MeetingProvider>(context, listen: false);
    final meeting = provider.meetings[widget.index];

    // Initialisation des champs
    provider.setDate(DateTime.parse(meeting.date));

    // Gestion du format de l'heure
    List<String> timeParts = meeting.time.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1].split(" ")[0]);
    provider.setTime(TimeOfDay(hour: hour, minute: minute));

    agendaController = TextEditingController(text: meeting.agenda);
    locationController = TextEditingController(text: meeting.location);
  }

  /// Ouvrir le sélecteur de date
  Future<void> _selectDate(BuildContext context) async {
    final provider = Provider.of<MeetingProvider>(context, listen: false);
    DateTime initialDate = provider.selectedDate ?? DateTime.now();
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    
    if (picked != null) {
      provider.setDate(picked);
    }
  }

  /// Ouvrir le sélecteur d'heure
  Future<void> _selectTime(BuildContext context) async {
    final provider = Provider.of<MeetingProvider>(context, listen: false);
    TimeOfDay initialTime = provider.selectedTime ?? TimeOfDay.now();
    
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    
    if (picked != null) {
      provider.setTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier la réunion"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sélecteur de date
            ListTile(
              title: const Text("Date de la réunion"),
              subtitle: Text(provider.selectedDate != null
                  ? "${provider.selectedDate!.year}-${provider.selectedDate!.month.toString().padLeft(2, '0')}-${provider.selectedDate!.day.toString().padLeft(2, '0')}"
                  : "Sélectionner une date"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),

            // Sélecteur d'heure
            ListTile(
              title: const Text("Heure de la réunion"),
              subtitle: Text(provider.selectedTime != null
                  ? provider.selectedTime!.format(context)
                  : "Sélectionner une heure"),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),

            // Champ de texte pour l'agenda
            TextField(
              controller: agendaController,
              decoration: const InputDecoration(labelText: "Ordre du jour"),
              onChanged: provider.setAgenda,
            ),
            const SizedBox(height: 10),

            // Champ de texte pour la localisation
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Lieu"),
              onChanged: provider.setLocation,
            ),
            const SizedBox(height: 20),

            // Bouton pour enregistrer les modifications
         ElevatedButton(
  onPressed: () {
    provider.updateMeeting(widget.index, context);
    provider.clearFields(); // Réinitialiser les champs après modification
    Navigator.pop(context); // Retour à la liste des réunions
  },
  child: const Text("Enregistrer"),
),

          ],
        ),
      ),
    );
  }
}
