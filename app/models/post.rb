class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 } 
    validates :summary, length: { maximum: 250 } 
    validates :category, inclusion: { in: %w(Fiction Non-Fiction), message: "Not a valid category" }
    validate :title_not_clickbaity_enough

    def title_not_clickbaity_enough
        #binding.pry
       if title
            click_bait = ["Won't Believe", "Secret", "Top [number]", "Guess"]
            #binding.pry
            result = click_bait.any? do |phrase|
                self.title.include?(phrase) 
            end
            if !result
                errors.add(:title, "not click-baity enough")
            end
        end
    end

end
