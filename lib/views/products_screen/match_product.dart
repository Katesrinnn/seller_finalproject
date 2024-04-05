import 'package:flutter/material.dart';

class MatchProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text('Match Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Handle save button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImagePlaceholder(label: 'Top'),
                ImagePlaceholder(label: 'Bottom'),
              ],
            ),
            DropdownButtonFormField<String>(
              hint: Text('Select a collection'),
              items: <String>['Collection 1', 'Collection 2', 'Collection 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle dropdown change
              },
            ),
            FilterChipWidget(),
            SizedBox(height: 10),
            ColorSelectionWidget(),
          ],
        ),
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final String label;

  ImagePlaceholder({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.camera_alt,
            color: Colors.grey,
          ),
        ),
        Text(label),
      ],
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  final List<String> _options = ['All', 'Men', 'Women'];
  String _selectedOption = 'All';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        _options.length,
        (int index) {
          return ChoiceChip(
            label: Text(_options[index]),
            selected: _selectedOption == _options[index],
            onSelected: (bool selected) {
              setState(() {
                _selectedOption = _options[index];
              });
            },
          );
        },
      ).toList(),
    );
  }
}

class ColorSelectionWidget extends StatelessWidget {
  final List<Color> _colors = [
    Colors.black, Colors.white, Colors.red, Colors.green, Colors.blue,
    Colors.amber,
    // Add more colors
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        _colors.length,
        (int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor: _colors[index],
              radius: 15,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.check, color: Colors.white, size: 15),
                onPressed: () {
                  // Handle color selection
                },
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
