class Univ < ApplicationRecord
    # cancancan 적용
    resourcify
    
    acts_as_commentable
end
