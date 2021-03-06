class MeasurementsController < ApplicationController
  def index
    query = Measurement.order('created_at DESC').limit(100)
    query = query.offset(params[:page].to_i * 100) if params[:page]
    @measurements = query.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @measurements }
    end
  end

  def show
    @measurement = Measurement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @measurement }
    end
  end

  def new
    @measurement = Measurement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @measurement }
    end
  end

  def edit
    @measurement = Measurement.find(params[:id])
  end

  def create
    @measurement = Measurement.new(params[:measurement])
    if Measurement.exists? params[:measurement]
      redirect_to :action => :index
      return
    end

    respond_to do |format|
      if @measurement.save
        format.html { redirect_to(@measurement, :notice => 'Measurement was successfully created.') }
        format.xml { render :xml => @measurement, :status => :created, :location => @measurement }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @measurement.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @measurement = Measurement.find(params[:id])

    respond_to do |format|
      if @measurement.update_attributes(params[:measurement])
        format.html { redirect_to(@measurement, :notice => 'Measurement was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @measurement.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @measurement = Measurement.find(params[:id])
    @measurement.destroy

    respond_to do |format|
      format.html { redirect_to(measurements_url) }
      format.xml { head :ok }
    end
  end

  def top_ten
    measurements_by_test = Measurement.all.group_by { |m| m.test }
    @benchmarks = measurements_by_test.map do |test, measurements_for_test|
      measurements_by_params = measurements_for_test.group_by { |s| [s.manufacturer, s.model, s.android_version, s.ruboto_app_version, s.ruboto_platform_version, s.package, s.package_version, s.compile_mode, s.ruby_version] }
      rows = measurements_by_params.map do |params, measurements_for_params|
        {
            :median => measurements_for_params.sort_by(&:duration)[(measurements_for_params.size / 4).to_i].duration,
            :params => params,
            :count => measurements_for_params.size,
        }
      end.sort_by { |r| r[:median] }
      {:name => test, :rows => rows, :count => measurements_for_test.size}
    end.sort_by { |r| [-r[:count], -r[:rows].size] }
  end

end
