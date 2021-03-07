import 'package:timessheet/file_export.dart';
class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: height*.15,)
              ,
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(child: Text("TIMES SHEET ",style: TextStyle(color: Colors.white,
                    fontSize: height*.04,letterSpacing: 6,fontWeight: FontWeight.bold,),),),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              CustomTextField(
                onClick: (value) {},
                icon: Icons.perm_identity,
                hint: 'Name',
              ),
              SizedBox(
                height: height * .02,
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
                  _password = value;
                },
                hint: 'Phone',
                icon: Icons.phone,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    height: height*.06,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      final modelHud = Provider.of<ModelHud>(context, listen: false);
                      modelHud.changeisLoading(true);

                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final authResult = await _auth.signUp(
                              _email.trim(), _password.trim());
                          modelHud.changeisLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                        } on
                        PlatformException catch (e) {
                          modelHud.changeisLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(backgroundColor: kSecondaryColor,
                            content: Text(e.message,style: TextStyle(color: Colors.red),),
                          ));

                        }
                      }
                      modelHud.changeisLoading(false);

                    },
                    color: Colors.black,
                    child: Text(
                      'SIGN UP ',
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
                    'Already have an account !   ',
                    style: TextStyle(color: Colors.white, fontSize: height*.02),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}