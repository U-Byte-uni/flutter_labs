import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const WeekendScheduleApp());
}

class WeekendScheduleApp extends StatelessWidget {
  const WeekendScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekend Schedule',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4A9EFF),
          surface: Color(0xFF1A1A1A),
        ),
        useMaterial3: true,
      ),
      home: const ScheduleScreen(),
    );
  }
}

class TimeSlot {
  final String start;
  final String end;
  final String? sectionLabel;
  const TimeSlot({required this.start, required this.end, this.sectionLabel});
}

const List<TimeSlot> allHours = [
  TimeSlot(start: '5:00 AM', end: '6:00 AM', sectionLabel: 'Early Morning'),
  TimeSlot(start: '6:00 AM', end: '7:00 AM'),
  TimeSlot(start: '7:00 AM', end: '8:00 AM'),
  TimeSlot(start: '8:00 AM', end: '9:00 AM'),
  TimeSlot(start: '9:00 AM', end: '10:00 AM'),
  TimeSlot(start: '10:00 AM', end: '11:00 AM', sectionLabel: 'Mid-Morning'),
  TimeSlot(start: '11:00 AM', end: '12:00 PM'),
  TimeSlot(start: '12:00 PM', end: '1:00 PM', sectionLabel: 'Afternoon'),
  TimeSlot(start: '1:00 PM', end: '2:00 PM'),
  TimeSlot(start: '2:00 PM', end: '3:00 PM'),
  TimeSlot(start: '3:00 PM', end: '4:00 PM'),
  TimeSlot(start: '4:00 PM', end: '5:00 PM', sectionLabel: 'Late Afternoon'),
  TimeSlot(start: '5:00 PM', end: '6:00 PM'),
  TimeSlot(start: '6:00 PM', end: '7:00 PM', sectionLabel: 'Evening'),
  TimeSlot(start: '7:00 PM', end: '8:00 PM'),
  TimeSlot(start: '8:00 PM', end: '9:00 PM'),
  TimeSlot(start: '9:00 PM', end: '10:00 PM', sectionLabel: 'Night'),
  TimeSlot(start: '10:00 PM', end: '11:00 PM'),
];

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, Map<int, String>> _activities = {
    'saturday': {},
    'sunday': {},
  };
  final Map<String, Map<int, int>> _merges = {
    'saturday': {},
    'sunday': {},
  };

  final List<String> _days = ['saturday', 'sunday'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    for (final day in _days) {
      final actJson = prefs.getString('activities_$day');
      final mergeJson = prefs.getString('merges_$day');
      if (actJson != null) {
        final map = jsonDecode(actJson) as Map<String, dynamic>;
        setState(() {
          _activities[day] =
              map.map((k, v) => MapEntry(int.parse(k), v as String));
        });
      }
      if (mergeJson != null) {
        final map = jsonDecode(mergeJson) as Map<String, dynamic>;
        setState(() {
          _merges[day] =
              map.map((k, v) => MapEntry(int.parse(k), v as int));
        });
      }
    }
  }

  Future<void> _saveData(String day) async {
    final prefs = await SharedPreferences.getInstance();
    final actMap =
    _activities[day]!.map((k, v) => MapEntry(k.toString(), v));
    final mergeMap =
    _merges[day]!.map((k, v) => MapEntry(k.toString(), v));
    await prefs.setString('activities_$day', jsonEncode(actMap));
    await prefs.setString('merges_$day', jsonEncode(mergeMap));
  }

  bool _isAbsorbed(String day, int idx) {
    final merges = _merges[day]!;
    for (int i = 0; i < idx; i++) {
      if (merges.containsKey(i) && i + merges[i]! > idx) return true;
    }
    return false;
  }

  int _getSpan(String day, int idx) => _merges[day]![idx] ?? 1;

  void _merge(String day, int idx) {
    final span = _getSpan(day, idx);
    if (idx + span >= allHours.length) return;
    setState(() => _merges[day]![idx] = span + 1);
    _saveData(day);
  }

  void _unmerge(String day, int idx) {
    final span = _getSpan(day, idx);
    if (span > 1) {
      setState(() {
        _merges[day]![idx] = span - 1;
        if (_merges[day]![idx] == 1) _merges[day]!.remove(idx);
      });
      _saveData(day);
    }
  }

  void _clearDay(String day) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          'Clear ${day[0].toUpperCase()}${day.substring(1)}?',
          style: const TextStyle(color: Color(0xFFE8E8E8)),
        ),
        content: const Text(
          'All activities and merged blocks will be removed.',
          style: TextStyle(color: Color(0xFF9A9A9A)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF9A9A9A))),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _activities[day] = {};
                _merges[day] = {};
              });
              _saveData(day);
              Navigator.pop(ctx);
            },
            child: const Text('Clear',
                style: TextStyle(color: Color(0xFFFF5C5C))),
          ),
        ],
      ),
    );
  }

  void _editActivity(String day, int idx) {
    final span = _getSpan(day, idx);
    final endSlot = allHours[(idx + span).clamp(0, allHours.length - 1)];
    final timeLabel = span > 1
        ? '${allHours[idx].start} – ${endSlot.start}'
        : '${allHours[idx].start} – ${allHours[idx].end}';
    final controller =
    TextEditingController(text: _activities[day]![idx] ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(timeLabel,
            style: const TextStyle(color: Color(0xFF4A9EFF), fontSize: 15)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Color(0xFFE8E8E8)),
          decoration: InputDecoration(
            hintText: 'Enter activity...',
            hintStyle: const TextStyle(color: Color(0xFF555555)),
            filled: true,
            fillColor: const Color(0xFF242424),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onSubmitted: (_) =>
              _saveAndClose(ctx, day, idx, controller.text),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF666666))),
          ),
          if (_activities[day]!.containsKey(idx))
            TextButton(
              onPressed: () {
                setState(() => _activities[day]!.remove(idx));
                _saveData(day);
                Navigator.pop(ctx);
              },
              child: const Text('Remove',
                  style: TextStyle(color: Color(0xFFFF5C5C))),
            ),
          TextButton(
            onPressed: () =>
                _saveAndClose(ctx, day, idx, controller.text),
            child: const Text('Save',
                style: TextStyle(color: Color(0xFF4A9EFF))),
          ),
        ],
      ),
    );
  }

  void _saveAndClose(
      BuildContext ctx, String day, int idx, String val) {
    final trimmed = val.trim();
    setState(() {
      if (trimmed.isEmpty) {
        _activities[day]!.remove(idx);
      } else {
        _activities[day]![idx] = trimmed;
      }
    });
    _saveData(day);
    Navigator.pop(ctx);
  }

  Widget _buildSchedule(String day) {
    final List<Widget> rows = [];
    int i = 0;
    while (i < allHours.length) {
      if (_isAbsorbed(day, i)) {
        i++;
        continue;
      }
      final h = allHours[i];
      final span = _getSpan(day, i);
      final isMerged = span > 1;
      final canMerge = i + span < allHours.length;
      final endSlot =
      allHours[(i + span).clamp(0, allHours.length - 1)];
      final activity = _activities[day]![i];
      final hasActivity = activity != null && activity.isNotEmpty;

      if (h.sectionLabel != null) {
        rows.add(_buildSectionHeader(h.sectionLabel!));
      }

      rows.add(_buildRow(
        day: day,
        idx: i,
        startTime: h.start,
        endTime: isMerged ? endSlot.start : h.end,
        isMerged: isMerged,
        canMerge: canMerge,
        activity: activity,
        hasActivity: hasActivity,
      ));
      i++;
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 40),
      children: rows,
    );
  }

  Widget _buildSectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6, left: 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
          color: Color(0xFF555555),
        ),
      ),
    );
  }

  Widget _buildRow({
    required String day,
    required int idx,
    required String startTime,
    required String endTime,
    required bool isMerged,
    required bool canMerge,
    required String? activity,
    required bool hasActivity,
  }) {
    return GestureDetector(
      onTap: () => _editActivity(day, idx),
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: isMerged
              ? const Color(0xFF0D1B2A)
              : hasActivity
              ? const Color(0xFF141824)
              : const Color(0xFF141414),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isMerged
                ? const Color(0xFF1E3A5F)
                : hasActivity
                ? const Color(0xFF1E2840)
                : const Color(0xFF242424),
            width: 0.8,
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Time column
              Container(
                width: 108,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 11),
                decoration: BoxDecoration(
                  color: isMerged
                      ? const Color(0xFF0A1520)
                      : const Color(0xFF111111),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(9),
                    bottomLeft: Radius.circular(9),
                  ),
                  border: Border(
                    right: BorderSide(
                      color: isMerged
                          ? const Color(0xFF1E3A5F)
                          : const Color(0xFF202020),
                      width: 0.8,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      startTime,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isMerged
                            ? const Color(0xFF4A9EFF)
                            : const Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '– $endTime',
                      style: TextStyle(
                        fontSize: 11,
                        color: isMerged
                            ? const Color(0xFF2A5A90)
                            : const Color(0xFF555555),
                      ),
                    ),
                  ],
                ),
              ),
              // Activity text
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 11),
                  child: Text(
                    hasActivity ? activity! : 'Tap to add...',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: hasActivity
                          ? const Color(0xFFE8E8E8)
                          : const Color(0xFF3A3A3A),
                    ),
                  ),
                ),
              ),
              // Merge / unmerge button
              SizedBox(
                width: 38,
                child: isMerged
                    ? IconButton(
                  icon: const Icon(Icons.remove, size: 15),
                  color: const Color(0xFF3A5A80),
                  onPressed: () => _unmerge(day, idx),
                  tooltip: 'Shrink block',
                  padding: EdgeInsets.zero,
                )
                    : canMerge
                    ? IconButton(
                  icon: const Icon(Icons.add, size: 15),
                  color: const Color(0xFF555555),
                  onPressed: () => _merge(day, idx),
                  tooltip: 'Merge with next hour',
                  padding: EdgeInsets.zero,
                )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Weekend Schedule',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFFE8E8E8),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined,
                color: Color(0xFF555555)),
            tooltip: 'Clear day',
            onPressed: () => _clearDay(_days[_tabController.index]),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF4A9EFF),
          indicatorWeight: 2,
          labelColor: const Color(0xFF4A9EFF),
          unselectedLabelColor: const Color(0xFF666666),
          labelStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500),
          tabs: const [
            Tab(text: 'Saturday'),
            Tab(text: 'Sunday'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSchedule('saturday'),
          _buildSchedule('sunday'),
        ],
      ),
    );
  }
}