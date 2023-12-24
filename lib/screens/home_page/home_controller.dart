import 'package:get/get.dart';
import 'package:gloify_task/services/api_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../models/home_model.dart';
import '../../utils/db_helper.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }


  Future<void> checkConnectivity() async{
    await _loadNotes();
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true && ApiService().apiUrl.isNotEmpty) {
     var message  =  await ApiService().postData(notes);
     Get.snackbar("","${message}");
    } else if(result == false ) {
      Get.snackbar("", "Internet not available");
    }
    else{
      Get.snackbar("API", "baseUrl not available");
    }
  }


  Future<void> _loadNotes() async {
    var db = await DatabaseHelper.instance.database;
    var result = await db.query('notes');
    notes.assignAll(result.map((note) => Note.fromMap(note)).toList());
  }

  Future<void> addNote(Note note) async {
    var db = await DatabaseHelper.instance.database;
    await db.insert('notes', note.toMap());
    _loadNotes();
  }

  Future<void> deleteNote(int id) async {
    var db = await DatabaseHelper.instance.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    _loadNotes();
  }

  Future<void> updateNote(Note note) async {
    var db = await DatabaseHelper.instance.database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    _loadNotes();
  }

}
