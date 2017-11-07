From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:37:01 +0100
Subject: [PATCH v2 06/15] ima: add parser of digest lists metadata
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-7-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Digest lists can be uploaded to IMA by supplying the path of their
metadata.

Digest list metadata are:

- DATA_ALGO: algorithm of the digests to be uploaded
- DATA_DIGEST: digest of the file containing the digest list
- DATA_SIGNATURE: signature of the file containing the digest list
- DATA_FILE_PATH: pathname
- DATA_REF_ID: reference ID of the digest list
- DATA_TYPE: type of digest list

The new function ima_load_digest_list_metadata() loads digest list metadata
from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
becomes available. Digest lists must be loaded before IMA appraisal is in
enforcing mode.

The new function ima_parse_digest_list_metadata() parses the metadata and
loads each digest list individually. Then, it parses the data according to
the data type specified.

To avoid the delay due to extending a PCR for each digest list, digests of
digest lists are added to the hash table. If appraisal is in enforcing
mode, this is done only if the signature verification succeeds. IMA does
not add the digest of an accessed file to the measurement list if the
digest is found in the hash table.

Changelog

v1:
- Verify signature of digest lists if appraisal is enabled
- Load digest lists when rootfs is available
- Ignore digest lists if no policy is loaded

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/fs.h                       |   2 +
 security/integrity/iint.c                |   1 +
 security/integrity/ima/Kconfig           |  19 ++++
 security/integrity/ima/Makefile          |   1 +
 security/integrity/ima/ima.h             |  12 +++
 security/integrity/ima/ima_digest_list.c | 152 +++++++++++++++++++++++++++++++
 security/integrity/integrity.h           |   8 ++
 7 files changed, 195 insertions(+)
 create mode 100644 security/integrity/ima/ima_digest_list.c

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8d7d2850963c..06737235665b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2793,6 +2793,8 @@ extern int do_pipe_flags(int *, int);
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(DIGEST_LIST_METADATA, digest-list-metadata)	\
+	id(DIGEST_LIST, digest-list)	\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index c84e05866052..68c14d1dfc0c 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -209,4 +209,5 @@ void __init integrity_load_keys(void)
 {
 	ima_load_x509();
 	evm_load_x509();
+	ima_load_digest_list_metadata();
 }
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 35ef69312811..fa40cee1e1a2 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -227,3 +227,22 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_DIGEST_LIST
+	bool "Measure/appraise/audit files depending on uploaded digest lists"
+	depends on IMA
+	default n
+	help
+	   This option allows users to load digest lists. If a measured file
+	   has the same digest of one from loaded lists, IMA will not create
+	   a new measurement entry or an audit log. They will be created only
+	   when digest lists are loaded. If appraisal is enabled, access will
+	   be permitted if the digest is in the digest list. File updates
+	   will be permitted if, in addition, the digest is marked as mutable.
+
+config IMA_DIGEST_LIST_METADATA_PATH
+	string "IMA digest list metadata path"
+	depends on IMA_DIGEST_LIST
+	default "/etc/ima/digest_lists/metadata"
+	help
+	   This option defines IMA digest list metadata path.
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 29f198bde02b..00dbe3a8cb71 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -9,4 +9,5 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
+ima-$(CONFIG_IMA_DIGEST_LIST) += ima_digest_list.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1f6591a57fea..1f43284788eb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -158,6 +158,18 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 struct ima_digest *ima_lookup_loaded_digest(u8 *digest);
 int ima_add_digest_data_entry(u8 *digest, u8 is_mutable);
+#ifdef CONFIG_IMA_DIGEST_LIST
+void __init ima_load_digest_list_metadata(void);
+ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf);
+#else
+static inline void ima_load_digest_list_metadata(void)
+{
+}
+static inline ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf)
+{
+	return -ENOTSUPP;
+}
+#endif
 int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
