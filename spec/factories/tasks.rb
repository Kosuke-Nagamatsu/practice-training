FactoryBot.define do
  factory :task do
    title { '1番目に作成したタスクのタイトル' }
    content { '1番目に作成したタスクのコンテント' }
    time_limit { '2021-07-04 07:15:00' }
  end
  factory :second_task, class: Task do
    title { '2番目に作成したタスクのタイトル' }
    content { '2番目に作成したタスクのコンテント' }
    time_limit { '2021-07-05 09:30:00' }
  end
  factory :third_task, class: Task do
    title { '最新のタスクのタイトル' }
    content { '最新のタスクの内容' }
    time_limit { '2021-07-06 010:05:00' }
  end
end
