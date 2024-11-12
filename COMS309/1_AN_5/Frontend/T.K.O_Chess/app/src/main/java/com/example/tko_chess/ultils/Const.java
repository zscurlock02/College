package com.example.tko_chess.ultils;

/**
 * @author Zachary Scurlock, Lex Somers
 */
public class Const {

    public static final String URL_SERVER_AN5 = "http://coms-309-005.class.las.iastate.edu:8080";



    public static final String URL_SERVER_GETUSERS = "http://coms-309-005.class.las.iastate.edu:8080/getusers";



    public static final String URL_SERVER_USERS = "http://coms-309-005.class.las.iastate.edu:8080/users/";

    public static final String URL_SERVER_LOGIN = "http://coms-309-005.class.las.iastate.edu:8080/users/login";



    public static final String URL_SERVER_GETUSERSTATS = "http://coms-309-005.class.las.iastate.edu:8080/getUserStats/";

    public static final String URL_SERVER_CHANGEUSERNAME = "http://coms-309-005.class.las.iastate.edu:8080/users/username/";

    public static final String URL_SERVER_CHANGEPASSWORD = "http://coms-309-005.class.las.iastate.edu:8080/users/password/";



    //Concatenate desired User's username
    public static final String URL_SERVER_GETUSER = "http://coms-309-005.class.las.iastate.edu:8080/users/getByName/";



    //This URL can be used to GET the friends list, and also to REMOVE a friend from the list.
    //For GET, concatenate currUser's Username. For REMOVE, concatenate currUser's username and the friend being removed
    public static final String URL_SERVER_FRIENDSLIST = "http://coms-309-005.class.las.iastate.edu:8080/friends/";

    //Used for sending a friend request to another user
    public static final String URL_SERVER_SENDFRIENDREQUEST = "http://coms-309-005.class.las.iastate.edu:8080/friendRequest/";

    //Used for denying a friend request sent to you, or canceling a friend request you sent to somebody.
    public static final String URL_SERVER_DELETEFRIENDREQUEST = "http://coms-309-005.class.las.iastate.edu:8080/deleteFriendRequest/";

    //Used for accepting a friend request sent to you.
    public static final String URL_SERVER_ACCEPTFRIENDREQUEST = "http://coms-309-005.class.las.iastate.edu:8080/acceptFriendRequest/";

    //Used to confirm if lobby exists.
    public static final String URL_SERVER_LOBBYFIND = "http://coms-309-005.class.las.iastate.edu:8080/lobby/find/";

    //Lobby WebSocket Address
    public static final String URL_SERVER_WEBSOCKETLOBBY = "ws://coms-309-005.class.las.iastate.edu:8080/websocket/lobby/";

    //Boxing WebSocket Address
    public static final String URL_SERVER_WEBSOCKETBOXING = "ws://coms-309-005.class.las.iastate.edu:8080/websocket/boxing/";

    //WebSocket Address for Chess
    public static final String URL_CHESS_WEBSOCKET = "ws://coms-309-005.class.las.iastate.edu:8080/chess/";

    //Boxing Test URL
    public static final String URL_SERVER_BOXINGTEST = "http://coms-309-005.class.las.iastate.edu:8080/boxingGame/";
}
