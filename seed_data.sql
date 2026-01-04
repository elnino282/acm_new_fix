-- =========================================================
-- ACM Platform - Seed Data (MySQL Compatible)
-- =========================================================
-- Version: 4.1 - Fixed & Ready-to-Run - Updated 2026-01-04
-- 
-- Default Admin: admin / Password: Admin@123
-- Default Farmer: farmer / Password: Farmer@123 (user_id = 2)
-- =========================================================
-- HƯỚNG DẪN SỬ DỤNG:
-- 1. Chạy file acm_db.sql trước để tạo schema
-- 2. Sau đó chạy file này để insert dữ liệu mẫu
-- =========================================================

-- Sử dụng database
USE `quanlymuavu`;

-- Tắt kiểm tra foreign key để insert dữ liệu theo thứ tự tùy ý
SET FOREIGN_KEY_CHECKS = 0;

-- =========================================================
-- 4. FARMS
-- =========================================================
INSERT INTO farms (farm_id, owner_id, farm_name, province_id, ward_id, area, active) VALUES
(1, 2, 'Nông trại Hoa Lan', 24, 25112, 12.50, TRUE),
(2, 2, 'Nông trại Bình An', 24, 25112, 8.20, TRUE);

-- =========================================================
-- 5. PLOTS
-- =========================================================
INSERT INTO plots (plot_id, farm_id, plot_name, area, soil_type, status, created_by, created_at, updated_at) VALUES
(1, 1, 'Lô A1 - Thửa trồng cà chua', 2.50, 'LOAM', 'IN_USE', 2, NOW(), NOW()),
(2, 1, 'Lô A2 - Thửa trồng lúa', 3.00, 'CLAY', 'IN_USE', 2, NOW(), NOW()),
(3, 2, 'Lô B1 - Nhà màng', 1.80, 'SANDY', 'IN_USE', 2, NOW(), NOW());

-- =========================================================
-- 6. CROPS & VARIETIES
-- =========================================================
INSERT INTO crops (crop_id, crop_name, description) VALUES
(1, 'Lúa', 'Cây lương thực chính'),
(2, 'Cà chua', 'Cây rau ăn quả');

INSERT INTO varieties (id, crop_id, name, description) VALUES
(1, 1, 'ST25', 'Giống lúa thơm đặc sản'),
(2, 2, 'Cà chua Cherry', 'Cà chua bi ngọt'),
(3, 2, 'Cà chua Beef', 'Cà chua to múi');

-- =========================================================
-- 7. SEASONS
-- =========================================================
INSERT INTO seasons (season_id, season_name, plot_id, crop_id, variety_id, start_date, planned_harvest_date, end_date, status, initial_plant_count, current_plant_count, expected_yield_kg, actual_yield_kg, notes, created_at) VALUES
-- Completed season
(1, 'Vụ Cà chua Đông 2024', 1, 2, 2, '2024-10-01', '2024-12-15', '2024-12-20', 'COMPLETED', 1000, 950, 800.00, 850.50, 'Vụ mùa thành công', '2024-10-01 08:00:00'),
-- Active seasons
(2, 'Vụ Cà chua Xuân 2025', 1, 2, 3, '2025-01-05', '2025-03-20', NULL, 'ACTIVE', 1200, 1180, 900.00, NULL, 'Đang phát triển tốt', NOW()),
(3, 'Vụ Lúa Hè Thu 2025', 2, 1, 1, '2025-01-15', '2025-04-10', NULL, 'ACTIVE', 5000, 4900, 2500.00, NULL, 'Giai đoạn làm đòng', NOW()),
-- Planned season
(4, 'Vụ Cà chua Thu 2025', 3, 2, 2, '2025-06-01', '2025-08-15', NULL, 'PLANNED', 1000, NULL, 800.00, NULL, 'Dự kiến gieo trồng nhà màng B1', NOW());

