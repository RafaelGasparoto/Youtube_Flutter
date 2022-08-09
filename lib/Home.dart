import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/Telas/Biblioteca.dart';
import 'package:youtube/Telas/Criar.dart';
import 'package:youtube/Telas/Inicio.dart';
import 'package:youtube/Telas/Inscricoes.dart';
import 'package:youtube/Telas/Shorts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indexAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [Inicio(_resultado), Shorts(), Criar(), Incricoes(), Biblioteca()];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "imagens/youtube.png",
          width: 100,
          height: 20,
        ),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.cast)),
          IconButton(onPressed: null, icon: Icon(Icons.notifications)),
          IconButton(onPressed: ()async{
            String? res = await showSearch(context: context, delegate: CustomSearchDelegate());
            setState(() {
              _resultado = res!;
            });
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: null, icon: Icon(Icons.account_circle)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: telas[_indexAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexAtual,
        type: BottomNavigationBarType.shifting,
        fixedColor: Colors.black,
        onTap: (index) {
          setState(() {
            _indexAtual = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: "Início",
              icon: Icon(Icons.home),
              backgroundColor: Colors.redAccent),
          BottomNavigationBarItem(
              label: "Shorts",
              icon: Icon(Icons.home),
              backgroundColor: Colors.amberAccent),
          BottomNavigationBarItem(
              label: "",
              icon: Icon(
                Icons.add_circle,
                size: 30,
              ),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              label: "Inscrições",
              icon: Icon(Icons.subscriptions),
              backgroundColor: Colors.purple),
          BottomNavigationBarItem(
              label: "Biblioteca",
              icon: Icon(Icons.folder),
              backgroundColor: Colors.green),
        ],
      ),
    );
  }
}
