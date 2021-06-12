import Foundation

@objc protocol Speaker {
    func Speak()
    
    @objc optional func Telljoke()
}

class Vicki: Speaker {
    func Speak() {
        print("Hello, I am Vicki!")
    }
    func Telljoke() {
        print("Q: What did Sushi A say to Sushi B?")
    }
}

class Ray: Speaker {
    func Speak() {
        print("Yo, I am Ray!")
    }
    func Telljoke() {
        print("Q: What's the object-oriented way to become wealthy?")
    }
    func WriteTutorial() {
        print("I'm on it!")
    }
}

class Animal {
    
}

class Dog : Animal, Speaker {
    func Speak() {
        print("Woof!")
    }
}

var speaker:Speaker
speaker = Ray()
speaker.Speak()
//speaker.WriteTutorial()
(speaker as! Ray).WriteTutorial()
speaker = Vicki()
speaker.Speak()
speaker.Telljoke?()
speaker = Dog()
speaker.Telljoke?()

class DateSimulator {
    let a:Speaker
    let b:Speaker
    
    init(a:Speaker, b:Speaker){
        self.a = a
        self.b = b
    }
    
    func simulate() {
        print("Off to dinner...")
        a.Speak()
        b.Speak()
        print("Walking back home...")
        a.Telljoke?()
        b.Telljoke?()
    }
}

let sim = DateSimulator(a: Vicki(), b:Ray())
sim.simulate()

protocol DateSimulatorDelegate {
    func dateSimulatorDidStart(sim:DateSimulator, a:Speaker, b:Speaker)
    func dateSimulatorDidEnd(sim:DateSimulator, a:Speaker, b:Speaker)
}

class DateSimulator {
    let a:Speaker
    let b:Speaker
}
