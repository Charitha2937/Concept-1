import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a file to Firebase Storage
  Future<String> uploadFile(File file, String userId) async {
    try {
      final String fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}';
      final Reference storageRef = _storage.ref().child('uploads/$fileName');
      
      final UploadTask uploadTask = storageRef.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      
      // Get download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw 'Error uploading file: $e';
    }
  }

  // Delete a file from Firebase Storage
  Future<void> deleteFile(String fileUrl) async {
    try {
      final Reference storageRef = _storage.refFromURL(fileUrl);
      await storageRef.delete();
    } catch (e) {
      throw 'Error deleting file: $e';
    }
  }

  // Get all uploaded files for a user
  Future<List<String>> getUserFiles(String userId) async {
    try {
      final Reference storageRef = _storage.ref().child('uploads');
      final ListResult result = await storageRef.listAll();
      
      List<String> urls = [];
      for (var ref in result.items) {
        if (ref.name.startsWith(userId)) {
          final String url = await ref.getDownloadURL();
          urls.add(url);
        }
      }
      return urls;
    } catch (e) {
      throw 'Error getting user files: $e';
    }
  }
}
