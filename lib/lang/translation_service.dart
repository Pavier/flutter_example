import 'package:flutter_example_test/lang/zh_CN.dart';
import 'package:get/get.dart';

import 'en_US.dart';

class TranslationService extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'zh_CN' : zh_CN,
    'en_US' : en_US
  };

}