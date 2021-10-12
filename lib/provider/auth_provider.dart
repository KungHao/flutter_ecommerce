import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/database/services/user_services.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserServices _userServices = UserServices();
  UserModel? _userModel;
  bool _isLoading = false;
  String _errorMessage = '';
  Status _status = Status.Uninitialized;

  User? get user => _firebaseAuth.currentUser;
  UserModel? get userModel => _userModel;
  Status get status => _status;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  AuthProvider.initialize() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen(_onStateChanged);
  }

  Future signUp(String userName, String email, String password) async {
    setLoading(true);

    try {
      _status = Status.Authenticating;
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await insertUser(authResult, userName);

      setLoading(false);
      Fluttertoast.showToast(msg: '註冊成功');
      return true;
    } on SocketException {
      _status = Status.Unauthenticated;
      setLoading(false);
      setMessage("No internet, please connect to internet");
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      setLoading(false);
      setMessage(errorMsg(e));
    }
    notifyListeners();
    return false;
  }

  Future mailSignIn(String email, String password) async {
    setLoading(true);

    try {
      _status = Status.Authenticating;
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      Fluttertoast.showToast(msg: '登入成功');
      _userModel = await _userServices.queryUser(user!.uid);
      return true;
    } on SocketException {
      _status = Status.Unauthenticated;
      setLoading(false);
      setMessage("No internet, please connect to internet");
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      setLoading(false);
      setMessage(errorMsg(e));
    } catch (e) {
      _status = Status.Unauthenticated;
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
    return false;
  }

  Future googleSignIn() async {
    setLoading(true);
    try {
      _status = Status.Authenticating;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;

      setLoading(false);
      Fluttertoast.showToast(msg: "Log in successful!");

      // 若新使用者則新增資料庫，否則...
      if (authResult.additionalUserInfo!.isNewUser) {
        if (user != null) {
          _userModel = UserModel(
            uid: user.uid,
            userName: user.displayName ?? "",
            userMail: user.email ?? "",
            createTime: getDateTime(),
            loginTime: getDateTime(),
          );
          _userServices.createUser(_userModel!);
        }
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      setLoading(false);
      print(e.toString());
    }
    notifyListeners();
  }

  Future facebookSignIn() async {
    setLoading(true);
    try {
      _status = Status.Authenticating;
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential credential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      FirebaseAuth.instance.signInWithCredential(credential);

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      setLoading(false);
      Fluttertoast.showToast(msg: "Log in successful!");

      // 若新使用者則新增資料庫，否則...
      if (authResult.additionalUserInfo!.isNewUser) {
        if (user != null) {
          _userModel = UserModel(
            uid: user.uid,
            userName: user.displayName ?? "",
            userMail: user.email ?? "",
            createTime: getDateTime(),
            loginTime: getDateTime(),
          );
          _userServices.createUser(_userModel!);
        }
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      setLoading(false);
      print(e.toString());
    }
    notifyListeners();
  }

  Future phoneSignIn(String phoneNumber) async {
    setLoading(true);
    try {
      _status = Status.Authenticating;
      UserCredential? authResult;
      FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            authResult = await _firebaseAuth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            setMessage(errorMsg(e));
          },
          codeSent: (String verificationId, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationId) {});

      if (authResult != null) {
        final User? user = authResult!.user;
      }

      setLoading(false);
      Fluttertoast.showToast(msg: "Log in successful!");

      // 若新使用者則新增資料庫，否則...
      if (authResult!.additionalUserInfo!.isNewUser) {
        if (user != null) {
          _userModel = UserModel(
            uid: user!.uid,
            userName: user!.displayName ?? "",
            userMail: user!.email ?? "",
            createTime: getDateTime(),
            loginTime: getDateTime(),
          );
          _userServices.createUser(_userModel!);
        }
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      setLoading(false);
      print(e.toString());
    }
    notifyListeners();
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    await _firebaseAuth.signOut();
    Fluttertoast.showToast(msg: "Log Out successful!");
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  String errorMsg(e) {
    var msg = '';
    switch (e.code) {
      case 'invalid-email':
        msg = '無效的mail';
        break;
      case 'email-already-in-use':
        msg = 'email 已經註冊過';
        break;
      case 'user-disabled':
      case 'user-not-found':
        msg = 'Mail尚未註冊';
        break;
      case 'wrong-password':
        msg = '密碼輸入錯誤';
        break;
      case 'invalid-phone-number':
        msg = '請輸入正確手機號碼';
        break;
      default:
        msg = '發生錯誤';
        break;
    }
    return msg;
  }

  Future insertUser(authResult, userName) async {
    User? user = authResult.user;
    user!.updateDisplayName(userName);
    await user.reload();
    user = _firebaseAuth.currentUser;
    _userModel = UserModel(
      uid: user!.uid,
      userName: user.displayName ?? 'user',
      userMail: user.email ?? 'user@com.tw',
      createTime: getDateTime(),
      loginTime: getDateTime(),
    );
    _userServices.createUser(_userModel!);
  }

  String getDateTime() {
    DateTime dateTime = DateTime.now();
    return DateFormat('yyyy-MM-dd - kk:mm:ss').format(dateTime);
  }

  Future _onStateChanged(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _userModel = await _userServices.queryUser(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
