class SitesController < ManagementController
  def index
    @sites = Site.where(user: current_user.company.users)
  end

  def new
    @site = current_user.sites.new
  end

  def edit
    @site = current_user.sites.find(params[:id])
  end

  def create
    @site = current_user.sites.new(site_params)
    begin
      start_time = Time.zone.now
      URI.open(site_params[:domain], { read_timeout: 10 }).read
      response_time = Time.zone.now - start_time

      @site.save!
      @site.histories.create!(result: true, response_time: response_time)

      redirect_to sites_path
    rescue StandardError => e
      flash[:danger] = "存在しないURLです"
      render :new
    end
  end

  def update
    site = current_user.sites.find(params[:id])
    site.update!(site_params)

    redirect_to sites_path
  end

  def delete
    site = current_user.sites.find(params[:id])
    site.destroy!

    redirect_to sites_path
  end

private

  def site_params
    params.require(:site).permit(:name, :domain, :timeout)
  end
end