-- =========================================================
-- 8. TASKS (phải insert trước EXPENSES vì expenses có FK tới tasks)
-- =========================================================
INSERT INTO tasks (task_id, user_id, season_id, title, description, planned_date, due_date, status, actual_start_date, actual_end_date, notes, created_at) VALUES
(1, 2, 2, 'Gieo hạt cà chua', 'Gieo hạt vào khay, theo dõi độ ẩm', '2025-01-05', '2025-01-07', 'DONE', '2025-01-05', '2025-01-06', 'Tỉ lệ nảy mầm cao', NOW()),
(2, 2, 2, 'Làm đất lô A1', 'Cày bừa, bón vôi khử trùng', '2025-01-08', '2025-01-10', 'DONE', '2025-01-08', '2025-01-09', 'Đất đã sẵn sàng', NOW()),
(3, 2, 2, 'Bón phân thúc đợt 1', 'Sử dụng phân NPK hòa tan', '2025-02-05', '2025-02-07', 'PENDING', NULL, NULL, NULL, NOW()),
(4, 2, 3, 'Gieo sạ lúa', 'Gieo sạ mạ khay', '2025-01-15', '2025-01-17', 'DONE', '2025-01-15', '2025-01-16', 'Hoàn thành đúng hạn', NOW()),
(5, 2, 3, 'Dặm lúa', 'Kiểm tra và dặm những chỗ mất mầm', '2025-01-25', '2025-01-27', 'IN_PROGRESS', '2025-01-26', NULL, 'Đang thực hiện', NOW());

-- =========================================================
-- 9. EXPENSES
-- =========================================================
INSERT INTO expenses (expense_id, user_id, season_id, task_id, category, item_name, unit_price, quantity, total_cost, amount, note, expense_date, created_at) VALUES
-- Season 1 (Completed)
(1, 2, 1, NULL, 'SEEDS', 'Hạt giống cà chua Cherry', 15000.00, 10, 150000.00, 150000.00, 'Mua tại đại lý', '2024-10-02', '2024-10-02 09:00:00'),
(2, 2, 1, NULL, 'FERTILIZER', 'Phân NPK 16-16-8', 50000.00, 5, 250000.00, 250000.00, 'Bón lót', '2024-10-05', '2024-10-05 10:00:00'),
(3, 2, 1, NULL, 'LABOR', 'Thuê nhân công thu hoạch', 200000.00, 2, 400000.00, 400000.00, 'Thu hoạch đợt 1', '2024-12-15', '2024-12-15 14:00:00'),
-- Season 2 (Active)
(4, 2, 2, NULL, 'SEEDS', 'Hạt giống cà chua Beef', 18000.00, 12, 216000.00, 216000.00, 'Nhập ngoại', '2025-01-05', NOW()),
(5, 2, 2, NULL, 'FERTILIZER', 'Phân hữu cơ', 60000.00, 10, 600000.00, 600000.00, 'Bón thúc', '2025-01-20', NOW()),
-- Season 3 (Active)
(6, 2, 3, NULL, 'SEEDS', 'Hạt giống lúa ST25', 25000.00, 50, 1250000.00, 1250000.00, 'Đặc sản ST', '2025-01-15', NOW());

-- =========================================================
-- 10. HARVESTS
-- =========================================================
INSERT INTO harvests (harvest_id, season_id, harvest_date, quantity, unit, note, created_at) VALUES
(1, 1, '2024-12-15', 400.00, 20000.00, 'Thu hoạch đợt 1 - Cà chua Cherry', '2024-12-15 17:00:00'),
(2, 1, '2024-12-20', 450.50, 22000.00, 'Thu hoạch đợt 2 - Cuối vụ', '2024-12-20 16:00:00');

-- =========================================================
-- 11. INVENTORY
-- =========================================================
INSERT INTO suppliers (id, name, contact_email, contact_phone) VALUES
(1, 'Đại lý Vật tư Nông nghiệp Xanh', 'vattuxanh@gmail.com', '0444555666');

-- Lưu ý: Schema supply_items không có cột 'category', dùng 'active_ingredient' thay thế
INSERT INTO supply_items (id, name, active_ingredient, unit, restricted_flag) VALUES
(1, 'Phân NPK 16-16-8', 'N-P-K 16-16-8', 'kg', FALSE),
(2, 'Thuốc trừ sâu sinh học B1', 'Bacillus thuringiensis', 'lít', TRUE);

