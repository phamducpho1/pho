class Supports::UserSupport
  def date
     Order.count_date.count.keys
  end

  def orderdate
    Order.count_date.count.values
  end

  def moneydate
     Order.count_date.sum(:total_amount).values
  end

  def month
     Order.count_month.count.keys
  end

  def ordermonth
     Order.count_month.count.values
  end

  def moneymonth
     Order.count_month.sum(:total_amount).values
  end

  def year
    Order.count_year.count.keys
  end

  def orderyear
    Order.count_year.count.values
  end

  def moneyyear
    Order.count_year.sum(:total_amount).values
  end

end
