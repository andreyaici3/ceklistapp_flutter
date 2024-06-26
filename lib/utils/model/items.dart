// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  int statusCode;
  String message;
  dynamic errorMessage;
  List<Datum> data;

  Items({
    required this.statusCode,
    required this.message,
    required this.errorMessage,
    required this.data,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;
  List<Item>? items;
  bool checklistCompletionStatus;

  Datum({
    required this.id,
    required this.name,
    required this.items,
    required this.checklistCompletionStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        checklistCompletionStatus: json["checklistCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "checklistCompletionStatus": checklistCompletionStatus,
      };
}

class Item {
  int id;
  String name;
  bool itemCompletionStatus;

  Item({
    required this.id,
    required this.name,
    required this.itemCompletionStatus,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        itemCompletionStatus: json["itemCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "itemCompletionStatus": itemCompletionStatus,
      };
}
