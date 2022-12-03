let
  issue = {
    number = "001";
    date = "2022-12-03";

    links = [
      {
        text = ''hello, this is super interesting'';
        url = "https://localhost/";
      }
    ];

    news = [
      "Wow, such a thing!"
    ];

    tips = ''

    '';

    artwork = {
      caption = "";
      url = "";
      author = "";
    };

    events = [
    ];

    editors = ''
      <p>Hello from the editorial team!</p>
    '';
  };
in
  issue
