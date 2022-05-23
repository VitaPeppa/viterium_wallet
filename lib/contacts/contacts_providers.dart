import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_providers.dart';
import '../database/database.dart';
import 'contact.dart';
import 'contacts_notifier.dart';

final contactsBoxProvider = Provider((ref) {
  final db = ref.watch(dbProvider);
  return db.getTypedBox<Contact>(kContactsBox);
});

final contactsProvider = ChangeNotifierProvider((ref) {
  final contactsBox = ref.watch(contactsBoxProvider);
  final sharedPrefsUtil = ref.watch(sharedPrefsUtilProvider);
  return ContactsNotifier(contactsBox, sharedPrefsUtil);
});
