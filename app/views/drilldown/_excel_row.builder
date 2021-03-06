xml.Row do
  padding_cells = @dimensions.size == 0 ? 1 : @dimensions.size
  1.upto(padding_cells - 1) { |n| xml.Cell('ss:StyleID'=>"Outer")}

  @search.fields.each_with_index do |field, i|
    if (field == 'time')
      value = (transaction.respond_to?(:completed_at) ? transaction.completed_at : transaction.created_at).localtime.strftime('%Y-%m-%d %H:%M')
    else
      if @transaction_fields_map[field.to_sym][:attr_method]
        value = @transaction_fields_map[field.to_sym][:attr_method].call(transaction)
      else
        value = transaction.send(field)
      end
    end

    field_def = @transaction_fields_map[field.to_sym]
    value = "#{value} #{transaction.assignment.try(:order).try("last_#{field}_change").try(:created_at).try(:localtime).try(:strftime, '(%H:%M)')}" if @search.last_change_time && field_def[:last_change_time]

    xml.Cell('ss:Index' => "#{padding_cells + i}") do
      xml.Data value, 'ss:Type' => "String"
    end
  end
end
