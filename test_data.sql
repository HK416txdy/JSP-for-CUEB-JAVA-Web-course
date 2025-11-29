-- 删除已存在的表（如果有的话）
DROP TABLE IF EXISTS TEST;
DROP TABLE IF EXISTS USERS;

-- 创建USERS表
CREATE TABLE USERS(
    userName VARCHAR(255),
    password VARCHAR(255),
    name VARCHAR(255),
    major VARCHAR(255),
    role VARCHAR(50) DEFAULT 'user'
);

-- 创建TEST表（根据实际表结构调整）.0
CREATE TABLE TEST(
    examinationID VARCHAR(255),
    examinationName VARCHAR(255),
    examinationLocation VARCHAR(255),
    examinationDate DATE,
    examinationTime TIME,
    examinationMajor VARCHAR(255)
);

-- 插入测试用户数据
INSERT INTO USERS (userName, password, name, major, role) VALUES
('test', '123456', '张三', '计算机科学与技术', 'user'),
('student1', 'password1', '李四', '软件工程', 'user'),
('student2', 'password2', '王五', '信息安全', 'user'),
('admin', 'admin123', '管理员', '信息管理', 'admin');

-- 插入测试考试数据
INSERT INTO TEST (examinationID, examinationName, examinationLocation, examinationDate, examinationTime, examinationMajor) VALUES
('MATH101', '高等数学期末考试', 'A101', '2025-12-15', '09:00:00', '高等数学'),
('ENG201', '大学英语期中考试', 'B205', '2025-11-30', '14:00:00', '大学英语'),
('CS301', '计算机网络期末考试', 'C301', '2025-12-20', '10:30:00', '计算机网络'),
('DS401', '数据结构期中考试', 'A208', '2025-11-25', '08:00:00', '数据结构'),
('OS501', '操作系统期末考试', 'B106', '2025-12-18', '13:00:00', '操作系统');