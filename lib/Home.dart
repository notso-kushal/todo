import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/addto.dart';

class Home extends ConsumerWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesList = ref.watch(noteProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'To-Do',
              style: GoogleFonts.spaceGrotesk(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color(0xFF0048B4),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              bottom: 35,
              left: 250,
              right: 30,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(14),
                  backgroundColor: Color(0xFF0048B4),
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'Add To-Do',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addto(),
                  ),
                );
              },
            ),
          ),
          body: notesList.isEmpty
              ? const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Something....',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF0048B4),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: notesList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF0048B4),
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(notesList[index].title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            )),
                        contentPadding: const EdgeInsets.only(left: 25, right: 10),
                        subtitle: Text(
                          notesList[index].description,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color(0xFF0048B4),
                          ),
                          splashColor: Colors.transparent,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Delete Note?',
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  actionsPadding: const EdgeInsets.only(top: 50),
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        ref.read(noteProvider.notifier).removeNote(notesList[index]);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xFF0048B4),
                                        size: 30,
                                      ),
                                      splashColor: Colors.transparent,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Color(0xFF0048B4),
                                        size: 30,
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  })),
    );
  }
}
