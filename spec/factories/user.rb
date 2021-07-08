FactoryBot.define do
    # When calling auth_hash, use one of the traits listed below for a
    # facebook user, google user or when testing a user who does not
    # persist, use the does_not_persist trait.
    factory :user, class: User do |f|
        f.email {"test@user.com"}
        f.password {"testuser"}
        f.password_confirmation {"testuser"}
    end
end