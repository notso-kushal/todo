import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notesModel.dart';

class Nofier extends StateNotifier<List<Notes>> {
  Nofier() : super([]);

  void addNote(Notes note) {
    state = [...state, note];
  }

  void removeNote(Notes note) {
    state = state.where((_note) => _note != note).toList();
  }
}
