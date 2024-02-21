import 'dart:math';

import 'package:bulleted_list/bulleted_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../riverpod_app/providers/dio_provider.dart';

part 'riverpod_basic_screen.g.dart';
part 'riverpod_basic_screen.freezed.dart';

@Riverpod(keepAlive: true)
String keesoon(KeesoonRef ref) {
  print('keesoonProvider  build');
  ref.onAddListener(() {
    print('keesoonProvider  onAddListener');
  });
  ref.onResume(() {
    print('keesoonProvider  onResume');
  });
  ref.onRemoveListener(() {
    print('keesoonProvider  onRemoveListener');
  });
  ref.onCancel(() {
    print('keesoonProvider  onCancel');
  });
  ref.onDispose(() {
    print('keesoonProvider  onDispose');
  });
  return 'keesoon';
}

@riverpod
String hello(HelloRef ref, {required String yourName}) {
  print('helloProvider(yourName:$yourName)  build');
  ref.onAddListener(() {
    print('helloProvider(yourName:$yourName)  onAddListener');
  });
  ref.onResume(() {
    print('helloProvider(yourName:$yourName)  onResume');
  });
  ref.onRemoveListener(() {
    print('helloProvider(yourName:$yourName)  onRemoveListener');
  });
  ref.onCancel(() {
    print('helloProvider(yourName:$yourName)  onCancel');
  });

  ref.onDispose(() {
    print('helloProvider(yourName:$yourName)  onDispose');
  });
  return 'hello $yourName';
}

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    print('counterProvider build');
    ref.onAddListener(() {
      print('counterProvider onAddListener');
    });
    ref.onResume(() {
      print('counterProvider onResume');
    });
    ref.onRemoveListener(() {
      print('counterProvider onRemoveListener');
    });
    ref.onCancel(() {
      print('counterProvider onCancel');
    });
    ref.onDispose(() {
      print('counterProvider onDispose');
    });
    return 0;
  }

  void increment() {
    state = state + 1;
  }

  void decrement() {
    state = state - 1;
  }
}

@riverpod
Stream<int> ticker(TickerRef ref) {
  print('tickerProvider build');
  ref.onAddListener(() {
    print('tickerProvider onAddListener');
  });
  ref.onResume(() {
    print('tickerProvider onResume');
  });
  ref.onRemoveListener(() {
    print('tickerProvider onRemoveListener');
  });
  ref.onCancel(() {
    print('tickerProvider onCancel');
  });
  ref.onDispose(() {
    print('tickerProvider onDispose');
  });
  return Stream.periodic(const Duration(seconds: 1), (t) => t + 1).take(10);
}

