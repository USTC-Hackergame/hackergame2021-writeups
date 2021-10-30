import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = '灯，等灯等灯';

  @override
  Widget build(BuildContext context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          routes: {
            '/': (context) => HomeScreen(),
            '/0': (context) => LevelPage(
                    level: 0,
                    threshold: 0,
                    excludeIndex: [],
                    weightMatrix: [
                      [0, 0, 1, 0, 0],
                      [0, 0, 2, 0, 0],
                      [1, 2, 3, 2, 1],
                      [0, 0, 2, 0, 0],
                      [0, 0, 1, 0, 0],
                    ]),
            '/1': (context) =>
                LevelPage(level: 1, threshold: 400, excludeIndex: [
                  26,
                  38,
                  50,
                  39,
                  40,
                  52,
                  28,
                  115,
                  116,
                  117,
                  105,
                  103,
                  91,
                  79,
                  80,
                  81
                ], weightMatrix: [
                  [0, 0, 1, 0, 0],
                  [0, 0, 2, 0, 0],
                  [1, 2, 3, 2, 1],
                  [0, 0, 2, 0, 0],
                  [0, 0, 1, 0, 0],
                ]),
            '/2': (context) =>
                LevelPage(level: 2, threshold: 600, excludeIndex: [
                  26,
                  28,
                  32,
                  33,
                  38,
                  40,
                  44,
                  50,
                  51,
                  52,
                  55,
                  56,
                  86,
                  87,
                  88,
                  91,
                  92,
                  93,
                  99,
                  103,
                  111,
                  115,
                  116,
                  117
                ], weightMatrix: [
                  [127, 127, 127, 127, 127],
                  [127, 63, 63, 63, 127],
                  [127, 63, 31, 63, 127],
                  [127, 63, 63, 63, 127],
                  [127, 127, 127, 127, 127]
                ]),
          });
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("灯，等灯等灯",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  child: Text('Level 0'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 60),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/0',
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  child: Text('Level 1'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 60),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/1',
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  child: Text('Level 2'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 60),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/2',
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}

class LevelPage extends StatefulWidget {
  final List<List<int>> weightMatrix;
  final List<int> excludeIndex;
  final int threshold;
  final int level;

