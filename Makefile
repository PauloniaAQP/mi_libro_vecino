start:
	fvm flutter run -d chrome lib/main_development.dart

build-web:
	fvm flutter build web --target lib/main_development.dart

deploy:
	firebase deploy --only hosting