FactoryBot.define do
  factory :task do
    title { '1番目に作成したタスクのタイトル' }
    content { '1番目に作成したタスクのコンテント' }
  end
  factory :second_task, class: Task do
    title { '2番目に作成したタスクのタイトル' }
    content { '2番目に作成したタスクのコンテント' }
  end
  factory :third_task, class: Task do
    title { '最新のタスクのタイトル' }
    content { '最新のタスクの内容' }
  end
end
