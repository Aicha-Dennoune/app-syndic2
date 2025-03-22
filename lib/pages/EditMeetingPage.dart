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

    // Initialiser les champs avec les valeurs existantes
    provider.setDate(DateTime.parse(meeting.date));

    List<String> timeParts = meeting.time.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1].split(" ")[0]);
    provider.setTime(TimeOfDay(hour: hour, minute: minute));

    agendaController = TextEditingController(text: meeting.agenda);
    locationController = TextEditingController(text: meeting.location);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier la réunion"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: agendaController,
              decoration: InputDecoration(labelText: "Ordre du jour"),
              onChanged: provider.setAgenda,
            ),
            SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Lieu"),
              onChanged: provider.setLocation,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                provider.updateMeeting(widget.index, context);
                Navigator.pop(context); // Retour à la liste des réunions
              },
              child: Text("Enregistrer"),
            ),
          ],
        ),
      ),
    );
  }
}
