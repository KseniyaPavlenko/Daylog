import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/setup/di.dart';
import 'package:daylog/common/style/app_style.dart';
import 'package:daylog/common/utils/logger.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/draft_detail/draft_detail_cubit.dart';
import 'package:daylog/cubits/draft_list/draft_list_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/event_detail/event_detail_cubit.dart';
import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/cubits/me/me_cubit.dart';
import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
import 'package:daylog/widgets/widget_test/widget_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* 
  - TODO(Kseniya): Исправить все ошибки от анализатора 
    Ошибки можно увидеть в вкладке PROBLEMS в VSCode 
    или запустить команду flutter analyze в терминале в директории проекта 

  - TODO(Kseniya): Вынеси все кастомные цвета в AppColors и дергай оттуда, 
    так у тебя цвета буду в одном месте и если какой-то цвет нужно будет подправить 
    ты исправишь его в одном файле, а не в 100 файлах

  - TODO(Kseniya): Не строй виджеты в функциях выноси их отдельный файл в 
    state less widget, это оптимизирует работу твоего проекта. Виджеты в функции
    будут перестраиваться каждый раз после изменения состояния родительского виджета 
    StateFullWidget. В то время как StateLessWidget перестраивается когда изменяются
    параметры передаваемые в него
*/
void main() {
  setupDi();
  setupLog();
  runApp(App());
  //testWidgets();
}

testWidgets() {
  DateTime selectedDate = DateTime.now();
  String previousDay =
      selectedDate.subtract(const Duration(days: 1)).toString();
  String nextDay = selectedDate.add(const Duration(days: 1)).toString();
  const keyPreviosDay = Key('dateSelector_prev');
  const keyNextDay = Key('dateSelector_next');
  const dayText = Key('day');

  runApp(WidgetTest(
    child: DateSelectorWidget(
      date: selectedDate,
      onChange: (_) {},
    ),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventListCubit>(
          create: (BuildContext context) => getIt(),
        ),
        BlocProvider<DraftListCubit>(
          create: (BuildContext context) => getIt(),
        ),
        BlocProvider<EventDetailCubit>(
          create: (BuildContext context) => getIt(),
        ),
        BlocProvider<DraftDetailCubit>(
          create: (BuildContext context) => getIt(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => getIt(),
        ),
        BlocProvider<MeCubit>(
          create: (BuildContext context) => getIt(),
        ),
        BlocProvider<ErrorCubit>(
          create: (BuildContext context) => getIt(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Day Log',
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
