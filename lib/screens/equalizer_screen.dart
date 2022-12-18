import 'package:flutter/material.dart';
import 'package:nileur_music_app/Utils/common.dart';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/services.dart';


class EqualizerScreen extends StatefulWidget {
  const EqualizerScreen({Key? key}) : super(key: key);

  @override
  State<EqualizerScreen> createState() => _EqualizerScreenState();
}

class _EqualizerScreenState extends State<EqualizerScreen> {

  bool enableCustomEQ = false;

  @override
  void initState() {
    super.initState();
    EqualizerFlutter.init(0);
  }

  @override
  void dispose() {
    EqualizerFlutter.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        appBar:  AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Equalizer'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(height: 10.0),
            Center(
              child: Builder(
                builder: (context) {
                  return TextButton.icon(
                    icon: Icon(Icons.equalizer),
                    label: Text('Open device equalizer',style: fontMontserrat(color: kPrimaryColor),),


                    onPressed: () async {
                      try {
                        await EqualizerFlutter.open(0);
                      } on PlatformException catch (e) {
                        customToast("${e.message}\n${e.details}");
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              color: Colors.grey.withOpacity(0.1),
              child: SwitchListTile(
                title: Text('Custom Equalizer'),
                value: enableCustomEQ,
                onChanged: (value) {
                  EqualizerFlutter.setEnabled(value);
                  setState(() {
                    enableCustomEQ = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20,),
            FutureBuilder<List<int>>(
              future: EqualizerFlutter.getBandLevelRange(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) return customProgressIndicator();
                return CustomEQ(enableCustomEQ, snapshot.data!);


              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomEQ extends StatefulWidget {
  const CustomEQ(this.enabled, this.bandLevelRange);

  final bool enabled;
  final List<int> bandLevelRange;

  @override
  _CustomEQState createState() => _CustomEQState();
}

class _CustomEQState extends State<CustomEQ> {
  late double min, max;
  String? _selectedValue;
  late Future<List<String>> fetchPresets;

  @override
  void initState() {
    super.initState();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();
    fetchPresets = EqualizerFlutter.getPresetNames();
  }

  @override
  Widget build(BuildContext context) {
    int bandId = 0;

    return FutureBuilder<List<int>>(
      future: EqualizerFlutter.getCenterBandFreqs(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.data!
                  .map((freq) => _buildSliderBand(freq, bandId))
                  .toList(),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _buildPresets(),
            ),
          ],
        )
            : CircularProgressIndicator();
      },
    );
  }

  Widget _buildSliderBand(int freq, int bandId) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            child: FutureBuilder<int>(
              future: EqualizerFlutter.getBandLevel(bandId),
              builder: (context, snapshot) {
                var data = snapshot.data?.toDouble() ?? 0.0;
                return RotatedBox(
                  quarterTurns: 1,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 1,
                        trackShape: SliderCustomTrackShape()
                    ),
                    child: Center(
                      child: Slider(
                        min: min,
                        max: max,
                        value: data,
                        onChanged: (lowerValue) {
                          EqualizerFlutter.setBandLevel(bandId, lowerValue.toInt());
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text('${freq ~/ 1000} Hz'),
        ],
      ),
    );
  }

  Widget _buildPresets() {
    return FutureBuilder<List<String>>(
      future: fetchPresets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final presets = snapshot.data;
          if (presets!.isEmpty) return Text('No presets available!');
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Available Presets',
              border: OutlineInputBorder(),
            ),
            value: _selectedValue,
            onChanged: widget.enabled
                ? (String? value) {
              EqualizerFlutter.setPreset(value!);
              setState(() {
                _selectedValue = value;
              });
            }
                : null,
            items: presets.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        } else if (snapshot.hasError)
          return Text(snapshot.error.toString());
        else
          return CircularProgressIndicator();
      },
    );
  }

}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = (parentBox.size.height) / 2;
    final double trackWidth =  230;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
  }
}

