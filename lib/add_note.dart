
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/note.dart';
import 'services/note_service.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  //declare controller
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  //form key variable
  final GlobalKey<FormState> noteFormKey = GlobalKey();

  //service variable
  final NoteService noteService = NoteService();

  //function to add notes
  Future addNote() async {

    final newNote = Note(
      name: nameController.text,
      description: descriptionController.text,
    );

    await noteService.addNote(newNote);



    Get.back();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.amberAccent,
        title: Text(
          "Add Notes",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Form(
        key: noteFormKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter name",
                  prefixIcon: const Icon(Icons.note_alt_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Enter Description",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
                  }

                  return null;
                },
              ),
              Expanded(child: Container()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: ()  {
                  if (noteFormKey.currentState!.validate()) {
                    noteFormKey.currentState!.save();

                    // add note function call here
                    addNote();


                  }
                },
                child: Text(
                  "Save Notes",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}