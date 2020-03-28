# TIVA C IDE
## Introduction
TIVA C IDE is an Auto-Generated-Code IDE designed for TIVA C Microcontroller to generate drivers through configrations.
used technologies **Qt,QML,C++**

## GUI

![tiva](https://user-images.githubusercontent.com/35613645/77140580-b8fb6f80-6a82-11ea-9f31-d8b5b8ef6bdd.png)

## Design 
### Class Diagram
![class_diagram](https://user-images.githubusercontent.com/35613645/77140584-bd278d00-6a82-11ea-8886-f74295aed574.png)

### Design Principles
- **Adapter Pattern** is used to abstract the communication's conversion between controller & generators classes
- **Program to Interface Principle** is achived through polymorphism, the controller deal with generators through an abstract one and dosn't care about its kind, the generator functionality is assigned @ runtime
- **Open-Closed Principle** is achived, a new generator class can be added without modifying(or even reading) controller & the main flow through the polymorphism & interfaces, so it is open for extentions but closed for modifications

### Sequence Diagram
![sequence_diagram](https://user-images.githubusercontent.com/35613645/77140586-be58ba00-6a82-11ea-98d1-4aea3331fc25.png)
