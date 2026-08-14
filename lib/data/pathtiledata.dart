import 'package:nitnem/models/pathtile.dart';

class PathTileData {
  static List<PathTile> items = <PathTile>[
    const PathTile(
      id: 1,
      title: 'Japji Sahib',
      gurmukhi: 'jpujI swihb',
      filePrefix: 'japji_sahib',
    ),
    const PathTile(
      id: 2,
      title: 'Jaap Sahib',
      gurmukhi: 'jwpu swihb',
      filePrefix: 'jaap_sahib',
    ),
    const PathTile(
      id: 3,
      title: 'Chaupai Sahib',
      gurmukhi: 'cOpeI swihb',
      filePrefix: 'chaupai_sahib',
    ),
    const PathTile(
      id: 4,
      title: 'Anand Sahib',
      gurmukhi: 'Anµdu swihb',
      filePrefix: 'anand_sahib',
    ),
    const PathTile(
      id: 5,
      title: 'Rehras Sahib',
      gurmukhi: 'rhrwis swihb',
      filePrefix: 'rehraas_sahib',
    ),
    const PathTile(
      id: 6,
      title: 'Tav-Prasad Savaiye',
      gurmukhi: 'qÍ pRswid sv`X',
      filePrefix: 'tavprasad_savaiye',
    ),
    const PathTile(
      id: 7,
      title: 'Ardas',
      gurmukhi: 'Ardws',
      filePrefix: 'ardas',
    ),
    const PathTile(
      id: 8,
      title: 'Sukhmani Sahib',
      gurmukhi: 'suKmnI swihb',
      filePrefix: 'sukhmani_sahib',
    ),
    const PathTile(
      id: 9,
      title: 'Dukh Bhanjani Sahib',
      gurmukhi: 'duK BMjnI swihb',
      filePrefix: 'dukh_bhanjani_sahib',
    ),
    const PathTile(
      id: 10,
      title: 'Sohila Sahib',
      gurmukhi: 'soihlw swihb',
      filePrefix: 'sohila_sahib',
    ),
    const PathTile(
      id: 11,
      title: 'Aarti',
      gurmukhi: 'AwrqI',
      filePrefix: 'aarti_aarta',
    ),
  ];

  static List<dynamic> defaultOrderIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
}
