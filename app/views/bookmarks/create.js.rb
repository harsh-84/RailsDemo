$('.create_bookmark').bind('ajax:success', function() {
   $(this).closest('tr').fadeOut();
});