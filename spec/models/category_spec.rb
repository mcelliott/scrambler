require 'rails_helper'

describe Category, type: :model do
  it { should respond_to :name  }
  it { should respond_to :category_type  }
  it { should respond_to :enabled  }
  it { should respond_to :display_name  }
  it { should respond_to :teams }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category_type) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_inclusion_of(:category_type).in_array(CategoryType.list)  }

  it { should have_many(:teams) }
end
