import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter ScreenShot Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo ScreenShot Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Image _image = Image.asset("assets/example.jpg");

  GlobalKey previewContainer = GlobalKey();
  int originalSize = 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RepaintBoundary(
                  key: previewContainer,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple),
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "This is a picture.",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Image.asset("assets/example.jpg"),
                        const Text(
                          "There’s something so whimsical about these beautiful images that incorporate bokeh. It’s almost as if they could be from a different, magical world. We’ve loved watching the submissions fly in for our bokeh-themed Photo Quest by Meyer-Optik-Görlitz and selected 30+ of our favourites beautiful images to ignite your creative spark! The three lucky winners of this Quest are going to receive an incredible prize courtesy of master lens-crafters Meyer-Optik.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: ElevatedButton(
                          child: const Text("Take Screenshot!"),
                          onPressed: () {
                            ShareFilesAndScreenshotWidgets()
                                .takeScreenshot(previewContainer, originalSize)
                                .then((Image value) {
                                  setState(() {
                                    _image = value;
                                  });
                                } as FutureOr Function(Image? value));
                          }),
                    ),
                    Container(
                        child: ElevatedButton(
                            child: const Text("Share Screenshot!"),
                            onPressed: () {
                              ShareFilesAndScreenshotWidgets().shareScreenshot(
                                  previewContainer,
                                  originalSize,
                                  "Title",
                                  "Name.png",
                                  "image/png",
                                  text: "This is the caption!");
                            })),
                    Container(
                        child: ElevatedButton(
                            child: const Text("Share Image!"),
                            onPressed: () async {
                              ByteData bytes =
                                  await rootBundle.load('assets/example.jpg');
                              Uint8List list = bytes.buffer.asUint8List();
                              ShareFilesAndScreenshotWidgets().shareFile(
                                  "Title", "Name.jpg", list, "image/jpg",
                                  text: "This is the caption!");
                            })),
                    Container(
                        child: ElevatedButton(
                            child: const Text("Share Video!"),
                            onPressed: () async {
                              ByteData bytes =
                                  await rootBundle.load('assets/example.mp4');
                              Uint8List list = bytes.buffer.asUint8List();
                              ShareFilesAndScreenshotWidgets().shareFile(
                                  "Title", "Name.mp4", list, "video/mp4",
                                  text: "This is the caption!");
                            })),
                    Container(
                        child: ElevatedButton(
                            child: const Text("Share Audio!"),
                            onPressed: () async {
                              ByteData bytes =
                                  await rootBundle.load('assets/example.mp3');
                              Uint8List list = bytes.buffer.asUint8List();
                              ShareFilesAndScreenshotWidgets().shareFile(
                                  "Title", "Name.mp3", list, "audio/mp3",
                                  text: "This is the caption!");
                            })),
                  ],
                ),
                _image
              ],
            ),
          ),
        ));
  }
}
