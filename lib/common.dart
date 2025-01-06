import 'package:flutter/material.dart';

import 'common/util/helpers/init_async_main.dart';

export 'common/const/app_consts.dart';
export 'common/const/enums.dart';
export 'common/const/failure.dart';
export 'common/const/typedef.dart';
export 'common/extensions/context_extensions.dart';
export 'common/extensions/enums_extensions.dart';
export 'common/extensions/font_extensions.dart';
export 'common/extensions/navigator_extensions.dart';
export 'common/extensions/platform_extensions.dart';
export 'common/extensions/size_extensions.dart';
export 'common/util/helpers/api_handler.dart';
export 'common/util/helpers/bloc_observer.dart';
export 'common/util/helpers/dio_helper.dart';
export 'common/util/helpers/error_handeler.dart';
export 'common/util/helpers/error_handeler_v2.dart';
export 'common/util/helpers/file_functions_helper.dart';
export 'common/util/helpers/init_async_main.dart';
export 'common/util/helpers/local_notifications.dart';
export 'common/util/helpers/logger_interceptor.dart';
export 'common/util/helpers/logger_interceptor_v2.dart';
export 'common/util/helpers/notifications.dart';
export 'common/util/helpers/shared_preferences_helper.dart';
export 'common/util/helpers/token_interceptor.dart';
export 'common/util/helpers/url_launcher_helper.dart';
export 'common/util/models/common_model.dart';
export 'common/util/models/error_model.dart';
export 'common/util/style/color_scheme.dart';
export 'common/util/style/font_style.dart';
export 'common/util/widgets/agreement_screen.dart';
export 'common/util/widgets/app_button.dart';
export 'common/util/widgets/app_google_map.dart';
export 'common/util/widgets/app_image.dart';
export 'common/util/widgets/app_language.dart';
export 'common/util/widgets/app_page_view.dart';
export 'common/util/widgets/app_pin_fields.dart';
export 'common/util/widgets/app_smooth_page_indicator.dart';
export 'common/util/widgets/app_text.dart';
export 'common/util/widgets/app_text_field.dart';
export 'common/util/widgets/loading_dialog.dart';
export 'common/util/widgets/osm.dart';
export 'common/util/widgets/toast_component.dart';

class Common extends StatelessWidget {
  const Common({super.key, required this.main});

  final Widget main;

  @override
  Widget build(BuildContext context) {
    return Initialization.initLocalization(main);
  }
}