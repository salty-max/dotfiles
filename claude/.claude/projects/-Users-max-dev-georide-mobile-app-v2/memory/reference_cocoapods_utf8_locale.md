---
name: CocoaPods requires UTF-8 locale or it crashes mid-install
description: `pod install` and `expo prebuild -p ios` fail with an "Encoding::CompatibilityError" unless LC_ALL + LANG are set to en_US.UTF-8 in the subprocess environment
type: reference
originSessionId: e903ca11-fdf5-4bb1-af6b-2327a4821377
---
This project's Homebrew CocoaPods (1.16.2 on Ruby 4.0.2) dies with:

```
Encoding::CompatibilityError
  Unicode Normalization not appropriate for ASCII-8BIT
```

somewhere inside `Pod::Config#installation_root` as soon as any command needs the installation path. It happens even when the user's shell has `LANG=en_US.UTF-8` set — the Bash subprocess launched by Expo / pnpm scripts doesn't inherit it.

**Fix when invoking pod install directly:**
```
cd ios && LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 pod install
```

**Fix when invoking expo prebuild:**
```
LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 pnpm expo prebuild -p ios --clean
```

Same treatment works for `pnpm ios --device` — wrap it in the same env prefix whenever prebuild runs as part of the build.

`pod --version` itself emits a yellow warning suggesting `export LANG=en_US.UTF-8 in ~/.profile`; this is the same issue manifesting at startup.
