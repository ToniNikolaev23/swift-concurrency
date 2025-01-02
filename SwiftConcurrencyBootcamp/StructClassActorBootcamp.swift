//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Toni Stoyanov on 2.01.25.
//

/*
 
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack
 - Faster
 - Thread safe
 - When you assign or pass value type a new copy of data is created
 
 REFERENCE TYPES:
 - Class, Functions, Actor
 - Stored in the Heap
 - Slower, but synchronized
 - NOT Thread safe
 - When you assign or pass reference type a new reference to original instalce will be created (pointer)
 
 STACK:
 - Stores Value Types
 - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast
 - Each thread has its own stack
 
 HEAP:
 - Stored Reference Types
 - Shared accross threads
 
 STRUCT:
 - Based on VALUES
 - Can be mutated
 - Stored in the Stack!
 
 CLASS:
 - Based on REFERENCES (INSTANCES)
 - Stored in the Heap!
 - Inherit from other classes
 
 ACTOR:
 - Same as Class, but thread safe!
 
 Structs: Data Models, Views
 Classes: View Models
 Actors: Data Managers and Data Store
 
 
 */

import SwiftUI

struct StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
             runTest()
            }
    }
}

#Preview {
    StructClassActorBootcamp()
}

//class StructClassActorBootcampViewModel: ObservableObject {
//    @Published var title: String = ""
//}
//
//struct StructClassActorBootcampHomeView: View {
//    @StateObject private var viewModel = StructClassActorBootcampViewModel()
//    let isActive: Bool
//    var body: some View {
//        Text("Hello world")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .ignoresSafeArea()
//            .background(isActive ? Color.red : Color.blue)
//        
//    }
//}

extension StructClassActorBootcamp {
    private func runTest() {
        print("Test started")
        structTest1()
        printDivider()
        classTest1()
        printDivider()
        actorTest1()
//        structTest2()
//        classTest2()
    }
    
    private func printDivider() {
        print("""
         ----------------------
        """)
    }
    
    private func structTest1() {
        let objectA = MyStruct(title: "Starting title")
        print("Object A: ", objectA.title)
        
        print("Pass the VALUES of objectA to objectB")
        var objectB = objectA
        print("Object B: ", objectB.title)
        
        objectB.title = "Second title"
        print("ObjectB title changed")
        
        print("Object A: ", objectA.title)
        print("Object B: ", objectB.title)
    }
    
    private func classTest1() {
        let objectA = MyClass(title: "Starting title!")
        print("Object A: ", objectA.title)
        
        print("Pass the REFERENCE of objectA to objectB")
        let objectB = objectA
        print("Object B: ", objectB.title)
        
        objectB.title = "Second title"
        print("ObjectB title changed")
        
        print("Object A: ", objectA.title)
        print("Object B: ", objectB.title)
    }
    
    private func actorTest1() {
        Task {
            let objectA = MyActor(title: "Starting title!")
            await print("Object A: ", objectA.title)
            
            print("Pass the REFERENCE of objectA to objectB")
            let objectB = objectA
            await print("Object B: ", objectB.title)
            
            await objectB.updateTitle(newTitle: "Second title")
            print("ObjectB title changed")
            
            await print("Object A: ", objectA.title)
            await print("Object B: ", objectB.title)
        }
    }
}

struct MyStruct {
    var title: String
}



// Immutable struct
struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        CustomStruct(title: newTitle)
    }
}

struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    mutating func updateTitle(newTitle: String) {
        title = newTitle
    }
}


extension StructClassActorBootcamp {
    private func structTest2() {
        print("StructTest2")
        
        var struct1 = MyStruct(title: "Title1")
        print("Struct1: ", struct1.title)
        struct1.title = "Title2"
        print("Struct1: ", struct1.title)
        
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2: ", struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct2: ", struct2.title)
        
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: ", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3: ", struct3.title)
        
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: ", struct4.title)
        struct4.updateTitle(newTitle: "Title2")
        print("Struct4: ", struct4.title)
    }
}

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}

extension StructClassActorBootcamp {
    private func classTest2() {
        print("ClassTest2")
        
        let class1 = MyClass(title: "Title1")
        print("Class1 ", class1.title)
        class1.title = "Title2"
        print("Class1 ", class1.title)
        
        let class2 = MyClass(title: "Title1")
        print("Class2 ", class2.title)
        class2.updateTitle(newTitle: "Title2")
        print("Class2 ", class2.title)
    }
}
