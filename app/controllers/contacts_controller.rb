class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to contacts_thanks_path, notice: 'お問い合わせ内容を送信しました'
    else
      render :new
    end
  end

  def thanks
  end

  private

    # Only allow a list of trusted parameters through.
    def contact_params
      params
        .require(:contact)
        .permit(
          :name, 
          :email, 
          :company_name, 
          :message
        )
    end
end
