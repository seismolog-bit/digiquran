import 'package:digiquran/app/pages/splash/splash-settings.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:digiquran/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPermissions extends StatefulWidget {
  const SplashPermissions({Key? key}) : super(key: key);

  @override
  State<SplashPermissions> createState() => _SplashPermissionsState();
}

class _SplashPermissionsState extends State<SplashPermissions> {
  bool locationGrand = false;
  bool isLoading = false;

  bool isContinue = false;

  String _latitude = '';
  String _longitude = '';
  String _curLocation = '';
  String _curCity = '';

  Future<dynamic> location() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      setState(() {
        isLoading = true;
      });

      Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((value) async {
        _latitude = value.latitude.toString();
        _longitude = value.longitude.toString();

        List<Placemark> places = await geolocator.placemarkFromCoordinates(
            value.latitude, value.longitude);

        Placemark place = places[0];
        setState(() {
          locationGrand = true;
          _curLocation = place.locality;
          _curCity = place.subAdministrativeArea;

          isLoading = false;
          isContinue = true;
        });

        pref.setString('location', place.locality);
        pref.setString('city', place.subAdministrativeArea);
        pref.setDouble('latitude', value.latitude);
        pref.setDouble('longitude', value.longitude);

        Toast.show('$_curLocation, $_curCity');

        // return true;
      }).catchError((e) {
        print('error location: $e');

        setState(() {
          isLoading = false;
          isContinue = false;
          Toast.show('Gagal mengambil lokasi');
        });
        // return false;
        // return 'false';
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isContinue = false;
      });

      debugPrint('error $e');

      // return 'false';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          margin: const EdgeInsets.fromLTRB(32, 12, 32, 12),
          child: Column(
            children: [
              Text(
                'Perijinan',
                style: defaultText.copyWith(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Kami membutuhkan perijnan anda untuk mendapatkan pengelaman yang lebih baik',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Image(
          image: AssetImage('assets/splash-permission.png'),
          fit: BoxFit.contain,
          height: 240,
        ),
        ListTile(
          leading: const Icon(FontAwesomeIcons.locationDot),
          title: const Text('Lokasi'),
          subtitle:
              const Text('Digunakan untuk menentukan koordinat waktu shalat'),
          trailing: (!locationGrand)
              // ? const Icon(
              //     FontAwesomeIcons.xmark,
              //     color: Colors.grey,
              //     size: 18,
              //   )
              ? Switch(
                  value: isContinue,
                  onChanged: (value) async {
                    await location();
                  },
                )
              : const Icon(
                  FontAwesomeIcons.circleCheck,
                  color: Colors.deepPurple,
                  size: 18,
                ),
          onTap: () => location(),
        )
      ]),
      bottomNavigationBar: continueButton(),
    );
  }

  Widget continueButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => finishButton(),
          child: Container(
            width: 162,
            height: 42,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Lanjutkan',
                    style: defaultText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future finishButton() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      if (!isContinue) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Pesetujuan Lokasi'),
                content: const Text(
                    'Lokasi default anda akan diarahkan ke Jakarta Pusat'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        pref.setString('location', 'Gambir');
                        pref.setString('city', 'Jakarta Pusat');
                        pref.setDouble('latitude', -6.1824899);
                        pref.setDouble('longitude', 106.8372377);

                        Toast.show('$_curLocation, $_curCity');
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SplashSettingsScreen()));
                    },
                    child: const Text('Setuju'),
                  )
                ]);
          },
        );
      } else {
        return Navigator.push(
            context,
            (MaterialPageRoute(
                builder: (context) => const SplashSettingsScreen())));
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
