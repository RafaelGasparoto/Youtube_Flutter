import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/Telas/Biblioteca.dart';
import 'package:youtube/Telas/Criar.dart';
import 'package:youtube/Telas/Inicio.dart';
import 'package:youtube/Telas/Inscricoes.dart';
import 'package:youtube/shorts_icons_fill.dart';
import 'package:youtube/shorts_icons.dart';

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
    List<Widget> telas = [
      Inicio(_resultado),
      const Incricoes(),
      const Criar(),
      const Incricoes(),
      const Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
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
          const IconButton(onPressed: null, icon: Icon(Icons.cast)),
          const IconButton(onPressed: null, icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () async {
                String? res = await showSearch(
                    context: context, delegate: CustomSearchDelegate());
                setState(() {
                  _resultado = res!;
                });
              },
              icon: const Icon(Icons.search)),
          const IconButton(onPressed: null, icon: Icon(Icons.account_circle)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: telas[_indexAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexAtual,
        type: BottomNavigationBarType.shifting,
        fixedColor: Colors.white,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _indexAtual = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: "Início",
              icon: (_indexAtual == 0)
                  ? const Icon(
                      Icons.home,
                    )
                  : const Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
            label: "Shorts",
            icon: (_indexAtual == 1)
                ? const Icon(
                    ShortsFill.shortsFill,
                  )
                : const Icon(Shorts.shorts),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: (_indexAtual == 2)
                ? const Icon(
                    Icons.add_circle,
                    size: 30,
                  )
                : const Icon(
                    Icons.add_circle_outline,
                    size: 30,
                  ),
          ),
          BottomNavigationBarItem(
            label: "Inscrições",
            icon: (_indexAtual == 3)
                ? const Icon(Icons.subscriptions)
                : const Icon(Icons.subscriptions_outlined),
          ),
          BottomNavigationBarItem(
            label: "Biblioteca",
            icon: (_indexAtual == 4)
                ? const Icon(Icons.folder)
                : const Icon(Icons.folder_outlined),
          ),
        ],
      ),
    );
  }
}
