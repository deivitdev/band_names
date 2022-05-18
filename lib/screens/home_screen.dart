import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Band> bands = [
    Band(id: '1', name: 'Green day', vote: 2),
    Band(id: '1', name: 'Blink 182', vote: 4),
    Band(id: '1', name: 'Simple Plan', vote: 1),
    Band(id: '1', name: 'My Chemical Romance', vote: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'BandNames',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i]),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 1,
          onPressed: () {
            addNewBand();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        // TODO llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white, size: 32),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.vote}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                color: Colors.blue[100],
                textColor: Colors.blue,
                elevation: 5,
                onPressed: () => addBandTOList(textController.text),
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('New band name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () => addBandTOList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Close'),
              onPressed: () => addBandTOList(textController.text),
            ),
          ],
        );
      },
    );
  }

  void addBandTOList(String name) {
    print(name);
    if (name.length > 1) {
      // Podemos agregar
      bands.add(
        Band(id: DateTime.now().toString(), name: name, vote: 0),
      );
    }
    Navigator.pop(context);
  }
}
