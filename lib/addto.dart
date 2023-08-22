import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Home.dart';
import 'package:todo/models/notesModel.dart';
import 'package:todo/notifier/notesNotifier.dart';

final noteProvider = StateNotifierProvider<Nofier, List<Notes>>((ref) => Nofier());

class addto extends ConsumerWidget {
  addto({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titlecontroller = TextEditingController();
    final descontroller = TextEditingController();

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_circle_left_rounded,
                color: Color(0xFF0048B4),
                size: 45,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: titlecontroller,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Color(0xFF0048B4)),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelStyle: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF0048B4),
                          fontWeight: FontWeight.bold,
                        ),
                        alignLabelWithHint: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF0048B4),
                        )),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0048B4), width: 2))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: descontroller,
                    maxLines: null,
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Color(0xFF0048B4)),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelStyle: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF0048B4),
                          fontWeight: FontWeight.bold,
                        ),
                        alignLabelWithHint: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF0048B4),
                        )),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0048B4), width: 2))),
                  ),
                ])),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.fromLTRB(160, 0, 0, 20),
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(noteProvider.notifier).addNote(
                          Notes(
                            title: titlecontroller.text,
                            description: descontroller.text,
                          ),
                        );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text('Done'),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color(0xFF0048B4)),
                    padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                    shape: MaterialStatePropertyAll(
                        ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)))))),
          ),
        ));
  }
}
