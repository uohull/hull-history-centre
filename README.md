# Getting Started

* rake jetty:unzip
* rake configure\_jetty
* rake jetty:start
* cp config/secrets.yml.template config/secrets.yml
* Edit secrets.yml and fill in values
* rails s

# Importing Records

Import all \*.xml files within a directory:

```bash
rake import:ead['path/to/your/ead/files']
```

Import specific EAD files:

```bash
rake import:ead['spec/fixtures/sample_ead_files/U_DDH.xml, spec/fixtures/sample_ead_files/U_DAR.xml']
```

Note that there is not a space between the rake task name and the square bracket that begins the arguments list, and that there are qutoes around the argument list.

