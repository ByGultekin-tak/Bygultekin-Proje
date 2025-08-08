# Database Schema

## Users Table
```sql
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    avatar VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    role ENUM('user', 'admin', 'moderator') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    INDEX idx_email (email),
    INDEX idx_username (username),
    INDEX idx_deleted_at (deleted_at)
);
```

## Categories Table
```sql
CREATE TABLE categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    icon VARCHAR(100),
    parent_id BIGINT UNSIGNED NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL,
    INDEX idx_parent_id (parent_id),
    INDEX idx_slug (slug),
    INDEX idx_deleted_at (deleted_at)
);
```

## Listings Table
```sql
CREATE TABLE listings (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    description TEXT,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'TRY',
    location VARCHAR(300),
    user_id BIGINT UNSIGNED NOT NULL,
    category_id BIGINT UNSIGNED NOT NULL,
    status ENUM('active', 'sold', 'inactive') DEFAULT 'active',
    view_count INT UNSIGNED DEFAULT 0,
    is_promoted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
    INDEX idx_user_id (user_id),
    INDEX idx_category_id (category_id),
    INDEX idx_status (status),
    INDEX idx_price (price),
    INDEX idx_created_at (created_at),
    INDEX idx_deleted_at (deleted_at),
    FULLTEXT idx_search (title, description)
);
```

## Listing Images Table
```sql
CREATE TABLE listing_images (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    listing_id BIGINT UNSIGNED NOT NULL,
    url VARCHAR(1000) NOT NULL,
    alt VARCHAR(300),
    order_index INT UNSIGNED DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE,
    INDEX idx_listing_id (listing_id),
    INDEX idx_order (order_index),
    INDEX idx_deleted_at (deleted_at)
);
```

## Favorites Table
```sql
CREATE TABLE favorites (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    listing_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_listing (user_id, listing_id),
    INDEX idx_user_id (user_id),
    INDEX idx_listing_id (listing_id),
    INDEX idx_deleted_at (deleted_at)
);
```

## Messages Table
```sql
CREATE TABLE messages (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sender_id BIGINT UNSIGNED NOT NULL,
    receiver_id BIGINT UNSIGNED NOT NULL,
    listing_id BIGINT UNSIGNED NULL,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE,
    INDEX idx_sender_id (sender_id),
    INDEX idx_receiver_id (receiver_id),
    INDEX idx_listing_id (listing_id),
    INDEX idx_created_at (created_at),
    INDEX idx_deleted_at (deleted_at)
);
```

## Initial Data

### Default Categories
```sql
-- Main Categories
INSERT INTO categories (name, slug, description, icon, parent_id) VALUES
('Emlak', 'emlak', 'Gayrimenkul ilanları', 'home', NULL),
('Vasıta', 'vasita', 'Araç ilanları', 'car', NULL),
('İkinci El ve Sıfır Alışveriş', 'ikinci-el', 'İkinci el ve sıfır ürünler', 'shopping-bag', NULL),
('İş İlanları', 'is-ilanlari', 'İş fırsatları', 'briefcase', NULL),
('Hizmetler', 'hizmetler', 'Hizmet ilanları', 'wrench', NULL);

-- Emlak Sub-categories
INSERT INTO categories (name, slug, description, parent_id) VALUES
('Konut', 'konut', 'Ev, daire, villa', 1),
('İş Yeri', 'is-yeri', 'Ofis, mağaza, fabrika', 1),
('Arsa', 'arsa', 'Konut, ticari, tarla arsası', 1),
('Bina', 'bina', 'Apartman, iş hanı', 1),
('Devren Satılık & Kiralık', 'devren', 'Devren işyeri', 1),
('Turistik Tesis', 'turistik-tesis', 'Otel, pansiyon', 1),
('Diğer Gayrimenkul', 'diger-gayrimenkul', 'Diğer emlak türleri', 1);

-- Vasıta Sub-categories
INSERT INTO categories (name, slug, description, parent_id) VALUES
('Otomobil', 'otomobil', 'Binek araçlar', 2),
('Arazi, SUV & Pickup', 'arazi-suv-pickup', 'Arazi ve SUV araçlar', 2),
('Motosiklet', 'motosiklet', 'Motorsiklet ve scooter', 2),
('Minivan & Panelvan', 'minivan-panelvan', 'Ticari araçlar', 2),
('Kamyon & Kamyonet', 'kamyon-kamyonet', 'Ağır vasıta', 2),
('Otobüs & Midibüs', 'otobus-midibus', 'Toplu taşıma araçları', 2),
('Tarım & İş Makinesi', 'tarim-is-makinesi', 'Traktör ve iş makineleri', 2),
('Deniz Araçları', 'deniz-araclari', 'Tekne, yat', 2),
('Hasarlı Araçlar', 'hasarli-araclar', 'Hasarlı ve hurda araçlar', 2),
('Kiralık Araçlar', 'kiralik-araclar', 'Araç kiralama', 2);
```
