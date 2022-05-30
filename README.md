# Mi Libro Vecino

[![codecov](https://codecov.io/gh/PauloniaAQP/mi_libro_vecino/branch/main/graph/badge.svg?token=RPQQG4BEGO)](https://codecov.io/gh/PauloniaAQP/mi_libro_vecino)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Mi libro vecino is a open source project.

---

## Use

Before you start, you need to add Google API key in the `index.html` file. [Google API key](https://developers.google.com/maps/documentation/javascript/get-api-key?hl=es)

```html
<script src="https://maps.googleapis.com/maps/api/js?key=your_key"></script>
```




## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Mi Libro Vecino works on Web._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Acounts for test
In order to test admin functionality use the following account:

user : admin@test.com  
password: 123456789

## How to contribute

If you want to take the time to make this project better, please read [the contributing guides](https://github.com/PauloniaAQP/mi_libro_vecino/blob/dev/CONTRIBUTING.md) first. Then, you can open an new issue, of a pull request.



[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
