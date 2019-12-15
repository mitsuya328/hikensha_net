var ready;

ready = function() {
  var dateFormat;
  dateFormat = 'yy-mm-dd';
  return $('.date-picker').datepicker({
    dateFormat: dateFormat,
    minDate: 0
  });
};

$(document).ready(ready);

$(document).on('turbolinks:load', ready);