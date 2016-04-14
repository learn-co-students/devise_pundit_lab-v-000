def build_notes
  let (:guest) {User.new(email: "guest@email.com")}
  let (:current_user) { FactoryGirl.build_stubbed :user}
  let (:other_user) { FactoryGirl.build_stubbed :user}
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:vip) {FactoryGirl.build_stubbed :user, :vip}

  let (:current_note) {Note.create(content: "current user's note", user: current_user)}
  let (:other_note) {Note.create(content: "other user's note", user: other_user)}
  let (:vipnote1) {Note.create(content: "vip's first note", user: vip)}
  let (:vipnote2) {Note.create(content: "vip's second note", user: vip)}
  let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
  let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
end