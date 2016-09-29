class VideosController < ApplicationController
  def get
    #验证接口
    if (params.has_key?"category") && (params["category"] =~ /^\d+$/)
      puts "flag"
      find_category_info
    else
      #无匹配接口
      render json:{}
    end
  end
  def find_category_info
    category_id=params["category"].to_i
    cat=Category.find(category_id)
    tags=Tag.find_by_sql("select t.id,t.name from categories_tags ct,tags t where ct.tag_id=t.id && ct.category_id="+category_id.to_s)
    tags_id=[]
    tags.each do |e| tags_id<<e["id"] end
    videos=Video.find_by_sql("select DISTINCT v.id,v.name from videos_tags vt,videos v where vt.video_id=v.id && vt.tag_id in ("+tags_id.join(",")+")")
    #拼结果
    jresult={}
    jresult[:id]=category_id
    jresult[:count]=videos.size
    jresult[:name]=cat["name"]
    result_tags=[]
    tags.each{ |e|
      result_tags<<{:id=>e["id"],:name=>e["name"]}
    }
    jresult[:tags]=result_tags
    result_videos=[]
    videos.each{ |e|
      result_videos<<{:id=>e["id"],:name=>e["name"]}
    }
    jresult[:videos]=result_videos

    render json:jresult
  end
end
