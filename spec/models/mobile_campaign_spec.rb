require 'spec_helper'

describe MobileCampaign do
  
  it { should have_db_column(:document_model) }
  it { should have_db_column(:title)          }
  it { should belong_to(:short_url)           }
  it { should have_many(:image_assets)        }
  
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
          :title => 'Valid mobile campaign',
          :document_model => '[{"type":"images","value":[{"asset_id":"7","style":"view","path":"/asset/image/7/view/1282996485.3278.jpg"},{"width":"101px","asset_id":"8","style":"view","path":"/asset/image/8/view/1282996546.43506.jpg"},{"width":"101px","asset_id":"9","style":"view","path":"/asset/image/9/view/1282996564.32426.jpg"}]},{"type":"text","value":"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},{"type":"header","value":"Updated content"},{"type":"images","value":[{"width":"194px","asset_id":"8","style":"view","path":"/asset/image/8/view/1282996546.43506.jpg"},{"width":"194px","asset_id":"7","style":"view","path":"/asset/image/7/view/1282996485.3278.jpg"},{"width":"194px","asset_id":"9","style":"view","path":"/asset/image/9/view/1282996564.32426.jpg"}]}]'
        }, {
          :title => 'Invalid mobile campaign',
          :document_model => '[{"type":"header","value":""},{"type":"images","value":[]}]'
        }
      ].each do |attributes|
        it "should not create a new instance for: #{attributes[:title]}" do
          lambda { MobileCampaign.create!(attributes) }.should raise_error
        end
      end
    end
  end
  
  describe "with AASM" do
    context "by default" do
      
      before(:all) do
        @mbc = Factory.create(:mobile_campaign)
      end
      
      it { @mbc.should be_published    }
      it { @mbc.should_not be_pending  }
      it { @mbc.should_not be_archived }
    
      context "with unpublish! event" do
        specify { @mbc.unpublish!; @mbc.should be_pending }
      end
      
      context "with publish! event" do
        specify { @mbc.publish!; @mbc.should be_published }
      end
      
      context "with archive! event" do
        specify { @mbc.archive!; @mbc.should be_archived }
      end
    
    end # end context
    
    context "by linked short_url" do
      
      before(:all) do
        MobileCampaign.destroy_all
        @short_url = Factory.create(:short_url)
        @mbc       = Factory.create(:mobile_campaign, :short_url => @short_url)
      end
      
      it { @short_url.should be_proxied }
      
      context "with unpublish! event" do
        specify { @mbc.unpublish!; @mbc.should be_pending; @mbc.short_url.should be_pending }
      end
      
      context "with publish! event" do
        specify { @mbc.publish!; @mbc.should be_published; @mbc.short_url.should be_proxied }
      end
      
      context "with archive! event" do
        specify { @mbc.archive!; @mbc.should be_archived; @mbc.short_url.should be_pending }
      end
    end # end context
  end #end describe
  
end