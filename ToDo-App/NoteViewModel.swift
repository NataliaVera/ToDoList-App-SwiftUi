//
//  NoteViewModel.swift
//  ToDo-App
//
//  Created by Desarrollador1 on 5/08/22.
//

import Foundation
import SwiftUI

class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] = [] // para que se refresque la informacion
    
    init(){
        notes = getAllNotes()
    }
    
    func saveNote(description: String){
        let newNote = NoteModel(description: description) // instancia de nuestro modelo
        notes.insert(newNote, at: 0) // position 0
        encodeAndSaveAllNotes()
    }
    
    private func encodeAndSaveAllNotes(){
        if let enconded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(enconded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel]{
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data{
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
            }
        }
        return []
    }
    
    //remove note }
    func removeNote(with id: String){
        notes.removeAll(where: {$0.id == id})
        encodeAndSaveAllNotes()
    }
    
    //actualizar nota
    func updateFavoriteNote(note: Binding<NoteModel>){
        note.wrappedValue.isFavorited = !note.wrappedValue.isFavorited
        encodeAndSaveAllNotes()
    }
}