@freezed
class User with _$User {
  factory User({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Address with _$Address {
  factory Address({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class Company with _$Company {
  factory Company({
    String? name,
    String? catchPhrase,
    String? bs,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}

@freezed
class Geo with _$Geo {
  factory Geo({
    String? lat,
    String? lng,
  }) = _Geo;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}

@riverpod
FutureOr<List<User>> users(UsersRef ref) async {
  print('usersProvider build');

  ref.onAddListener(() {
    print('usersProvider  onAddListener');
  });
  ref.onResume(() {
    print('usersProvider  onResume');
  });
  ref.onRemoveListener(() {
    print('usersProvider  onRemoveListener');
  });
  ref.onCancel(() {
    print('usersProvider  onCancel');
  });
  ref.onDispose(() {
    print('usersProvider onDispose');
  });

  final response = await ref
      .watch(dioProvider(
          baseOptions:
              BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com')))
      .get('/users');

  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];

  return users;
}

@riverpod
FutureOr<User> user(UserRef ref, {required int id}) async {
  print('userProvider(id:$id) build');

  ref.onAddListener(() {
    print('userProvider(id:$id)  onAddListener');
  });
  ref.onResume(() {
    print('userProvider(id:$id)  onResume');
  });
  ref.onRemoveListener(() {
    print('userProvider(id:$id)  onRemoveListener');
  });
  ref.onCancel(() {
    print('userProvider(id:$id)  onCancel');
  });

  ref.onDispose(() {
    print('userProvider(id:$id) onDispose');
  });
  final response = await ref
      .watch(dioProvider(
          baseOptions:
              BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com')))
      .get('/users/$id');
  final user = User.fromJson(response.data);
  return user;
}

@freezed
class Activity with _$Activity {
  factory Activity({
    String? activity,
    String? type,
    double? participants,
    double? price,
    String? link,
    String? key,
    double? accessibility,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  factory Activity.empty() => Activity(
        activity: '',
        type: '',
        participants: 0.0,
        price: 0.0,
        link: '',
        key: '',
        accessibility: 0.0,
      );
}

final activityTypes = [
  "education",
  "recreational",
  "social",
  "diy",
  "charity",
  "cooking",
  "relaxation",
  "music",
  "busywork"
];

enum ActivityStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState({
    required ActivityStatus status,
    required Activity activity,
    required String error,
  }) = _ActivityState;

  factory ActivityState.initial() {
    return ActivityState(
        status: ActivityStatus.initial, activity: Activity.empty(), error: '');
  }
}

@riverpod
class NormalActivity extends _$NormalActivity {
  int _errorCount = 0;
  @override
  ActivityState build() {
    print('NormalActivity build $hashCode');
    ref.onDispose(() {
      print('NormalActivity onDispose $hashCode');
    });
    _errorCount = 0;

    return ActivityState.initial();
  }

  Future<void> fetchActivity(String activityType) async {
    print('NormalActivity fetchActivity $activityType $hashCode');
    state = state.copyWith(status: ActivityStatus.loading);

    try {
      if (_errorCount++ % 5 == 1) {
        await Future.delayed(const Duration(seconds: 1));

        throw Exception('Fail to fetch activity');
      }
      final response = await ref
          .watch(dioProvider(
              baseOptions: BaseOptions(baseUrl: 'https://www.boredapi.com')))
          .get('/api/activity?type=$activityType');

      final activity = Activity.fromJson(response.data);
      state =
          state.copyWith(status: ActivityStatus.success, activity: activity);
    } catch (e) {
      state =
          state.copyWith(status: ActivityStatus.failure, error: e.toString());
    }
  }
}

@riverpod
class AsyncActivity extends _$AsyncActivity {
  int _errorCounter = 0;

  @override
  FutureOr<Activity> build() {
    print('AsyncActivity build $hashCode');
    ref.onDispose(() {
      print('AsyncActivity onDispose $hashCode');
    });
    _errorCounter = 0;

    return getActivity(activityTypes[0]);
  }

  Future<Activity> getActivity(String activityType) async {
    if (_errorCounter++ % 5 == 1) {
      await Future.delayed(const Duration(seconds: 1));
      throw 'Fail to fetch activity';
    }
    final response = await ref
        .watch(dioProvider(
            baseOptions: BaseOptions(baseUrl: 'https://www.boredapi.com')))
        .get('/api/activity?type=$activityType');
    final activity = Activity.fromJson(response.data);
    return activity;
  }

  Future<void> fetchActivity(String activityType) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() {
      return getActivity(activityType);
    });
  }
}

class RiverpodBasicScreen extends ConsumerStatefulWidget {
  const RiverpodBasicScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RiverpodBasicScreenState();
}

class _RiverpodBasicScreenState extends ConsumerState<RiverpodBasicScreen> {
  @override
  void initState() {
    print('_RiverpodBasicScreenState initState');
    Future.microtask(() {
      print('microtask fetchActivity');
      ref.read(normalActivityProvider.notifier).fetchActivity(activityTypes[0]);
    });

    Future(() => print('future 1'));
    Future(() => print('future 2'));

    Future.microtask(() => print('microtask 1'));
    Future.microtask(() => print('microtask 2'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('_RiverpodBasicScreenState build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Basic'),
      ),
      body: Column(
        children: [
          Text(ref.watch(keesoonProvider)),
          Text(ref.watch(helloProvider(yourName: 'keesoon'))),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).increment();
                  },
                  child: const Icon(Icons.add)),
              Text(ref.watch(counterProvider).toString()),
              ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).decrement();
                  },
                  child: const Icon(Icons.remove)),
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              final AsyncValue<int> ticker = ref.watch(tickerProvider);
              return switch (ticker) {
                AsyncError(:final error, :final stackTrace) =>
                  Text(error.toString()),
                AsyncData(:final value) => Text(value.toString()),
                _ => const CircularProgressIndicator()
              };
            },
          ),
          SizedBox(
            height: 200,
            child: Consumer(
              builder: (context, ref, child) {
                final users = ref.watch(usersProvider);
                //developer.log(users.toString());
                return users.when(
                    skipLoadingOnRefresh: false,
                    data: (users) => RefreshIndicator(
                          onRefresh: () async {
                            //ref.invalidate(usersProvider); //밑에랑 같다.
                            ref.refresh(usersProvider.future);
                          },
                          color: Colors.red,
                          child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: users.length,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return UserDetailPage(userId: user.id!);
                                  }));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      user.id.toString(),
                                    ),
                                  ),
                                  title: Text(user.name.toString()),
                                ),
                              );
                            },
                          ),
                        ),
                    error: (e, s) => Center(
                          child: Text(e.toString()),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ));
              },
            ),
          ),
          Row(
            children: [
              //NormalActivity
              Flexible(
                child: Consumer(
                  builder: (context, ref, child) {
                    final normalActivityState =
                        ref.watch(normalActivityProvider);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              final randomNumber =
                                  Random().nextInt(activityTypes.length);
                              ref
                                  .read(normalActivityProvider.notifier)
                                  .fetchActivity(activityTypes[randomNumber]);
                            },
                            child: const Text('NormalActivity')),
                        switch (normalActivityState.status) {
                          ActivityStatus.initial => const Center(
                              child: Text(
                                'Get some activity',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ActivityStatus.loading => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ActivityStatus.failure => Center(
                              child: Text(
                                'Get some activity error: ${normalActivityState.error}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ActivityStatus.success => ActivityWidget(
                              activity: normalActivityState.activity)
                        }
                      ],
                    );
                  },
                ),
              ),
              //AsyncActivity
              Flexible(child: Consumer(
                builder: (context, ref, child) {
                  final asyncActivity = ref.watch(asyncActivityProvider);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            final randomNumber =
                                Random().nextInt(activityTypes.length);
                            ref
                                .read(asyncActivityProvider.notifier)
                                .fetchActivity(activityTypes[randomNumber]);
                          },
                          child: const Text('AsyncActivity')),
                      asyncActivity.when(
                        //skipError: true,
                        //skipLoadingOnRefresh: false,
                        data: (activity) => ActivityWidget(activity: activity),
                        error: (e, st) => Center(
                          child: Text(
                            'Get some activity error: ${e.toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  );
                },
              )),
            ],
          )
        ],
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Text(
            activity.type.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Divider(),
          BulletedList(
            bullet: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            listItems: [
              'activity: ${activity.activity}',
              'accessibility: ${activity.accessibility}',
              'participants: ${activity.participants}',
              'price: ${activity.price}',
              'key: ${activity.key}',
            ],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final int userId;
  const UserDetailPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(userProvider(id: userId));
          return user.when(
              data: (user) => RefreshIndicator(
                    /*
                    onRefresh: () {
                      return ref.refresh(userProvider(id: userId).future);
                    },
                    
                    */
                    //같다
                    onRefresh: () async {
                      return ref.refresh(userProvider(id: userId));
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      children: [
                        Text(
                          user.name.toString(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Divider(),
                        UserInfo(
                            iconData: Icons.account_circle,
                            data: user.username.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        UserInfo(
                            iconData: Icons.email_rounded,
                            data: user.email.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        UserInfo(
                            iconData: Icons.phone_enabled,
                            data: user.phone.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        UserInfo(
                            iconData: Icons.web_rounded,
                            data: user.website.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
              error: (e, s) => Center(
                    child: Text(e.toString()),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final IconData iconData;
  final String data;
  const UserInfo({super.key, required this.iconData, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(
          width: 10,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}
