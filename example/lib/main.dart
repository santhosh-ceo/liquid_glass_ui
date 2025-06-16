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
        accentColor: Color(0xFFFF9500), // Warm orange for iOS 26 vibe
        blurStrength: 40.0,
        borderRadius: 24.0,
        textStyle: TextStyle(
          fontFamily: 'SFPro',
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        defaultPadding: EdgeInsets.all(12.0),
        defaultMargin: EdgeInsets.all(8.0),
      ),
      child: MaterialApp(
        title: 'Liquid Glass UI Design Demo',
        theme: ThemeData.dark(),
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF9013FE),
            ], // Blue to purple gradient
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // TabBar
              Container(
                color: Colors.black.withOpacity(0.3),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  indicatorColor: Colors.white,
                  tabs: const [
                    Tab(text: 'Input'),
                    Tab(text: 'Navigation'),
                    Tab(text: 'Content'),
                    Tab(text: 'Feedback'),
                    Tab(text: 'Layout'),
                    Tab(text: 'Decorative & Interactive'),
                  ],
                ),
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Input Components
                    _buildInputTab(),
                    // Navigation Components
                    _buildNavigationTab(),
                    // Content Components
                    _buildContentTab(),
                    // Feedback Components
                    _buildFeedbackTab(),
                    // Layout Components
                    _buildLayoutTab(),
                    // Decorative & Interactive Components
                    _buildDecorativeInteractiveTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputTab() {
    final controller = TextEditingController();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidButton(
            child: const Text('Tap Me', style: TextStyle(color: Colors.white)),
            onTap: () => print('Button tapped'),
            semanticsLabel: 'Action Button',
          ),
          const SizedBox(height: 16),
          LiquidTextField(
            controller: controller,
            hintText: 'Enter text',
            onChanged: (value) => print(value),
            semanticsLabel: 'Input Field',
          ),
          const SizedBox(height: 16),
          LiquidSwitch(
            value: true,
            onChanged: (value) => print('Switch: $value'),
            semanticsLabel: 'Toggle Switch',
          ),
          const SizedBox(height: 16),
          LiquidSlider(
            value: 0.5,
            onChanged: (value) => print('Slider: $value'),
            semanticsLabel: 'Volume Slider',
          ),
          const SizedBox(height: 16),
          LiquidPicker(
            items: const ['Option 1', 'Option 2', 'Option 3'],
            onSelected: (index) => print('Selected: $index'),
            semanticsLabel: 'Option Picker',
          ),
          const SizedBox(height: 16),
          LiquidDropdown<String>(
            value: null,
            items: const [
              DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
              DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
            ],
            onChanged: (value) => print('Selected: $value'),
            hint: 'Select an option',
            semanticsLabel: 'Dropdown',
          ),
          const SizedBox(height: 16),
          LiquidRadio<String>(
            value: 'Option 1',
            groupValue: 'Option 1',
            onChanged: (value) => print('Radio: $value'),
            semanticsLabel: 'Radio Option 1',
          ),
          const SizedBox(height: 16),
          LiquidCheckbox(
            value: true,
            onChanged: (value) => print('Checkbox: $value'),
            semanticsLabel: 'Checkbox',
          ),
          const SizedBox(height: 16),
          LiquidToggle(
            options: const ['A', 'B', 'C'],
            selectedIndices: const [0],
            onChanged: (indices) => print('Toggle: $indices'),
            semanticsLabel: 'Toggle Group',
          ),
          const SizedBox(height: 16),
          LiquidSearch(
            controller: controller,
            onChanged: (value) => print('Search: $value'),
            semanticsLabel: 'Search Bar',
          ),
          const SizedBox(height: 16),
          LiquidRating(
            value: 3.5,
            onChanged: (value) => print('Rating: $value'),
            semanticsLabel: 'Rating',
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidTabs(
            tabs: const ['Tab 1', 'Tab 2', 'Tab 3'],
            onTabSelected: (index) => print('Tab $index selected'),
          ),
          const SizedBox(height: 16),
          LiquidBottomNav(
            icons: const [Icons.home, Icons.search, Icons.person],
            onItemSelected: (index) => print('Nav item $index selected'),
            semanticsLabel: 'Navigation Bar',
          ),
          const SizedBox(height: 16),
          LiquidAppBar(
            title: const Text('App Bar', style: TextStyle(color: Colors.white)),
            semanticsLabel: 'App Bar',
          ),
          const SizedBox(height: 16),
          LiquidDrawer(
            child: ListView(
              children: const [
                LiquidListTile(
                  title: Text('Item 1'),
                  semanticsLabel: 'Drawer Item 1',
                ),
                LiquidListTile(
                  title: Text('Item 2'),
                  semanticsLabel: 'Drawer Item 2',
                ),
              ],
            ),
            semanticsLabel: 'Navigation Drawer',
          ),
          const SizedBox(height: 16),
          LiquidFAB(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => print('FAB pressed'),
            semanticsLabel: 'Add Button',
          ),
          const SizedBox(height: 16),
          LiquidPageView(
            children: [
              Container(color: Colors.red.withOpacity(0.3), height: 200),
              Container(color: Colors.green.withOpacity(0.3), height: 200),
            ],
            onPageChanged: (index) => print('Page: $index'),
            semanticsLabel: 'Page View',
          ),
          const SizedBox(height: 16),
          LiquidCarousel(
            items: [
              Container(color: Colors.blue.withOpacity(0.3), height: 200),
              Container(color: Colors.yellow.withOpacity(0.3), height: 200),
            ],
            onPageChanged: (index) => print('Carousel: $index'),
            semanticsLabel: 'Image Carousel',
          ),
          const SizedBox(height: 16),
          LiquidSegment<String>(
            values: const ['Option 1', 'Option 2'],
            selectedValue: 'Option 1',
            onChanged: (value) => print('Segment: $value'),
            semanticsLabel: 'Segment Control',
          ),
        ],
      ),
    );
  }

  Widget _buildContentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidCard(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'This is a card',
                style: TextStyle(color: Colors.white),
              ),
            ),
            semanticsLabel: 'Content Card',
          ),
          const SizedBox(height: 16),
          LiquidText(text: 'Sample Text', semanticsLabel: 'Sample Text'),
          const SizedBox(height: 16),
          LiquidIcon(
            icon: Icons.star,
            onTap: () => print('Icon tapped'),
            semanticsLabel: 'Star Icon',
          ),
          const SizedBox(height: 16),
          LiquidAvatar(radius: 40.0, semanticsLabel: 'User Avatar'),
          const SizedBox(height: 16),
          LiquidListTile(
            title: const Text('Item 1', style: TextStyle(color: Colors.white)),
            onTap: () => print('List tile tapped'),
            semanticsLabel: 'Item 1',
          ),
          const SizedBox(height: 16),
          LiquidGridTile(
            child: Container(color: Colors.purple.withOpacity(0.3)),
            onTap: () => print('Grid tile tapped'),
            semanticsLabel: 'Grid Item',
          ),
          const SizedBox(height: 16),
          LiquidBanner(
            message: 'New Update!',
            action: TextButton(
              onPressed: () => print('Update'),
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
            semanticsLabel: 'Update Banner',
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidAlert(
            title: 'Alert',
            content: 'This is an alert dialog.',
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
            semanticsLabel: 'Sample Alert',
          ),
          const SizedBox(height: 16),
          LiquidDialog(
            content: const Text(
              'This is a custom dialog.',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            semanticsLabel: 'Custom Dialog',
          ),
          const SizedBox(height: 16),
          LiquidProgress(value: 0.7, semanticsLabel: 'Progress'),
          const SizedBox(height: 16),
          LiquidIndicator(active: true, semanticsLabel: 'Active Indicator'),
          const SizedBox(height: 16),
          LiquidLoader(semanticsLabel: 'Loading Spinner'),
        ],
      ),
    );
  }

  Widget _buildLayoutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidScaffold(
            body: const LiquidText(
              text: 'Scaffold Body',
              semanticsLabel: 'Scaffold Content',
            ),
            appBar: const LiquidAppBar(
              title: Text(
                'Scaffold AppBar',
                style: TextStyle(color: Colors.white),
              ),
              semanticsLabel: 'Scaffold App Bar',
            ),
            semanticsLabel: 'Sample Scaffold',
          ),
          const SizedBox(height: 16),
          LiquidContainer(
            child: const LiquidText(
              text: 'Container Content',
              semanticsLabel: 'Container',
            ),
            semanticsLabel: 'Sample Container',
          ),
          const SizedBox(height: 16),
          LiquidDivider(thickness: 2.0, semanticsLabel: 'Separator'),
          const SizedBox(height: 16),
          LiquidSpacer(height: 30, semanticsLabel: 'Spacer'),
          const SizedBox(height: 16),
          LiquidStack(
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.red.withOpacity(0.3),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
            ],
            semanticsLabel: 'Stacked Content',
          ),
          const SizedBox(height: 16),
          LiquidScrollBar(
            semanticsLabel: 'Scrollable List',
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => LiquidListTile(
                      title: Text(
                        'Item $index',
                        style: TextStyle(color: Colors.white),
                      ),
                      semanticsLabel: 'List Item $index',
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeInteractiveTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiquidChip(
            label: 'Filter',
            selected: true,
            onSelected: (selected) => print('Chip selected: $selected'),
            semanticsLabel: 'Filter Chip',
          ),
          const SizedBox(height: 16),
          LiquidTag(
            label: 'New',
            onTap: () => print('Tag tapped'),
            semanticsLabel: 'New Tag',
          ),
          const SizedBox(height: 16),
          LiquidBadge(
            text: '5',
            onTap: () => print('Badge tapped'),
            semanticsLabel: 'Notification Badge',
          ),
          const SizedBox(height: 16),
          LiquidPlaceholder(semanticsLabel: 'Loading Placeholder'),
          const SizedBox(height: 16),
          LiquidShimmer(
            child: Container(width: double.infinity, height: 100),
            semanticsLabel: 'Shimmer Effect',
          ),
          const SizedBox(height: 16),
          LiquidSkeleton(
            width: double.infinity,
            height: 50,
            semanticsLabel: 'Skeleton Loader',
          ),
          const SizedBox(height: 16),
          LiquidMenu(
            items: [
              const PopupMenuItem(child: Text('Option 1'), value: 1),
              const PopupMenuItem(child: Text('Option 2'), value: 2),
            ],
            child: const Text(
              'Open Menu',
              style: TextStyle(color: Colors.white),
            ),
            semanticsLabel: 'Context Menu',
          ),
          const SizedBox(height: 16),
          LiquidPopup<String>(
            child: const Text('Popup', style: TextStyle(color: Colors.white)),
            items: [
              const PopupMenuItem(value: 'Option 1', child: Text('Option 1')),
              const PopupMenuItem(value: 'Option 2', child: Text('Option 2')),
            ],
            onSelected: (value) => print('Selected: $value'),
            semanticsLabel: 'Popup Menu',
          ),
          const SizedBox(height: 16),
          LiquidTooltip(
            message: 'This is a hint',
            child: const Text(
              'Hover me',
              style: TextStyle(color: Colors.white),
            ),
            semanticsLabel: 'Hint Tooltip',
          ),
          const SizedBox(height: 16),
          LiquidExpansion(
            title: 'Details',
            content: const Text(
              'Expandable content',
              style: TextStyle(color: Colors.white),
            ),
            semanticsLabel: 'Details Panel',
          ),
          const SizedBox(height: 16),
          LiquidAccordion(
            title: 'Section 1',
            content: const Text(
              'Accordion content',
              style: TextStyle(color: Colors.white),
            ),
            semanticsLabel: 'Section 1 Accordion',
          ),
          const SizedBox(height: 16),
          LiquidStepper(
            steps: [
              Step(
                title: const Text(
                  'Step 1',
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                  'First step content',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Step(
                title: const Text(
                  'Step 2',
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                  'Second step content',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            currentStep: 0,
            onStepTapped: (index) => print('Step tapped: $index'),
            semanticsLabel: 'Process Stepper',
          ),
        ],
      ),
    );
  }
}
