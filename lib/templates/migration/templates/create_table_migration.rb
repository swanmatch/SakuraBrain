class <%= migration_class_name %> < ActiveRecord::Migration
  def change
    create_table :<%= table_name %> do |t|
<%- attributes.each do |attribute| -%>
<%- if attribute.password_digest? -%>
      t.string :password_digest<%= attribute.inject_options %>
<%- else -%>
      t.<%= attribute.type %> :<%= attribute.name %><%= attribute.inject_options %>
<%- end -%>
<%- end -%>

      t.integer :lock_version, default: 0, null: false
      t.integer :created_by
      t.integer :updated_by
      t.integer :deleted_by
      t.datetime :deleted_at

<%- if options[:timestamps] %>
      t.timestamps
<%- end -%>
    end
<% attributes_with_index.each do |attribute| -%>
    add_index :<%= table_name %>, :<%= attribute.index_name %><%= attribute.inject_index_options %>
<% end -%>
  end
end