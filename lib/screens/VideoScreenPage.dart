import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/VideoController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import '../VideoList.dart';


 final videoController controller = Get.find();


 class VideoScreenPage extends StatefulWidget {
   String videoId ;

  VideoScreenPage({super.key,required this.videoId});

   @override
   State<VideoScreenPage> createState() => _VideoScreenPageState(this.videoId);
 }

 class _VideoScreenPageState extends State<VideoScreenPage> {

   // final videoController videoIdController = Get.find();
   String videoId;


  _VideoScreenPageState(this.videoId);


   static var retlated =controller.id.value;


   @override
   void initState() {
     super.initState();
     _controller = YoutubePlayerController(
       initialVideoId: videoId,
       flags: const YoutubePlayerFlags(
         mute: false,
         autoPlay: true,
         disableDragSeek: false,
         loop: false,
         isLive: false,
         forceHD: false,
         enableCaption: true,
       ),
     )..addListener(listener);
     _idController = TextEditingController();

   }



   static Future<VideoData> fetchAlbum() async {
     final response = await http.get(
         Uri.parse(
             'https://youtube-v31.p.rapidapi.com/search?part=id%2Csnippet&type=video&maxResults=50&q='+retlated),
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

   // final videoController videoId = Get.find();

   late TextEditingController _idController;



   void listener() {

     }



late YoutubePlayerController _controller;


   @override
   Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;

     return  Scaffold(
       body:  Column(
         children: [
           SizedBox(
             height: size.height*0.33,
             child: YoutubePlayer(

               controller: _controller,
               showVideoProgressIndicator: true,

             ),
           ),
           FutureBuilder<VideoData>(
             future: fetchAlbum(),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const CircularProgressIndicator();
               } else if (snapshot.hasData) {
                 return Column(
                   children: [

                     SizedBox(
                       height: size.height * 0.66,
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
                                     width:size.width,
                                     height: 200,
                                     child: GestureDetector(

                                         onTap: (){
                                           Navigator.pop(context);
                                           Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=> VideoScreenPage(videoId:user.id!.videoId.toString(),)));

                                           _idController.text= user.id!.videoId.toString();
                                         },
                                         child: Image.network(user.snippet!.thumbnails!.medium!.url!.toString(),fit: BoxFit.cover,))),
                                 Text(user.snippet!.title.toString(),maxLines: 2 ,style: TextStyle(
                                     fontWeight: FontWeight.w500,
                                     fontSize: 16
                                 ),),
                                 Text('${user.snippet!.channelTitle.toString()}  ・${user.snippet!.publishTime.toString()}',maxLines: 2 ,style: TextStyle(
                                     fontWeight: FontWeight.w500,color: Colors.grey,
                                     fontSize: 12
                                 ),)
                               ],
                             ),
                           );
                         },
                       ),
                     ),
                   ],
                 );
               } else {
                 return const Text("No data available");
               }
             },
           ),
         ],
       ),
     );


   }
 }
