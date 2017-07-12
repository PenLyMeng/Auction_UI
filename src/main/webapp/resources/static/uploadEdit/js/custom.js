    // File to Send to Server
    var newFiles = [];
    // Old File Name
    var deletedImageIDs = [];
    // Input File Element
    var inputFile = [];

    //Example 2
    function initJqueryFiler(fileElements, uploadedImagesArr){

        var checkAfterShow = true;

        for (var i = 0; i < fileElements.length; i++){
            var keyName = fileElements[i].substr(1);

            // Each File Array
            newFiles[keyName] = [];
            deletedImageIDs[keyName] = [];

            // Input Element
            inputFile[keyName] = $(fileElements[i])[0];

            $(fileElements[i]).filer({
                extensions: ['jpeg', 'jpg', 'png', 'gif', 'bmp'],
                changeInput: '<a class="jFiler-input-choose-btn blue" id="browse_gallery"><i class="glyphicon glyphicon-circle-arrow-up"></i> Browse Gallery</a>',
                showThumbs: true,
                theme: "dragdropbox",
                templates: {
                    box: '<ul class="jFiler-items-list jFiler-items-grid"></ul>',
                    item: '<li class="jFiler-item">\
                                <div class="jFiler-item-container">\
                                    <div class="jFiler-item-inner">\
                                        <div class="jFiler-item-thumb">\
                                            <div class="jFiler-item-status"></div>\
                                            <div class="jFiler-item-info">\
                                            </div>\
                                            {{fi-image}}\
                                        </div>\
                                        <div class="jFiler-item-assets jFiler-row">\
                                            <ul class="list-inline pull-left">\
                                                <li>{{fi-progressBar}}</li>\
                                            </ul>\
                                            <ul class="list-inline pull-right">\
                                                <li><a class="icon-jfi-trash jFiler-item-trash-action"></a></li>\
                                            </ul>\
                                        </div>\
                                    </div>\
                                </div>\
                            </li>',
                    itemAppend: '<li class="jFiler-item">\
                                    <div class="jFiler-item-container">\
                                        <div class="jFiler-item-inner">\
                                            <div class="jFiler-item-thumb">\
                                                <div class="jFiler-item-status"></div>\
                                                <div class="jFiler-item-info">\
                                                </div>\
                                                {{fi-image}}\
                                            </div>\
                                            <div class="jFiler-item-assets jFiler-row">\
                                                <ul class="list-inline pull-left">\
                                                    <li><span class="jFiler-item-others">{{fi-icon}}</span></li>\
                                                </ul>\
                                                <ul class="list-inline pull-right">\
                                                    <li><a class="icon-jfi-trash jFiler-item-trash-action"></a></li>\
                                                </ul>\
                                            </div>\
                                        </div>\
                                    </div>\
                                </li>',
                    itemAppendToEnd: false,
                    removeConfirmation: false,
                    progressBar: '<div class="bar"></div>',
                    _selectors: {
                        list: '.jFiler-items-list',
                        item: '.jFiler-item',
                        progressBar: '.bar',
                        remove: '.jFiler-item-trash-action'
                    }
                },
                addMore: false,
                uploadFile: {
                    error: function(el){
                        //el.find(".jFiler-jProgressBar").hide();
                    }
                },
                files: uploadedImagesArr[i],
                afterShow: function(a,b,c, currentInputFile){
                    // Push to Associate Array by ID Name
                    var inputName = currentInputFile.attr('id');
                    $.each(currentInputFile[0].files, function(index, file) {
                        newFiles[inputName].push(file);
                    });
                },
                onRemove: function(itemEl, currentFile, id, listEl, boxEl, newInputEl, inputEl){
                    var inputName = inputEl.attr('id');
                    var isImageFromServer = itemEl.find('ul:first i').hasClass('icon-jfi-file-image');

                    if (isImageFromServer){
                        // Get Deleted Image name
                        deletedImageIDs[inputName].push(currentFile.id);
                    } else {
                        var temp;
                        $.each(newFiles[inputName], function(index, item) {
                            if (item.name === currentFile.name) {
                                temp = item;
                                return;
                            }
                        });
                        newFiles[inputName].splice(newFiles[inputName].indexOf(temp), 1);                
                    }
                },
                onEmpty: null,
                captions: {
                    button: "Choose Files",
                    feedback: "Choose files To Upload",
                    feedback2: "files were chosen",
                    drop: "Drop file here to Upload",
                    removeConfirmation: "Are you sure you want to remove this file?",
                    errors: {
                        filesLimit: "Only {{fi-limit}} files are allowed to be uploaded.",
                        filesType: "Only Images are allowed to be uploaded.",
                        filesSize: "{{fi-name}} is too large! Please upload file up to {{fi-maxSize}} MB.",
                        filesSizeAll: "Files you've choosed are too large! Please upload files up to {{fi-maxSize}} MB."
                    }
                }
            });
        }

        
    }
