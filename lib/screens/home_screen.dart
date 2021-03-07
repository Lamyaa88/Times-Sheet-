import 'package:timessheet/file_export.dart';
class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final _trackActivity = TrackActivity();
  final _addToSelectedList = AddToSelectedList();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Container(padding: EdgeInsets.only(right:width*.03 ,left: width*.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*.05,),
              Text("Your Activity History" ,style: TextStyle(color:
              kMainColor,fontSize: height*.03,fontWeight: FontWeight.bold),),
              Container(height: height*.8,
                child:activityView(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(isActiveButtonHome : true,onTapHome: false ,),


    );
  }
  Widget activityView() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return StreamBuilder<QuerySnapshot>(
      stream: _trackActivity.loadActivity(),
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
            bool _selected = false ;

            return InkWell(
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
                          Text(activities[index].activityTime.toString()
                            ,style:
                          TextStyle(color:
                          kMainColor,fontSize: height*.02,),),
                          SizedBox(width:width*.03,),
                          SizedBox(height: height*.02,),

                          Row(
                            children: [

                              Text(activities[index].activityStatus.toString(),style:  TextStyle(color:
                              activities[index].activityStatus=="logout" ? Colors.pink:kMainColor,fontSize:
                              height*.02,fontWeight: FontWeight.bold),),
                              SizedBox(width:width*.3,),

                              InkWell(onTap: (){
                                Scaffold.of(context).showSnackBar(SnackBar(backgroundColor: Colors.black.withOpacity(.5),
                                  content: Text("Activity Added to Selected List !"),
                                ));
                                _addToSelectedList.addActivityToSelectedList(Activity(
                                activityId:activities[index].activityId.toString() ,
                                activityStatus: activities[index].activityStatus.toString(),
                                activityTime: activities[index].activityTime.toString(),
                              ));
                              },
                                  child: Text("Select" ,style: TextStyle(color:
                                  kMainColor,fontSize: height*.025,fontWeight:
                                  FontWeight.bold),))],
                          ),
                          SizedBox(width:20,),

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
