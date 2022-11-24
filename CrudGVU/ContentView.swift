//
//  ContentView.swift
//  CrudGVU
//
//  Created by CCDM30 on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var clvobra=""
    @State var clvviga=""
    @State var longitud=""
    @State var material=""
    @State var peso=""
    
    @State var newclvobra=""
    @State var newclvviga=""
    @State var newlongitud=""
    @State var newmaterial=""
    @State var newpeso=""
    @State var seleccionado:Vigas?
    @State var prodArray=[Vigas]()
    @State var isTapped = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                
                    TextField("Obra:",text:self.$newclvobra).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                    
                  
                    TextField("Viga:",text:self.$newclvviga).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                    
                    
                    TextField("longitud:",text:self.$newlongitud).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                  
                    TextField("material:",text:self.$newmaterial).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                    TextField("peso:",text:self.$newpeso).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    Button("Save"){
                        coreDM.GuardarVigas(clvobra: newclvobra, clvviga: newclvviga, longitud: newlongitud, material: newmaterial, peso: newpeso)
                        newclvobra = ""
                        newclvviga = ""
                        newlongitud = ""
                        newmaterial = ""
                        newpeso = ""
                        mostrarProductos()
                    }
                }){
                    Text("Agregar")
                }
                List{
                    ForEach(prodArray, id: \.self){
                        viga in
                        VStack{
                            Text(viga.clvviga ?? "")
                            Text(viga.clvobra ?? "")
                            Text(viga.longitud ?? "")
                            Text(viga.material ?? "")
                            Text(viga.peso ?? "")
                        }
                        .onTapGesture{
                            seleccionado = viga
                            clvviga = viga.clvviga ?? ""
                            //seleccionado = viga
                            clvobra = viga.clvobra ?? ""
                            longitud = viga.longitud ?? ""
                            material = viga.material ?? ""
                            peso = viga.peso ?? ""
                            isTapped.toggle()
                        }
                    }.onDelete(perform: {
                        indexSet in
                        indexSet.forEach({ index in
                            let viga = prodArray[index]
                            coreDM.eliminarVigas(Viga: viga)
                            mostrarProductos()
                        })
                    })
                }.padding()
                    .onAppear(perform: {mostrarProductos()})
                
                NavigationLink("",destination:
                                VStack{
                    TextField("Obra:",text:self.$clvobra).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                    
                  
                    TextField("Viga:",text:self.$clvviga).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                    
                    
                    TextField("longitud:",text:self.$longitud).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                  
                    TextField("material:",text:self.$material).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                    TextField("peso:",text:self.$peso).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Update"){
                        seleccionado?.clvobra=clvobra
                        seleccionado?.clvviga=clvviga
                        seleccionado?.longitud=longitud
                        seleccionado?.material=material
                        seleccionado?.peso=peso
                        
                        coreDM.actualizarVigas(viga: seleccionado!)
                        clvobra=""
                        clvviga=""
                        longitud=""
                        material=""
                        peso=""
                        mostrarProductos()
                    }
                },isActive: $isTapped)
            }
        }
    }
    
    func mostrarProductos(){
        prodArray = coreDM.ConsultarVigas()
    }
}
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
