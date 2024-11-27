import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of books
  final CollectionReference books =
      FirebaseFirestore.instance.collection('books');

  //CREATE: add a new book
  Future<void> addBook(String title, String author, String genre,
      String description, String language, DateTime release) async {
    await books.add({
      'title': title,
      'author': author,
      'genre': genre,
      'release': release,
      'description': description,
      'language': language,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  //READ: get all books
  Stream<QuerySnapshot> getBooksStream() {
    final booksStream =
        books.orderBy('timestamp', descending: true).snapshots();
    return booksStream;
  }

  //UPDATE: update a book by id
  Future<void> updateBook(
      String docId,
      String newTitle,
      String newAuthor,
      String newGenre,
      String newDescription,
      String newLanguage,
      DateTime newRelease) async {
    await books.doc(docId).update({
      'title': newTitle,
      'author': newAuthor,
      'genre': newGenre,
      'release': newRelease,
      'description': newDescription,
      'language': newLanguage,
      'timestamp': Timestamp.now(),
    });
  }

  //DELETE:  delete a book by id
  Future<void> deleteBook(String docId) {
    return books.doc(docId).delete();
  }
}
