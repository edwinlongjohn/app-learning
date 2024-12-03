import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  dynamic url;
  NetworkHelper({required this.url});

  Future<dynamic> getData() async {
    try {
      var response = await http.get(url).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        return 'not found';
      }
    } catch (e) {
      return 'error';
    }
  }

  Future<dynamic> getImage() async {
    try {
      var response = await http.get(url).timeout(
            const Duration(seconds: 60),
          );
      if (response.statusCode == 200) {
        Uint8List data = response.bodyBytes;
        return data;
      } else {
        throw Exception('image not found');
      }
    } catch (e) {
      return 'error';
    }
  }
}
