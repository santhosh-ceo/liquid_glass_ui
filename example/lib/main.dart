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
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              LiquidProgress(
                value: _sliderValue,
                semanticsLabel: 'Progress',
              ),
              const SizedBox(height: 16),
              LiquidAvatar(
                radius: 40,
                semanticsLabel: 'User Avatar',
              ),
              const SizedBox(height: 16),
              LiquidBadge(
                text: '5',
                onTap: () => print('Badge tapped'),
                semanticsLabel: 'Notification Badge',
              ),
              const SizedBox(height: 16),
              LiquidButton(
                child: const Text('Show Dialog'),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => LiquidDialog(
                    content: const Text('This is a custom dialog.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                    semanticsLabel: 'Custom Dialog',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              LiquidButton(
                child: const Text('Show Snackbar'),
                onTap: () => LiquidSnackbar(
                  message: 'Action completed',
                  action: TextButton(
                    onPressed: () => print('Undo'),
                    child: const Text('Undo', style: TextStyle(color: Colors.white)),
                  ),
                  semanticsLabel: 'Notification',
                ).show(context),
              ),
              const SizedBox(height: 16),
              LiquidButton(
                child: const Text('Show Toast'),
                onTap: () => LiquidToast(
                  message: 'Success!',
                  semanticsLabel: 'Success Toast',
                ).show(context),
              ),
              const SizedBox(height: 16),
              LiquidExpansion(
                title: 'Details',
                content: const Text('This is expandable content.'),
                semanticsLabel: 'Details Panel',
              ),
              const SizedBox(height: 16),
              LiquidStepper(
                steps: [
                  Step(
                    title: Text('Step 1', style: Theme.of(context).textTheme.bodyMedium),
                    content: const Text('First step content'),
                  ),
                  Step(
                    title: Text('Step 2', style: Theme.of(context).textTheme.bodyMedium),
                    content: const Text('Second step content'),
                  ),
                ],
                currentStep: _currentStep,
                onStepTapped: (index) => setState(() => _currentStep = index),
                onStepContinue: () => setState(() => _currentStep = (_currentStep + 1).clamp(0, 1)),
                onStepCancel: () => setState(() => _currentStep = (_currentStep - 1).clamp(0, 1)),
                semanticsLabel: 'Process Stepper',
              ),
            ],
          ),
        ),
      ),
    );
  }
}