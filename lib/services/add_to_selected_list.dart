import 'package:timessheet/file_export.dart';

class AddToSelectedList{
  final Firestore _firestore = Firestore.instance;

  addActivityToSelectedList(Activity activity ) {
    _firestore.collection(kselectedListTable).add({
      kactivityTime: activity.activityTime,
      kactivityStatus : activity.activityStatus,

    });
  }

  Stream<QuerySnapshot> loadActivity() {
    return _firestore.collection(kselectedListTable).snapshots();
  }
}