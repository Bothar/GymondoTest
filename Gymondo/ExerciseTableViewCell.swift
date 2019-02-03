import UIKit

class ExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var equipmentTitleLabel: UILabel! {
        didSet {
            equipmentTitleLabel.text = .equipmentTitle
        }
    }
    
    @IBOutlet weak var equipmentValueLabel: UILabel!
    
    @IBOutlet weak var muscleTitleLabel: UILabel! {
        didSet {
            muscleTitleLabel.text = .musclesTitle
        }
    }
    
    @IBOutlet weak var muscleValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
