import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> veriListesi = [];
  bool yukleniyor = true;

  Future<void> veriCek() async {
    final url = Uri.parse(
      "https://jsonplaceholder.typicode.com/posts",
    ); // Örnek API
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final veri = json.decode(response.body);
      setState(() {
        veriListesi = veri;
        yukleniyor = false;
      });
    } else {
      print("Hata: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    veriCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          yukleniyor
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: veriListesi.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(veriListesi[index]['title']),
                      subtitle: Text(veriListesi[index]['body']),
                    ),
                  );
                },
              ),
    );
  }
}
