// Provide search suggestion/autocompletion for wikis
var ready;
ready = function() {
    var engine = new Bloodhound({
        datumTokenizer: function(d) {
            console.log(d);
            return Bloodhound.tokenizers.whitespace(d.title);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '../wikis/autocomplete?query=%QUERY',
            wildcard: '%QUERY'
        }
    });

    var promise = engine.initialize();

    promise
        .done(function() { console.log('success!'); })
        .fail(function() { console.log('err!'); });

    $('.search-wiki').typeahead(null, {
        name: 'engine',
        displayKey: 'title',
        source: engine.ttAdapter()
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);


// Parse markdown using Showdown
function parseMarkdown(source, target) {
  if (document.getElementById(source)) {
    var input =  document.getElementById(source).value ||
                 document.getElementById(source).innerHTML,
        target = document.getElementById(target),
        converter = new Showdown.converter();
        html = converter.makeHtml(input);
        target.innerHTML = html;
      }
};

// Provide live preview of markdown in wiki edit/create page
$(document).ready(function(){
  $('#wiki_body').keyup(function() {
    var html = parseMarkdown('wiki_body', 'preview_text')
  });
});

// Parse markdown on page load for wiki show page
$(document).ready(function(){
    var html = parseMarkdown('show_wiki', 'show_wiki')
});
