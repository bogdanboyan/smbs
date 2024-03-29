require 'spec_helper'

describe MobileCampaign do
  
  # specify model members
  it { should have_db_column(:document_model)           }
  it { should have_db_column(:title)                    }
  
  it { should belong_to(:account)                       }
  it { should belong_to(:user)                          }
  it { should belong_to(:short_url)                     }
  
  it { should have_many(:like_its)                      }
  
  it { should have_and_belong_to_many(:asset_files)     }
  
  it { should have_db_index(:account_id)                }
  it { should have_db_index(:user_id)                   }
  it { should have_db_index(:short_url_id)              }
  it { should have_db_index(:current_state)             }
  
  describe "with assets" do
    
    before(:each) do
      @mobile_campaign = Factory.create(:mobile_campaign)
    end
    
    specify "image assignments" do
      
      @mobile_campaign.asset_files.only_images.should have(1).item
      
      [
        { :asset_file_name => 'first image',  :asset_content_type => 'image/gif', :asset_file_size => 10 },
        { :asset_file_name => 'second image', :asset_content_type => 'image/gif', :asset_file_size => 10 },
      ].each { |asset_params| @mobile_campaign.asset_files << ImageAsset.create(asset_params) }
      
      @mobile_campaign.reload
      
      @mobile_campaign.asset_files.only_images.should have(3).items
      @mobile_campaign.asset_files.only_images.first.should be_instance_of(ImageAsset)
    end
  end
  
  describe "with document model" do
    it 'should truncate invalid document model' do
      MobileCampaign.new.sanitize([
        { 
          'type'  => 'header',
          'value' => 'sanizided model'
        }, {
          'type'  => 'text',
          'value' => nil
        }, {
          'type'  => 'unknown',
          'value' => 'abcd'
        }, {
          'unknown' => 'type',
        }, {
          'type'  => 'images',
        }, {
          'type'  => 'images',
          'value' => 'unknown',
        }, {
          'type'  => 'images',
          'value' => []
        }, {
          'type'  => 'header',
          'value' => ""
        }
      
      ]).should == [{'type' => 'header', 'value' => 'sanizided model'}]
    end

    context 'with valid document model' do
      [
        {
            :title => 'Untitled 2010-08-28',
            :document_model => '[{"type":"images","value":[{"width":"101px","asset_id":"7","style":"view","path":"/asset/image/7/view/1282996485.3278.jpg"},{"width":"101px","asset_id":"8","style":"view","path":"/asset/image/8/view/1282996546.43506.jpg"},{"width":"101px","asset_id":"9","style":"view","path":"/asset/image/9/view/1282996564.32426.jpg"}]},{"type":"text","value":"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},{"type":"header","value":"Updated content"},{"type":"images","value":[{"width":"194px","asset_id":"8","style":"view","path":"/asset/image/8/view/1282996546.43506.jpg"},{"width":"194px","asset_id":"7","style":"view","path":"/asset/image/7/view/1282996485.3278.jpg"},{"width":"194px","asset_id":"9","style":"view","path":"/asset/image/9/view/1282996564.32426.jpg"}]}]'
        }
      ].each do |attributes|
        it "should validate and create a new instance for: #{attributes[:title]}" do
          MobileCampaign.create!(attributes)
        end
      end
    end
  
    context 'with invalid document model' do
      [
        {
          :title => 'Invalid mobile campaign',
          :document_model => '[{"type":"images","value":[{"asset_id":"7","style":"view","path":"/asset/image/7/view/1282996485.3278.jpg"},{"width":"101px","asset_id":"8","style":"view","path":"/asset/image/8/view/1282996546.43506.jpg"},{"width":"101px","asset_id":"9","style":"view","path":"/asset/image/9/view/1282996564.32426.jpg"}]},{"type":"text","value":"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},{"type":"header","value":"Updated content"},{"type":"images","value":[{"width":"194px","asset_id":"8","style":"view","path":"/asset/image/8/view/1282996546.43506.jpg"},{"width":"194px","asset_id":"7","style":"view","path":"/asset/image/7/view/1282996485.3278.jpg"},{"width":"194px","asset_id":"9","style":"view","path":"/asset/image/9/view/1282996564.32426.jpg"}]}]'
        }, {
          :title => 'Invalid mobile campaign',
          :document_model => '[{"type":"header","value":""},{"type":"images","value":[]}]'
        }, {
          :title => 'Invalid mobile campaign',
          :document_model => '[]'
        }
      ].each do |attributes|
        it "should not create a new instance for: #{attributes[:title]}" do
          -> { MobileCampaign.create!(attributes) }.should raise_error
        end
      end
    end
  end
  
  describe "with AASM" do
    
    context "by default" do
      
      before(:all) do
        @mbc = Factory.create(:mobile_campaign)
      end
      
      it { @mbc.should be_draft         }
      it { @mbc.should_not be_published }
      it { @mbc.should_not be_pending   }
      it { @mbc.should_not be_archived  }
      
      specify "state transition" do
        @mbc.request_approve!; @mbc.should be_pending
        @mbc.cancel_response!; @mbc.should be_draft
        
        @mbc.request_approve!; @mbc.should be_pending
        @mbc.publish!; @mbc.should be_published
        
        @mbc.unpublish!; @mbc.should be_pending
        @mbc.archive!; @mbc.should be_archived
      end
    
    end # end context
    
    context "by linked proxied short_url" do
      
      before(:all) do
        # TODO investigate!!
        AssetFile.destroy_all; MobileCampaign.destroy_all
        
        @mbc           = Factory.create(:mobile_campaign, :short_url => @short_url)
        @short_url     = Factory.create(:short_url)
        @mbc.short_url = @short_url
        @mbc.save!
      end
      
      it { @short_url.should be_pending; @short_url.should_not be_proxied }
      
      specify "state transition" do
         @mbc.request_approve!; @mbc.should be_pending
         @mbc.publish!; @mbc.should be_published; @mbc.short_url.should be_proxied
         @mbc.unpublish!; @mbc.should be_pending; @mbc.short_url.should be_pending
         @mbc.archive!; @mbc.should be_archived; @mbc.short_url.should be_pending
      end
      
    end # end context
    
    context "by linked pending short_url" do
      
      before(:all) do
        # TODO investigate!!
        AssetFile.destroy_all; MobileCampaign.destroy_all; ShortUrl.destroy_all
        
        @short_url = Factory.create(:short_url)
        @short_url.disable!
        
        @mbc       = Factory.create(:mobile_campaign, :short_url => @short_url)
      end
      
      it { @short_url.should be_pending }
      
      specify "state transition" do
        @mbc.request_approve!; @mbc.should be_pending
        @mbc.publish!; @mbc.should be_published; @mbc.short_url.should be_proxied
        @mbc.unpublish!; @mbc.should be_pending; @mbc.short_url.should be_pending
        @mbc.archive!; @mbc.should be_archived; @mbc.short_url.should be_pending
      end
      
    end # end context
    
  end #end AASM describe
  
  describe "dashboardable" do
    
    before(:all) { @mobile_campaign = MobileCampaign.new }
    
    it { @mobile_campaign.should be_kind_of(Dashboardable) }
    
    specify "update_dashboard with invalid transition" do
      -> { @mobile_campaign.assert_transition_key(:yo!) }.should raise_error(RuntimeError)
    end
    
    specify "update_dashboard with valid transition" do
      -> { @mobile_campaign.assert_transition_key(:page_created)          }.should_not raise_error
      -> { @mobile_campaign.assert_transition_key(:content_changed)       }.should_not raise_error
      -> { @mobile_campaign.assert_transition_key(:short_url_assigned)    }.should_not raise_error
      -> { @mobile_campaign.assert_transition_key(:short_url_generated)   }.should_not raise_error
      -> { @mobile_campaign.assert_transition_key(:page_published)        }.should_not raise_error
      -> { @mobile_campaign.assert_transition_key(:page_drafted)          }.should_not raise_error
      -> { @mobile_campaign.assert_transition_key(:page_unpublished)      }.should_not raise_error
    end
    
  end
  
end