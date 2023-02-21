start:
	fvm flutter pub get
	fvm flutter run -d chrome lib/main_development.dart

start-release:
	fvm flutter pub get
	fvm flutter run -d chrome lib/main_development.dart --release

build-web:
	fvm flutter build web --target lib/main_development.dart

clean:
	fvm flutter clean

deploy:
	firebase deploy --only hosting