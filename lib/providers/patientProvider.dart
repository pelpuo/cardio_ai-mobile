import 'dart:convert';
import 'dart:math';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:cardio_ai/models/EcgReading.dart';
import 'package:cardio_ai/models/Patient.dart';
import 'package:cardio_ai/models/User.dart';
import 'package:cardio_ai/services/cardioAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardio_ai/constants.dart';

class PatientProvider extends ChangeNotifier {
  String accessToken = "";
  bool loadingPatients = false;
  bool loadingReadings = false;
  bool loadingCurrentReadings = false;

  List<Patient> patients = [];
  List<EcgReading> patientReadings = [];
  EcgReading? currentReading;
  Patient? currentPatient;
  User? currentUser;
  List ecgValues = [];
  CardioAPI cardioAPI = CardioAPI();

  getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("accessToken") ?? "";
    return accessToken;
    notifyListeners();
  }

  deleteAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("accessToken");
    notifyListeners();
  }

  setCurrentReading(EcgReading reading) {
    currentReading = reading;
    notifyListeners();
  }

  // Retrieve all patients in the database
  getPatients({bool refresh = false}) async {
    if (!refresh && patients.isNotEmpty) {
      return patients;
    }

    bool isCacheExist = await APICacheManager().isAPICacheKeyExist("patients");

    if (!isCacheExist) {
      loadingPatients = true;

      var tempResponse =
          await cardioAPI.getRequest("/patient/doctor/me", accessToken);

      if (tempResponse != null) {
        patients = [];
        for (var patient in tempResponse) {
          Patient tempPatient = Patient.fromJson(patient);
          patients.add(tempPatient);
        }

        // Update cache
        APICacheDBModel patientsModel = APICacheDBModel(
            key: "patients", syncData: jsonEncode(tempResponse));
        var cacheData = await APICacheManager().addCacheData(patientsModel);
      }
    } else {
      var cacheData = await APICacheManager().getCacheData("patients");
      var syncData = jsonDecode(cacheData.syncData);
      patients = [];
      for (var patient in syncData) {
        Patient tempPatient = Patient.fromJson(patient);
        patients.add(tempPatient);
      }
    }

    loadingPatients = false;
    notifyListeners();
    return patients;
  }

  // Get all the ECG readings for a particular patient
  getEcgReadings({bool refresh = false}) async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist(currentPatient!.id);

    if (!isCacheExist) {
      loadingReadings = true;

      var tempResponse = await cardioAPI.getRequest(
          "/reading/patient/${currentPatient!.id}", accessToken);

      if (tempResponse != null) {
        patientReadings = [];
        for (var reading in tempResponse) {
          EcgReading tempReading = EcgReading.fromJson(reading);
          patientReadings.add(tempReading);
        }

        // Update Cache
        APICacheDBModel readingsModel = APICacheDBModel(
            key: currentPatient!.id, syncData: jsonEncode(tempResponse));
        var cacheData = await APICacheManager().addCacheData(readingsModel);
      }
    } else {
      var cacheData = await APICacheManager().getCacheData(currentPatient!.id);
      var syncData = jsonDecode(cacheData.syncData);
      patientReadings = [];
      for (var reading in syncData) {
        EcgReading tempReading = EcgReading.fromJson(reading);
        patientReadings.add(tempReading);
      }
    }

    loadingReadings = false;
    notifyListeners();
    return patientReadings;
  }

  // Get selected reading of current patient
  getCurrentReading({bool refresh = false}) async {
    loadingCurrentReadings = true;

    var isCacheExist = await APICacheManager()
        .isAPICacheKeyExist("${currentPatient!.id}-${currentReading!.id}");

    if (!isCacheExist) {
      loadingReadings = true;

      var tempResponse = await cardioAPI.getRequest(
          "/reading/${currentReading!.id}", accessToken);

      if (tempResponse != null) {
        ecgValues = tempResponse["values"];
        ecgValues = ecgValues.sublist(0, 3000);

        // Update Cache
        APICacheDBModel cacheModel = APICacheDBModel(
            key: "${currentPatient!.id}-${currentReading!.id}",
            syncData: jsonEncode(tempResponse));
        var cacheData = await APICacheManager().addCacheData(cacheModel);
      }
    } else {
      var cacheData = await APICacheManager()
          .getCacheData("${currentPatient!.id}-${currentReading!.id}");
      var syncData = jsonDecode(cacheData.syncData);
      ecgValues = syncData["values"];
    }

    loadingCurrentReadings = false;
    notifyListeners();
    print("Values: $ecgValues");
    print("Values length: ${ecgValues.length}");
    return ecgValues;
  }

  // Get current user of application
  getCurrentUser({bool refresh = false, required String token}) async {
    print("getting user.....");
    try {
      final response =
          await get(Uri.parse("${AppConstants.apiBase}/user/info"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(accessToken);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);
        currentUser = User.fromJson(temp);
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    print("................................................");
    print(currentUser);
    return currentUser;
  }

  setCurrentPatient(Patient patient) {
    currentPatient = patient;
    notifyListeners();
  }
}
