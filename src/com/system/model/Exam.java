package com.system.model;

import java.sql.Timestamp;

public class Exam {
    private String examName;
    private Timestamp examTime;
    private String classroom;
    private String subject;
    
    public Exam() {}
    
    public Exam(String examName, Timestamp examTime, String classroom, String subject) {
        this.examName = examName;
        this.examTime = examTime;
        this.classroom = classroom;
        this.subject = subject;
    }
    
    // Getter and Setter methods
    public String getExamName() {
        return examName;
    }
    
    public void setExamName(String examName) {
        this.examName = examName;
    }
    
    public Timestamp getExamTime() {
        return examTime;
    }
    
    public void setExamTime(Timestamp examTime) {
        this.examTime = examTime;
    }
    
    public String getClassroom() {
        return classroom;
    }
    
    public void setClassroom(String classroom) {
        this.classroom = classroom;
    }
    
    public String getSubject() {
        return subject;
    }
    
    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    @Override
    public String toString() {
        return "Exam{" +
                "examName='" + examName + '\'' +
                ", examTime=" + examTime +
                ", classroom='" + classroom + '\'' +
                ", subject='" + subject + '\'' +
                '}';
    }
}