FactoryBot.define do
  factory :user do
    nickname              {Faker::JapaneseMedia::OnePiece.character}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(min_alpha: 1, min_numeric: 1, number: 6)}
    password_confirmation {password}
    last_name             {Gimei.last.kanji}
    first_name            {Gimei.first.kanji}
    last_name_kana        {Gimei.last.katakana}
    first_name_kana       {Gimei.first.katakana}
    birthday              {Faker::Date.birthday(min_age: 5, max_age: 90)}
  end
end
