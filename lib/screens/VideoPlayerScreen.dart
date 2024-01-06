import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:youtube_clone/VideoList.dart';
import 'package:youtube_clone/screens/VideoScreenPage.dart';
import 'package:youtube_clone/VideoController.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final videoController videoIdController = Get.put(videoController());
  static String query= 'trending in india';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static Future<VideoData> fetchAlbum() async {
    final response = await http.get(
        Uri.parse(
            'https://youtube-v31.p.rapidapi.com/search?part=id%2Csnippet&type=video&maxResults=50&q='+query),
        headers: {
          "X-RapidAPI-Key":
          "684f8cc5c3msh1e7a6b43385a39fp198303jsn28bfeb5875b7",
          "X-RapidAPI-Host": "youtube-v31.p.rapidapi.com"
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return VideoData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  Widget appBarTitle = new Text("Youtube Clone");
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    return MaterialApp(
      home: Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(
            appBar: new AppBar(
                centerTitle: true,
                title:appBarTitle,
                actions: <Widget>[
                  new IconButton(icon: actionIcon,onPressed:(){
                    _formKey.currentState!.save();
                    FocusScope.of(context).unfocus();


                    setState(() {
                      if ( this.actionIcon.icon == Icons.search){

                        this.appBarTitle = new TextFormField(

                          style: new TextStyle(
                            color: Colors.black,

                          ),
                          decoration: new InputDecoration(
                              prefixIcon: new Icon(Icons.search,color: Colors.black),
                              hintText: "Search...",
                              hintStyle: new TextStyle(color: Colors.black)
                          ),
                          onSaved: (value){
                            setState(() {
                              query = value!;
                            });
                          },


                        );}
                      else {
                        this.actionIcon = new Icon(Icons.search);
                        this.appBarTitle = new Text("AppBar Title");
                      }


                    });
                  } ,),]
            ),


            body: Center(
              child: FutureBuilder<VideoData>(
                future: fetchAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(
                            height: size.height * 0.9,
                            child: ListView.builder(
                              itemCount: snapshot.data!.items!.length,
                              itemBuilder: (context, index) {
                                final user = snapshot.data!.items![index];
                                return Container(

                                  height: 270,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: size.width,
                                          height: 200,
                                          child: GestureDetector(
                                              onTap: () {
                                                videoIdController.setId(
                                                    user.id!.videoId.toString());
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            VideoScreenPage(
                                                              videoId: user.id!
                                                                  .videoId
                                                                  .toString(),)));
                                              },
                                              child: Image.network(
                                                user.snippet!.thumbnails!.medium!.url!
                                                    .toString(),
                                                fit: BoxFit.cover,))),
                                      Text(
                                        user.snippet!.title.toString(), maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                        ),),
                                      Text('${user.snippet!.channelTitle
                                          .toString()}  ・${user.snippet!.publishTime
                                          .toString()}', maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, color: Colors
                                            .grey,
                                            fontSize: 12
                                        ),)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text("No data available");
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
