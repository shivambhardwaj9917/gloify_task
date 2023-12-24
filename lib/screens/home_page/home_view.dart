import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/home_model.dart';
import '../login_page/login_view.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: noteController.notes.length,
                itemBuilder: (context, index) {
                  var note = noteController.notes[index];
                  return Card(
                    elevation: 7,
                    color: Colors.white70,
                    child: ListTile(
                      title: Text("title: ${note.title}"),
                      subtitle: Text("content: ${note.content}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () {
                              _showEditNoteDialog(context, note);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              noteController.deleteNote(note.id!);
                              Get.snackbar("Data", "data deleted successfully",snackPosition: SnackPosition.TOP);
                            },
                          ),
                        ],
                      )
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: SideMenu(),
      floatingActionButton: FloatingActionButton.extended(
        //backgroundColor: Colors.red,
        label: const Text('Add Note'),
        icon: const Icon(Icons.add),
        onPressed: (){
          _showAddNoteDialog(context, null);
        },
      ),
    );
  }

  Future<void> _showEditNoteDialog(BuildContext context, Note note) async {
    TextEditingController titleController = TextEditingController(text: note.title);
    TextEditingController contentController = TextEditingController(text: note.content);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: titleController,
                        onChanged: (value) {
                        },
                        style: TextStyle(fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: 'Add a new task...',
                          border: InputBorder.none,
                          icon: Icon(Icons.task),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: contentController,
                          maxLines: 5,
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            hintText: 'Add a description...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var updatedNote = Note(
                  id: note.id,
                  title: titleController.text,
                  content: contentController.text,
                );
                noteController.updateNote(updatedNote);
                Get.back();
                Get.snackbar("Data", "data updated successfully",snackPosition: SnackPosition.TOP);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddNoteDialog(BuildContext context, int? id) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      child: TextField(
                        controller: titleController,
                        onChanged: (value) {
                        },
                        style: TextStyle(fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: 'Add a new task...',
                          border: InputBorder.none,
                          icon: Icon(Icons.task),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: contentController,
                          maxLines: 5,
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            hintText: 'Add a description...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var newNote = Note(
                  id: id,
                  title: titleController.text,
                  content: contentController.text,
                );
                noteController.addNote(newNote);
                Get.back();
                Get.snackbar("Data", "data add successfully",snackPosition: SnackPosition.TOP);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xff764abc)),
            accountName: const Text('Shivam Bhardwaj'),
            accountEmail: const Text("s.bhardwaj3112@gmail.com"),
            currentAccountPicture: InkWell(
              onTap: (){
              },
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.manage_accounts_sharp,color: Colors.white,),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.document_scanner_outlined),
            title: const Text('Home'),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logout();
            },
          ),

        ],
      ),
    );
  }
  Future<void> logout() async {
    // Clear login status in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Navigate to the login page
    Get.to(LoginScreen());
  }
}
