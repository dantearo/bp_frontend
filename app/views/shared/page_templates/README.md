# Page Templates

This directory contains reusable page structure templates for consistent UI across the application.

## Standard Page Template

**File**: `_standard_page.html.erb`

A flexible template that provides the common page structure used across the platform:
- Page title on the left
- Action controls (dropdowns, buttons) on the right  
- Optional statistics section
- Main content area

### Usage Example

Instead of duplicating the header structure in each page, use content_for blocks:

```erb
<%# In your page (e.g., logs_audit/index.html.erb) %>

<% content_for :page_title, "Logs & Audit Trail" %>

<% content_for :page_controls do %>
  <%= render 'shared/filter_dropdown', 
      form_url: logs_audit_path,
      field_name: :filter_type,
      options: [['All Categories', 'all'], ['Security', 'security']],
      selected_value: @filter_type,
      hidden_fields: { date_range: @date_range, search: @search_term } %>
      
  <%= render 'shared/action_button', 
      text: "Export Logs", 
      icon: "download", 
      style: "primary",
      onclick: "exportLogs()" %>
<% end %>

<% content_for :page_stats do %>
  <%= render 'shared/statistics_cards', stats: @statistics %>
<% end %>

<% content_for :page_content do %>
  <!-- Your main page content here -->
  <%= render 'shared/data_table', data: @filtered_logs, ... %>
<% end %>

<%= render 'shared/page_templates/standard_page' %>
```

## Component Partials

### Filter Dropdown (`_filter_dropdown.html.erb`)

Reusable dropdown component with form submission:

```erb
<%= render 'shared/filter_dropdown',
    form_url: your_path,
    field_name: :filter_field,
    options: [['Display Text', 'value'], ...],
    selected_value: @current_value,
    hidden_fields: { other_param: @other_value } %>
```

### Action Button (`_action_button.html.erb`)

Reusable button component with multiple styles:

```erb
<%# As a button %>
<%= render 'shared/action_button',
    text: "Button Text",
    icon: "lucide-icon-name",
    style: "primary", # primary, secondary, success, danger
    onclick: "myFunction()" %>

<%# As a link %>
<%= render 'shared/action_button',
    text: "Link Text", 
    icon: "edit",
    style: "secondary",
    link_to: edit_path(item) %>
```

### Available Button Styles:
- `primary`: Yellow (default platform color)
- `secondary`: Gray  
- `success`: Green
- `danger`: Red
- Default: Blue

## Benefits

1. **Consistency**: All pages use the same header structure
2. **Maintainability**: Changes to the layout only need to be made in one place
3. **Reusability**: Components can be mixed and matched as needed
4. **Flexibility**: Content blocks allow customization per page
5. **Clean Code**: Pages focus on their specific content, not layout boilerplate
