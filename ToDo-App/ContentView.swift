//
//  ContentView.swift
//  ToDo-App
//
//  Created by Desarrollador1 on 5/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack {
                Color
                    .green.ignoresSafeArea()
                Circle()
                    .scale(1.8)
                    .foregroundColor(.white.opacity(0.20))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack {
                    Text("To Do List")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(25.0)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    NavigationLink("Añadir una tarea", destination: ToDoView())
                        .buttonStyle(.bordered)
                        .tint(.green)
                }
            }
                
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
