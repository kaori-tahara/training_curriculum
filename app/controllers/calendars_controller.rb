class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
   get_week
   @plan = Plan.new

  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
     
  end

  private

  def plan_params
    params.require(:plan).permit(:date,:plan)
  end


  
  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    
    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    @plans = Plan.where(date: @todays_date..@todays_date + 7)
  
    7.times do |x|
      plans = []
      plan = @plans.map do |plan|
        plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, day:(wdays[(@todays_date+x).wday]), plans: plans}
      @week_days.push(days)
    end

  end
end

# wdays[(@todays_date + x).wday]
# # wdays[1]
# wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
# wdays[(@todays_date + x).wday]
# wdays[1]
# wdays[2]　　xは7timesのブロック変数で曜日の回数を表している

# (@todays_date + x).wday
# (1 + 1) * 3 = 

# プライベートにget_weekを入れているのは、見やすくするため。プライベートの下にメゾットをおいても、ok
# メゾット名を呼び出して使える。