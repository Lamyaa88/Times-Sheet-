import 'file_export.dart';
main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Loading....'),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
          return
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
                child: MaterialApp(
                    theme: ThemeData(
                        primaryColor: kMainColor,
                        accentColor: kMainColor,
                        fontFamily: "Cairo",
                        textTheme: TextTheme(
                          bodyText1: TextStyle(),
                          bodyText2: TextStyle(),
                        ).apply(
                        )),
                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? HomePage.id : LoginScreen.id,
                routes: {
                LoginScreen.id: (context) => LoginScreen(),
                SignupScreen.id: (context) => SignupScreen(),
                HomePage.id : (context) => HomePage(),
                SelectedTimesScreen.id : (context) => SelectedTimesScreen(),

                },
            ),
          );
        }
      },
    );
  }
}



