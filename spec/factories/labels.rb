FactoryBot.define do
  factory :label do
    name  { '家事' }

    trait :label2 do
      name  { '仕事' }
    end
    trait :label3 do
      name  { '趣味' }
    end
  end
end

