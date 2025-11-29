package com.system.dao;

import com.system.model.Exam;
import com.system.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

public class ExamDAO {
    
    public List<Exam> getAllExams() {
        List<Exam> exams = new ArrayList<>();
        
        try (Connection conn = DBUtil.getConnection()) {
            // 查询所有考试信息（根据实际表结构调整）
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT * FROM TEST ORDER BY examinationName");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Exam exam = new Exam();
                // 根据实际表结构调整字段映射
                exam.setExamName(rs.getString("examinationID")); // 使用examinationID作为考试名称
                exam.setSubject(rs.getString("examinationMajor")); // 使用examinationMajor作为科目
                
                // 合并日期和时间字段为完整的考试时间
                Date examDate = rs.getDate("examinationDate");
                Time examTime = rs.getTime("examinationTime");
                if (examDate != null && examTime != null) {
                    Timestamp timestamp = Timestamp.valueOf(examDate.toString() + " " + examTime.toString());
                    exam.setExamTime(timestamp);
                }
                
                exam.setClassroom(rs.getString("examinationLocation")); // 使用examinationLocation作为地点
                exams.add(exam);
            }
            
            // 关闭资源
            rs.close();
            pstmt.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return exams;
    }
    
    // 添加考试
    public boolean addExam(Exam exam) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO TEST (examinationID, examinationName, examinationLocation, examinationDate, examinationTime, examinationMajor) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, exam.getExamName());
            pstmt.setString(2, exam.getExamName()); // 简化处理，名称相同
            pstmt.setString(3, exam.getClassroom());
            
            // 分离Timestamp为Date和Time
            if (exam.getExamTime() != null) {
                Date examDate = new Date(exam.getExamTime().getTime());
                Time examTime = new Time(exam.getExamTime().getTime());
                pstmt.setDate(4, examDate);
                pstmt.setTime(5, examTime);
            } else {
                pstmt.setNull(4, java.sql.Types.DATE);
                pstmt.setNull(5, java.sql.Types.TIME);
            }
            
            pstmt.setString(6, exam.getSubject());
            
            int rowsAffected = pstmt.executeUpdate();
            pstmt.close();
            
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 删除考试
    public boolean deleteExam(String examId) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM TEST WHERE examinationID = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, examId);
            
            int rowsAffected = pstmt.executeUpdate();
            pstmt.close();
            
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}