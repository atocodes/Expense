import "package:expense/models/user.dart";
import "package:flutter/material.dart";


class HomePage extends StatelessWidget{
  final User user;
  const HomePage({required this.user, super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(body:Center(child:Text("HomePage")));
  }
}