public static class User {

    public String email;

    public User(String email) {
        this.email = email
    }

}

DatabaseReference usersRef = ref.child("users");

Map<String, User> users = new HashMap<>();
users.put("John Park", new User("parkjmjohn@gmail.com"));

usersRef.setValueAsync(users);
