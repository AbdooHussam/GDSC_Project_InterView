import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  List<Gdsc> photo = [];

  Future<void> getPhoto() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://breakingbadapi.com/api/characters"),
        headers: <String, String>{
          'Content-Type': 'application/json; char=UTF-8',
        },
      );
      var body = json.decode(response.body);
      body.map((e) {photo.add(Gdsc.fromJson(e));}).toList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}

class PhotoCard extends StatelessWidget {
  PhotoCard(
      {this.charId,
      this.name,
      this.birthday,
      this.img,
      this.status,
      this.nickname,
      this.portrayed,
      this.category});

  final int? charId;
  final String? name;
  final String? birthday;
  final String? img;
  final String? status;
  final String? nickname;
  final String? portrayed;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: AutoSizeText(
                name!,
                maxLines: 1,
                textAlign: TextAlign.center,
              )),
          child: Image.network(
            img!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class Gdsc {
  int? charId;
  String? name;
  String? birthday;
  List<String>? occupation;
  String? img;
  String? status;
  String? nickname;
  List<int>? appearance;
  String? portrayed;
  String? category;

  Gdsc({
    this.charId,
    this.name,
    this.birthday,
    this.occupation,
    this.img,
    this.status,
    this.nickname,
    this.appearance,
    this.portrayed,
    this.category,
  });

  Gdsc.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['char_id'] = this.charId;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['occupation'] = this.occupation;
    data['img'] = this.img;
    data['status'] = this.status;
    data['nickname'] = this.nickname;
    data['appearance'] = this.appearance;
    data['portrayed'] = this.portrayed;
    data['category'] = this.category;

    return data;
  }
}
