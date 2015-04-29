kibana:
  archive:
    - extracted
    - name: /opt/
    - source: http://download.elastic.co/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz
    - source_hash: md5=ae5019e3c36a03fc57a069c235ca97e4
    - archive_format: tar
    - if_missing: /opt/kibana-4.0.1-linux-x64/


kibana_init.d:
  file.managed:
    - name: '/etc/init.d/kibana4'
    - source: salt://elk/files/kibana4


update_rc.d-kibana:
  cmd.run:
    - name: chmod +x /etc/init.d/kibana4 && update-rc.d kibana4 defaults 96 9

kibana4:
  service.running:
    - enable: True