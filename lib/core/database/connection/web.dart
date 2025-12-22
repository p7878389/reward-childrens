import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

QueryExecutor connect() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 'children_rewards_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    
    if (result.missingFeatures.isNotEmpty) {
      print('Using ${result.chosenImplementation} due to missing features: ${result.missingFeatures}');
    }
    
    return result.resolvedExecutor;
  });
}
