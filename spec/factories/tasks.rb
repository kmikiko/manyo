FactoryBot.define do
  factory :task do
    name { |i| "test_name#{i}" }
    detail { |i| "test_detail#{i}" }
    from = Date.parse("2023/07/01")
    to   = Date.parse("2023/12/31")
    expired_at { Random.rand(from..to) }
    status {['完了', '着手中', '未着手'].sample}
    association :user

    # trait :with_label1 do
    #   name {'家事'}
    # end

    # trait :with_label2 do
    #   name {'仕事'}
    # end

    # trait :with_label3 do
    #   name {'趣味'}
    # end

    # label {create(:label, name: name)}
    trait :with_label do
      after(:build) do |task|
        labels = [
          Label.first || create(:label),
          Label.second || create(:label, :label2),
          Label.third || create(:label, :label3)
        ]
          task.labellings << build(:labelling, task: task, label: labels[0])
      end
    end
    trait :with_label2 do
      after(:build) do |task|
        labels = [
          Label.first || create(:label),
          Label.second || create(:label, :label2),
          Label.third || create(:label, :label3)
        ]
          task.labellings << build(:labelling, task: task, label: labels[1])
      end
    end
    trait :with_label3 do
      after(:build) do |task|
        labels = [
          Label.first || create(:label),
          Label.second || create(:label, :label2),
          Label.third || create(:label, :label3)
        ]
          task.labellings << build(:labelling, task: task, label: labels[2])
      end
    end
  end
  
end
