//
//  ContentView.swift
//  AlDente
//
//  Created by David Wernhart on 09.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import LaunchAtLogin
import SwiftUI

private struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
            .background(configuration.isPressed ? Color.white : Color.blue)
            .cornerRadius(6.0)
            .padding()
    }
}

private struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.red : Color.white)
            .background(configuration.isPressed ? Color.white : Color.red)
            .cornerRadius(6.0)
            .padding()
    }
}

private var osxScale = true

private struct Settings: View {
    @State private var launchAtLogin = LaunchAtLogin.isEnabled
    @State private var osxScaleToggle = osxScale
    @ObservedObject private var presenter = SMCPresenter.shared

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Toggle(isOn: Binding(
                        get: { launchAtLogin },

                        set: { newValue in
                            launchAtLogin = newValue
                            print("Launch at login turned \(newValue ? "on" : "off")!")
                            LaunchAtLogin.isEnabled = newValue
                        }
                    )) {
                        Text("Launch at login")
                    }

                    Toggle(isOn: Binding(
                        get: { osxScaleToggle },

                        set: { newValue in
                            osxScaleToggle = newValue
                            osxScale = newValue
                            presenter.setValue(value: Float(presenter.value))
                        }
                    )) {
                        Text("Use macOS battery scale")
                    }
                }.padding()

                Spacer()

                Button(action: {
                    Helper.instance.installHelper()
                }) {
                    Text("Reinstall Helper")
                        .frame(maxWidth: 120, maxHeight: 30)
                }.buttonStyle(BlueButtonStyle())
            }

            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
                    Text("AlDente \(version ?? "") 🍝").font(.headline)

                    let address = "github.com/davidwernhart/AlDente"
                    Button(action: {
                        openURL("https://" + address)
                    }) {
                        Text(address).foregroundColor(Color(.linkColor))
                    }.buttonStyle(PlainButtonStyle())

                    Text("Created with ♡ by David Wernhart in 2020")
//                    Text("AlDente 🍝").font(.title)
//                    Text("Keep your battery just right").font(.subheadline)
                }

                Spacer()

                Button(action: {
                    openURL("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6PLR7D9ZCZGGC&source=url")
                }) {
                    Text("Donate")
                        .frame(maxWidth: 60, maxHeight: 50)
                }
                .buttonStyle(BlueButtonStyle())
            }
        }
        .background(Color(.unemphasizedSelectedContentBackgroundColor))
        .cornerRadius(5)
    }

    private func openURL(_ string: String) {
        let url = URL(string: string)!
        if NSWorkspace.shared.open(url) {
            print("default browser was successfully opened")
        }
    }
}

struct ContentView: View {
    @State private var adaptableHeight = CGFloat(100)
    @State private var showSettings = false

    @ObservedObject private var presenter = SMCPresenter.shared

    init() {
        Helper.instance.delegate = presenter
        Helper.instance.readMaxBatteryCharge()
    }

    var body: some View {
        VStack(alignment: .leading) {

            HStack {
                Text("Max. Battery Charge:").padding(.leading)
                TextField("Number", value: Binding(
                    get: {
                        Float(presenter.value)
                    },
                    set: { newValue in
                        if newValue >= 20 && newValue <= 100 {
                            presenter.setValue(value: newValue)
                        }
                    }
                ), formatter: NumberFormatter())
                .multilineTextAlignment(.center)
                .frame(maxWidth: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())

                Spacer()

                Button(action: {
                    showSettings.toggle()
                    adaptableHeight = showSettings ? 235 : 100
                }) {
                    Text("Settings")
                        .frame(maxWidth: 70, maxHeight: 30)
                }.buttonStyle(BlueButtonStyle()).padding(.leading, -30)

                Button(action: {
                    NSApplication.shared.terminate(self)
                }) {
                    Text("Quit")
                        .frame(maxWidth: 50, maxHeight: 30)
                }.buttonStyle(RedButtonStyle()).padding(.leading, -30)
            }

            Slider(value: Binding(
                get: {
                     Float(presenter.value)
                },
                set: { newValue in
                    if newValue >= 20 && newValue <= 100 {
                        presenter.setValue(value: newValue)
                    }
                }
            ), in: 20...100).padding(.horizontal).padding(.top, -20)

            Spacer()

            if showSettings {
                Settings()
            }

        }.frame(width: 400, height: adaptableHeight)

    }
}

private final class SMCPresenter: ObservableObject, HelperDelegate {

    static let shared = SMCPresenter()

    @Published var value: UInt8 = 0
    private var timer: Timer?

    func OnMaxBatRead(value: UInt8) {
        DispatchQueue.main.async {
            if osxScale {
                self.value = value + 3
            } else {
                self.value = value
            }
        }
    }

    func setValue(value: Float) {
        DispatchQueue.main.async {
            self.value = UInt8(value)
        }
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            var setval = value
            if osxScale {
                setval -= 3
            }
            if setval >= 20 && setval <= 100 {
                print("Setting Max Battery To: ", setval)
                Helper.instance.writeMaxBatteryCharge(setVal: UInt8(setval))
                Helper.instance.readMaxBatteryCharge()
                self.timer = nil
            }

        }
    }

}
