import 'package:flutter/material.dart';
import 'package:responsi/responsi_124200082/helper/data_source.dart';
import 'package:responsi/responsi_124200082/helper/matchesmodel.dart';
import 'detail.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piala Dunia 2022"),
      ),
      body: Container(
        color: Colors.red,
        child: FutureBuilder(
            future: MatchesSource.instance.LoadMatches(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              if (snapshot.hasError) {
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                // MatchesModel1 matchesModel1 = MatchesModel1.fromJson(snapshot.data);
                return _buildSuccessSection(snapshot.data);
              }
              return _buildLoadingSection();
            }
        ),
      ),
    );

  }

  Widget _buildErrorSection(){
    return Text("Error");
  }
  Widget _buildLoadingSection(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Widget _buildSuccessSection(MatchesModel data){
  Widget _buildSuccessSection(List<dynamic> data){
    return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          // final HomeTeam? homeTeam = data.homeTeam?[index];
          MatchesModel matchesModel = MatchesModel.fromJson(data[index]);
          return Container(
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchDetail(
                            detail: matchesModel,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // if you need this
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                'https://countryflagsapi.com/png/${matchesModel.homeTeam!.name!}', width: 150,height: 150,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(("${matchesModel.homeTeam!.name!}")),
                              ),
                            ],
                          ),

                          SizedBox(width: 20,),
                          Text(("${matchesModel.homeTeam!.goals!}")),
                          SizedBox(width: 20,),
                          Text("-"),
                          SizedBox(width: 20,),
                          Text(("${matchesModel.awayTeam!.goals!}")),
                          SizedBox(width: 20,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Image.network('https://countryflagsapi.com/png/${matchesModel.awayTeam!.name!}',width: 150,height: 150,),
                                Text(("${matchesModel.awayTeam!.name!}")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 48,
        );
    }
}