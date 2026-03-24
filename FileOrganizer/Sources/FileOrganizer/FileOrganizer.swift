import Foundation

let fileManager = FileManager.default

print("Enter folder path:")

if let path = readLine() {
    
    do {
        let files = try fileManager.contentsOfDirectory(atPath: path)
        
        let imagesPath = path + "/Images" // create folders
        let docsPath = path + "/Documents"
        let videosPath = path + "/Videos"
        
        try? fileManager.createDirectory(atPath: imagesPath, withIntermediateDirectories: true)
        try? fileManager.createDirectory(atPath: docsPath, withIntermediateDirectories: true)
        try? fileManager.createDirectory(atPath: videosPath, withIntermediateDirectories: true)
        
        print("\nOrganizing files...\n")
        
        for file in files {
            
            let sourcePath = path + "/" + file
            
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: sourcePath, isDirectory: &isDirectory), isDirectory.boolValue {
                continue
            }
            
            let lowerFile = file.lowercased()
            
            do {
                if lowerFile.hasSuffix(".jpg") || lowerFile.hasSuffix(".png") {
                    
                    let destination = imagesPath + "/" + file
                    try fileManager.moveItem(atPath: sourcePath, toPath: destination)
                    print("Moved \(file) → Images")
                    
                } else if lowerFile.hasSuffix(".pdf") || lowerFile.hasSuffix(".txt") || lowerFile.hasSuffix(".docx") {
                    
                    let destination = docsPath + "/" + file
                    try fileManager.moveItem(atPath: sourcePath, toPath: destination)
                    print("Moved \(file) → Documents")
                    
                } else if lowerFile.hasSuffix(".mp4") || lowerFile.hasSuffix(".mkv") {
                    
                    let destination = videosPath + "/" + file
                    try fileManager.moveItem(atPath: sourcePath, toPath: destination)
                    print("Moved \(file) → Videos")
                    
                } else {
                    print("Skipped \(file)")
                }
                
            } catch {
                print("Failed to move \(file)")
            }
        }
        
        print("\nDone organizing files!")
        
    } catch {
        print("Error reading folder path")
    }
    
} else {
    print("Invalid input")
}