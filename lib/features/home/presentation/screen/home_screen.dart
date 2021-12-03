import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_dispenser/features/home/domain/model/count_meal.dart';
import 'package:smart_dispenser/features/home/presentation/bloc/home_bloc.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart'
    show Configurations;

class HomeScreen extends StatelessWidget {
  const HomeScreen._({Key? key}) : super(key: key);

  static Widget create() => BlocProvider<HomeBloc>(
        create: (_) => GetIt.I.get()..add(const HomeEvent.loadData()),
        child: const HomeScreen._(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeBody());
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, Configurations?>(
      selector: (state) => state.configurations,
      builder: (_, configurations) {
        if (configurations == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return RefreshIndicator(
          onRefresh: context.read<HomeBloc>().refresh,
          child: const CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              Header(),
              DailyMeals(),
              Meals(),
            ],
          ),
        );
      },
    );
  }
}

class Meals extends StatelessWidget {
  const Meals({Key? key}) : super(key: key);

  Future<void> _showModal(
    BuildContext context,
    String title,
    int value,
    String hour,
    MealType type,
  ) async {
    final bloc = context.read<HomeBloc>();
    final result =
        await DialogEditMeal.show<CountMeal>(context, title, value, hour);
    if (result != null) {
      bloc.add(HomeEvent.updateConfigurations(result, type));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      sliver: BlocSelector<HomeBloc, HomeState, Configurations?>(
        selector: (state) => state.configurations,
        builder: (context, configurations) => SliverList(
          delegate: SliverChildListDelegate(
            [
              SmartDispenserCard(
                title: 'Breakfast',
                hour:
                    '''${configurations!.breakfastHour}:${configurations.breakfastMinute}''',
                gr: '${configurations.breakfastAmount}',
                onTap: () => _showModal(
                  context,
                  'Breakfast',
                  configurations.breakfastAmount,
                  '''${configurations.breakfastHour}:${configurations.breakfastMinute}''',
                  MealType.breakFast,
                ),
              ),
              SmartDispenserCard(
                title: 'Lunch',
                hour:
                    '''${configurations.lunchHour}:${configurations.lunchMinute}''',
                gr: '${configurations.lunchAmount}',
                onTap: () => _showModal(
                  context,
                  'Lunch',
                  configurations.lunchAmount,
                  '''${configurations.lunchHour}:${configurations.lunchMinute}''',
                  MealType.lunch,
                ),
              ),
              SmartDispenserCard(
                title: 'Dinner',
                hour:
                    '''${configurations.dinnerHour}:${configurations.dinnerMinute}''',
                gr: '${configurations.dinnerAmount}',
                onTap: () => _showModal(
                  context,
                  'Dinner',
                  configurations.dinnerAmount,
                  '''${configurations.dinnerHour}:${configurations.dinnerMinute}''',
                  MealType.dinner,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmartDispenserCardContainer extends StatelessWidget {
  const SmartDispenserCardContainer({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }
}

class SmartDispenserCard extends StatelessWidget {
  const SmartDispenserCard({
    Key? key,
    required this.title,
    required this.hour,
    required this.gr,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String hour;
  final String gr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: GestureDetector(
        onTap: onTap,
        child: SmartDispenserCardContainer(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      hour,
                      style: textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    RichText(
                      text: TextSpan(
                        text: gr,
                        style: textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' gr',
                            style: textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyMeals extends StatelessWidget {
  const DailyMeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Daily Meal',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.sp,
              ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: ClipPath(
        clipper: const HeaderClipper(),
        child: Container(
          height: size.height * .4,
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(
            child: Column(
              children: const [
                ActionsAndTitle(),
                StatusDispenser(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatusDispenser extends StatelessWidget {
  const StatusDispenser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocSelector<HomeBloc, HomeState, Configurations?>(
                selector: (state) => state.configurations,
                builder: (_, configurations) => CircularPercentIndicator(
                  radius: 150.r,
                  lineWidth: 15.r,
                  animation: true,
                  animationDuration: 900,
                  percent: configurations!.currentWeight / 5,
                  center: const ActualWeith(),
                  progressColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.black.withOpacity(.05),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DialogEditMeal extends StatefulWidget {
  const DialogEditMeal._(
    this.title,
    this.value,
    this.hour, {
    Key? key,
  }) : super(key: key);
  final String title;
  final int value;
  final String hour;

  static Future<T?> show<T>(
    BuildContext context,
    String title,
    int value,
    String hour,
  ) =>
      showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (_) => DialogEditMeal._(title, value, hour),
      );

  @override
  State<DialogEditMeal> createState() => _DialogEditMealState();
}

class _DialogEditMealState extends State<DialogEditMeal> {
  late final TextEditingController hourController;
  late final ValueNotifier<int> gr;
  late TimeOfDay timeOfDay;

  @override
  void initState() {
    hourController = TextEditingController(text: widget.hour);
    gr = ValueNotifier<int>(widget.value);
    timeOfDay = TimeOfDay(
      hour: int.parse(widget.hour.split(':')[0]),
      minute: int.parse(widget.hour.split(':')[1]),
    );
    super.initState();
  }

  @override
  void dispose() {
    hourController.dispose();
    super.dispose();
  }

  Future<void> showPicker() async {
    final timer = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (timer != null) {
      timeOfDay = timer;
      hourController.text = '${timer.hour}:${timer.minute}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.title,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Hora',
                style: theme.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: showPicker,
                child: AbsorbPointer(
                  child: CupertinoTextField(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                    enabled: false,
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    controller: hourController,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Cantidad (gr)',
                style: theme.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 5.h),
              ValueListenableBuilder<int>(
                valueListenable: gr,
                builder: (_, value, __) => NumberPicker(
                  value: value,
                  minValue: 0,
                  maxValue: 400,
                  step: 5,
                  onChanged: (value) => gr.value = value,
                  axis: Axis.horizontal,
                  infiniteLoop: true,
                  textStyle: theme.textTheme.bodyText1,
                  selectedTextStyle: theme.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                  haptics: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    onPressed: Navigator.of(context).pop,
                    padding: EdgeInsets.zero,
                    child: const Text('Cancelar'),
                  ),
                  SizedBox(width: 15.w),
                  CupertinoButton(
                    onPressed: () {
                      final countMeal = CountMeal(
                        gr: gr.value,
                        hour: timeOfDay.hour,
                        minutes: timeOfDay.minute,
                      );
                      Navigator.of(context).pop(countMeal);
                    },
                    padding: EdgeInsets.zero,
                    child: const Text('Ok'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActualWeith extends StatelessWidget {
  const ActualWeith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(60.r),
      child: Container(
        width: 120.r,
        height: 120.r,
        color: theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.balanceScale,
              color: theme.primaryColor,
            ),
            SizedBox(height: 5.h),
            BlocSelector<HomeBloc, HomeState, Configurations?>(
              selector: (state) => state.configurations,
              builder: (context, configurations) => Text(
                '${configurations!.currentWeight}',
                style: theme.textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Kg',
              style: theme.textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionsAndTitle extends StatelessWidget {
  const ActionsAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 25.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            child: Text(
              'HOME',
              style: theme.textTheme.bodyText1!.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const FaIcon(FontAwesomeIcons.userCircle),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: const FaIcon(FontAwesomeIcons.ellipsisH),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  const HeaderClipper();

  @override
  Path getClip(Size size) => Path()
    ..lineTo(0, size.height * .9)
    ..quadraticBezierTo(
      size.width * .5,
      size.height * 1.1,
      size.width,
      size.height * .9,
    )
    ..lineTo(size.width, size.height)
    ..lineTo(size.width, 0)
    ..close();

  @override
  bool shouldReclip(HeaderClipper oldClipper) => false;
}
