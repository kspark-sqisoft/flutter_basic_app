import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../utils/general.dart';
import 'apple_all_shortcuts.dart';
import 'apple_clock.dart';
import 'apple_contacts.dart';
import 'apple_folders.dart';
import 'apple_messages.dart';
import 'apple_music.dart';
import 'apple_shortcuts_gallery.dart';
import 'apple_store.dart';
import 'apple_tips.dart';
import 'github_inbox.dart';
import 'github_issues.dart';
import 'playground.dart';
import 'whatsapp.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SearchBarScrollBehavior scrollBehavior = SearchBarScrollBehavior.floated;
  SearchBarAnimationBehavior animationBehavior = SearchBarAnimationBehavior.top;
  double unfocusedSliderValue = 1.0;
  double focusedSliderValue = 0.0;
  double alwaysSliderValue = 0.0;
  bool stretch = false;
  bool largeTitleEnabled = true;
  bool searchBarEnabled = true;
  SearchBarResultBehavior resultBehavior =
      SearchBarResultBehavior.visibleOnFocus;

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onCollapsed: (val) {
        print("collapsed => $val");
      },
      transitionBetweenRoutes: true,
      stretch: stretch,
      appBar: SuperAppBar(
        automaticallyImplyLeading: true,
        previousPageTitle: "Main",
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.50),
        title: Text(
          "Welcome",
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
        searchBar: SuperSearchBar(
          resultColor: Theme.of(context).appBarTheme.backgroundColor,
          enabled: searchBarEnabled,
          searchResult: const Text(
            "This is result page",
            style: TextStyle(color: Colors.white),
          ),
          animationBehavior: animationBehavior,
          resultBehavior: resultBehavior,
          scrollBehavior: scrollBehavior,
          cancelButtonText: "Cancel",
        ),
        largeTitle: SuperLargeTitle(
          enabled: largeTitleEnabled,
          largeTitle: "Welcome",
          actions: [
            const Icon(
              CupertinoIcons.profile_circled,
              size: 30,
            )
          ],
        ),
      ),
      body: [
        Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Playground();
                },
              ),
            ),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/heisenberg.jpeg",
                      width: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Playground",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  const Icon(
                    CupertinoIcons.arrow_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.all(15),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    if (i == 0) {
                      return const AppleMusic();
                    } else if (i == 1) {
                      return const AppleClock();
                    } else if (i == 2) {
                      return const AppleStore();
                    } else if (i == 3) {
                      return const AppleContacts();
                    } else if (i == 4) {
                      return const AppleMessages();
                    } else if (i == 5) {
                      return const AppleAllShortcuts();
                    } else if (i == 6) {
                      return const AppleFolders();
                    } else if (i == 7) {
                      return const AppleTips();
                    } else if (i == 8) {
                      return const ShortcutsGallery();
                    } else if (i == 9) {
                      return const Whatsapp();
                    } else if (i == 10) {
                      return const GithubInbox();
                    } else {
                      return const GithubIssues();
                    }
                  },
                ),
              ),
              child: Container(
                color: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "${General.instance.examples[i].imageUrl}",
                        width: 35,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      General.instance.examples[i].title,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (c, i) => const Divider(
              indent: 65,
              height: 0,
            ),
            itemCount: General.instance.examples.length,
          ),
        ),
      ],
    );
  }
}
