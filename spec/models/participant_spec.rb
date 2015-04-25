require 'rails_helper'

describe Participant do
  it { should respond_to :name  }
  it { should respond_to :category    }
  it { should respond_to :flyer       }
  it { should respond_to :event       }
end
