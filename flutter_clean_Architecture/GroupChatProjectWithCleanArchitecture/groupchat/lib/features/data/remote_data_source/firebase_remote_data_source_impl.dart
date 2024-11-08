import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groupchat/features/data/remote_data_source/firebase_remote_data_source.dart';
import 'package:groupchat/features/data/remote_data_source/models/user_model.dart';
import 'package:groupchat/features/domine/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  FirebaseRemoteDataSourceImpl(
      {required this.fireStore,
      required this.auth,
      required this.googleSignIn});

  @override
  Future<void> forgetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    print('++++++++');
    final userCollection = fireStore.collection('users');

    final uid = await getCurrentUserId();
    print("uid");
    print(uid);

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        isOnline: user.isOnline,
        uid: uid,
        status: user.status,
        profileUrl: user.profileUrl,
        dob: user.dob,
        gender: user.gender,
      ).toDocument();

      if (!userDoc.exists) {
        print('Create new User');
        userCollection.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUserId() async => auth.currentUser!.uid;

  @override
  Future<void> getUpdateUser(UserEntity user) async {
    Map<String, dynamic> userInformation = {};

    final userCollection = fireStore.collection("users");

    if (user.profileUrl != null && user.profileUrl != "") {
      userInformation['profileUrl'] = user.profileUrl;
    }
    if (user.name != null && user.name != "") {
      userInformation['name'] = user.name;
    }
    if (user.status != null && user.status != "") {
      userInformation['status'] = user.status;
    }

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<void> googleAuth() async {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await account!.authentication;
    final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final userInformation =
        (await auth.signInWithCredential(authCredential)).user;

    getCreateCurrentUser(UserEntity(
        name: userInformation!.displayName,
        email: userInformation.email,
        gender: "",
        dob: "",
        phoneNumber: userInformation.phoneNumber,
        profileUrl: userInformation.photoURL,
        status: "",
        isOnline: false));
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
    // await auth.signInWithEmailAndPassword(
    //     email: user.email!, password: user.password!);
  }

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async {
    await auth.createUserWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = fireStore.collection('users');
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot((e))).toList());
  }
}
