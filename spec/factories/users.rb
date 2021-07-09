FactoryBot.define do
  factory :user do
    name { "一般ユーザ" }
    email { "user@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { "なし" }
  end
  factory :second_user, class: User do
    name { "管理者" }
    email { "admin@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { "あり" }
  end
end
