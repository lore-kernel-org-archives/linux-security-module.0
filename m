From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 16 May 2017 14:53:40 +0200
Subject: [PATCH 0/7] IMA: new parser for ima_restore_measurement_list()
Message-ID: <20170516125347.10574-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A new IMA measurement list format, called Crypto Agile, will be introduced
shortly to take full advantage of the algorithm flexibility of TPM 2.0.
With the new format, it will be possible to provide for each list entry
multiple digests, each calculated with an algorithm supported by the TPM.
Those digests will be used by remote entities to verify the integrity of
the measurements list.

The current (SHA1) and the new (Crypto Agile) format definitions are:

SHA1: pcr[4] digest[20]
      template_name_len[4] template_name[template_name_len]
      template_data_len[4] template_data[template_data_len]

Crypto Agile: pcr[4] total_digest_len[4]
              digest1_len[4] digest1[digest1_len] ...
              digestN_len[4] digestN[digestN_len]
              template_name_len[4] template_name[template_name_len]
              template_data_len[4] template_data[template_data_len]

IMA must be able to parse lists with these formats, in order to restore
a measurement list after kexec(). This functionality is implemented
in ima_restore_measurement_list().

With the SHA1 format, the measurement entry header is parsed by casting
a buffer to two structures (binary_hdr_v1 and binary_data_v1), whose
members have the same length of the fields mentioned above.

Since clang does not support variable-length arrays in structures (VLAIS),
the binary_hdr_v1 should be split in two parts, to parse the Crypto Agile
format: one for pcr and digests with variable length, and the other
for template name. This would make the parsing code more complex,
as casting would have been done with three structures.

Given that in most cases, in the binary format of measurements, a length
field is prepended to data, a better solution would be to use only one
function to parse all length-data combinations.

This patch set introduces a new function, called ima_parse_buf(), which
takes as input a buffer and writes lengths and pointers of parsed data
to an array of ima_field_data structures, currently used for template
data fields. ima_restore_measurement_list() and ima_restore_template_data()
are modified to use the new function.

This patch set also introduces two new securityfs interfaces, for testing
purposes, to save the binary measurements list with the kexec header and
to restore it.

Finally, a list entry size calculation issue is fixed in the last patch.

Roberto Sassu (7):
  ima: introduce ima_parse_buf()
  ima: use ima_parse_buf() to parse measurements headers
  ima: use ima_parse_buf() to parse template data
  ima: declare get_binary_runtime_size() as non-static
  ima: add securityfs interface to save a measurements list with kexec
    header
  ima: add securityfs interface to restore a measurements list
  ima: fix get_binary_runtime_size()

 security/integrity/ima/Kconfig            |   8 ++
 security/integrity/ima/ima.h              |   3 +
 security/integrity/ima/ima_fs.c           |  80 +++++++++++++++++--
 security/integrity/ima/ima_kexec.c        |   2 +-
 security/integrity/ima/ima_queue.c        |   6 +-
 security/integrity/ima/ima_template.c     | 126 ++++++++++--------------------
 security/integrity/ima/ima_template_lib.c |  80 +++++++++++++++++++
 security/integrity/ima/ima_template_lib.h |   8 ++
 8 files changed, 217 insertions(+), 96 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
