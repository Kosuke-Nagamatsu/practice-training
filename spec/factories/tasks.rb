FactoryBot.define do
  factory :task do
    title { '1番目に作成したタスクのタイトル' }
    content { '1番目に作成したタスクのコンテント' }
    time_limit { '2021-07-10 07:15:00' }
    status { '未着手' }
    priority { '高' }
  end
  factory :second_task, class: Task do
    title { '2番目に作成したタスクのタイトル' }
    content { '2番目に作成したタスクのコンテント' }
    time_limit { '2021-07-11 09:30:00' }
    status { '着手中' }
    priority { '中' }
  end
  factory :third_task, class: Task do
    title { '最新のタスクのタイトル' }
    content { '最新のタスクの内容' }
    time_limit { '2021-07-12 010:05:00' }
    status { '完了' }
    priority { '低' }
  end
end
