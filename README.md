## 자식부모상태 다루기 
- 자식부모상태 수동으로 가져다 쓰기
    - 부모의 상태를 보기: `static SonState of(BuildContext context) => context.findAncestorStateOfType<SonState>()!;` → `Son.of(context).name`(자식이호출)
    - 자식의 상태를 보기: `final sonKey = GlobalKey<GrandSonState>();` → `GrandSon(key: sonKey)` → `sonKey.currentState!.name`(부모가호출)

### 예제구조

![스크린샷 2024-03-25 19.36.52.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/c7af29bd-556b-42df-87f5-cac260b23c30/a4e8c881-29ea-4293-84ab-e0809b2cf9f1/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2024-03-25_19.36.52.png)

### main.dart

```java
import 'package:flutter/material.dart';
import 'package:global_key_test/widgets/parent.dart';

void main() {
  runApp(const Parent());
}

**class SnackbarGlobal {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void show(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text(message), duration: const Duration(seconds: 5)));**
  }
}

```

### parent.dart

```java

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
  **final sonKey = GlobalKey<SonState>();**
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
      **scaffoldMessengerKey: SnackbarGlobal.key,**
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
                  **Son(key: sonKey),**
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### son.dart

```java

import 'package:flutter/material.dart';
import 'package:global_key_test/widgets/widgets.dart';

class Son extends StatefulWidget {
  const Son({
    super.key,
  });

  @override
  State<Son> createState() => SonState();

  static SonState of(BuildContext context) {
    return context.findAncestorStateOfType<SonState>()!;
  }
}

**class SonState extends State<Son> {**
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
```

### grand_son.dart

```java

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

```