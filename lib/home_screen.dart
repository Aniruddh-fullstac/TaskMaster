import 'dart:developer';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/notes_model.dart';
import 'package:todo_app/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  signoutUser() async {
    await FirebaseAuth.instance.signOut().then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route) => false);
    });
  }

  addNoteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController addNoteController = TextEditingController();
          return AlertDialog(
            title: Text("Add Note"),
            content: TextField(
              controller: addNoteController,
              decoration: InputDecoration(
                hintText: "Enter note",
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  print(addNoteController.text);
                  uploadNotes(note: addNoteController.text);
                },
                child: Text("Add"),
              )
            ],
          );
        });
  }

  uploadNotes({required String note}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString("userId") ?? "";
    await FirebaseFirestore.instance.collection("notes").add(
      {
        "user_id": userId,
        "notes": note,
        "created_at": DateTime.now(),
        "updated_at": DateTime.now(),
      },
    ).then((value) {
      Navigator.pop(context);
    });
  }

  Stream<QuerySnapshot> getNotes() {
    Stream<QuerySnapshot> notesStream = FirebaseFirestore.instance
        .collection("notes")
        // .where("user_id", isEqualTo: userId)
        .snapshots();
    return notesStream;
  }

  String userId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  getUserId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.person_2_sharp))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addNoteDialog();
          },
          child: Icon(Icons.note_add_sharp),
        ),
        body: StreamBuilder(
          stream: getNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                List<NotesModel> notesList = [];
                for (var element in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      element.data() as Map<String, dynamic>;
                  data["document_id"] = element.id;
                  if (data["user_id"] == userId) {
                    notesList.add(NotesModel.fromDocumentSnapshot(data));
                  }
                }

                return NoteWidget(
                  notes: notesList,
                );
              } else {
                return Center(
                  child: Text("No notes added"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    required this.notes,
  });

  final List<NotesModel> notes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(notes[index].note!),
              trailing: IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("notes")
                        .doc(notes[index].documentId)
                        .delete();
                  },
                  icon: Icon(Icons.delete_forever)));
        });
  }
}
