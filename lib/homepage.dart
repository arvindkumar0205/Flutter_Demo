import 'dart:convert';

import 'package:fletter_demo/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SamplePost> samplepost = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return ListView.builder(
                itemCount: samplepost.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    width: 350,
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'user Id:${samplepost[index].userId} ',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          ' Id: ${samplepost[index].id} ',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          'tital :${samplepost[index].title} ',
                          maxLines: 1,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          'body : ${samplepost[index].body} ',
                          maxLines: 1,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                });
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }

  Future<List<SamplePost>> getData() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplepost.add(SamplePost.fromJson(index));
      }
      return samplepost;
    } else {
      return samplepost;
    }
  }
}
