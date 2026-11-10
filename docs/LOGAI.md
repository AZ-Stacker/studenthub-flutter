# AI usage log

Lab 5.1, StudentHub. Kept by Muhammad Nasriq Bin Man (105260).

## Task given to the AI tools

Move the selected navigation index (`currentIndex`) out of `MainShell`, which was a StatefulWidget using `setState`,
into a separate state class in `lib/providers/`, and have the NavigationBar and the Drawer read it from there.

The same prompt went to both tools. It contained `lib/main.dart`, `lib/pages/main_shell.dart` and
`lib/providers/student_provider.dart` exactly as they were on `main` (commit c08ed8a), plus these constraints:
keep the structure and the package name, change as few files as possible, return full files, add no packages,
follow null safety and use const, and say in one line per file what changed and why.

## Log

| Date | Tool | Used for | Result | What was kept |
| --- | --- | --- | --- | --- |
| 10 Nov 2026 | ChatGPT (chatgpt.com, not signed in) | The refactor prompt above | 3 files. Format failed on 2 files, analyze clean, tests failed with ProviderNotFoundException | Not used. Kept for the comparison |
| 10 Nov 2026 | Claude (claude.ai, Sonnet 5.5, effort Low) | The same prompt | 3 files. Format failed on 2 files, analyze clean, tests failed with ProviderNotFoundException | Used, after the corrections below |
| 10 Nov 2026 | Claude Code (Claude desktop app) | Pasting both answers into throwaway copies of `main`, running the checks, drafting this log | Checks run as listed above | The checks and this log, reviewed by me |

## Why both failed the tests

Both tools registered `NavigationProvider` in `main()`. The widget test builds `StudentHubApp` directly and never
runs `main()`, so `MainShell` could not find the provider.

## Corrections made before merging

1. Moved both providers from `main()` into `StudentHubApp.build`, as a `MultiProvider` around `MaterialApp`.
2. Ran `dart format` to remove the blank lines Claude left in.
3. Added `test/navigation_test.dart`, which taps the bottom bar and the drawer and checks the page changes.

After this: `dart format` clean, `flutter analyze` no issues, `flutter test` 2 of 2 passed.

## Review of the generated code

- Null safety: both keep the index as a non-nullable `int` starting at 0. No nullable lookups, no `!`.
- Rebuilds: ChatGPT uses `context.watch`, so the shell rebuilds on any change in the provider. Claude uses
  `context.select` on the index only, so it rebuilds only when the index changes.
- Naming: `setIndex` (ChatGPT) and `select` (Claude). Both clear. Claude adds `_selectAndClose` for the drawer tiles.
- Range check: ChatGPT ignores indexes outside 0 to 3, but the 3 is hard-coded. Claude has no check.
- Unused imports: none in either.

## Which one we used and why

Claude's version. Both needed the same corrections, so the choice came down to the code: `context.select` avoids
extra rebuilds and there is no hard-coded page count.
