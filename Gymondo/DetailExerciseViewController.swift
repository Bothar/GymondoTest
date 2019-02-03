import UIKit

class DetailExerciseViewController: BaseViewController {
    
    @IBOutlet weak var exerciseImageView: UIImageView! {
        didSet {
            exerciseImageView.image = exercice.image
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = exercice.name
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = exercice.description?.htmlToString
        }
    }
    
    @IBOutlet weak var equipmentTitleLabel: UILabel! {
        didSet {
            if exercice.equipment.count == 0 {
                equipmentTitleLabel.isHidden = true
            } else {
                equipmentTitleLabel.text = .equipmentTitle
            }
        }
    }
    
    @IBOutlet weak var equipmentValueLabel: UILabel! {
        didSet {
            equipmentValueLabel.text = exercice.equipmentStringList
        }
    }
    
    @IBOutlet weak var musclesTitleLabel: UILabel! {
        didSet {
            if exercice.muscles.count == 0 {
                musclesTitleLabel.isHidden = true
            } else {
                musclesTitleLabel.text = .musclesTitle
            }
        }
    }
    
    @IBOutlet weak var musclesValueLabel: UILabel! {
        didSet {
            musclesValueLabel.text = exercice.musclesStringList
        }
    }
    
    var exercice: Exercise!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleNavigationBar(title: exercice.category!)
    }
}
