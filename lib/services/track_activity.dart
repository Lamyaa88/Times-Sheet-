import 'package:timessheet/file_export.dart';

class TrackActivity {
  final Firestore _firestore = Firestore.instance;

  addActivity(Activity activity ) {
    _firestore.collection(kactivityTrackeingTable).add({
      kactivityTime: activity.activityTime,
      kactivityStatus : activity.activityStatus,

    });
  }

  Stream<QuerySnapshot> loadActivity() {
    return _firestore.collection(kactivityTrackeingTable).snapshots();
  }


  deleteActivity(documentId) {
    _firestore.collection(kactivityTrackeingTable).document(documentId).delete();
  }

  editActivity(data, documentId) {
    _firestore
        .collection(kactivityTrackeingTable)
        .document(documentId)
        .updateData(data);
  }


}