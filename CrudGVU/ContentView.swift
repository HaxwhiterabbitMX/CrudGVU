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
    
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                    TextField("clvobra:",text: self.$newclvobra).multilineTextAlignment(.center)
                    TextField("clvviga:",text: self.$newclvviga).multilineTextAlignment(.center)
                    TextField("longitud:",text:self.$newlongitud).multilineTextAlignment(.center)
                    TextField("material:",text: self.$newmaterial).multilineTextAlignment(.center)
                    TextField("peso:",text: self.$newpeso).multilineTextAlignment(.center)
                    
                    Button("Save"){
                        coreDM.GuardarVigas(clvobra: newclvobra, clvviga: newclvviga, longitud: newlongitud, material: newmaterial, peso: newpeso)
                        newclvobra = ""
                        newclvviga = ""
                        newlongitud = ""
                        newmaterial = ""
                        newpeso = ""
                        ConsultarVigas()
                    }
                }){
                    Text("Agregar")
                }
            }
        }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
