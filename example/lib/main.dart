import 'package:flutter/material.dart';
import 'package:liquid_glass_ui_design/liquid_glass_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidThemeProvider(
      theme: const LiquidTheme(
        primaryColor: Color(0x90FFFFFF),
        accentColor: Color(0xFF2196F3), // Blue for blog theme
        blurStrength: 10.0,
        borderRadius: 12.0,
        textStyle: TextStyle(
          fontFamily: 'SFPro',
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        defaultPadding: EdgeInsets.all(12.0),
        defaultMargin: EdgeInsets.all(8.0),
      ),
      child: MaterialApp(
        title: 'Liquid Glass Blog List App',
        theme: ThemeData.light(),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _switchValue = false;
  double _sliderValue = 0.5;
  int _currentStep = 0;
  String? _dropdownValue = 'Tech';

  final List<Map<String, dynamic>> _dummyPosts = [
    {'title': 'Flutter Basics', 'content': 'Learn Flutter in 10 mins'},
    {'title': 'UI Design Tips', 'content': 'Best practices for UI'},
    {'title': 'Mobile Development', 'content': 'Trends in 2025'},
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight;
    return Scaffold(
      body: Container(
        color: Colors.blueGrey, // Plain white background
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    SizedBox(height: screenHeight, child: _buildBlogTab()),
                    SizedBox(height: screenHeight, child: _buildCategoriesTab()),
                    SizedBox(height: screenHeight, child: _buildProfileTab()),
                  ],
                ),
              ),
              LiquidBottomNav(
                icons: const [Icons.list, Icons.category, Icons.person],
                onItemSelected: _onItemSelected,
                semanticsLabel: 'Blog Navigation',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var post in _dummyPosts)
            LiquidCard(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LiquidText(
                      text: post['title'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      semanticsLabel: 'Post Title ${post['title']}',
                    ),
                    const SizedBox(height: 8),
                    LiquidText(
                      text: post['content'],
                      semanticsLabel: 'Post Content ${post['content']}',
                    ),
                    const SizedBox(height: 8),
                    LiquidButton(
                      child: const Text('Read More', style: TextStyle(color: Colors.black87)),
                      onTap: () => print('Read ${post['title']}'),
                      semanticsLabel: 'Read More ${post['title']}',
                    ),
                  ],
                ),
              ),
              semanticsLabel: 'Post Card ${post['title']}',
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidText(
            text: 'Categories',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            semanticsLabel: 'Categories Title',
          ),
          const SizedBox(height: 16),
          LiquidChip(
            label: 'Tech',
            selected: true,
            onSelected: (selected) => print('Tech selected: $selected'),
            semanticsLabel: 'Tech Chip',
          ),
          const SizedBox(height: 8),
          LiquidChip(
            label: 'Lifestyle',
            selected: false,
            onSelected: (selected) => print('Lifestyle selected: $selected'),
            semanticsLabel: 'Lifestyle Chip',
          ),
          const SizedBox(height: 8),
          LiquidChip(
            label: 'Travel',
            selected: false,
            onSelected: (selected) => print('Travel selected: $selected'),
            semanticsLabel: 'Travel Chip',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidAvatar(
            radius: 60.0,
            semanticsLabel: 'Profile Avatar',
          ),
          const SizedBox(height: 16),
          LiquidText(
            text: 'Jane Doe',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            semanticsLabel: 'Username',
          ),
          const SizedBox(height: 16),
          LiquidText(
            text: '5 Posts | 30 Followers',
            semanticsLabel: 'User Stats',
          ),
          const SizedBox(height: 16),
          LiquidButton(
            child: const Text('Edit Profile', style: TextStyle(color: Colors.black87)),
            onTap: () => print('Edit profile tapped'),
            semanticsLabel: 'Edit Button',
          ),
          const SizedBox(height: 16),
          LiquidSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() => _switchValue = value),
            semanticsLabel: 'Notifications Toggle',
          ),
          const SizedBox(height: 16),
          LiquidSlider(
            value: _sliderValue,
            onChanged: (value) => setState(() => _sliderValue = value),
            semanticsLabel: 'Font Size Slider',
          ),
          const SizedBox(height: 16),
          LiquidDropdown<String>(
            value: _dropdownValue,
            items: const [
              DropdownMenuItem(value: 'Tech', child: Text('Tech')),
              DropdownMenuItem(value: 'Lifestyle', child: Text('Lifestyle')),
            ],
            onChanged: (value) => setState(() => _dropdownValue = value),
            hint: 'Select Category',
            semanticsLabel: 'Category Dropdown',
          ),
          const SizedBox(height: 16),
          LiquidStepper(
            steps: [
              Step(
                title: const Text('Step 1', style: TextStyle(color: Colors.black87)),
                content: const Text('Account Setup', style: TextStyle(color: Colors.black87)),
              ),
              Step(
                title: const Text('Step 2', style: TextStyle(color: Colors.black87)),
                content: const Text('Preferences', style: TextStyle(color: Colors.black87)),
              ),
            ],
            currentStep: _currentStep,
            onStepTapped: (index) => setState(() => _currentStep = index),
            onStepContinue: () => setState(() => _currentStep = (_currentStep + 1).clamp(0, 1)),
            onStepCancel: () => setState(() => _currentStep = (_currentStep - 1).clamp(0, 1)),
            semanticsLabel: 'Setup Stepper',
          ),
          const SizedBox(height: 16),
          LiquidButton(
            child: const Text('Logout', style: TextStyle(color: Colors.black87)),
            onTap: () => print('Logged out'),
            semanticsLabel: 'Logout Button',
          ),
        ],
      ),
    );
  }
}