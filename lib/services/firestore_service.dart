import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collection = 'tasks';

  // Add a new task
  Future<void> addTask(String title, String userId) async {
    try {
      await _db.collection(collection).add({
        'title': title,
        'completed': false,
        'userId': userId,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      throw 'Error adding task: $e';
    }
  }

  // Get tasks stream for real-time updates
  Stream<QuerySnapshot> getTasks(String userId) {
    return _db
        .collection(collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Update task completion status
  Future<void> updateTaskStatus(String taskId, bool completed) async {
    try {
      await _db.collection(collection).doc(taskId).update({
        'completed': completed,
      });
    } catch (e) {
      throw 'Error updating task: $e';
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await _db.collection(collection).doc(taskId).delete();
    } catch (e) {
      throw 'Error deleting task: $e';
    }
  }

  // Get total task count
  Future<int> getTaskCount(String userId) async {
    try {
      final snapshot = await _db
          .collection(collection)
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      throw 'Error getting task count: $e';
    }
  }
}
