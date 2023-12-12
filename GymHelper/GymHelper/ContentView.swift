//
//  ContentView.swift
//  GymHelper
//
//  Created by Mubarız Ahmadov on 12.12.2023.
//

import SwiftUI


struct exercise: Identifiable{
    var id = UUID()
    var name: String
    var reps: String
    var sets: String
    var weight: String
}


struct ContentView: View {
    @State private var name: String = ""
    @State private var reps: String = ""
    @State private var sets: String = ""
    @State private var weight: String = ""
    @ObservedObject var ExerciseData = ExerciseClass()

    var body: some View {
        
        ZStack{
            NavigationView{

                       Form{
                           
                           Section(header: Text("Exercise Information")) {
                               TextField("Name", text: $name)
                               TextField("Reps", text: $reps)
                               TextField("Sets", text: $sets)
                               TextField("Weight", text: $weight)

                           }
                           Section {
                                       Button("Add Exercise") {
                                           ExerciseData.addExercise(name: name, reps: reps, sets: sets, weight: weight)
                                               name = ""
                                               reps = ""
                                               sets = ""
                                               weight = ""
                                               }
                                           }
                           Section(header: Text("Exercise List")) {
                                               ForEach(ExerciseData.exercises) { exercise in
                                                   Text("\(exercise.name), \(exercise.reps), \(exercise.sets), \(exercise.weight)")
                                               }
                                           }
                           Button("Clear the List"){
                               ExerciseData.clearExercises()
                           }
                           Button("Save the Data"){
                               ExerciseData.saveExercises()
                           }
                           Button("Upload the Data"){
                               ExerciseData.loadExercises()
                           }
                           
                       }
                       .background(Color(hex: "092635"))
                       .navigationTitle("Add Exercise ")
                   }
        }
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
