import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meeting_provider.dart';
import 'EditMeetingPage.dart'; // Import de la nouvelle page

class MeetingListPage extends StatelessWidget {
  const MeetingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des réunions"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<MeetingProvider>(
        builder: (context, provider, child) {
          if (provider.meetings.isEmpty) {
            return Center(child: Text("Aucune réunion enregistrée."));
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: provider.meetings.length,
            itemBuilder: (context, index) {
              final meeting = provider.meetings[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(meeting.date, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Heure: ${meeting.time}"),
                      Text("Lieu: ${meeting.location}"),
                      Text("Ordre du jour: ${meeting.agenda}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditMeetingPage(index: index),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          provider.deleteMeeting(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
