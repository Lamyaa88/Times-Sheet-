import 'package:timessheet/file_export.dart';
class SettingsScreen extends StatefulWidget {
  static String id = 'selectedTimes';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  final _auth = Auth();
  final _trsckActivity = TrackActivity();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor:kSecondaryColor,
      body: Center(
        child: InkWell(child: Text("Logout",style:
        TextStyle(fontSize: height*.05,color: kMainColor)),onTap: ()async{
          SharedPreferences pref =
          await SharedPreferences.getInstance();
          pref.clear();
          await _auth.signOut();
          Navigator.popAndPushNamed(context, LoginScreen.id);
          _trsckActivity.addActivity(Activity(
              activityStatus: "logout",
              activityTime: DateTime.now().toString()));
        },),
      ),bottomNavigationBar:
      CustomBottomNavigationBar(isActiveButtonSettings: true,onTapSettings: false,),
    );
  }
}
