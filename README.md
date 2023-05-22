# Check if the user is logged in Flutter & firebase auth

When developing a Flutter app that uses Firebase authentication, it's important to manage the app's flow based on the user's login sessions. There are two methods to check if a user is logged in using Firebase Auth.

## Method 1: Utilizing the authStateChanges() Stream

FirebaseAuth provides the authStateChanges() method, which returns a stream of the current user's authentication state. This stream is automatically triggered whenever a user logs in or out, eliminating the need to manually handle the state.

```
StreamBuilder<User?>(
   stream: FirebaseAuth.instance.authStateChanges(),
   builder: (context, snapshot) {
     return Text(
       "User Detail: ${snapshot.data != null ? snapshot.data?.email : "User not found"}” 
);
})
   ```
   
## Method 2: Checking the currentUser Property
Another approach is to utilize the currentUser property provided by FirebaseAuth. This property returns the currently authenticated user. If the currentUser is null, it means the user is logged out; otherwise, the user is currently logged in.
```
Text(
 "User Detail: ${FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser?.email : "User not found"}"
),
```
