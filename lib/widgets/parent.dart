import 'package:flutter/material.dart';
import 'package:global_key_test/widgets/widgets.dart';

class Parent extends StatefulWidget {
  const Parent({super.key});

  @override
  State<Parent> createState() => ParentState();

  static ParentState of(BuildContext context) {
    return context.findAncestorStateOfType<ParentState>()!;
  }
}

class ParentState extends State<Parent> {
  String name = '할아버지';
  TextEditingController nameController = TextEditingController();
  final sonKey = GlobalKey<SonState>();
  @override
  void initState() {
    super.initState();
    nameController.text = name;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: SnackbarGlobal.key,
      home: Scaffold(
        body: Center(
          child: Container(
            width: 600,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: EnmBoxColor.parent.color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 40),
                      SizedBox(
                          width: 100,
                          child: TextField(
                            controller: nameController,
                            onChanged: (text) => setState(() => name = text),
                          )),
                      const SizedBox(width: 220),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          child: Text('$name 의 아들 ▼'),
                          onPressed: () {
                            SnackbarGlobal.show(
                                '${sonKey.currentState!.name}    sonKey.currentState!.name');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Son(key: sonKey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
