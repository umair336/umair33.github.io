import 'package:api_check/DetailsScreen.dart';
import 'package:api_check/Services/Utilities/State_Services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices =StateServices();
    return Scaffold(
      appBar: AppBar(elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcontroller,
              onChanged: (value){
                setState(() {
                  
                });
              },
              decoration: InputDecoration(
                // icon: Icon(Icons.search),
                hintText: "search with country name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
              ),
            ),
          ),
      Expanded(
        child:FutureBuilder(
          future: stateServices.CountriesListApi(),
          builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {

          if(!snapshot.hasData){
           return  ListView.builder(itemCount:4
             ,itemBuilder:(context, index) {
        return     Shimmer.fromColors(
         baseColor: Colors.green.shade600,
         highlightColor: Colors.green.shade100,
         child:  Column(children: [
             ListTile(
       title:Container(height: 10,width: 89,color: Colors.white,),
       leading:Container(height: 50,width: 50,color: Colors.white),
              subtitle: Container(height: 10,width: 89,color: Colors.white),
     ),
 
              ],),
         );
            }, );
          }
          else
          {
            return ListView.builder(itemCount: snapshot.data!.length
             ,itemBuilder:(context, index) {
              String name= snapshot.data![index]["country"];
      if(searchcontroller.text.isEmpty){
          return      Column(children: [
     InkWell(onTap:(){ 
      Navigator.push(context, MaterialPageRoute(builder:(context) =>
      DetailsScreen(name: snapshot.data![index]["country"],
       image: snapshot.data![index]['countryInfo']['flag'],
        totalCases: snapshot.data![index]["cases"],
       totalDeaths: snapshot.data![index]["deaths"],
        totalRecovered: snapshot.data![index]["recovered"], 
       active: snapshot.data![index]["active"],
        critical: snapshot.data![index]["critical"],
        todayRecovered: snapshot.data![index]["todayRecovered"],
         test: snapshot.data![index]["tests"]) ,));},
       child: ListTile(
       title: Text(snapshot.data![index]["country"]),
       leading: Image(
         height: 50,
         width: 50,
         image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
         subtitle: Text(snapshot.data![index]["cases"].toString()),
     ),
     ),
     ],);
      }
      else if(
        name.toLowerCase().contains(searchcontroller.text.toString())){
           return Column(children: [
            InkWell(onTap: (){
               Navigator.push(context, MaterialPageRoute(builder:(context) =>
      DetailsScreen(name: snapshot.data![index]["country"],
       image: snapshot.data![index]['countryInfo']['flag'],
        totalCases: snapshot.data![index]["cases"],
       totalDeaths: snapshot.data![index]["deaths"],
        totalRecovered: snapshot.data![index]["recovered"], 
       active: snapshot.data![index]["active"],
        critical: snapshot.data![index]["critical"],
        todayRecovered: snapshot.data![index]["todayRecovered"],
         test: snapshot.data![index]["tests"]) ,));
            },
              child: ListTile(
                title: Text(snapshot.data![index]["country"]),
              leading: Image(
                height: 50,
                width: 50,
                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                subtitle: Text(snapshot.data![index]["cases"].toString()),
            ),
            ),
     ],);
        } else{
  Container();
}

            }, );
           

          }
        },)
         )
        ]),
      ),
    );
  }
}