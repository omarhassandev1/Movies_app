import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  WebViewApp({required this.url,required this.title, super.key});
  String url;
  String title;
  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("watch ${widget.title}",style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// //import 'package:webview_flutter_module/constants/text_constants.dart';

// class WebViewScreen extends StatefulWidget {
//    WebViewScreen({required this.url, Key? key}) : super(key: key);
//   static const String routeName = "web_view";
//   String url;
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }
// class _WebViewScreenState extends State<WebViewScreen> {
//   late WebViewController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse(widget.url),
//       );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("watch now"),
//       ),
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }