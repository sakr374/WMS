class DbSyncer
  def self.sync_inventory(records, stocks)
    return unless records.is_a?(Array)

    # Upsert Inventories
    inventories = records.map do |r|
      {
        id: r['id'],
        sku: r['sku'],
        name: r['name'],
        upc: r['upc'],
        uom_base: r['uom_base'],
        is_active: r['is_active'].nil? ? true : r['is_active'],
        is_kit: r['is_kit'] || false,
        is_batch: r['is_batch'] || false,
        is_serial: r['is_serial'] || false,
        cost: r['cost'] || 0.0,
        currency: r['currency'],
        # Removed the 'available' attribute here!
        created_at: Time.current,
        updated_at: Time.current
      }
    end
    
    Inventory.upsert_all(inventories, unique_by: :id) if inventories.any?
  end

  def self.sync_orders(records)
    return unless records.is_a?(Array)

    orders = records.map do |r|
      {
        id: r['id'],
        reference: r['reference'],
        order_number: r['order_number'],
        order_type: r['order_type'],
        order_status: r['order_status'],
        lines_count: r['lines_count'] || 0,
        created_at: r['created_at'] || Time.current,
        updated_at: Time.current
      }
    end

    Order.upsert_all(orders, unique_by: :id) if orders.any?
  end
end