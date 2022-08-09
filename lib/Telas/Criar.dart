import 'package:flutter/material.dart';

class Criar extends StatefulWidget {
  const Criar({Key? key}) : super(key: key);

  @override
  State<Criar> createState() => _CriarState();
}

class _CriarState extends State<Criar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Criar",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
