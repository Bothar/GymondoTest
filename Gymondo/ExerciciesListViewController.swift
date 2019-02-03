import UIKit

class ExerciciesListViewController: UIViewController {
    
    @IBOutlet weak var exerciciesTableView: UITableView! {
        didSet {
            exerciciesTableView.delegate = self
            exerciciesTableView.dataSource = self
        }
    }
    
    let session = Session.shared
    var exerciciesList: [Exercise] = []
    var page: Int = 0
    var selectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestNewExercicies()
    }
    
    private func requestNewExercicies() {
        self.page += 1
        session.fetchNewExercicies(atPage: page) { [weak self] err, execices in
            guard let weakSelf = self else {return}
            if err != nil {
                AlertView.showAlert(view: weakSelf, title: .errorTitle, message: err!.localizedDescription, buttonOk: .okButton)
            }
            weakSelf.exerciciesList += execices
            weakSelf.exerciciesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.kSEGUE_DETAIL {
            let nextVC = segue.destination as! DetailExerciseViewController
            nextVC.exercice = exerciciesList[selectedCell]
        }
    }
}

extension ExerciciesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exerciciesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCELL_EXERCISE_ID) as! ExerciseTableViewCell
        
        let exercisie = exerciciesList[indexPath.row]
        
        cell.nameLabel.text = exercisie.name
        cell.categoryLabel.text = exercisie.category
        cell.exerciseImageView.image = exercisie.image
        
        //Check if has to display equipment
        if exercisie.equipment.count > 0 {
            cell.equipmentTitleLabel.isHidden = false
            cell.equipmentValueLabel.isHidden = false
            cell.equipmentValueLabel.text = exercisie.equipmentStringList
        } else {
            cell.equipmentTitleLabel.isHidden = true
            cell.equipmentValueLabel.isHidden = true
        }
        
        //Check if has to display muscles
        if exercisie.muscles.count > 0 {
            cell.muscleTitleLabel.isHidden = false
            cell.muscleValueLabel.isHidden = false
            cell.muscleValueLabel.text = exercisie.musclesStringList
            
        } else {
            cell.muscleTitleLabel.isHidden = true
            cell.muscleValueLabel.isHidden = true
        }
         
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        
        //Check if its the last row and has to load new exercices
        if indexPath.row == lastRowIndex {
            
            self.requestNewExercicies()

            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCell = indexPath.row
        self.performSegue(withIdentifier: Constants.kSEGUE_DETAIL, sender: nil)
    }
    
    
}



