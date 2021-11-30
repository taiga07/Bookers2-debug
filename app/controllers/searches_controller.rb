class SearchesController < ApplicationController
  
  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    @records = search_for(@model, @method, @content)
  end
  
  private
  
  def search_for(model, method, content)
    
    if model == 'user'
      
      if method == 'perfect_match'
        User.where('name', 'content')
        # 完全一致
      elsif method == 'forward_match'
        User.where('name LIKE ?', 'content%')
        # 前方一致
      elsif method == 'backward_match'
        User.where('name LIKE ?', '%content')
        # 後方一致
      else
        method == 'partial_match'
        User.where('name LIKE ?', '%content%' )
        # 部分一致
      end
      
    elsif model =='book'
      
      if method == 'perfect_match'
        Book.where('title', 'content')
        
      elsif method == 'forward_match'
        Book.where('title LIKE ?', 'content%')
        
      elsif method == 'backward_match'
        Book.where('title LIKE ?', '%content')
        
      else
        method == 'partial_match'
        Book.where('title LIKE ?', '%content%')
      end
      
    end
    
  end
  
end
  
  