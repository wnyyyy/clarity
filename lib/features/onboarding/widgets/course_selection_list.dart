import 'package:flutter/material.dart';

class CourseSelectionList extends StatefulWidget {
  const CourseSelectionList({super.key, required this.courses});

  final Map<String, Color> courses;

  @override
  State<CourseSelectionList> createState() => _CourseSelectionListState();
}

class _CourseSelectionListState extends State<CourseSelectionList> {
  late List<bool> _selectedCourses;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedCourses = List.generate(widget.courses.length, (_) => false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thickness: 6,
      thumbColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      radius: const Radius.circular(10),
      controller: _scrollController,
      thumbVisibility: true,
      crossAxisMargin: 4,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: widget.courses.length,
        separatorBuilder: (context, index) => SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
              height: 1,
            ),
          ),
        ),
        itemBuilder: (context, index) {
          final String course = widget.courses.keys.elementAt(index);
          final Color color = widget.courses[course]!;
          return ListTile(
            title: Text(
              course,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: color,
                  ),
            ),
            onTap: () {
              setState(() {
                _selectedCourses[index] = !_selectedCourses[index];
              });
            },
            trailing: Switch(
              value: _selectedCourses[index],
              onChanged: (value) {
                setState(() {
                  _selectedCourses[index] = value;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
