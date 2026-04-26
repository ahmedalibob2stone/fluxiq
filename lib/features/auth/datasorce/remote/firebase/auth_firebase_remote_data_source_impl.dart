

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/error/app_exception.dart';
import '../../../../../core/error/auth_error_handler.dart';
import '../../../model/user_model.dart';
import 'auth_firebase_remote_data_source.dart';
import 'dart:async' as dart_async;


  class AuthFirebaseRemoteDataSourceImpl implements AuthFirebaseRemoteDataSource {
    final FirebaseAuth _auth;
    final FirebaseFirestore _db;
    final GoogleSignIn _googleSignIn;

    AuthFirebaseRemoteDataSourceImpl({
      required FirebaseAuth auth,
      required FirebaseFirestore db,
      required GoogleSignIn googleSignIn,
    })  : _auth = auth,
          _db = db,
          _googleSignIn = googleSignIn;


    @override
    String? getCurrentUserId() {
      return _auth.currentUser?.uid;
    }
    @override
    Future<UserModel?> signInWithEmail(String email, String password) async {
      try {
        final userCred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final doc =
        await _db.collection('users').doc(userCred.user!.uid).get();

        if (doc.exists) {
          return UserModel.fromJson(doc.data()!);
        }
        return null;
      } catch (e) {
        throw AuthErrorHandler.handle(e);
      }
    }

    @override
      Future<RegisterResult> registerWithEmail(
        String name,
        String email,
        String password,
        ) async {
      try {
        final userCred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = UserModel(
          uid: userCred.user!.uid,
          email: email,
          name: name,
        );

        await _db.collection('users').doc(user.uid).set(user.toJson());

        final idToken = await userCred.user!.getIdToken();

        return (user: user, idToken: idToken);
      } on FirebaseAuthException catch (e) {
        throw AuthErrorHandler.handle(e);
      } on AppException {
        rethrow;
      } catch (e) {
        throw AuthErrorHandler.handle(e);
      }
    }


    @override
    Future<void> signOut() async {
      try {


        await Future.wait([
          _auth.signOut(),
          _googleSignIn.signOut(),
        ]).timeout(const Duration(seconds: 3));

      } on dart_async.TimeoutException {
        throw const NetworkException();
      } on FirebaseAuthException catch (e) {
        throw AuthErrorHandler.handle(e);
      } catch (e) {
        throw AuthErrorHandler.handle(e);
      }
    }
    @override
    Future<UserModel?> getCurrentUser() async {
      try {
        final user = _auth.currentUser;
        if (user == null) return null;

        final doc = await _db.collection('users').doc(user.uid).get();
        if (doc.exists) return UserModel.fromJson(doc.data()!);
        return null;
      } catch (e) {
        throw AuthErrorHandler.handle(e);
      }
    }


    @override
    Future<UserModel?> checkAuthStatus() async {
      try {
        final user = _auth.currentUser;
        if (user == null) return null;

        final doc = await _db.collection('users').doc(user.uid).get();
        if (doc.exists) return UserModel.fromJson(doc.data()!);
        return null;
      } catch (e) {
        throw AuthErrorHandler.handle(e);
      }
    }


    @override
    Future<GoogleSignInResult> signInWithGoogle() async {
      try {
        final googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          return (user: null, idToken: null, isNewUser: false);
        }

        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCred = await _auth.signInWithCredential(credential);
        if (userCred.user == null) {
          return (user: null, idToken: null, isNewUser: false);
        }

        final uid = userCred.user!.uid;
        final email = userCred.user!.email ?? 'No Email';
        final displayName = userCred.user!.displayName ?? 'No Name';

        final doc = await _db.collection('users').doc(uid).get();

        if (doc.exists) {
          return (
          user: UserModel.fromJson(doc.data()!),
          idToken: null,
          isNewUser: false,
          );
        }

        final user = UserModel(uid: uid, email: email, name: displayName);
        await _db.collection('users').doc(uid).set(user.toJson());
        final token = await userCred.user!.getIdToken();

        return (user: user, idToken: token, isNewUser: true);
      } on FirebaseAuthException catch (e) {
        throw AuthErrorHandler.handle(e);
      } catch (e) {
        throw AuthErrorHandler.handle(e);
      }
    }
  }