new file mode 100644
index 000000000000..28172424e5a2
--- /dev/null
+++ b/security/integrity/ima/ima_digest_list.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_digest_list.c
+ *      Functions to manage digest lists.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/vmalloc.h>
+
+#include "ima.h"
+#include "ima_template_lib.h"
+
+enum digest_metadata_fields {DATA_ALGO, DATA_DIGEST, DATA_SIGNATURE,
+			     DATA_FILE_PATH, DATA_REF_ID, DATA_TYPE,
+			     DATA__LAST};
+
+static int ima_parse_digest_list_data(struct ima_field_data *data)
+{
+	void *digest_list;
+	loff_t digest_list_size;
+	u16 data_algo = le16_to_cpu(*(u16 *)data[DATA_ALGO].data);
+	u16 data_type = le16_to_cpu(*(u16 *)data[DATA_TYPE].data);
+	int ret;
+
+	if (data_algo != ima_hash_algo) {
+		pr_err("Incompatible digest algorithm, expected %s\n",
+		       hash_algo_name[ima_hash_algo]);
+		return -EINVAL;
+	}
+
+	ret = kernel_read_file_from_path(data[DATA_FILE_PATH].data,
+					 &digest_list, &digest_list_size,
+					 0, READING_DIGEST_LIST);
+	if (ret < 0) {
+		pr_err("Unable to open file: %s (%d)",
+		       data[DATA_FILE_PATH].data, ret);
+		return ret;
+	}
+
+	switch (data_type) {
+	default:
+		pr_err("Parser for data type %d not implemented\n", data_type);
+		ret = -EINVAL;
+	}
+
+	if (ret < 0) {
+		pr_err("Error parsing file: %s (%d)\n",
+		       data[DATA_FILE_PATH].data, ret);
+		return ret;
+	}
+
+	vfree(digest_list);
+	return ret;
+}
+
+ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf)
+{
+	struct ima_field_data entry;
+
+	struct ima_field_data entry_data[DATA__LAST] = {
+		[DATA_ALGO] = {.len = sizeof(u16)},
+		[DATA_TYPE] = {.len = sizeof(u16)},
+	};
+
+	DECLARE_BITMAP(data_mask, DATA__LAST);
+	void *bufp = buf, *bufendp = buf + size;
+	int ret;
+
+	bitmap_zero(data_mask, DATA__LAST);
+	bitmap_set(data_mask, DATA_ALGO, 1);
+	bitmap_set(data_mask, DATA_TYPE, 1);
+
+	ret = ima_parse_buf(bufp, bufendp, &bufp, 1, &entry, NULL, NULL,
+			    ENFORCE_FIELDS, "metadata list entry");
+	if (ret < 0)
+		return ret;
+
+	ret = ima_parse_buf(entry.data, entry.data + entry.len, NULL,
+			    DATA__LAST, entry_data, NULL, data_mask,
+			    ENFORCE_FIELDS | ENFORCE_BUFEND,
+			    "metadata entry data");
+	if (ret < 0)
+		goto out;
+
+	if (ima_policy_flag & IMA_APPRAISE) {
+		ret = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
+				(const char *)entry_data[DATA_SIGNATURE].data,
+				entry_data[DATA_SIGNATURE].len,
+				entry_data[DATA_DIGEST].data,
+				entry_data[DATA_DIGEST].len);
+		if (ret < 0) {
+			pr_err("Failed signature verification of: %s (%d)",
+				entry_data[DATA_FILE_PATH].data, ret);
+			goto out_parse_digest_list;
+		}
+	}
+
+	ret = ima_add_digest_data_entry(entry_data[DATA_DIGEST].data, 0);
+	if (ret < 0) {
+		if (ret == -EEXIST)
+			ret = 0;
+
+		goto out;
+	}
+
+out_parse_digest_list:
+	ret = ima_parse_digest_list_data(entry_data);
+out:
+	return ret < 0 ? ret : bufp - buf;
+}
+
+void __init ima_load_digest_list_metadata(void)
+{
+	void *datap;
+	loff_t size;
+	int ret;
+
+	int unset_flags = ima_policy_flag & IMA_APPRAISE;
+
+	if (!ima_policy_flag)
+		return;
+
+	ima_policy_flag &= ~unset_flags;
+	ret = kernel_read_file_from_path(CONFIG_IMA_DIGEST_LIST_METADATA_PATH,
+					 &datap, &size, 0,
+					 READING_DIGEST_LIST_METADATA);
+	if (ret < 0)
+		pr_err("Unable to open file: %s (%d)",
+		       CONFIG_IMA_DIGEST_LIST_METADATA_PATH, ret);
+
+	ima_policy_flag |= unset_flags;
+
+	while (size > 0) {
+		ret = ima_parse_digest_list_metadata(size, datap);
+		if (ret < 0) {
+			pr_err("Unable to parse file: %s (%d)",
+			       CONFIG_IMA_DIGEST_LIST_METADATA_PATH, ret);
+			break;
+		}
+		datap += ret;
+		size -= ret;
+	}
+}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e1bf040fb110..a5951879c15c 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -174,6 +174,14 @@ static inline void evm_load_x509(void)
 }
 #endif
 
+#ifdef CONFIG_IMA_DIGEST_LIST
+void __init ima_load_digest_list_metadata(void);
+#else
+static inline void ima_load_digest_list_metadata(void)
+{
+}
+#endif
+
 #ifdef CONFIG_INTEGRITY_AUDIT
 /* declarations */
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
