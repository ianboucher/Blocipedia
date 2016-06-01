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

    $('.typeahead-wiki').typeahead(null, {
        name: 'engine',
        displayKey: 'title',
        source: engine.ttAdapter()
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);

// $(document).ready(function(){
//   var converter = new Showdown.converter()
//     $('#wiki_body').keyup(function() {
//       var content = $('#wiki_body').val()
//       $('#preview_text').text(
//         converter.makeHtml(content)
//       );
//     });
// });

$(document).ready(function(){
  $('#wiki_body').keyup(function() {
  var input = document.getElementById('wiki_body').value,
      target = document.getElementById('preview_text'),
      converter = new Showdown.converter();
      html = converter.makeHtml(input);

      target.innerHTML = html
    })
});

$(document).ready(function(){
  var input = document.getElementById('show_wiki').value,
      target = document.getElementById('show_wiki'),
      converter = new Showdown.converter();
      html = converter.makeHtml(input);

      target.innerHTML = html
});
