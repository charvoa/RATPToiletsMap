//
//  DetailsView.swift
//  RATPTest
//
//  Created by Nicolas Charvoz on 11/02/2024.
//

import SwiftUI
import MapKit

struct DetailsViewModel {
    let toiletteModel: ToiletteModel
    let region: MKCoordinateRegion

    init(toiletteModel: ToiletteModel) {
        self.toiletteModel = toiletteModel
        self.region = MKCoordinateRegion(center: toiletteModel.coordinates ?? LocationService.centerOfParis, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }

    var title: String {
        toiletteModel.title
    }

    var subtitle: String {
        toiletteModel.subtitle
    }
}

struct DetailsView: View {

    var viewModel: DetailsViewModel

    var body: some View {
        ScrollView {
            VStack {
                Map(coordinateRegion: .constant(viewModel.region), annotationItems: [viewModel.toiletteModel]) { place in
                    MapPin(coordinate: place.coordinates ?? LocationService.centerOfParis,
                           tint: Color.blue)
                }
                .frame(height: 300)

                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.title2)
                        .bold()
                    Text(viewModel.subtitle)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)

                    HStack(alignment: .bottom, spacing: 12) {
                        if viewModel.toiletteModel.hasPmrAccess {
                            Image(ImageResource.figureRoll)
                                .foregroundColor(Color(UIColor.blue))
                        }
                        if viewModel.toiletteModel.hasBabyRelay {
                            Image(ImageResource.faceSmiling)
                                .foregroundColor(Color(UIColor.systemPink))
                        }

                        Image(ImageResource.doorLeftHandOpen)
                            .foregroundColor(viewModel.toiletteModel.isOpen == true ? Color(UIColor.systemGreen) : Color.red)
                        Text(viewModel.toiletteModel.displayHoraire.value())
                            .font(.footnote)
                            .foregroundColor(Color(UIColor.tertiaryLabel))
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    DetailsView(viewModel: DetailsViewModel(toiletteModel: ToiletteModel(from: ToiletteModelNetwork(complementAdresse: "numero_de_voie nom_de_voie", geoPoint2d: [48.8789207974837, 2.294473730079993], accesPmr: "Oui", horaire: "6 h - 22 h", gestionnaire: "Toilette publique de la Ville de Paris", adresse: "4 ANUE NIEL", type: .other, relaisBebe: "None"))))
}
