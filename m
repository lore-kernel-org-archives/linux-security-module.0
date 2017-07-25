From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 25 Jul 2017 17:44:17 +0200
Subject: [PATCH 06/12] ima: added parser of digest lists metadata
In-Reply-To: <20170725154423.24845-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
Message-ID: <20170725154423.24845-7-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Userspace applications will be able to load digest lists by supplying
their metadata.

Digest list metadata are:

- DATA_ALGO: algorithm of the digests to be uploaded
- DATA_DIGEST: digest of the file containing the digest list
- DATA_SIGNATURE: signature of the file containing the digest list
- DATA_FILE_PATH: pathname
- DATA_REF_ID: reference ID of the digest list
- DATA_TYPE: type of digest list

The new function ima_parse_digest_list_metadata() parses the metadata
and load each file individually. Then, it parses the data according
to the data type specified.

Since digest lists are measured, their digest is added to the hash table
so that IMA does not create a measurement entry for them (which would
affect the performance). The only measurement entry created will be
for the metadata.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/fs.h                       |   1 +
 security/integrity/ima/Kconfig           |  11 ++++
 security/integrity/ima/Makefile          |   1 +
 security/integrity/ima/ima.h             |   8 +++
 security/integrity/ima/ima_digest_list.c | 105 +++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+)
 create mode 100644 security/integrity/ima/ima_digest_list.c

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e1fd5d..2eb6e7c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2751,6 +2751,7 @@ extern int do_pipe_flags(int *, int);
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
+	id(DIGEST_LIST, security-digest-list)	\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 35ef693..8965dcc 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -227,3 +227,14 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_DIGEST_LIST
+	bool "Measure files depending on uploaded digest lists"
+	depends on IMA
+	default n
+	help
+	   This option allows users to load digest lists. If a measured
+	   file has the same digest of one from loaded lists, IMA will
+	   not create a new measurement entry. A measurement entry will
+	   be created only when digest lists are loaded (this entry
+	   contains the digest of digest lists metadata).
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 29f198b..00dbe3a 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -9,4 +9,5 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
+ima-$(CONFIG_IMA_DIGEST_LIST) += ima_digest_list.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a0c6808..77dd4d0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -157,6 +157,14 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 struct ima_digest *ima_lookup_loaded_digest(u8 *digest);
 int ima_add_digest_data_entry(u8 *digest);
+#ifdef CONFIG_IMA_DIGEST_LIST
+ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf);
+#else
+static inline ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf)
+{
+	return -ENOTSUP;
+}
+#endif
 int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
new file mode 100644
index 0000000..3e1ff69b
--- /dev/null
+++ b/security/integrity/ima/ima_digest_list.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2017 Huawei Technologies Co. Ltd.
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
+	ret = ima_add_digest_data_entry(entry_data[DATA_DIGEST].data);
+	if (ret < 0) {
+		if (ret == -EEXIST)
+			ret = 0;
+
+		goto out;
+	}
+
+	ret = ima_parse_digest_list_data(entry_data);
+out:
+	return ret < 0 ? ret : bufp - buf;
+}
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
