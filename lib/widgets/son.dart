import 'package:flutter/material.dart';
import 'package:global_key_test/widgets/widgets.dart';

class Son extends StatefulWidget {
  const Son({
    super.key,
  });

  @override
  State<Son> createState() => SonState();

  static SonState of(BuildContext context) =>
      context.findAncestorStateOfType<SonState>()!;
}

class SonState extends State<Son> {
  String name = '아버지';
  TextEditingController nameController = TextEditingController();
  final sonKey = GlobalKey<GrandSonState>();
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
    return Container(
      width: 600,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: EnmBoxColor.son.color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                SizedBox(
                    width: 100,
                    child: TextField(
                      controller: nameController,
                      onChanged: (text) => setState(() => name = text),
                    )),
                const SizedBox(width: 20),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    child: Text('▲ $name 의 아버지'),
                    onPressed: () {
                      SnackbarGlobal.show(
                          '${Parent.of(context).name}   Parent.of(context).name');
                    },
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    child: Text('$name 의 아들 ▼'),
                    onPressed: () {
                      SnackbarGlobal.show(
                          '${sonKey.currentState!.name}   sonKey.currentState!.name');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GrandSon(key: sonKey),
          ],
        ),
      ),
    );
  }
}
