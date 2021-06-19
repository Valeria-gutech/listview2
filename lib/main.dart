import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main()=>runApp(MiApp());
class MiApp extends StatelessWidget {
  const MiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      home: Inicio(),
    );
  }
}
class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  Future <List<Product>>getData() async {
var response = await http.get(
  Uri.parse("https://jsonplaceholder.typicode.com/comments"),
  headers: {"Accept":"Applicatio/json"}
 );
 var data=json.decode(response.body);
 print(data);
 List<Product> products=[];
 for(var p in data){
   Product product=Product(p["ProductId"],p["Name"],p["Email"]);
   products.add(product);
 }
    return products;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title:Text("Valeria Gutierrez")
       ),
       body:Container(
         child: FutureBuilder(
           future: getData(),
           builder: (BuildContext context, AsyncSnapshot snapshot) {
           print(snapshot.data);
           if(snapshot.data == null){
             return Container(child:  Center(child: Text("Caargando.."),),);
           }
           else{
             return ListView.builder(
               itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int ProductId){
                 return ListTile(title:Text(snapshot.data.Name),);

               },
               );
           }
           },
         ) ,
         )
    );
  }
}

class Product {
  final int ProductId;
  final String Name;
  final String Email;

  Product (this.ProductId, this.Name, this.Email);
}