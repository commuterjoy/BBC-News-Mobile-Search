
var ls = function() {

    this.id = 'history';

    this.fetch = function(){
        var value = window.localStorage.getItem(this.id)
        return (value) ? value.split(";") : [];
    };

    this.clear = function(){
        window.localStorage.setItem(this.id, '');
    };

    this.add = function(term) {

        if (term.length == 0) {
            return false;
        }

        // does term exist ?
        var exists = this.fetch().some(function(element){
            return element == term
        });

        if (!exists) {
            var update = this.fetch();
            update.push(term);
            window.localStorage.setItem(this.id, update.join(";"));
        }

        return exists;
    };

    this.render = function() {
        var html = this.fetch().map(function(element){
            return '<a href="/news/search?q='+element+'">'+element+'</a>';
        });
        return html.join('');
    }
}

if (window.localStorage)
{
    var store = new ls();

    function render(){
        document.getElementById('favourite-list').innerHTML = store.render();
    }

    render();

    document.getElementById('favourite-clear').addEventListener('click', function(){
        store.clear();
        render();
        }, false);

    document.getElementById('favourite').addEventListener('click', function(){
        var term = document.getElementById('q').value;
        store.add(term);
        render();
        }, false);
}

