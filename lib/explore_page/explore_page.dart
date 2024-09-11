import 'package:flutter/material.dart';
import 'package:studyapp/explore_page/filter_page.dart';
import 'package:studyapp/explore_page/flash_card.dart';
import 'package:studyapp/explore_page/study_set.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String selectedTab = 'Flashcards';
  String selectedSortOption = 'Date Added (Newest to Oldest)';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        title: Text("E X P L O R E"),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTopButton(
                    'Flashcards', selectedTab == 'Flashcards', screenWidth),
                _buildTopButton(
                    'Explanations', selectedTab == 'Explanations', screenWidth),
                _buildTopButton(
                    'Exercises', selectedTab == 'Exercises', screenWidth),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(screenWidth * 0.02),
                children: _buildContentForSelectedTab(
                    screenHeight, screenWidth, context),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('Sort', Icons.sort, screenWidth, context),
                _buildActionButton(
                    'Filter', Icons.filter_list, screenWidth, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton(String label, bool isActive, double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenWidth * 0.02),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.teal),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContentForSelectedTab(
      double screenHeight, double screenWidth, BuildContext context) {
    if (selectedTab == 'Flashcards') {
      return [
        StudySetCardComponent(
          title: 'Cell Membranes',
          size: '20 Flashcards',
          source: 'Community resource',
          subject: 'Biology',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FlashcardDetailPageComponent(title: 'Cell Membranes'),
              ),
            );
          },
        ),
      ];
    } else if (selectedTab == 'Explanations') {
      return [
        StudySetCardComponent(
          title: 'The Structure and Function of Cell',
          size: '1.2 MB',
          source: 'Microbiology',
          subject: 'Biology',
          onTap: () {},
        ),
      ];
    } else if (selectedTab == 'Exercises') {
      return [
        StudySetCardComponent(
          title: 'Cell Division and Genetics Practice',
          size: '15 questions',
          source: 'Microbiology',
          subject: 'Biology',
          onTap: () {},
        ),
        StudySetCardComponent(
          title: 'Database Management Exercises',
          size: '18 questions',
          source: 'Computer Science',
          subject: 'Computer Science',
          onTap: () {},
        ),
      ];
    } else {
      return [];
    }
  }

  Widget _buildActionButton(
      String label, IconData icon, double screenWidth, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == 'Sort') {
          _showSortOptions(context);
        } else if (label == 'Filter') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterPage(), // Navigate to FilterPage
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: screenWidth * 0.02),
            Text(label, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  // Sort options modal
  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Colors.white, // Ensures the modal background matches your design
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ), // Rounded corners on the top
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sort Title
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Sort',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(), // Adds a subtle divider line

                // List of Sort Options with Radio Buttons
                RadioListTile<String>(
                  title: Text('Most Relevance'),
                  value: 'Most Relevance',
                  groupValue: selectedSortOption,
                  activeColor: Colors.teal, // Active radio button color
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: Text('Trending'),
                  value: 'Trending',
                  groupValue: selectedSortOption,
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: Text('Popularity (Most Viewed)'),
                  value: 'Popularity (Most Viewed)',
                  groupValue: selectedSortOption,
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: Text('Alphabetical (A to Z)'),
                  value: 'Alphabetical (A to Z)',
                  groupValue: selectedSortOption,
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: Text('Alphabetical (Z to A)'),
                  value: 'Alphabetical (Z to A)',
                  groupValue: selectedSortOption,
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: Text('Date Added (Newest to Oldest)'),
                  value: 'Date Added (Newest to Oldest)',
                  groupValue: selectedSortOption,
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: Text('Date Added (Oldest to Newest)'),
                  value: 'Date Added (Oldest to Newest)',
                  groupValue: selectedSortOption,
                  activeColor: Colors.teal,
                  onChanged: (value) {
                    setState(() {
                      selectedSortOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),

                Divider(), // Bottom Divider

                // Reset and Apply buttons
                // Reset and Apply buttons
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Reset button with outlined style and lighter background
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSortOption =
                                'Most Relevance'; // Reset logic
                          });
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 52, vertical: 12),
                          backgroundColor: Colors.teal
                              .withOpacity(0.1), // Light teal background
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(25), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Apply button with filled teal background
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(
                              horizontal: 52, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(25), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Apply',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class StudySetCardComponent extends StatelessWidget {
  final String title;
  final String size;
  final String source;
  final String subject;
  final VoidCallback onTap;

  StudySetCardComponent({
    required this.title,
    required this.size,
    required this.source,
    required this.subject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.insert_drive_file, color: Colors.black),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '$size · from $source',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      subject,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.more_vert, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
