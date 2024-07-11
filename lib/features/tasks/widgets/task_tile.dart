import 'package:flutter/material.dart';

class Task_Tile extends StatelessWidget {
  Map<String, dynamic> tile;

  Task_Tile({super.key, required this.tile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Color(tile['color'])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('UI/UX Design'),
              Icon(
                Icons.more_horiz_sharp,
                color: Colors.black,
                size: 25,
              ),
            ],
          ),
          Text(
            tile['name']!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            tile['description']!,
            style: const TextStyle(fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                backgroundColor: Color(tile['color']),
                label: Text(
                  tile['priority']!,
                  style: const TextStyle(fontSize: 12),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                side: const BorderSide(color: Colors.black),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child: const Icon(
                  Icons.arrow_outward_rounded,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
