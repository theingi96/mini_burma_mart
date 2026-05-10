## データベース設計

### user
| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| id                 | bigint   | primary key               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| created_at         | datetime | null: false               |
| updated_at         | datetime | null: false               |

### Association
has_one :cart
has_many :orders
has_many :addresses

### categories
| Column     | Type     | Options                   |
| ---------- | -------- | ------------------------- |
| id         | bigint   | primary key               |
| name       | string   | null: false, unique: true |
| created_at | datetime | null: false               |
| updated_at | datetime | null: false               |

### Association
has_many :products

### products
| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| id          | bigint     | primary key                    |
| name        | string     | null: false                    |
| description | text       | null: false                    |
| price       | integer    | null: false                    |
| stock       | integer    | null: false                    |
| is_active   | boolean    | default: true                  |
| category    | references | null: false, foreign_key: true |
| created_at  | datetime   | null: false                    |
| updated_at  | datetime   | null: false                    |

### Association
belongs_to :category
has_many :cart_items
has_many :order_items

### carts
| Column     | Type       | Options                                |
| ---------- | ---------- | -------------------------------------- |
| id         | bigint     | primary key                            |
| user       | references | null: false, foreign_key: true, unique |
| status     | integer    | default: 0                             |
| created_at | datetime   | null: false                            |
| updated_at | datetime   | null: false                            |

### Association
belongs_to :user
has_many :cart_items

### cart_items
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| id         | bigint     | primary key                    |
| cart       | references | null: false, foreign_key: true |
| product    | references | null: false, foreign_key: true |
| quantity   | integer    | null: false                    |
| created_at | datetime   | null: false                    |
| updated_at | datetime   | null: false                    |

### Association
belongs_to :cart
belongs_to :product

### addresses
| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| id           | bigint     | primary key                    |
| user         | references | null: false, foreign_key: true |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address_line | string     | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| created_at   | datetime   | null: false                    |
| updated_at   | datetime   | null: false                    |

### Association
belongs_to :user
has_many :orders

### orders
| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| id           | bigint     | primary key                    |
| user         | references | null: false, foreign_key: true |
| address      | references | null: false, foreign_key: true |
| total_amount | integer    | null: false                    |
| status       | integer    | default: 0                     |
| created_at   | datetime   | null: false                    |
| updated_at   | datetime   | null: false                    |

### Association
belongs_to :user
belongs_to :address
has_many :order_items

### order_items
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| id         | bigint     | primary key                    |
| order      | references | null: false, foreign_key: true |
| product    | references | null: false, foreign_key: true |
| price      | integer    | null: false                    |
| quantity   | integer    | null: false                    |
| created_at | datetime   | null: false                    |
| updated_at | datetime   | null: false                    |

### Association
belongs_to :order
belongs_to :product