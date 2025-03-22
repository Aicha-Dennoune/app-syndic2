import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'meeting_provider.dart';
import '../widgets/user_avatar.dart';
import 'UserProfilePage.dart';
import 'MeetingListPage.dart';

class ScheduleMeetingPage extends StatelessWidget {
  const ScheduleMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Planifier une réunion", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
              child: UserAvatar(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMeetingCard(
              context,
              title: "Date de la réunion",
              icon: Icons.calendar_today,
              child: Consumer<MeetingProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.selectedDate == null
                          ? "Aucune date sélectionnée"
                          : DateFormat('yyyy-MM-dd').format(provider.selectedDate!),
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.date_range, color: Colors.blueAccent),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          provider.setDate(pickedDate);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildMeetingCard(
              context,
              title: "Heure de la réunion",
              icon: Icons.access_time,
              child: Consumer<MeetingProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.selectedTime == null
                          ? "Aucune heure sélectionnée"
                          : provider.selectedTime!.format(context),
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time, color: Colors.blueAccent),
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          provider.setTime(pickedTime);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildMeetingCard(
              context,
              title: "Lieu de la réunion",
              icon: Icons.location_on,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Saisir le lieu...",
                  border: InputBorder.none,
                ),
                onChanged: (text) => context.read<MeetingProvider>().setLocation(text),
                controller: context.read<MeetingProvider>().locationController,
              ),
            ),
            _buildMeetingCard(
              context,
              title: "Ordre du jour",
              icon: Icons.edit,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Saisir l'ordre du jour...",
                  border: InputBorder.none,
                ),
                maxLines: 3,
                onChanged: (text) => context.read<MeetingProvider>().setAgenda(text),
                controller: context.read<MeetingProvider>().agendaController,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      final provider = context.read<MeetingProvider>();
                      provider.saveMeeting(context);
                      provider.clearFields();
                  ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Réunion programmée avec succès"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MeetingListPage()),
                      );
                    },
                    child: Text(
                      "Voir la liste",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingCard(BuildContext context, {required String title, required IconData icon, required Widget child}) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                SizedBox(width: 10),
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}