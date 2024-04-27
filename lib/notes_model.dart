import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String? userId;
  String? note;
  String? documentId;
  DateTime? updatedAt;

  NotesModel({
    this.userId,
    this.note,
    this.documentId,
    this.updatedAt,
  });

  NotesModel.fromDocumentSnapshot(Map<String, dynamic> doc)
      : userId = doc["user_id"],
        note = doc["notes"],
        documentId = doc["document_id"],
        updatedAt = doc["updated_at"] != null
            ? (doc["updated_at"] as Timestamp).toDate()
            : null;

  Map<String, dynamic> toMap() {
    return {
      "user_id": userId,
      "notes": note,
      "document_id": documentId,
      "updated_at": updatedAt,
    };
  }
}
