FactoryBot.define do
  factory :task do
    title { '1番目に作成したタスクのタイトル' }
    content { '1番目に作成したタスクのコンテント' }
    time_limit { '2021-07-10 07:15:00' }
    status { '未着手' }
    priority { '高' }

    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
end
