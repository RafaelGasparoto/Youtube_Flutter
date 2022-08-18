import 'package:flutter/material.dart';

class Incricoes extends StatefulWidget {
  const Incricoes({Key? key}) : super(key: key);

  @override
  State<Incricoes> createState() => _IncricoesState();
}

class _IncricoesState extends State<Incricoes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Incrições",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
