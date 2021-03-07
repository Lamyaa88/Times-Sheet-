import 'package:timessheet/file_export.dart';
class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, password;
  final _auth = Auth();
  final _trsckActivity = TrackActivity();


  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: widget.globalKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: height*.2,)
              ,
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: Text("TIMES SHEET ",style: TextStyle(color: Colors.white,
                    fontSize: height*.04,letterSpacing: 6,fontWeight: FontWeight.bold,),),),
                ],
              ),
              SizedBox(
                height: height * .07,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  password = value;
                },
                hint: 'Password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .01,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: kSecondaryColor,
                        activeColor: kMainColor,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remmeber Me ',
                      style: TextStyle(color: Colors.white ,fontSize: height*.018),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * .0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    height: height*.06,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
// (1) keep the user logged in
                      if (keepMeLoggedIn == true) {
                        keepUserLoggedIn();
// (2) validate
                      }

                      validate(context);

//  (3) store login time and status in database
                      _trsckActivity.addActivity(Activity(
                          activityStatus: "login",
                          activityTime: DateTime.now().toString()));


                    },
                    color: Colors.black,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account ?  ',
                    style: TextStyle(color: Colors.white, fontSize: height*.018),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }




  void validate(BuildContext context)async{
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeisLoading(true);
    if (widget.globalKey.currentState.validate()){
      widget.globalKey.currentState.save();
      try{
        await _auth.signIn(_email.trim(), password.trim());
        Navigator.pushNamed(context, HomePage.id);

      }catch(e){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(e.message),
        ));

      }
    }
    modelHud.changeisLoading(false);
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn );
  }
}

class AdminHome extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.red);
  }
}
