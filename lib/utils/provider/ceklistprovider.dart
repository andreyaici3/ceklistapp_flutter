import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_test/utils/model/items.dart';

class CekListProvider with ChangeNotifier {
  Items? items;
  String url = "http://94.74.86.174:8080/api";
  String token =
      "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlcyI6W119.i2OVQdxr08dmIqwP7cWOJk5Ye4fySFUqofl-w6FKbm4EwXTStfm0u-sGhDvDVUqNG8Cc7STtUJlawVAP057Jlg";

  Items? get getAllItem {
    return items;
  }

  Future<Items> getAll() async {
    final dio = Dio();

    final response = await dio.get(
      "$url/checklist",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    final i = Items.fromJson(response.data);
    items = i;
    return i;
  }

  Future saveItem(String name) async {
    final dio = Dio();

    final response = await dio.post("$url/checklist",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
        data: {"name": name});

    return response;
  }

  Future saveSubItem(int ceklistId, String item) async {
    final dio = Dio();

    final response = await dio.post("$url/checklist/$ceklistId/item",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
        data: {"itemName": item});

    return response;
  }

  Future deleteItem(int id) async {
    final dio = Dio();

    final response = await dio.delete(
      "$url/checklist/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response.data;
  }

  Future deleteSubItem(int ceklisId, int id) async {
    final dio = Dio();

    final response = await dio.delete(
      "$url/checklist/$ceklisId/item/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response.data;
  }
}
