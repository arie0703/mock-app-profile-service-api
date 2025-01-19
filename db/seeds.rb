5.times do |n|
  Organization.create!(
    name: "株式会社テスト#{n + 1}",
  )
end

Organization.all.each do |o|
  o.members.create!(
    name: "TEST#{o.id}",
    email: "test-#{o.id}@test.com",
    password: "hoge",
  )
end
