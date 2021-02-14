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

private var allowDischarge = true

private struct Settings: View {
    @State private var launchAtLogin = LaunchAtLogin.isEnabled
    @State private var oldKey = PersistanceManager.instance.oldKey
    @ObservedObject private var presenter = SMCPresenter.shared

    var body: some View {
        VStack {
            Spacer().frame(height: 15)
            Text(presenter.status)
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
                    
                    if(!Helper.instance.appleSilicon!){
                        Toggle(isOn: Binding(
                            get: { oldKey },

                            set: { newValue in
                                oldKey = newValue
                                PersistanceManager.instance.oldKey = oldKey
                                PersistanceManager.instance.save()
                                Helper.instance.setStatusString()
                                if(newValue){
                                    Helper.instance.enableCharging()
                                    Helper.instance.enableSleep()
                                    //presenter.writeValue()
                                }
                                else{
                                    presenter.setValue(value: 100)
                                }
                            }
                        )) {
                            Text("Use Classic SMC Key (Intel)")
                        }
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
                Spacer().frame(width: 15)
                VStack(alignment: .leading) {
                    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
                    Text("AlDente \(version ?? "") 🍝").font(.headline)

                    let address = "github.com/davidwernhart/AlDente"
                    Button(action: {
                        openURL("https://" + address)
                    }) {
                        Text(address).foregroundColor(Color(.linkColor))
                    }.buttonStyle(PlainButtonStyle())

                    Text("Cooked up in 2021 by AppHouseKitchen")
//                    Text("AlDente 🍝").font(.title)
//                    Text("Keep your battery just right").font(.subheadline)
                }

                Spacer()

                Button(action: {
                    openURL("https://apphousekitchen.com/aldente/")
                }) {
                    Text("Get Pro 🍜")
                        .frame(maxWidth: 100, maxHeight: 50)
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
                    adaptableHeight = showSettings ? 275 : 100
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

public final class SMCPresenter: ObservableObject, HelperDelegate {

    static let shared = SMCPresenter()

    @Published var value: UInt8 = 0
    @Published var status: String = ""
    private var timer: Timer?
    private var accuracyTimer: Timer?

    func OnMaxBatRead(value: UInt8) {
        if(PersistanceManager.instance.oldKey){
            DispatchQueue.main.async {
                self.value = value
            }
        }
    }
    
    func updateStatus(status:String){
        DispatchQueue.main.async {
            self.status = status
        }
    }
    
    public func loadValue(){
        PersistanceManager.instance.load()
        self.value = UInt8(PersistanceManager.instance.chargeVal!)
        if(self.value == 0){
            self.value = 50
        }
        print("loaded max charge val: ",self.value," old key:",PersistanceManager.instance.oldKey)
//        if(!Helper.instance.appleSilicon!){
//            Helper.instance.getSMCCharge(withReply: { (smcval) in
//                self.value = UInt8(smcval)
//            })
//        }
        if(PersistanceManager.instance.oldKey){
            writeValue()
        }
    }

    func setValue(value: Float) {
        DispatchQueue.main.async {
            self.value = UInt8(value)
            PersistanceManager.instance.chargeVal = Int(value)
            PersistanceManager.instance.save()
            self.writeValue()
        }
        timer?.invalidate()
        accuracyTimer?.invalidate()        
    }
    
    func writeValue(){
        if(PersistanceManager.instance.oldKey){
            print("should write bclm value: ", self.value)
            Helper.instance.writeMaxBatteryCharge(setVal: self.value)
        }
    }

}
