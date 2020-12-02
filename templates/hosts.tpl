[master]
%{ for ip in cks_master ~}
${ip}
%{ endfor ~}
[worker]
%{ for ip in cks_worker ~}
${ip}
%{ endfor ~}