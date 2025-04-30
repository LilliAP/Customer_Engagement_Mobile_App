import 'package:flutter/material.dart';

const List<String> profilePicPaths = [
  'assets/images/pp1.png',
  'assets/images/pp2.png',
  'assets/images/pp3.png',
  'assets/images/pp4.png',
  'assets/images/pp5.png',
  'assets/images/pp6.png',
  'assets/images/pp7.png',
  'assets/images/pp8.png',
  'assets/images/pp9.png',
];

class ProfilePicSelector extends StatefulWidget {
  final String initialPic;
  final Function(String) onPicSelected;

  const ProfilePicSelector({
    super.key,
    required this.initialPic,
    required this.onPicSelected,
  });

  @override
  State<ProfilePicSelector> createState() => _ProfilePicSelectorState();
}

class _ProfilePicSelectorState extends State<ProfilePicSelector>
    with SingleTickerProviderStateMixin {
  late String selectedProfilePic;
  bool showImageGrid = false;

  @override
  void initState() {
    super.initState();
    selectedProfilePic = widget.initialPic;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showImageGrid = !showImageGrid;
            });
          },
          child: Column(
            children: [
              ClipRRect(
                child: Image.asset(
                  selectedProfilePic,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
              const SizedBox(height: 5.0),
              const Text("Tap to select a new profile picture"),
            ],
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: showImageGrid
              ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profilePicPaths.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final path = profilePicPaths[index];
                      final isSelected = path == selectedProfilePic;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedProfilePic = path;
                          });
                          widget.onPicSelected(path);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                    width: 3,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(path, width: 80, height: 80),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
