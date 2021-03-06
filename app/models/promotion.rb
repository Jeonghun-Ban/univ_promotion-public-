class Promotion < ApplicationRecord
    # 투표 Gem 관련
    acts_as_votable
    
    acts_as_commentable
    
    # 해시태그 DB 모델관계 설정
    has_and_belongs_to_many :ptags
    
    after_create do
        post = Promotion.find_by(id: self.id)
        hashtags = self.univ_hashtag.scan(/[#＃][a-z|A-Z|가-힣|0-9|\w]+/)
        hashtags.uniq.map do |hashtag|
            tag = Ptag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.ptags << tag
        end
    end
    
    before_update do
        post = Promotion.find_by(id: self.id)
        post.promotion_tags.clear
        hashtags = self.univ_hashtag.scan(/[#＃][a-z|A-Z|가-힣|0-9|\w]+/)
        hashtags.uniq.map do |hashtag|
            tag = Ptag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.ptags << tag
        end
    end
end
