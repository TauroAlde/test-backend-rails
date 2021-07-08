FactoryBot.define do
    # When calling auth_hash, use one of the traits listed below for a
    # facebook user, google user or when testing a user who does not
    # persist, use the does_not_persist trait.
    factory :auth_hash, class: OmniAuth::AuthHash do
  
      initialize_with do
        OmniAuth::AuthHash.new({
          provider: provider,
          uid: uid,
          info: {
            email: email
          }
        })
      end
  
      trait :github do
        provider {"github"}
        sequence(:uid)
        email {"testuser@github.com"}
      end
  
      trait :does_not_persist do
        email {""}
      end
  
    end
  end