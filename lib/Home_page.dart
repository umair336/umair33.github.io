import 'package:api_check/Model/api.dart';
import 'package:api_check/Services/Utilities/State_Services.dart';
import 'package:api_check/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
   late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this
  )..repeat();

  final ColorList= <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
      StateServices stateServices =StateServices();

    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 
            MediaQuery.of(context).size.height*.0200
            ,),
            FutureBuilder(
              future: stateServices.fetchWorldStateRecord(),
              builder:(context, AsyncSnapshot<WorldStateModel> snapshot){
                if(!snapshot.hasData){
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white24,
                    size: 50,
                    controller: controller,
                  ),
                );
                }else{
                  return Column(
                    children: [
                       PieChart(dataMap: 
            {
              "Total": double.parse(snapshot.data!.cases!.toString(),),
              "Recovered": double.parse(snapshot.data!.recovered.toString()),
              "Death": double.parse(snapshot.data!.deaths.toString()),
             
            },
            chartValuesOptions:const ChartValuesOptions(
              showChartValuesInPercentage: true
            ),
            ),
            Card(shadowColor: Colors.black,shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)), // You can adjust the radius to change the shape
        ),
              child: Column(
                children: [
              ReuseableRow(tittle: "Total",value: snapshot.data!.cases.toString(),),
              ReuseableRow(tittle: "Recovered",value: snapshot.data!.recovered.toString(),),
              ReuseableRow(tittle: "Death",value: snapshot.data!.deaths.toString(),),
               ReuseableRow(tittle: "Active",value: snapshot.data!.active.toString(),),
              ReuseableRow(tittle: "Critical",value: snapshot.data!.critical.toString(),),
              ReuseableRow(tittle: "Today Deaths",value: snapshot.data!.todayDeaths.toString(),),
               ReuseableRow(tittle: "Today Recovery",value: snapshot.data!.todayRecovered.toString(),),


                ],
              ),
            ),SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GestureDetector(onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                 } ,
                   child: Container(height: 50,
                               decoration: BoxDecoration(
                    color: Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(20),
                               ),
                               child: Center(
                    child: Text("Track Countries"),
                               ),
                             ),
                 ),
               )

                    ],
                  );
                }
              } ,
            
            ),
                     ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
    String tittle,value;
 ReuseableRow({super.key,required this.tittle,required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
        // EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.03),
      child: Column(
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tittle),
              Text(value)
            ],
          )
        ],
      ),
    );
  }
}