import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

class CountryModel {
  String? status;
  CountryData? data;

  CountryModel({
    this.status,
    this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        status: json["status"],
        data: CountryData.fromJson(json["data"]),
      );
}

class CountryData {
  int? totalSize;
  List<CountryList>? list;

  CountryData({
    this.totalSize,
    this.list,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        totalSize: json["totalSize"],
        list: List<CountryList>.from(
            json["list"].map((x) => CountryList.fromJson(x))),
      );
}

class CountryList {
  String? name;
  int? code;
  int? id;
  String? shortname;

  CountryList({
    this.name,
    this.code,
    this.id,
    this.shortname,
  });

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
        name: json["name"],
        code: json["code"],
        id: json["id"],
        shortname: json["shortname"],
      );
}
