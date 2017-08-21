FactoryGirl.define do
  factory :neural_network do
    data_set	[
      [8, 12, 31, 39, 43, 45],
      [5, 10, 11, 22, 25, 27],
      [18, 19, 20, 26, 45, 49],
      [2, 11, 14, 37, 40, 45]
    ]
    game LottoGame
    norm 30
    net_error 0.01

    factory :ai4r_neural_network do
      net_type 'ai4r'
      initialize_with { new(attributes) }
    end

    factory :fann_neural_network do
      net_type 'ruby-fann'
      initialize_with { new(attributes) }
    end
  end
end
