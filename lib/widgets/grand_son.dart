import 'package:flutter/material.dart';
import 'package:global_key_test/widgets/widgets.dart';

class GrandSon extends StatefulWidget {
  const GrandSon({
    super.key,
  });

  @override
  State<GrandSon> createState() => GrandSonState();
}

class GrandSonState extends State<GrandSon> {
  String name = '나';
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
    return Container(
      width: 600,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: EnmBoxColor.grandSon.color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    onPressed: () {
                      SnackbarGlobal.show(
                          '${Son.of(context).name}    Son.of(context).name');
                    },
                    child: Text('▲ $name 의 아버지'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
