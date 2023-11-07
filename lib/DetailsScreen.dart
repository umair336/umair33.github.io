import 'package:api_check/Home_page.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeaths, totalRecovered, active, critical, todayRecovered, test;
   DetailsScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(widget.name.toString()),
      centerTitle: true,
    ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.065),
                child: Card(
                  child: Column(
                    children: [
                    ReuseableRow(tittle: "Cases",value: widget.totalCases.toString(),),
                    ReuseableRow(tittle: "Recovered",value: widget.totalRecovered.toString(),),
                    ReuseableRow(tittle: "Active",value: widget.active.toString(),),
                    ReuseableRow(tittle: "Critical",value: widget.critical.toString(),),
                    ReuseableRow(tittle: "Death",value: widget.totalDeaths.toString(),),
                    ReuseableRow(tittle: "Today Recovery",value: widget.todayRecovered.toString(),),
                    ],
                  ),
                ),
              )
          , CircleAvatar(
            radius:50 ,
            backgroundImage: NetworkImage(widget.image),
            )
            ],
          )
        ],
      ),
    );
  }
}