//
//  ContentView.swift
//  AlDente
//
//  Created by David Wernhart on 09.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import SwiftUI
import ServiceManagement
import Foundation
import LaunchAtLogin
import Combine

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
            .background(configuration.isPressed ? Color.white : Color.blue)
            .cornerRadius(6.0)
            .padding()
    }
}

struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.red : Color.white)
            .background(configuration.isPressed ? Color.white : Color.red)
            .cornerRadius(6.0)
            .padding()
    }
}

var osxScale:Bool = true

struct settings<Content: View>: View {
    
    
    var content: () -> Content
    @State var launchOnLogin = LaunchAtLogin.isEnabled
    @State var osxScaleToggle = osxScale
    @ObservedObject var presenter = SMCPresenter.shared


    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
        
        //Helper.instance.delegate = self
    }

    var body: some View {
        VStack(alignment: .center){
            HStack(alignment: .center) {
                Toggle(isOn: Binding(
                    get: {
                        self.launchOnLogin
                    },
                    set: {(newValue) in
                          self.launchOnLogin  = newValue
                        if(newValue){
                            print("launch on login turned on!")
                            LaunchAtLogin.isEnabled = true
                        }
                        else{
                            print("launch on login turned off!")
                            LaunchAtLogin.isEnabled = false
                        }
                    }
                )) {
                    Text("Launch on Login")
                }.padding()
                
                Toggle(isOn: Binding(
                    get: {
                        self.osxScaleToggle
                    },
                    set: {(newValue) in
                        self.osxScaleToggle = newValue
                        osxScale = newValue
                        self.presenter.setValue(value: Float(self.presenter.value))
                    }
                )) {
                    Text("Use macOS battery scale")
                }.padding()
                
                Spacer()
                Button( action: {
                        Helper.instance.installHelper()
                    }
                ) {
                    Text("Reinstall Helper")
                        .frame(maxWidth: 120, maxHeight: 30)
                }.buttonStyle(BlueButtonStyle())
            }

            
            HStack(alignment: .center) {
                Spacer()
                VStack(alignment: .leading){
                    Text("AlDente 1.2 🍝").font(.subheadline)
                    Button(action:{
                        let url = URL(string: "https://www.github.com/davidwernhart/AlDente")!
                        if NSWorkspace.shared.open(url) {
                            print("default browser was successfully opened")
                        }
                    }){
                        Text("github.com/davidwernhart/AlDente").foregroundColor(Color.blue)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Text("Created with 🤍 by David Wernhart in 2020")
//                    Text("AlDente 🍝").font(.title)
//                    Text("Keep your battery just right").font(.subheadline)
                }
                Spacer()
                Button(action: {
                    let url = URL(string: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6PLR7D9ZCZGGC&source=url")!
                    if NSWorkspace.shared.open(url) {
                        print("default browser was successfully opened")
                    }
                }) {
                    Text("Donate")
                        .frame(maxWidth: 60, maxHeight: 50)
                }
                .buttonStyle(BlueButtonStyle())
            }
        }.background(Color("SettingsColor")).cornerRadius(5)
    }
}

struct ContentView: View{
    @State var adaptableHeight = CGFloat(100)
    @State var showSettings = false
    
    @ObservedObject var presenter = SMCPresenter.shared
    
    init() {
        Helper.instance.delegate = presenter
        Helper.instance.readMaxBatteryCharge()
    }
    
    
    
    var body: some View {
        let vstack = VStack{
            VStack(alignment: .leading) {
                //Text("Value is: \(presenter.value)")
                HStack(alignment: .center){
                    Text(" Max. Battery Charge:").padding(.leading)
                    TextField("Number", value: Binding(
                           get: {
                                Float(self.presenter.value)
                           },
                           set: {(newValue) in
                            if(newValue >= 20 && newValue <= 100){
                                self.presenter.setValue(value: newValue)
                            }
                           }
                       ), formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .frame(maxWidth:50)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Spacer()
                    Button( action: {
                        self.showSettings = !self.showSettings
                        if(self.showSettings){
                            self.adaptableHeight = 235
                        }
                        else{
                            self.adaptableHeight = 100
                        }
                    }) {
                        Text("Settings")
                            .frame(maxWidth: 70, maxHeight: 30)
                    }.buttonStyle(BlueButtonStyle()).padding(.leading,-30)
                    
                    Button( action: {
                        NSApplication.shared.terminate(self)
                    }) {
                        Text("Exit")
                            .frame(maxWidth: 50, maxHeight: 30)
                    }.buttonStyle(RedButtonStyle()).padding(.leading,-30)
                }
                
                
                HStack(alignment: .center){
                    
                    Slider(value: Binding(
                        get: {
                             Float(self.presenter.value)
                        },
                        set: {(newValue) in
                         if(newValue >= 20 && newValue <= 100){
                             self.presenter.setValue(value: newValue)
                            }
                        }
                    ), in: 20...100).padding(.horizontal).padding(.top,-20)
                }
                
                Spacer()
                if(self.showSettings){
                    //settings{Text("")}
                    settings({Text("")})
                }
                
            }.frame(width: 400, height: adaptableHeight)
            
        }
        
        return vstack
    }
}

class SMCPresenter: ObservableObject, HelperDelegate{
    
    static let shared = SMCPresenter()
    
    @Published var value: UInt8 = 0
    private var timer: Timer?
    
    func OnMaxBatRead(value: UInt8){
        DispatchQueue.main.async {
            if(osxScale){
                self.value = value + 3
            }
            else{
                self.value = value
            }
        }
    }
    
    func setValue(value: Float){
        DispatchQueue.main.async {
            self.value = UInt8(value)
        }
        self.timer?.invalidate()

        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            var setval = value
            if(osxScale){
                setval -= 3
            }
            if(setval >= 20 && setval <= 100){
                print("Setting Max Battery To: ",setval)
                Helper.instance.writeMaxBatteryCharge(setVal: UInt8(setval))
                Helper.instance.readMaxBatteryCharge()
                self.timer = nil
            }
            
        })
    }

}

