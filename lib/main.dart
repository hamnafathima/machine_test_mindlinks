import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Tabs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabNavigationScreen(),
    );
  }
}

class TabNavigationScreen extends StatefulWidget {
  const TabNavigationScreen({super.key});

  @override
  _TabNavigationScreenState createState() => _TabNavigationScreenState();
}

class _TabNavigationScreenState extends State<TabNavigationScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const TextPost(),
    const VideoPost(),
    const ImagePost(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'Text Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image Post',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TextPost extends StatelessWidget {
  final String postLink = 'https://example.com/textpost';

  const TextPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is a text post.', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _sharePost(context, postLink),
          child: const Text('Share'),
        ),
      ],
    );
  }
}

class VideoPost extends StatelessWidget {
  final String postLink = 'https://example.com/videopost';

  const VideoPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.video_library, size: 100),
        const Text('This is a video post.', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _sharePost(context, postLink),
          child: const Text('Share'),
        ),
      ],
    );
  }
}

class ImagePost extends StatelessWidget {
  final String postLink = 'https://example.com/imagepost';

  const ImagePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.image, size: 100),
        const Text('This is an image post.', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _sharePost(context, postLink),
          child: const Text('Share'),
        ),
      ],
    );
  }
}

void _sharePost(BuildContext context, String postLink) {
  final RenderBox box = context.findRenderObject() as RenderBox;
  Share.share(
    postLink,
    subject: 'Check out this post!',
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
