# Liquid Glass UI

A Flutter package providing 52 iOS 26-style liquid glass UI components with frosted glass effects, smooth transitions, and flexible customization. Enhance your Flutter apps with a modern, elegant, and immersive user interface inspired by iOS 26’s aesthetic.

[![Pub Version](https://img.shields.io/pub/v/liquid_glass_ui)](https://pub.dev/packages/liquid_glass_ui)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## About

`liquid_glass_ui` is a comprehensive UI library designed for Flutter developers seeking to create visually stunning interfaces. The package features:

- **52 Components**: Including buttons, text fields, tabs, navigation bars, cards, pickers, dialogs, and more.
- **Liquid Glass Aesthetic**: Frosted glass with blur, gradients, and subtle reflections, inspired by iOS 26.
- **Smooth Transitions**: Fluid animations for interactive components using `LiquidTransition`.
- **Flexible Customization**: Arbitrary `child` widgets, nullable callbacks, and customizable styling (colors, radii, padding).
- **Theming**: Centralized styling with `LiquidTheme` for consistency and overrides.
- **Pure Dart/Flutter**: No external dependencies, ensuring lightweight performance.

This package is ideal for building modern, immersive apps with a premium look and feel.

## Installation

To use `liquid_glass_ui` in your Flutter project, add it to your `pubspec.yaml`:

```yaml
dependencies:
  liquid_glass_ui: ^1.0.0
```
Then, run:
```bash
flutter pub get
```

## Usage
Wrap your app with LiquidThemeProvider to apply the liquid glass theme, then use any of the 52 components. Below is an example showcasing a few components:

```dart
import 'package:flutter/material.dart';
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidThemeProvider(
      theme: const LiquidTheme(),
      child: MaterialApp(
        title: 'Liquid Glass UI Demo',
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
  bool _switchValue = false;
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return LiquidScaffold(
      appBar: const LiquidAppBar(
        title: Text('Liquid Glass UI'),
        semanticsLabel: 'App Bar',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LiquidButton(
                child: const Text('Tap Me'),
                onTap: () => print('Button tapped'),
                semanticsLabel: 'Action Button',
              ),
              const SizedBox(height: 16),
              LiquidTextField(
                hintText: 'Enter text',
                onChanged: (value) => print(value),
                semanticsLabel: 'Input Field',
              ),
              const SizedBox(height: 16),
              LiquidSwitch(
                value: _switchValue,
                onChanged: (value) => setState(() => _switchValue = value),
                semanticsLabel: 'Toggle Switch',
              ),
              const SizedBox(height: 16),
              LiquidSlider(
                value: _sliderValue,
                onChanged: (value) => setState(() => _sliderValue = value),
                semanticsLabel: 'Volume Slider',
              ),
              const SizedBox(height: 16),
              LiquidCard(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('This is a card'),
                ),
                semanticsLabel: 'Content Card',
              ),
              const SizedBox(height: 16),
              LiquidBottomNav(
                icons: const [Icons.home, Icons.search, Icons.person],
                onItemSelected: (index) => print('Nav item $index selected'),
                semanticsLabel: 'Navigation Bar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Components
**liquid_glass_ui** includes 52 components, such as:
Input: `LiquidButton`, `LiquidTextField`, `LiquidSwitch`, `LiquidSlider`, `LiquidDropdown`, `LiquidRadio`, `LiquidCheckbox`, `LiquidSearch`, `LiquidRating`.

Navigation: `LiquidTabs`, `LiquidBottomNav`, `LiquidAppBar`, `LiquidDrawer`, `LiquidFAB`, `LiquidPageView`, `LiquidCarousel`, `LiquidSegment`.

Content: `LiquidCard`, `LiquidText`, `LiquidIcon`, `LiquidAvatar`, `LiquidListTile`, `LiquidGridTile`, `LiquidBanner`.

Feedback: `LiquidAlert`, `LiquidDialog`, `LiquidSnackbar`, `LiquidToast`, `LiquidFlushbar`, `LiquidProgress`, `LiquidIndicator`, `LiquidLoader`.

Layout: `LiquidScaffold`, `LiquidContainer`, `LiquidDivider`, `LiquidSpacer`, `LiquidStack`, `LiquidScrollBar`.

Decorative: `LiquidChip`, `LiquidTag`, `LiquidBadge`, `LiquidPlaceholder`, `LiquidShimmer`, `LiquidSkeleton`.

Interactive: `LiquidMenu`, `LiquidPopup`, `LiquidTooltip`, `LiquidExpansion`, `LiquidAccordion`, `LiquidStepper`.

Each component supports flexible properties like child, onTap, color, and more, with smooth transitions for interactive elements.

Theming
Customize the appearance using LiquidTheme:
```dart
LiquidThemeProvider(
  theme: LiquidTheme(
    primaryColor: Colors.white.withOpacity(0.4),
    accentColor: Colors.blue,
    blurStrength: 12.0,
    borderRadius: 16.0,
  ),
  child: YourApp(),
)
```

## Contributing
Contributions are welcome! Please:
Fork the repository: https://github.com/yourusername/liquid_glass_ui.

Create a feature branch (git checkout -b feature/new-component).

Commit changes (git commit -m 'Add new component').

Push to the branch (git push origin feature/new-component).

Open a pull request.

Report issues or suggest features via the issue tracker.

## License
This package is licensed under the MIT License (LICENSE).

## Acknowledgements
Inspired by iOS 26’s frosted glass design and the Flutter community’s commitment to beautiful UI.


Built with ❤️ by Santhosh Adiga U