  const LevelPage({
    required this.weightMatrix,
    required this.excludeIndex,
    required this.threshold,
    required this.level,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<LevelPage> {
  static final countMatrix = 12;

  static final target = [
    [189, 189, 189, 189, 189, 33, 33, 33, 189, 189, 189, 189],
    [189, 189, 189, 33, 33, 33, 189, 33, 44, 189, 189, 189],
    [189, 189, 189, 189, 189, 33, 33, 33, 33, 189, 189, 189],
    [189, 189, 189, 189, 189, 33, 189, 33, 33, 189, 189, 189],
    [189, 189, 189, 33, 33, 189, 189, 33, 33, 33, 189, 189],
    [189, 134, 33, 33, 189, 189, 189, 189, 33, 33, 189, 189],
    [189, 144, 33, 33, 189, 189, 189, 189, 33, 189, 189, 189],
    [189, 142, 33, 33, 189, 189, 189, 189, 33, 33, 33, 189],
    [189, 100, 142, 33, 189, 189, 189, 189, 33, 33, 33, 189],
    [189, 142, 142, 189, 189, 189, 189, 189, 189, 33, 189, 189],
    [189, 59, 142, 33, 189, 189, 189, 189, 33, 189, 189, 189],
    [189, 189, 33, 33, 189, 189, 189, 189, 189, 189, 189, 189]
  ];
  bool isPressed = false;
  bool showInsight = false;
  bool showTarget = false;
  late List<List<int>> matrix, solution;
  late int score;

  void updateScore() {
    setState(() {
      int temp = 0;
      for (var i = 0; i < countMatrix; i++) {
        for (var j = 0; j < countMatrix; j++) {
          var value = (matrix[i][j] - target[i][j]).abs();
          temp += value;
        }
      }
      score = temp;
    });
  }

  Future<void> submit(int lv) async {
    final response = await http.post(Uri.parse('/submit'), body: {
      "level": widget.level.toString(),
      "solution": solution.toString()
    });
    Text title;
    if (response.statusCode == 200) {
      title = Text("提交结果");
    } else {
      title = Text(response.statusCode.toString());
    }
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: title,
              content: Text(response.body),
            ));
  }

  @override
  void initState() {
    super.initState();
    setState(() => matrix = List.generate(
          countMatrix,
          (_) => List.generate(countMatrix, (_) => 0),
        ));
    setState(() => solution = List.generate(
          countMatrix,
          (_) => List.generate(countMatrix, (_) => 0),
        ));
    updateScore();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.pink.shade400,
          title: Tooltip(
            message: "达到目标分值后方可获取 FLAG",
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.lerp(
                      Colors.green.shade400,
                      Colors.pink.shade400,
                      score / 20277.0)!),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                      "Lv.${widget.level} - "
                      "当前分值: $score / 目标分值: ${widget.threshold}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                onPressed: () => submit(widget.level)),
          ),
          centerTitle: true,
          actions: <Widget>[
            ToggleButtons(
                children: <Widget>[
                  Tooltip(message: "详细信息", child: Icon(Icons.remove_red_eye)),
                  Tooltip(message: "目标图案", child: Icon(Icons.blur_on)),
                ],
                isSelected: [
                  showInsight,
                  showTarget,
                ],
                color: Colors.white,
                selectedColor: Colors.indigo.shade900,
                splashColor: Colors.purple,
                hoverColor: Colors.cyan,
                renderBorder: false,
                onPressed: (int index) {
                  setState(() {
                    if (index == 0) {
                      showInsight = !showInsight;
                    } else {
                      showTarget = !showTarget;
                    }
                  });
                }),
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('帮助'),
                  content: Container(
                    width: 800,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Text("\u2022 触碰方块会提升附近方块的亮度. "
                            "不同关卡中亮度增加幅度可能有所差别."),
                        Text("\u2022 方块的亮度范围为 [0, 255], "
                            "当某个方块的亮度达到 256 时会归零."),
                        Text("\u2022 部分关卡中会存在禁止触碰的方块. "
                            "在详细数据中会以红色勾勒出来."),
                        Text("\u2022 游戏目标是使得各方块亮度尽可能接近给定图案."),
                        Text("\u2022 当前局面的分值为各方块亮度"
                            "与目标图案对应方块的亮度之差的绝对值之和."),
                        Text("\u2022 当分值降至目标分数时, 可点击标题按钮获取关卡对应的 FLAG."),
                        Text(""),
                        Text("提示:"),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "\u2022 点击 "),
                            WidgetSpan(
                                child: Icon(Icons.remove_red_eye, size: 19)),
                            TextSpan(text: " 按钮以显示详细数据."),
                          ]),
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "\u2022 点击 "),
                            WidgetSpan(child: Icon(Icons.blur_on, size: 19)),
                            TextSpan(text: " 按钮以检查目标图案."),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('好耶'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: SizedBox(
            width: min(
                min(
                        MediaQuery.of(context).size.height -
                            (AppBar().preferredSize.height),
                        MediaQuery.of(context).size.width) *
                    0.8,
                800),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: countMatrix,
                        ),
                        itemBuilder: buildField,
                        itemCount: countMatrix * countMatrix,
                        shrinkWrap: true,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      );

  Color getFieldColor(int value) {
    return Color((((value << 8) + value) << 8) + value + 0xFF000000);
  }

  Widget buildField(BuildContext context, int index) {
    int x = (index / countMatrix).floor();
    int y = index % countMatrix;
    final value = showTarget ? target[x][y] : matrix[x][y];
    final color = getFieldColor(value);

    bool excluded = false;
    for (int i = 0; i < widget.excludeIndex.length; i++) {
      if (index == widget.excludeIndex[i]) {
        excluded = true;
      }
    }
    return Container(
      margin: EdgeInsets.all(1),
      decoration: excluded && showInsight
          ? BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.redAccent.shade400.withOpacity(0.8),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(1, 1),
              )
            ])
          : null,
      child: GestureDetector(
        child: AspectRatio(
          aspectRatio: 1,
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(20, 20)),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(color),
            ),
            child: showInsight
                ? FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(value.toString(),
                        style: TextStyle(
                            fontSize: 10, color: Colors.limeAccent.shade700)))
                : null,
            onPressed:
                (!excluded && !showTarget) ? () => selectField(x, y) : null,
          ),
        ),
        onLongPressStart: (!excluded && !showTarget)
            ? (_) async {
                isPressed = true;
                do {
                  selectField(x, y);
                  await Future.delayed(Duration(milliseconds: 30));
                } while (isPressed);
              }
            : null,
        onLongPressEnd: (!excluded && !showTarget)
            ? (_) => setState(() => isPressed = false)
            : null,
      ),
    );
  }

  void selectField(int x, int y) {
    setState(() {
      solution[x][y] = (solution[x][y] + 1) % 256;
      for (int i = 0; i < widget.weightMatrix.length; i++) {
        for (int j = 0; j < widget.weightMatrix[i].length; j++) {
          if (x + 2 - i >= 0 &&
              x + 2 - i < countMatrix &&
              y + 2 - j >= 0 &&
              y + 2 - j < countMatrix)
            matrix[x + 2 - i][y + 2 - j] =
                (matrix[x + 2 - i][y + 2 - j] + widget.weightMatrix[i][j]) %
                    256;
        }
      }
    });
    updateScore();
  }
}
