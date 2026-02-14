import 'package:drift/drift.dart';
import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/data/repositories/abstract.dart';
import 'package:thousand_counter/models/profile.dart';

class ProfileRepository implements AbstractRepository<Profile> {
  final AppDatabase db;

  ProfileRepository(this.db);

  @override
  Future<Profile> add(Profile profile) async {
    await db
        .into(db.profiles)
        .insert(ProfilesCompanion.insert(id: profile.id, name: profile.name));
    return profile;
  }

  @override
  Future<void> delete(String id) async {
    await (db.delete(db.profiles)..where((p) => p.id.equals(id))).go();
  }

  @override
  Stream<Profile?> get(String id) {
    final query = db.select(db.profiles)..where((p) => p.id.equals(id));
    return query.watchSingleOrNull().map(
      (model) => model != null ? Profile.fromDb(model) : null,
    );
  }

  @override
  Future<List<Profile>> getAll() async {
    final query = db.select(db.profiles);
    final rows = await query.get();
    return rows.map((ProfileModel model) {
      return Profile.fromDb(model);
    }).toList();
  }

  @override
  Future<Profile> update(Profile updatedProfile) async {
    await (db.update(db.profiles)..where((p) => p.id.equals(updatedProfile.id)))
        .write(ProfilesCompanion(name: Value(updatedProfile.name)));
    return updatedProfile;
  }
}
