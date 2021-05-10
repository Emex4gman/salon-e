// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:salon_e/providers/auth_state.dart';
import 'package:salon_e/sevices/dimension.dart';
import 'package:salon_e/util/translation/app_translate.dart';
import 'package:salon_e/util/translation/app_translate_delegate.dart';

abstract class SalonSatefulWidget extends StatefulWidget {
  SalonSatefulWidget({Key? key}) : super(key: key);
}

abstract class SalonSatefulWidgetState<Page extends SalonSatefulWidget> extends State<Page> {
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList = application.supportedLanguagesCodes;
  AuthUser? get user => AuthState().user;
  int currentPage = 1;
  int lastPage = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  double get height => DimensionService().deviceHeight;
  double get width => DimensionService().deviceWidth;
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  String tr(String key) {
    return AppTranslations.of(context).text(key);
  }

  buildLanguagesList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: languagesList.length,
      itemBuilder: (context, index) {
        return buildLanguageItem(languagesList[index]);
      },
    );
  }

  buildLanguageItem(String language) {
    return InkWell(
      onTap: () {
        application.onLocaleChanged!(Locale(languagesMap[language]));
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            language,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
