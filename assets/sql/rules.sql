-- 系统内置规则（可编辑）
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Clean Bedroom', 'bed', 20, 'reward', 1, 1, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Finish Homework', 'book', 30, 'reward', 1, 1, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Wash Dishes', 'water_drop', 15, 'reward', 1, 1, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Walk the Dog', 'pets', 15, 'reward', 1, 1, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Practice Instrument', 'piano', 25, 'reward', 1, 1, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Tantrum', 'sentiment_very_dissatisfied', 20, 'punish', 1, 1, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Fighting', 'sports_mma', 30, 'punish', 1, 1, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Not Listening', 'hearing_disabled', 10, 'punish', 1, 1, strftime('%s','now') * 1000);
-- 系统自定义规则（不可编辑，用于自定义记录）
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Custom Reward', 'star', 10, 'reward', 1, 0, strftime('%s','now') * 1000);
INSERT INTO rules (name, icon, points, type, is_system, is_editable, created_at) VALUES ('Custom Penalty', 'remove_circle', 10, 'punish', 1, 0, strftime('%s','now') * 1000);
