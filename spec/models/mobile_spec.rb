require 'spec_helper'

describe Mobile do
  
  context 'specify fileds' do
    it { should have_db_column(:manufacturer)     }
    it { should have_db_column(:model)            }
    it { should have_db_column(:resolution)       }
    it { should have_db_column(:width)            }
    it { should have_db_column(:height)           }
    
    it { should have_many(:user_agents)           }
  end
  
end