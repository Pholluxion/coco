
package logic.models;


public class PostModel {
    
    private String message;
    private String date;
    private String user;
    private String topic;

    public PostModel() {
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    @Override
    public String toString() {
        return "PostModel{" + "message=" + message + ", date=" + date + ", user=" + user + ", topic=" + topic + '}';
    }

}
