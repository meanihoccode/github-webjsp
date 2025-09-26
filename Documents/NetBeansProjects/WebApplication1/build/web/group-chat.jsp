<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Group Chat</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <style>
        body {
            background-color: #f7f7f7;
        }

        .message-item {
            padding: 10px 15px;
            background-color: #6f42c1;
            border-radius: 15px;
            color: white;
            display: inline-block;
            margin-top: 10px;
            max-width: 70%;
            word-wrap: break-word;
            font-size: 16px;
            font-weight: 500;
            clear: both;
        }

        .form-send {
            position: fixed;
            max-width: 80%;
            bottom: 20px;
            right: 0;
        }

        #message-box {
            height: 70vh;
            overflow-y: auto;
            padding: 10px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            margin-bottom: 100px;
        }

        .mine {
            float: right;
            background-color: #007bff !important;
        }

        label {
            display: block;
            margin-bottom: 4px;
            font-weight: bold;
            color: #333;
        }

        .sender-name {
            clear: both;
        }

        button.btn-primary {
            border-radius: 20px;
            padding: 6px 20px;
        }

        #comment-text {
            border-radius: 20px;
            padding: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Group Chat!</h1>

    <!-- Vùng hiển thị tin nhắn -->
    <div id="message-box"></div>

    <form method="POST" action="./group-chat.jsp">
        <input type="hidden" name="user_id" id="user_id" value="1"><!-- Thay 1 bằng ID thực tế -->
        <input id="comment-text" name="comment" type="text" class="form-control" placeholder="Chat...">
        <button type="button" onclick="createMessage()" class="btn btn-primary mt-2">Send</button>
    </form>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>

<script>
    const myUserId = document.getElementById("user_id").value;

    callApi();
    setInterval(() => {
        callApi();
    }, 5000);

    function callApi() {
        $.ajax({
            url: "http://localhost:8080/WebApplication1/message",
            type: "GET",
            success: function (data) {
                if (typeof data === "string") {
                    data = JSON.parse(data);
                }

                let htmls = "";
                for (let i = 0; i < data.length; i++) {
                    let name = data[i].user.firstname;
                    let content = data[i].content;
                    let userId = data[i].user.id;
                    let cssClass = (userId == myUserId) ? "mine" : "";

                    htmls += '<div class="sender-name"><label>' + name + '</label></div>' +
                             '<div class="message-item ' + cssClass + '">' + content + '</div><br>';
                }

                document.getElementById("message-box").innerHTML = htmls;
                let box = document.getElementById("message-box");
                box.scrollTop = box.scrollHeight;
            },
            error: function (xhr) {
                console.error("Lỗi khi gọi API:", xhr);
            }
        });
    }

    function createMessage() {
        let element = document.querySelector("#comment-text");
        $.ajax({
            url: "http://localhost:8080/WebApplication1/message",
            type: "POST",
            data: {
                message: element.value
            },
            success: function (data) {
                console.log("Gửi tin nhắn thành công:", data);
                element.value = "";
                callApi();
            },
            error: function (xhr) {
                console.error("Lỗi khi gửi tin nhắn:", xhr);
            }
        });
    }
</script>
</body>
</html>
