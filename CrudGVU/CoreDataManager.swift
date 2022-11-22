//
//  CoreDataManager.swift
//  CrudGVU
//
//  Created by CCDM30 on 17/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistenContainer: NSPersistentContainer
    
    init(){
        persistenContainer = NSPersistentContainer(name: "Vigas")
        persistenContainer.loadPersistentStores(completionHandler: {
            (descripcion,error) in
            if let error = error{
                fatalError("Error en el CoreData\(error.localizedDescription)")
            }
        })
    }
    
    func GuardarVigas(clvobra:Int32,clvviga:Int32,longitud:Int32,material:String,peso:Int32){
        let viga = Vigas(context: persistenContainer.viewContext)
        viga.clvobra = clvobra
        viga.clvviga = clvviga
        viga.longitud = longitud
        viga.material = material
        viga.peso = peso
        do{
            try persistenContainer.viewContext.save()
            print("producto guardado")
        }catch{
            print("failed to save error")
        }
    }
    
    func ConsultarVigas()-> [Vigas]{
        let fetchRequest: NSFetchRequest<Vigas> = Vigas.fetchRequest()
            do{
                return try persistenContainer.viewContext.fetch(fetchRequest)
            }catch{
                return []
        }
    }
    
    func eliminarVigas(Viga: Vigas){
            persistenContainer.viewContext.delete(Viga)

           do{
               try persistenContainer.viewContext.save()
           }catch{
               persistenContainer.viewContext.rollback()
               print("Failed to save context")
           }
       }
    
    func actualizarVigas(viga: Vigas){
         let fetchRequest: NSFetchRequest<Vigas> = Vigas.fetchRequest()
         let predicate = NSPredicate(format: "clvviga = %@", viga.clvviga ?? "")
         fetchRequest.predicate = predicate


         do{
             let datos = try persistenContainer.viewContext.fetch(fetchRequest)
             let p = datos.first
             p?.clvobra = viga.clvobra
             p?.clvviga = viga.clvviga
             p?.longitud = viga.longitud
             p?.material = viga.material
             p?.peso = viga.peso
             //Segui asi con los demas atributos
             try persistenContainer.viewContext.save()
             print("mobilaria guardada")
         }catch{
             print("failed to save error en \(error)")
         }
     }
    
    func leerViga(clvviga: Int32) -> Vigas?{
          let fetchRequest: NSFetchRequest<Vigas> = Vigas.fetchRequest()
          let predicate = NSPredicate(format: "clvviga = %@", clvviga)
          fetchRequest.predicate = predicate
          do{
              let datos = try persistenContainer.viewContext.fetch(fetchRequest)
              return datos.first
          }catch{
              print("failed to save error en \(error)")
          }
          return nil
      }
    
    
    
}
