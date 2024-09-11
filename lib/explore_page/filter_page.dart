import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // Close the page and go back
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildFilterOption('Accounting'),
                  _buildFilterOption('Biology'),
                  _buildFilterOption('Chemistry'),
                  _buildFilterOption('Computer Science'),
                  _buildFilterOption('Economics'),
                  _buildFilterOption('Engineering'),
                  _buildFilterOption('Unchecked'),
                  _buildFilterOption('History'),
                  _buildFilterOption('Mathematics'),
                  _buildFilterOption('Physics'),
                  _buildFilterOption('Psychology'),
                  _buildFilterOption('Sociology'),
                ],
              ),
            ),
          ),
          // Reset and Apply buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Reset Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: TextButton(
                    onPressed: () {
                      // Reset logic (e.g., uncheck all options)
                      Navigator.pop(context); // Go back after resetting
                    },
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                      backgroundColor:
                          Colors.teal.withOpacity(0.1), // Light teal background
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Apply Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      // Apply logic for the filter
                      Navigator.pop(context); // Go back after applying
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding:
                          EdgeInsets.symmetric(horizontal: 52, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper function to build each filter option with a checkbox
  Widget _buildFilterOption(String label) {
    bool isChecked = false; // Track the state of each checkbox

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return CheckboxListTile(
          title: Text(label),
          value: isChecked,
          activeColor: Colors.teal,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        );
      },
    );
  }
}
