import 'package:flutter/material.dart';

class ListActorDirector extends StatelessWidget {
  final String actors;

  const ListActorDirector({Key? key, required this.actors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actorList = actors.split(',');

    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorList.length,
        itemBuilder: (context, index) {
          final actor = actorList[index].trim();
          if (actor.isEmpty) return const SizedBox();

          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF1C1C1C),
            ),
            child: Text(
              actor,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
