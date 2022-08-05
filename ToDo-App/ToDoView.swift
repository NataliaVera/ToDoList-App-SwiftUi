//
//  ToDoView.swift
//  ToDo-App
//
//  Created by Desarrollador1 on 5/08/22.
//

import SwiftUI

struct ToDoView: View {
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach($notesViewModel.notes, id: \.id){ $note in
                        HStack{
                            if note.isFavorited{
                                Text("♥️")
                            }
                            Text(note.description)
                        }
                        .swipeActions(edge: .trailing){
                            Button{
                                notesViewModel.updateFavoriteNote(note: $note)
                            }label: {
                                Label("Favorito", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading){
                            Button{
                                notesViewModel.removeNote(with: note.id)
                            }label: {
                                Label("Eliminar", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                    }
                }
                Text("Crear tarea")
                    .padding(.horizontal, 16)
                CustomTextEditor.init(placeholder: "Añade una tarea", text: $descriptionNote)
                    .foregroundColor(.gray)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.green, lineWidth: 3)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(3.0)
                Button("Crear"){
                    notesViewModel.saveNote(description: descriptionNote)
                    descriptionNote = ""
                }
                .buttonStyle(.bordered)
                .tint(.green)
                Spacer()
                
            }
            .navigationTitle("ToDo List")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CustomTextEditor: View{
    let placeholder: String
    @Binding var text: String
    let internalPadding: CGFloat = 5 //CGFloat -> tipo de dato en Swift utilizado en las vistas
    var body: some View{
        ZStack(alignment: .topLeading){
            if text.isEmpty{
                Text(placeholder)
                    .foregroundColor(.gray.opacity(0.25))
                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
                    .padding(internalPadding)
            }
            TextEditor(text: $text)
                .padding(internalPadding)
        }.onAppear(){
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear(){
            UITextView.appearance().backgroundColor = nil
        }
    }
    
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
