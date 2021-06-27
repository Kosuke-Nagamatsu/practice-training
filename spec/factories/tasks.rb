FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
  end
  factory :second_task, class: Task do
    title { 'Factoryのタイトル１' }
    content { 'Factoryのコンテント１' }
  end
  factory :third_task, class: Task do
    title { 'Factoryのタイトル２' }
    content { 'Factoryのコンテント２' }
  end
end
