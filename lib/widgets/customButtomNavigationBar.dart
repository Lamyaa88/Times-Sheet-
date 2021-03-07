import 'package:timessheet/file_export.dart';
class CustomBottomNavigationBar extends StatelessWidget {
  final bool isActiveButtonHome;
  final bool isActiveButtonSelected;
  final bool isActiveButtonSettings;
  final bool onTapHome;
  final bool onTapSelected;
  final bool onTapSettings;
  CustomBottomNavigationBar(
      {this.isActiveButtonHome: false,
      this.isActiveButtonSelected : false,
      this.isActiveButtonSettings: false,
      this.onTapHome: true,
      this.onTapSelected: true,
      this.onTapSettings: true ,
      });
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: kMainColor,
                  blurRadius: 10.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              )),
          height: height * .09,
          width: width,
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                      onTap: onTapHome ==false ? (){print(" home  pressed");} : () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return HomePage();
                            },
                            transitionsBuilder:
                                (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );
                      },
                      child: isActiveButtonHome == false
                          ? Container(
                              child:Text("Home" ,style: TextStyle(fontSize: height*.018,
                                  color:kMainColor,letterSpacing:
                                  -0.5,fontWeight: FontWeight.bold),),
                            )
                          : Stack(
                              children: [
                                Container(
                                    height: height * .2,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kMainColor),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text("Home" ,style: TextStyle(fontSize: height*.018,
                                            color:Colors.white,letterSpacing:
                                        -0.5,fontWeight: FontWeight.bold),),
                                      ),
                                    )),
//                        redPoint will be here
                                Container()
                              ],
                            )),
                  InkWell(
                      onTap: onTapSelected == false ? (){print("selected pressed ");} : () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return SelectedTimesScreen();
                            },
                            transitionsBuilder:
                                (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );
                      },
                      child: isActiveButtonSelected == false
                          ? Container(
                        child:Text("Selected" ,style: TextStyle(fontSize: height*.018,
                            color:kMainColor,letterSpacing:
                            -0.5,fontWeight: FontWeight.bold),),
                      )
                          : Stack(
                        children: [
                          Container(
                              height: height * .2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kMainColor),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("Selected" ,style: TextStyle(fontSize: height*.018,
                                      color:Colors.white,letterSpacing:
                                      -0.5,fontWeight: FontWeight.bold),),
                                ),
                              )),
//                        redPoint will be here
                          Container()
                        ],
                      )),

                  InkWell(
                      onTap: onTapSettings  ==false ? (){print(" settings pressed");} : () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return SettingsScreen();
                            },
                            transitionsBuilder:
                                (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );
                      },
                      child: isActiveButtonSettings  == false
                          ? Container(
                        child: Text("Settings" ,style: TextStyle(fontSize: height*.018,
                            color:kMainColor,letterSpacing:
                            -0.5,fontWeight: FontWeight.bold),),
                      )
                          : Stack(
                        children: [
                          Container(
                              height: height * .2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kMainColor),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child:Text("Settings" ,style: TextStyle(fontSize: height*.018,
                                      color:Colors.white,letterSpacing:
                                      -0.5,fontWeight: FontWeight.bold),),
                                ),
                              )),
//                        redPoint will be here
                          Container()
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onTap() {
    print("pressed");
  }
}
