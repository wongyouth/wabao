namespace :wabao do
  desc 'prepare'
  task :prepare => :environment do
    OpenTaobao.load(Rails.root + 'config/taobao.yml')
  end

  namespace :category do
    def create_categories(parent_id)
      c = OpenTaobao.get(
        :method => 'taobao.itemcats.get',
        :fields => 'cid,parent_cid,name,is_parent',
        :parent_cid => parent_id
      )
      array = c.try(:itemcats_get_response).try(:item_cats).try(:item_cat)
      array = (array || []).map { |e|
        {_id: e.cid, parent_id: e.parent_cid, name: e.name, is_parent: e.is_parent}.with_indifferent_access
       }
      Category.collection.insert array unless array.blank?
      array.each do |a|
        create_categories a._id if a.is_parent == true
      end
    end

    def update_categories(parent_id)
      c = OpenTaobao.get(
        :method => 'taobao.itemcats.get',
        :fields => 'cid,parent_cid,name,is_parent',
        :parent_cid => parent_id
      )

      array = c.try(:itemcats_get_response).try(:item_cats).try(:item_cat)
      array = (array || []).map { |e|
        {_id: e.cid, parent_id: e.parent_cid, name: e.name, is_parent: e.is_parent}.with_indifferent_access
       }
      (array || []).each do |a|
        Category.find_or_create_by(_id: a._id).update_attributes!(a.slice(:parent_id,:name,:is_parent))
        get_category a._id if a.is_parent == true
      end
    end

    desc 'pull all categories from taobao'
    task :pull => :prepare do
      create_categories 0
    end

    desc 'update all categories'
    task :update => :prepare do
      update_categories 0
    end
  end
end
