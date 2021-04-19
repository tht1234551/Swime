console.log("studyListService Module.....");

let studyListService = (function(){

    function getList(param, callback, error) {

        console.log("param=" + param);

        let grpSn = param.grpSn;
        let page = param.page || 1;

        console.log("grpSn = " + grpSn);
        console.log("page = " + page);

        $.getJSON("/study/list/" + grpSn + "/" + page + ".json",
            function(data) {
                console.log(data);
                if(callback) {
                    callback(data.count, data.list);
                }
            }).fail(function(xhr, status, err) {
            if(error) {
                error();
            }
        })
    }
    return {
        getList : getList
    };
})();