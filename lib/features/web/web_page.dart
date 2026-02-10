import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String title;
  final String url;

  const WebPage({super.key, required this.title, required this.url});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late final WebViewController _controller;
  int _loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _loadingPercentage = 0;
            });
          },
          onProgress: (int progress) {
            setState(() {
              _loadingPercentage = progress;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error: ${error.description}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal memuat: ${error.description}')),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan Gradient
      appBar: AppBar(
        // UPDATE: Hanya menampilkan Judul, tanpa URL
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false, // Judul rata kiri
        
        // Background Gradient
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF050542),
                Color(0xFF0A0F6C),
              ],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Tombol Navigasi Web (Back, Forward, Refresh)
          NavigationControls(controller: _controller),
        ],
      ),
      
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          
          // Loading Bar Modern (Linear) di bagian atas
          if (_loadingPercentage < 100)
            LinearProgressIndicator(
              value: _loadingPercentage / 100.0,
              color: const Color(0xFFFFA726), // Warna Amber (Accent)
              backgroundColor: Colors.transparent,
              minHeight: 4, 
            ),
        ],
      ),
    );
  }
}

// --- WIDGET KONTROL NAVIGASI (Back, Forward, Reload) ---
class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.controller});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () async {
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tidak ada riwayat kembali')),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
          onPressed: () async {
            if (await controller.canGoForward()) {
              await controller.goForward();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tidak ada riwayat maju')),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay_rounded, size: 24),
          onPressed: () {
            controller.reload();
          },
        ),
        const SizedBox(width: 8), // Sedikit jarak di kanan
      ],
    );
  }
}