<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <script>
        $(document).ready(function () {
            $('#file_input').change(function () {
            onDrop(this);
        });});
 
        function onDrop(e) {
            //var files=null;
            ReadFile(e);
        }
        function ReadFile(files) {
            var file = files.files[0];
            var filename = getFileName(file.name);
            var reader = new FileReader();
            reader.onerror = function (e) {
                alert('Error code: ' + e.target.error);
            };// Create a closure to capture the file information.
            reader.onload = (function (aFile) {
                return function(evt) {
                    var fd = new window.FormData();
                    fd.append('file', file);
                    fd.append('filename', filename);
                    if (file.size > 3000000)alert("file size is very big. Maximum size is 3MB");
                    debugger;
                    $.ajax({
                        url: "UploadFile.ashx",
                        type: 'POST',
                        processData: false,
                        contentType: false,
                        data: fd,
                        responseType: "json",
                        success: function(result) {
                            if (result.Operation == 'success') {
                                //alert('File Uploaded Successfully');
                                debugger;

                                $("#uploader").after("<img src=\"" + location.hostname +":"+location.port+"/uploadedImg/"+ result.FileName + "\" />");
                            }
                        },
                        error: function(fail) {

                        }
                    });
                };
            })(file); 
            reader.readAsDataURL(file);
        }
        
        function getFileName(fullPath) {
            var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
            var filename = fullPath.substring(startIndex);
            if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
                filename = filename.substring(1);
            }
            return filename;
        }
 
</script>
<%--<input type="file" id="mul_FileUpload" />
  --%>
     <div id="uploader" class="image-upload">
    <label for="file_input">
        <img src="/img/add.png" alt="add_img" style="width: 150px;"/>
    </label>

    <input id="file_input" type="file"/>
</div>
    <style type="text/css">
        .image-upload > input
            {
                display: none;
            }
    </style>
</asp:Content>
