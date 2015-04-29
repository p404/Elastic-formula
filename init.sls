elasticsearch_repo:
  pkgrepo.managed:
    - humanname: Elasticsearch PPA
    - name: deb http://packages.elasticsearch.org/elasticsearch/1.5/debian stable main
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: elasticsearch_soft


elasticsearch_soft:
  pkg.installed:
    - name: elasticsearch
{% if not salt['file.directory_exists']('/usr/share/elasticsearch/plugins/marvel') %}
  cmd.run:
    - name: bin/plugin -i elasticsearch/marvel/latest
    - cwd: /usr/share/elasticsearch/
    - require_in:
        - service: elasticsearch
{% endif %}


update_rc.d-elasticsearch:
  cmd.run:
    - name: update-rc.d elasticsearch defaults 95 10
    - require:
      - pkg: elasticsearch


elasticsearch:
  service.running:
    - enable: True
