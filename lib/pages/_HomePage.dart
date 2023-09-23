
// API call page
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';

class HomeePage extends StatefulWidget {
  const HomeePage({Key? key}) : super(key: key);

  @override
  State<HomeePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomeePage> {
  List<Welcome> welcome = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context,snapshot) {
        if (snapshot.hasData){
          return ListView.builder(
              itemCount: welcome.length,
              itemBuilder: (context, index){
                return Container(padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.all(10),
                  color: Colors.tealAccent,
                  height: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Id: ${welcome[index].userId}"),
                      Text("Id: ${welcome[index].id}"),
                      Text("Title: ${welcome[index].title}"),
                      Text("Body: ${welcome[index].body}",maxLines: 1),
                    ],
                  ),
                );
              });
        }
        else{
          return Center(child: CircularProgressIndicator(), );
        }

      }
    );
  }

  Future<List<Welcome>> getData()async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')) ;
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map<String,dynamic> index in data){
        welcome.add(Welcome.fromJson(index));
      }
      return welcome ;
    }else{
      return welcome ;
    }
  }
}
