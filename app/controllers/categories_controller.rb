class CategoriesController < ApplicationController

	def get
		cat_to_tag=Category.find_by_sql("select c.id cid,c.name cname,ct.tag_id tid from categories c,categories_tags ct where c.id=ct.category_id")
		video_to_tag=Video.find_by_sql("select vt.video_id vid,vt.tag_id tid from videos_tags vt")
		#整理对应关系
		cat_tag_hash=Hash.new do |h,k| h[k]=[] end
		cat_to_tag.each{ |e|
			cat_tag_hash[e["cid"]]<<e["tid"]
		}

		video_tag_hash=Hash.new do |h,k| h[k]=[] end
		video_to_tag.each{ |e|
			video_tag_hash[e["vid"]]<<e["tid"]
		}
		#计数
		cat_counter=Hash.new 0
		cat_tag_hash.each{ |cid,c_tids|
			video_tag_hash.values.each{ |v_tids|
				cat_counter[cid]+=1 if  (c_tids&v_tids).empty?
			}
		}
		#整理json
		data=[]
		jresult={:data=>data}
		cat_to_tag.each{ |e|
			data<<{:id=>e.cid,:name=>e.cname,:count=>cat_counter[e.cid]}
		}
		data.uniq!
		render json:jresult
	end
end
