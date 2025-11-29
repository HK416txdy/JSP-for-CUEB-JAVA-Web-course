-- 添加role字段到现有的USERS表
ALTER TABLE USERS ADD COLUMN role VARCHAR(50) DEFAULT 'user';

-- 更新admin用户的role为admin
UPDATE USERS SET role = 'admin' WHERE userName = 'admin';

-- 查看更新后的表结构
\d USERS