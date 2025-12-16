package com.mydomain.tags;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

// Simple custom tag that outputs a greeting using the provided `user` attribute.
public class GreetUserTag extends SimpleTagSupport {
    private String user;

    public void setUser(String user) {
        this.user = user;
    }

    @Override
    public void doTag() throws JspException, IOException {
        JspWriter out = getJspContext().getOut();
        String name = (user != null && !user.isEmpty()) ? user : "guest";
        out.print("Hello, " + name + "!");
    }
}

