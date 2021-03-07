import 'package:flutter/services.dart';
import 'package:timessheet/file_export.dart';
import 'package:timessheet/services/add_to_selected_list.dart';
import 'package:timessheet/widgets/customButtomNavigationBar.dart';
class SelectedTimesScreen extends StatefulWidget {
  static String id = 'selectedTimes';

  @override
  _SelectedTimesScreenState createState() => _SelectedTimesScreenState();
}

class _SelectedTimesScreenState extends State<SelectedTimesScreen> {
  final _auth = Auth();
  final _addToSelectedList =  AddToSelectedList();
  final _trsckActivity = TrackActivity();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Container(padding: EdgeInsets.only(right:width*.03 ,left: width*.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*.05,),
              Text("Selected Activities " ,style: TextStyle(color:
              kMainColor,fontSize: height*.03,fontWeight: FontWeight.bold),),
              Container(height: height*.8,
                child:activityView(),
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(isActiveButtonSelected: true,onTapSelected: false,),
    );
  }

  Widget activityView() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(

      stream: _addToSelectedList.loadActivity(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Activity> activities = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            activities.add(Activity(
              activityId: doc.documentID,
              activityTime: data[kactivityTime],
              activityStatus: data[kactivityStatus],
            ));
          }
          return ListView.builder(itemBuilder: (context ,index ){
            return InkWell(onTap: (){
            },
              child: Container(width: width*.7,height: height*.2,
                child: Card(elevation: height*.005,shadowColor: kMainColor,
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(width:width*.03,),
                        CircleAvatar(
                          radius: height*.035,child: Text(((index+1).toString()) ,style: TextStyle(color: Colors.white
                            ,fontSize: height*.03,fontWeight: FontWeight.bold),),backgroundColor:
                        kMainColor,),
                        SizedBox(width: width*.05,),

                        Column(children: [
                          SizedBox(height: height*.04,),
                          Text(activities[index].activityTime.toString(),style:  TextStyle(color:
                          kMainColor,fontSize: height*.02,),),
                          SizedBox(width:width*.03,),
                          SizedBox(height: height*.02,),

                          Row(
                            children: [
                              Text(activities[index].activityStatus.toString(),style:  TextStyle(color:
                              activities[index].activityStatus=="logout" ? Colors.pink:kMainColor,fontSize:
                              height*.02,fontWeight: FontWeight.bold),),
                              SizedBox(width:width*.35,),
                            ],
                          ),


                        ],),

                      ],
                    ),
                  ),
                ),
              ),
            );
          },itemCount: activities.length,);
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }
}
