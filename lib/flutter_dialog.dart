import 'package:flutter/material.dart';
import 'package:game_template/main.dart';

class FlutterDialog extends StatelessWidget {
  FlutterDialog({super.key, required this.gameRef});

  final GameTemplate gameRef;
  final List<String> shipList = ['NCC-1701', 'NCC-1701A', 'NCC-1701B', 'NCC-1701C', 'NCC-1701D'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.grey[900],
        width: 400,
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enterprise Selection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: shipList.length,
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.white);
                    },
                    itemBuilder: (context, index) {
                      return Material(
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            shipList[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  gameRef.router.pop();
                },
                child: const Text('Close'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
