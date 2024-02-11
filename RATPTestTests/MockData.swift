//
//  MockData.swift
//  RATPTestTests
//
//  Created by Nicolas Charvoz on 11/02/2024.
//

import Foundation

let responseJson = """
{
  "nhits": 616,
  "parameters": {
    "dataset": "sanisettesparis2011",
    "rows": 20,
    "start": 0,
    "format": "json",
    "timezone": "UTC"
  },
  "records": [
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "e4f7fe8c34361fb693866256f7688a1e43e4799e",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.294473730079993,
              48.8789207974837
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75017,
        "geo_point_2d": [
          48.8789207974837,
          2.294473730079993
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "4  AVENUE NIEL",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.294473730079993,
          48.8789207974837
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "de9d86b039babbdcd505d3d1eee38bc1c62462d2",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.402583928887365,
              48.84910044336135
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75020,
        "geo_point_2d": [
          48.84910044336135,
          2.402583928887365
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "1  RUE DE BUZENVAL",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.402583928887365,
          48.84910044336135
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "4e04ce7264fe2f8239daa7677ae6e5d4e4303e61",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3289696159647555,
              48.88421434923708
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "24 h / 24",
        "acces_pmr": "Oui",
        "arrondissement": 75009,
        "geo_point_2d": [
          48.88421434923708,
          2.3289696159647555
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "130 ter BOULEVARD DE CLICHY",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3289696159647555,
          48.88421434923708
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "686315409fbe3930b6060ca3d878e38b38223c30",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.354561497762257,
              48.87075131711197
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "24 h / 24",
        "acces_pmr": "Oui",
        "arrondissement": 75010,
        "geo_point_2d": [
          48.87075131711197,
          2.354561497762257
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "face au 1 RUE DE METZ",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.354561497762257,
          48.87075131711197
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "8c7a6424f02a6338c7c2731b45da12db9422d74b",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.366856434532836,
              48.82266348081883
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75013,
        "geo_point_2d": [
          48.82266348081883,
          2.366856434532836
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "27  AVENUE D IVRY",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.366856434532836,
          48.82266348081883
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "8eec4e9fb31a6b7aa7933d3ca4984c3d26ee7167",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3201789580568954,
              48.831657967806095
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "24 h / 24",
        "acces_pmr": "Oui",
        "arrondissement": 75014,
        "geo_point_2d": [
          48.831657967806095,
          2.3201789580568954
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "face au 36 RUE DIDOT",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3201789580568954,
          48.831657967806095
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "fdb714fac7642bfd53a8727e0824128e68bf795e",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3737508079721192,
              48.836321683521824
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "Voir fiche équipement",
        "acces_pmr": "Non",
        "arrondissement": 75013,
        "url_fiche_equipement": "https://www.paris.fr/equipements/jardin-james-joyce-2560",
        "geo_point_2d": [
          48.836321683521824,
          2.3737508079721192
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "JARDIN JAMES JOYCE",
        "type": "TOILETTES",
        "relais_bebe": "Non"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3737508079721192,
          48.836321683521824
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "88fc305755d21d5f7a5f42ef3c8f9b702251bc40",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3195679829481666,
              48.86260809408294
            ]
          ],
          "type": "MultiPoint"
        },
        "acces_pmr": "Oui",
        "arrondissement": 75007,
        "geo_point_2d": [
          48.86260809408294,
          2.3195679829481666
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "Parc Rives de Seine",
        "type": "WC PUBLICS PERMANENTS"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3195679829481666,
          48.86260809408294
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "8fbf35cecde9882c536ea58300cf382d053cbc29",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.2559870408279363,
              48.84581312142149
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75016,
        "geo_point_2d": [
          48.84581312142149,
          2.2559870408279363
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "face au 21 AVENUE DU GENERAL SARRAIL",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.2559870408279363,
          48.84581312142149
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "324173b6f32bfbba639c6e071c481a17c5798b71",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.407478775285175,
              48.84710769744264
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75012,
        "geo_point_2d": [
          48.84710769744264,
          2.407478775285175
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "90  COURS DE VINCENNES",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.407478775285175,
          48.84710769744264
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "4d4a1247e03bf9b0f188549ea1f2efcb2b410dc6",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.364376693852452,
              48.82304802120928
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "Voir fiche équipement",
        "acces_pmr": "Non",
        "arrondissement": 75013,
        "url_fiche_equipement": "https://www.paris.fr/equipements/jardin-baudricourt-2853",
        "geo_point_2d": [
          48.82304802120928,
          2.364376693852452
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "SQUARE DE LA RUE JEAN DUNAND (ZAC BAUDRICOURT)",
        "type": "TOILETTES",
        "relais_bebe": "Non"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.364376693852452,
          48.82304802120928
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "f15f7bf173b8ac799cd9326588e35ba8699b75de",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3236001578901857,
              48.82225626602284
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "Voir fiche équipement",
        "acces_pmr": "Oui",
        "arrondissement": 75014,
        "url_fiche_equipement": "https://www.paris.fr/equipements/square-du-serment-de-koufra-1773",
        "geo_point_2d": [
          48.82225626602284,
          2.3236001578901857
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "SQUARE DU SERMENT DE KOUFRA",
        "type": "TOILETTES",
        "relais_bebe": "Non"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3236001578901857,
          48.82225626602284
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "4c0ee9543cc2e9617fc2de539c98b98ef0cdbb89",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.2994986792907017,
              48.8331257246312
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75015,
        "geo_point_2d": [
          48.8331257246312,
          2.2994986792907017
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "face au 41 RUE DES MORILLONS",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.2994986792907017,
          48.8331257246312
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "184b8e8bef336143bc17a42a53e5a06c2a2d6543",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3346274255529247,
              48.89642913978984
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75018,
        "geo_point_2d": [
          48.89642913978984,
          2.3346274255529247
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "face au 36 RUE LEIBNIZ",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3346274255529247,
          48.89642913978984
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "8b253eff846b6cd0410657e1bbccfa002ffb3784",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3897517151089436,
              48.87368018535096
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 1 h",
        "acces_pmr": "Oui",
        "arrondissement": 75020,
        "geo_point_2d": [
          48.87368018535096,
          2.3897517151089436
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "face au 375 RUE DES PYRENEES",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3897517151089436,
          48.87368018535096
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "2239277e951b1dba1ac5b337927649116654c672",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.350534228884385,
              48.88224462938898
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75010,
        "geo_point_2d": [
          48.88224462938898,
          2.350534228884385
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "145  BOULEVARD DE MAGENTA",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.350534228884385,
          48.88224462938898
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "90dc980c844465cceb0abe56bf69eab3e3bc15c7",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.338685895223042,
              48.88453071312593
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "19 h - 7 h",
        "acces_pmr": "Oui",
        "arrondissement": 75009,
        "geo_point_2d": [
          48.88453071312593,
          2.338685895223042
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.338685895223042,
          48.88453071312593
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "76bdb1fb8556da8471bbf2c56828be1d9c17d9c9",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.349430631664678,
              48.888494138405285
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "24 h / 24",
        "acces_pmr": "Oui",
        "arrondissement": 75018,
        "geo_point_2d": [
          48.888494138405285,
          2.349430631664678
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "43  BOULEVARD BARBES",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.349430631664678,
          48.888494138405285
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "0e244673ee804384b1e2c4e7baff26d8b179050a",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.415233912585565,
              48.855327563669604
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75020,
        "geo_point_2d": [
          48.855327563669604,
          2.415233912585565
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "12  AVENUE DU PROFESSEUR ANDRE LEMIERE",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.415233912585565,
          48.855327563669604
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    },
    {
      "datasetid": "sanisettesparis2011",
      "recordid": "9b8c38e1ba6757ba32bd67cb1f9458ce4292afbf",
      "fields": {
        "complement_adresse": "numero_de_voie nom_de_voie",
        "geo_shape": {
          "coordinates": [
            [
              2.3484500288367336,
              48.86816218874815
            ]
          ],
          "type": "MultiPoint"
        },
        "horaire": "6 h - 22 h",
        "acces_pmr": "Oui",
        "arrondissement": 75002,
        "geo_point_2d": [
          48.86816218874815,
          2.3484500288367336
        ],
        "source": "http://opendata.paris.fr",
        "gestionnaire": "Toilette publique de la Ville de Paris",
        "adresse": "91  RUE D ABOUKIR",
        "type": "SANISETTE"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          2.3484500288367336,
          48.86816218874815
        ]
      },
      "record_timestamp": "2024-02-04T05:12:00.494Z"
    }
  ]
}
"""
