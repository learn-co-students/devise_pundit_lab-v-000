def build_notes
  let (:guest) {User.new(email: "guest@email.com")}
  let (:one_user) { FactoryGirl.create :user}
  let (:another_user) { FactoryGirl.create :user}
  let (:admin) { FactoryGirl.create :user, :admin }
  let (:vip) {FactoryGirl.create :user, :vip}

  let (:current_note) {Note.create(content: "current user's note", user: current_user)}
  let (:other_note) {Note.create(content: "other user's note", user: other_user)}
  let (:vipnote1) {Note.create(content: "vip's first note", user: vip)}
  let (:vipnote2) {Note.create(content: "vip's second note", user: vip)}
  let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
  let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
end