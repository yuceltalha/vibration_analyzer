// ignore_for_file: avoid_web_libraries_in_flutter, unused_import, import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart' as http;
import 'package:vibration_catcher/models/metric_model.dart';

const _credentials = r''' 
{
  "type": "service_account",
  "project_id": "xyz-values",
  "private_key_id": "74e33380b6d7f42dfe372a9ef2c66232418141f8",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQD2H61Qn+bHhAiv\nomY0V59Q2Uvrj6OTynPhHwtHPAa/XGfax5dx3ZaUeSGOVJa5ng3wWkPcVP7JB4OX\n1NjTTu3F2IctLQM5kIIIx2ZILHVNgU+pHHU8toNO95auSk0WPvTBJ6Igk9Lj0OUh\ntwqAY1izxZQtVFpl+WEf8eFFpwJW8KWcqSObPs0A+pQUtx46aXUOkCD1yud00Vk0\n5ivVr2s8aIqhKP2gnFPpw0qO0Ad1ntENU2kItQJZVGBbhsI+9RlGlOCLY6rNpNPQ\nZuDaF4tdksrB1LBGjtaGlruV/Y4sbGVJMZZ7B1mG6O7R1PATtiMFFtUxWe7TYUh8\n3d16P8udAgMBAAECggEAJvVjLAKvl0/HRzPb3TesdHH88jvRnvx6JL2S/bLa95Hz\nL36N8pxqcDSPUvYBSL7jwnKrULZUgTIzCobKzoHtIbbRSN2Z59P/vU+A2XZOGBda\nqnBif1p9hPOscoi41IdhGy0AnQsBJAYGKvTMEQAIw6YH+zfhukgD73hMWgfiVyvf\ndpL++rmdMICWEwrOge9mwH6ldGMbUAi7i+RFwo7HcDgdQmR7ca2it0OOC4iLTof8\n5+2Rqn+wqkJaB1KF+ErDFJ0i6axE5tstzH4uoCfdawbKElC212FmSBfHQ6ySTR2m\n17u4R5jYl1OAa1diBbUntFxbilpNtrsZdMxFb6TxwQKBgQD9wjfbL2ya5xMlEBlT\n4zuGHzmhhi53gMo/stO8wqBftTSAWZ73kSwx8/b2VJ9WOJxQn0e3rgLkT+pOgCMG\n9KhCV22o87/e2eGDJEDScUQoRU7hp1MAuHdEQv4SZe7LEtB0B7hwbA1RHCCL7m++\nvMRbWNF79TPktRw//A+hBNMs3QKBgQD4TDH7vGwWeL7xHyj+9BtjvjnEoAuxEWYz\nANPBST/+SE4FJXWhsTd5r4JskdSsWav6JfzMKKJuPY7OxcoGkvOgdIMcJ81jmX1y\n5WnmAPhQvlKHl+METVA7w0iGD2tY4GUnH7AeLB4v6/yRPJ9OS/CkC02WUcBnI87o\nrw7sQ7bNwQKBgDAPJH0CklMUCHAwiFt24cMZDtUkkJBZd/RwbeGGCtGVhAf68Tx5\n5iDfz5n/lN3DgvdR80c6UZnj+MA9TGT42RUXcdFZuLEAGtG3f/9bLElkNvhNtE6i\noRPwjCX34C3dtlUDUU8ZZ7xA03ktA0Tgg1+5hpMvcVCTbHJBzsP0IfqRAoGAHaOC\nx+jrAhexuzib/SsIZfScErOEEcPg7i+oF0d2IxVgcs7Q5tcvpw/jQrB5sYUWuUp1\nja1ADma8uEP15Kj/+eROjjrWEpCM3/0wkesFuSWu1k60I5xS+n9KFe6bQsWubWgj\n7sYXaGMECBYzcfYwqHRM86eYjvdASJg08ND4bkECgYBT1OvSozsb24oeVFz3Ooo+\nij2iv4R4TkDal87Ap6l8oW7OJabWV4QseJ2Zq/R+kZvlAw/+2RsfPKo1YK0pTFDr\nmwSgYfAfXOLlEFdb25Y8cCh3ItBsEcVjnKqZ7Lmm6DF4hfBv9c6lxee9G5z9dOgE\nkzu4FW3AOLfx8BpCkpb79g==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheet@xyz-values.iam.gserviceaccount.com",
  "client_id": "117587747145577706707",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheet%40xyz-values.iam.gserviceaccount.com"
}
''';
const _spreadSheetId = "1wnbeM5-tRB63NApPgHhXVVdXfQKTC7Y0K9EtrqxEQis";

class SheetStorage {
  List<List<double>> items = [];

  sheetFunc(List x, int row, int col) async {
    final gSheets = GSheets(_credentials);
    final ss = await gSheets.spreadsheet(_spreadSheetId);
    var sheet = ss.worksheetByTitle("xyz-metrics1");
    sheet.values.insertColumn(col, x, fromRow: row * 100 + 1);
  }

  sheetFuncY(List y, int row, int col) async {
    final gSheets = GSheets(_credentials);
    final ss = await gSheets.spreadsheet(_spreadSheetId);
    var sheet = ss.worksheetByTitle("xyz-metrics1");
    sheet.values.insertColumn(col, y, fromRow: row * 100 + 1);
  }

  sheetFuncZ(List z, int row, int col) async {
    final gSheets = GSheets(_credentials);
    final ss = await gSheets.spreadsheet(_spreadSheetId);
    var sheet = ss.worksheetByTitle("xyz-metrics1");
    sheet.values.insertColumn(col, z, fromRow: row * 100 + 1);
  }

  clearSheet() async {
    final gSheets = GSheets(_credentials);
    final ss = await gSheets.spreadsheet(_spreadSheetId);
    var sheet = ss.worksheetByTitle("xyz-metrics1");
    sheet.clear();
  }
  final apiKey= "AKfycbyCuVRXdh_NsurrxMFLijUmShD-I3Cpb0uuxCEVkKBq69O_Lm_WOwogIg9DqlkktnOzwg";

  Future<MetricModel> getDataFromGoogleSheet() async {
    final response = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/$apiKey/exec"),
    );  print(response.body);
      print(response.statusCode);
    if (response.statusCode == 200) {
    
      return MetricModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }
}
