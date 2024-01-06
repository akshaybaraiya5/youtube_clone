import 'package:flutter/material.dart';
import 'package:get/get.dart';

class videoController extends GetxController{
  var id = ''.obs;
  var query = 'genaral'.obs;



  setId(value){
    id.value=value;
  }

  setQuery(value){
    query.value=value;
  }
}