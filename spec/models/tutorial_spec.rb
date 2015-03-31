require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
end
