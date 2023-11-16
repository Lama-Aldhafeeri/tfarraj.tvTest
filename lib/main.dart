import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

List<WebViewController> _videosControllers = [];
List<String> _videosIds = [
  '63f3daf03e12167f51c8fd7c',
  '64a1fa034bb997bdf598ef77',
  '64a1fee44bb997bdf5991442',
  '64a80dcf4bb997bdf59f34e2',
];

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    for (var element in _videosIds) {
      WebViewController controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              const CircularProgressIndicator();
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://tfarraj.tv/embed/$element')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse('https://tfarraj.tv/embed/$element'));
      _videosControllers.add(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: _videosIds.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: WebViewWidget(controller: _videosControllers[index]));
          },
        ),
      ),
    );
  }
}