INSERT INTO supply_lots (id, supply_item_id, supplier_id, batch_code, expiry_date, status) VALUES
(1, 1, 1, 'BATCH-NPK-001', '2026-12-31', 'IN_STOCK');

-- Lưu ý: Schema warehouses dùng 'id' không phải 'warehouse_id'
INSERT INTO warehouses (id, farm_id, name, type, province_id, ward_id) VALUES
(1, 1, 'Kho vật tư Hoa Lan', 'INPUT', 24, 25112);

-- Lưu ý: Schema stock_locations dùng 'id' không phải 'location_id'
INSERT INTO stock_locations (id, warehouse_id, zone, aisle, shelf, bin) VALUES
(1, 1, 'Khu A', 'Hàng 1', 'Kệ 1', 'Ô 1');

INSERT INTO stock_movements (id, supply_lot_id, warehouse_id, location_id, movement_type, quantity, movement_date, season_id, task_id, note) VALUES
(1, 1, 1, 1, 'IN', 100.000, '2025-01-01 08:00:00', NULL, NULL, 'Nhập kho đầu năm');

-- =========================================================
-- 12. INCIDENTS
-- =========================================================
INSERT INTO incidents (id, season_id, reported_by, incident_type, severity, status, description, deadline, created_at) VALUES
(1, 2, 2, 'DISEASE', 'MEDIUM', 'OPEN', 'Phát hiện bệnh sương mai trên lá cà chua', '2025-02-10', NOW());

-- =========================================================
-- 13. DOCUMENTS
-- =========================================================
-- Lưu ý: Schema documents có cấu trúc khác, đã điều chỉnh theo đúng schema
INSERT INTO documents (document_id, title, url, description, crop, stage, topic, is_active, is_public, created_by, created_at, updated_at) VALUES
(1, 'Quy trình trồng cà chua GAP', 'https://example.com/tomato-gap.pdf', 'Hướng dẫn kỹ thuật trồng cà chua theo tiêu chuẩn GAP', 'Cà chua', 'ALL', 'GUIDE', TRUE, TRUE, 1, NOW(), NOW()),
(2, 'Lịch thời vụ 2025', 'https://example.com/calendar-2025.pdf', 'Lịch thời vụ các loại cây trồng chính năm 2025', NULL, 'ALL', 'CALENDAR', TRUE, TRUE, 1, NOW(), NOW());

-- =========================================================
-- Bật lại kiểm tra foreign key
-- =========================================================
SET FOREIGN_KEY_CHECKS = 1;

-- =========================================================
-- KIỂM TRA KẾT QUẢ
-- =========================================================
SELECT '=== KẾT QUẢ INSERT DỮ LIỆU MẪU ===' AS '';
SELECT CONCAT('Provinces: ', COUNT(*)) AS result FROM provinces;
SELECT CONCAT('Wards: ', COUNT(*)) AS result FROM wards;
SELECT CONCAT('Roles: ', COUNT(*)) AS result FROM roles;
SELECT CONCAT('Users: ', COUNT(*)) AS result FROM users;
SELECT CONCAT('Farms: ', COUNT(*)) AS result FROM farms;
SELECT CONCAT('Plots: ', COUNT(*)) AS result FROM plots;
SELECT CONCAT('Crops: ', COUNT(*)) AS result FROM crops;
SELECT CONCAT('Varieties: ', COUNT(*)) AS result FROM varieties;
SELECT CONCAT('Seasons: ', COUNT(*)) AS result FROM seasons;
SELECT CONCAT('Tasks: ', COUNT(*)) AS result FROM tasks;
SELECT CONCAT('Expenses: ', COUNT(*)) AS result FROM expenses;
SELECT CONCAT('Harvests: ', COUNT(*)) AS result FROM harvests;
SELECT CONCAT('Incidents: ', COUNT(*)) AS result FROM incidents;
SELECT CONCAT('Documents: ', COUNT(*)) AS result FROM documents;
SELECT CONCAT('Warehouses: ', COUNT(*)) AS result FROM warehouses;
SELECT '=== HOÀN TẤT ===' AS '';
