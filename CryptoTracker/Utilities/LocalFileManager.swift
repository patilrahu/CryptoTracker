//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Apple on 22/10/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    private init() {}
    
    func saveImage(image:UIImage,imageName: String, folderName: String) {
        
        createFolderNeeded(folderName: folderName)
        
        guard let data  = image.pngData(),let url = getURlForImage(imageName: imageName, folderName: folderName) else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print("ERROR SAVING IMAGE: \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)
        else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderNeeded(folderName: String) {
        guard let url = getURlForFolder(folderName: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("ERROR CREATING FOLDER: \(error)")
            }
        }
    }
    
    private func getURlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    
    private func getURlForImage(imageName: String,folderName: String) -> URL? {
        guard let folderURL = getURlForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
