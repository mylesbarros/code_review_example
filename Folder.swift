class Task {
    let title: String = ""
    let date: Date = Date()
}
 
protocol FolderDelegate {
    func didSave(_ folder: Folder)
}
 
class Folder {
    var delegate: FolderDelegate?
    var tasks: [Task]!
    
    func getTitleForThisFolder() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        
        if tasks.count != 0 {
            return tasks[0].title + formatter.string(from: tasks[0].date)
        } else { return nil }
    }
    
    func getTasksForPageNumber(_ number: Int) -> [Task] {
        var result: [Task] = []
        while result.count < 10 {
            result.append(tasks[number*10])
        }
        
        return result
    }
    
    func save() {
        try? Database.shared.write {
            self.delegate?.didSave(self)
        }
    }
}

