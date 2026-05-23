import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shorts App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.red,
          secondary: Colors.redAccent,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FeedScreen(),
      },
    );
  }
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _mockPosts = [
    {
      'username': '@flutter_dev',
      'description': 'Building a shorts app in Flutter! #flutter #coding',
      'color': Colors.blueGrey.shade800,
      'likes': '1.2K',
      'comments': '342',
      'shares': '56',
    },
    {
      'username': '@dart_master',
      'description': 'Dart is awesome. Look at this cool animation. #dart #animation',
      'color': Colors.teal.shade800,
      'likes': '890',
      'comments': '12',
      'shares': '4',
    },
    {
      'username': '@ui_designer',
      'description': 'Beautiful UI design inspiration. #ui #ux #design',
      'color': Colors.deepPurple.shade800,
      'likes': '5.6K',
      'comments': '1.1K',
      'shares': '890',
    },
    {
      'username': '@tech_news',
      'description': 'The latest in tech today. #tech #news',
      'color': Colors.indigo.shade800,
      'likes': '432',
      'comments': '54',
      'shares': '12',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: _mockPosts.length,
        itemBuilder: (context, index) {
          final post = _mockPosts[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background (Simulating Video/Photo)
              Container(
                color: post['color'],
                child: const Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),
              // Content (Bottom Left)
              Positioned(
                bottom: 20,
                left: 16,
                right: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      post['username'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post['description'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Actions (Bottom Right)
              Positioned(
                bottom: 20,
                right: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildActionItem(Icons.favorite, post['likes']),
                    const SizedBox(height: 16),
                    _buildActionItem(Icons.comment, post['comments']),
                    const SizedBox(height: 16),
                    _buildActionItem(Icons.share, post['shares']),
                    const SizedBox(height: 16),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://picsum.photos/100'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 36),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Library',
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

