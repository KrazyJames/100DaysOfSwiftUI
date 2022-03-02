//
//  ProspectsView.swift
//  HotProspects
//
//  Created by jescobar on 2/27/22.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortSelection = false
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    ProspectCellView(prospect: prospect, filter: filter)
                        .swipeActions {
                            Button {
                                prospects.delete(prospect)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                            if prospect.isContacted {
                                Button {
                                    prospects.toggle(prospect)
                                } label: {
                                    Label("Mark as uncontacted", systemImage: "person.crop.circle.badge.xmark")
                                }
                                .tint(.blue)
                            } else {
                                Button {
                                    prospects.toggle(prospect)
                                } label: {
                                    Label("Mark as contacted", systemImage: "person.crop.circle.badge.checkmark")
                                }
                                .tint(.green)
                                Button {
                                    addNotification(for: prospect)
                                } label: {
                                    Label("Remind me", systemImage: "bell")
                                }
                                .tint(.orange)
                            }
                        }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingScanner.toggle()
                    } label: {
                        Label("Scan",
                              systemImage: "qrcode.viewfinder")
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Button {
                        isShowingSortSelection.toggle()
                    } label: {
                        Label("Sort",
                              systemImage: "arrow.up.arrow.down.square")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "\(["A", "B", "C", "D"].randomElement() ?? "Z" )\nyouremail@email.com",
                    completion: handleScan
                )
            }
            .confirmationDialog("Sort by", isPresented: $isShowingSortSelection) {
                ForEach(Prospects.Sorting.allCases, id: \.self) { sorting in
                    Button(sorting.rawValue) {
                        prospects.sort(by: sorting)
                    }
                }
            }
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let prospect = Prospect()
            prospect.name = details[0]
            prospect.emailAddress = details[1]
            prospects.add(prospect)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = .default
            var components = DateComponents()
            components.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
