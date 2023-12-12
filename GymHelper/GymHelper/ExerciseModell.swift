//
//  ExerciseModell.swift
//  GymHelper
//
//  Created by Mubarız Ahmadov on 12.12.2023.
//

import Foundation

class ExerciseClass: ObservableObject {
    @Published var exercises: [Exercise] = []

    init() {
        loadExercises()
    }

    func addExercise(name: String, reps: String, sets: String, weight: String) {
        let newExercise = Exercise(name: name, reps: reps, sets: sets, weight: weight)
        exercises.append(newExercise)
        saveExercises()
    }

    func clearExercises() {
        exercises.removeAll()
        saveExercises()
    }

    func saveExercises() {
        if let encodedData = try? JSONEncoder().encode(exercises) {
            UserDefaults.standard.set(encodedData, forKey: "exercises")
        }
    }


    func loadExercises() {
        if let encodedData = UserDefaults.standard.data(forKey: "exercises"),
           let decodedExercises = try? JSONDecoder().decode([Exercise].self, from: encodedData) {
               exercises = decodedExercises
        }
    }

}

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var reps: String
    var sets: String
    var weight: String
}
