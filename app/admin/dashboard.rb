ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    ul class: "menu-navigation" do
      li do
        link_to(admin_base_page_path(BasePage.first.id)) do
          I18n.t("activerecord.models.base_page.one")
        end
      end

      li do
        link_to(admin_compositions_path) do
          I18n.t("activerecord.models.composition.other") + " (#{Composition.count})"
        end
      end

      li do
        link_to(admin_gallery_items_path) do
          I18n.t("activerecord.models.gallery_item.other") + " (#{GalleryItem.count})"
        end
      end

      li do
        link_to(admin_riders_path) do
          I18n.t("activerecord.models.rider.other") + " (#{Rider.count})"
        end
      end

      li do
        link_to(admin_members_path) do
          I18n.t("activerecord.models.member.other") + " (#{Member.count})"
        end
      end

      li do
        link_to(admin_instruments_path) do
          I18n.t("activerecord.models.instrument.other") + " (#{Instrument.count})"
        end
      end

      li do
        link_to(admin_contact_path(Contact.first.id)) do
          I18n.t("activerecord.models.contact")
        end
      end

      li do
        link_to(admin_admin_users_path) do
          I18n.t("activerecord.models.admin_user.other") + " (#{AdminUser.count})"
        end
      end

      li class: 'admin-messages-link' do
        link_to(admin_messages_path) do
          admin_messages_link
        end
      end
    end
  end
end
