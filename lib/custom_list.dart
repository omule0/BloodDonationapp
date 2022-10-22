import 'package:flutter/material.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List<String> data = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
  ];
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return Card(
              color: Colors.deepOrangeAccent,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: Text(data[index]),
                  trailing: Container(
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                            children: [
                                              TextField(
                                                onChanged: ((value) {
                                                  setState(() {
                                                    text = value;
                                                  });
                                                }),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      data[index] = text;
                                                    });
                                                  },
                                                  child: Text('update'))
                                            ],
                                          ));
                                },
                                icon: Icon(Icons.edit))),
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    data.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.delete))),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
