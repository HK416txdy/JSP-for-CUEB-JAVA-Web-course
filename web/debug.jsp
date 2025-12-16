<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    out.println("Debugging class loading:\n");
    try {
        Class<?> c = Class.forName("com.mydomain.tags.GreetUserTag");
        out.println("Class found: " + c.getName());
        out.println("Class loader: " + c.getClassLoader());
    } catch (Throwable t) {
        out.println("Failed to load com.mydomain.tags.GreetUserTag");
        java.io.PrintWriter pw = new java.io.PrintWriter(out);
        t.printStackTrace(pw);
        pw.flush();
    }

    out.println("\nCheck JSP compile by attempting to load org.apache.jsp.index_jsp (may not exist if JSP compilation failed)");
    try {
        Class<?> jspClass = Class.forName("org.apache.jsp.index_jsp");
        out.println("index_jsp class found: " + jspClass.getName());
    } catch (Throwable t) {
        out.println("index_jsp class not found: " + t);
    }
%>
