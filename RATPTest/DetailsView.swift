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
        toiletteModel.adresse ?? "N/A"
    }

    var subtitle: String {
        toiletteModel.gestionnaire ?? "N/A"
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
    DetailsView(viewModel: DetailsViewModel(toiletteModel: ToiletteModel()))
}
