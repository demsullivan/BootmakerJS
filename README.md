bootstrapeditor
===============

## Quick Start

Requires jQuery, jQuery UI and Bootstrap.

Start off with a simple file like this:

```
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Bootstrap Editor Demo</title>
    <link rel="stylesheet" type="text/css" href="/path/to/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="/path/to/jquery-ui.css"/>
  </head>
  <body>
    <div class="container" id="maincontent">
      <div class="row-fluid" bse-row="">
        <div class="span3" bse-col="">LEFT COLUMN</div>
	<div class="span6" bse-col="">CENTER COLUMN</div>
	<div class="span3" bse-col="">RIGHT COLUMN</div>
      </div>
    </div>
    <script type="text/javascript" src="/path/to/jquery.js"></script>
    <script type="text/javascript" src="/path/to/jquery-ui.js"></script>
    <script type="text/javascript" src="/path/to/pageeditor.js"></script>
    <script type="text/javascript">
      var PageEditor = new BootstrapEditor({
        el: '#maincontent',
	prefix: 'bse',
	cssPrefix: 'bse-edit'
      });
    </script>
  </body>
</html>
```