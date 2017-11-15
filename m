From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 15 Nov 2017 14:39:22 +0100
Subject: [USER SPACE][RFC][PATCH 1/5] digest-list-tools: headers
In-Reply-To: <20171115133926.20108-1-roberto.sassu@huawei.com>
References: <20171115133926.20108-1-roberto.sassu@huawei.com>
Message-ID: <20171115133926.20108-2-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch adds the headers used by the library. kernel_lib.h contains
definitions taken from the Linux kernel.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/compact_list.h |  25 +++++++++
 include/kernel_ima.h   |  54 ++++++++++++++++++++
 include/kernel_lib.h   | 135 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/lib.h          |  32 ++++++++++++
 include/metadata.h     |  32 ++++++++++++
 include/rpm.h          |  36 +++++++++++++
 6 files changed, 314 insertions(+)
 create mode 100644 include/compact_list.h
 create mode 100644 include/kernel_ima.h
 create mode 100644 include/kernel_lib.h
 create mode 100644 include/lib.h
 create mode 100644 include/metadata.h
 create mode 100644 include/rpm.h

diff --git a/include/compact_list.h b/include/compact_list.h
new file mode 100644
index 0000000..99066b0
--- /dev/null
+++ b/include/compact_list.h
@@ -0,0 +1,25 @@
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
+ * File: compact_list.h
+ *      Header of compact_list.c.
+ */
+
+#ifndef _COMPACT_LIST_H
+#define _COMPACT_LIST_H
+
+#include "kernel_ima.h"
+#include "rpm.h"
+
+int compact_list_from_rpm(Header rpm, char *outdir, char *output_filename);
+int compact_list_from_digest_list_ascii(char *input_filename, char *outdir,
+					char *output_filename, int is_mutable);
+
+#endif /*_COMPACT_LIST_H*/
diff --git a/include/kernel_ima.h b/include/kernel_ima.h
new file mode 100644
index 0000000..1b5fe1b
--- /dev/null
+++ b/include/kernel_ima.h
@@ -0,0 +1,54 @@
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
+ * File: kernel_ima.h
+ *      IMA functions header
+ */
+
+#ifndef _KERNEL_IMA_H
+#define _KERNEL_IMA_H
+
+#include "kernel_lib.h"
+#include "lib.h"
+
+#define ENFORCE_FIELDS 0x00000001
+#define ENFORCE_BUFEND 0x00000002
+
+extern int digests;
+extern int ima_hash_algo;
+
+struct compact_list_hdr {
+	u16 entry_id;
+	u32 count;
+	u32 datalen;
+} __attribute__((packed));
+
+struct ima_field_data {
+	u8 *data;
+	u_int32_t len;
+};
+
+enum digest_metadata_fields {DATA_ALGO, DATA_DIGEST, DATA_SIGNATURE,
+			     DATA_FILE_PATH, DATA_REF_ID, DATA_TYPE,
+			     DATA__LAST};
+
+enum digest_data_types {DATA_TYPE_COMPACT_LIST, DATA_TYPE_RPM};
+
+enum compact_list_entry_ids {COMPACT_DIGEST, COMPACT_DIGEST_MUTABLE};
+
+int ima_hash_setup(char *str);
+int ima_get_buflen(int maxfields, struct ima_field_data *fields,
+		   unsigned long *len_mask);
+int ima_write_buf(void *bufstartp, void *bufendp, void **bufcurp,
+		  int maxfields, struct ima_field_data *fields, int *curfields,
+		  unsigned long *len_mask, int enforce_mask, char *bufname);
+ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf);
+
+#endif /* _KERNEL_IMA_H */
diff --git a/include/kernel_lib.h b/include/kernel_lib.h
new file mode 100644
index 0000000..63ca9f2
--- /dev/null
+++ b/include/kernel_lib.h
@@ -0,0 +1,135 @@
+/*
+ * Copyright (C) 1991, 1992 Linus Torvalds
+ * Copyright 2007 rPath, Inc. - All Rights Reserved
+ * Copyright (c) 2013 Dmitry Kasatkin <d.kasatkin@samsung.com>
+ * Copyright (C) 2017 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: kernel_lib.h
+ *      Header of kernel_lib.c
+ */
+
+#ifndef _KERNEL_LIB_H
+#define _KERNEL_LIB_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <string.h>
+#include <linux/byteorder/little_endian.h>
+
+/* kernel types */
+typedef u_int8_t u8;
+typedef u_int16_t u16;
+typedef u_int32_t u32;
+typedef u_int64_t u64;
+typedef int bool;
+typedef long loff_t;
+
+enum kernel_read_file_id {READING_DIGEST_LIST_METADATA, READING_DIGEST_LIST};
+
+#define true 1
+#define false 0
+
+#define S_IWUGO         (S_IWUSR|S_IWGRP|S_IWOTH)
+#define S_IXUGO         (S_IXUSR|S_IXGRP|S_IXOTH)
+
+/* bitmap */
+#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
+#define BITS_PER_BYTE           8
+#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+#define BITS_PER_LONG 64
+#define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[BITS_TO_LONGS(bits)]
+
+#define small_const_nbits(nbits) \
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
+
+#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
+
+static inline bool constant_test_bit(int nr, const void *addr)
+{
+	const u32 *p = (const u32 *)addr;
+	return ((1UL << (nr & 31)) & (p[nr >> 5])) != 0;
+}
+
+#define test_bit(nr,addr) constant_test_bit((nr),(addr))
+
+/* errors */
+#define ENOENT           2      /* No such file or directory */
+#define ENOMEM          12      /* Out of memory */
+#define EACCES          13      /* Permission denied */
+#define EEXIST          17      /* File exists */
+#define EINVAL          22      /* Invalid argument */
+
+#define pr_err printf
+
+/* endianness conversion */
+#define be32_to_cpu __be32_to_cpu
+#define be16_to_cpu __be16_to_cpu
+#define le16_to_cpu __le16_to_cpu
+#define le32_to_cpu __le32_to_cpu
+#define cpu_to_le16 __cpu_to_le16
+#define cpu_to_le32 __cpu_to_le32
+
+/* crypto */
+#define CRYPTO_MAX_ALG_NAME             128
+
+#define MD5_DIGEST_SIZE         16
+#define SHA1_DIGEST_SIZE        20
+#define RMD160_DIGEST_SIZE      20
+#define SHA256_DIGEST_SIZE      32
+#define SHA384_DIGEST_SIZE      48
+#define SHA512_DIGEST_SIZE      64
+#define SHA224_DIGEST_SIZE      28
+#define RMD128_DIGEST_SIZE      16
+#define RMD256_DIGEST_SIZE      32
+#define RMD320_DIGEST_SIZE      40
+#define WP512_DIGEST_SIZE 64
+#define WP384_DIGEST_SIZE 48
+#define WP256_DIGEST_SIZE 32
+#define TGR192_DIGEST_SIZE 24
+#define TGR160_DIGEST_SIZE 20
+#define TGR128_DIGEST_SIZE 16
+#define SM3256_DIGEST_SIZE 32
+
+enum hash_algo {
+	HASH_ALGO_MD4,
+	HASH_ALGO_MD5,
+	HASH_ALGO_SHA1,
+	HASH_ALGO_RIPE_MD_160,
+	HASH_ALGO_SHA256,
+	HASH_ALGO_SHA384,
+	HASH_ALGO_SHA512,
+	HASH_ALGO_SHA224,
+	HASH_ALGO_RIPE_MD_128,
+	HASH_ALGO_RIPE_MD_256,
+	HASH_ALGO_RIPE_MD_320,
+	HASH_ALGO_WP_256,
+	HASH_ALGO_WP_384,
+	HASH_ALGO_WP_512,
+	HASH_ALGO_TGR_128,
+	HASH_ALGO_TGR_160,
+	HASH_ALGO_TGR_192,
+	HASH_ALGO_SM3_256,
+	HASH_ALGO__LAST
+};
+
+extern const char *const hash_algo_name[HASH_ALGO__LAST];
+extern const int hash_digest_size[HASH_ALGO__LAST];
+
+void bitmap_zero(unsigned long *dst, unsigned int nbits);
+void bitmap_set(unsigned long *map, unsigned int start, int len);
+
+int hex2bin(u8 *dst, const char *src, size_t count);
+
+#endif /* _KERNEL_LIB_H */
diff --git a/include/lib.h b/include/lib.h
new file mode 100644
index 0000000..2205cfd
--- /dev/null
+++ b/include/lib.h
@@ -0,0 +1,32 @@
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
+ * File: lib.h
+ *      Header of lib.h.
+ */
+
+#ifndef _LIB_H
+#define _LIB_H
+
+#include <openssl/sha.h>
+#include <openssl/evp.h>
+
+#include "kernel_lib.h"
+
+#define MAX_FILENAME_LENGTH 256
+
+extern char *digest_list_path;
+
+int calc_digest(u8 *digest, void *data, int len, enum hash_algo algo);
+int calc_file_digest(char *path, u8 *digest, enum hash_algo algo);
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id);
+
+#endif /* _LIB_H */
diff --git a/include/metadata.h b/include/metadata.h
new file mode 100644
index 0000000..5658325
--- /dev/null
+++ b/include/metadata.h
@@ -0,0 +1,32 @@
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
+ * File: metadata.h
+ *      Header of metadata.c.
+ */
+
+#ifndef _METADATA_H
+#define _METADATA_H
+
+#include "compact_list.h"
+#include "rpm.h"
+#include "lib.h"
+
+enum input_formats { INPUT_FMT_RPMDB, INPUT_FMT_RPMPKG,
+		     INPUT_FMT_DIGEST_LIST_ASCII, INPUT_FMT__LAST };
+
+int write_digests_and_metadata(Header hdr, char *outdir,
+			       char *metadata_filename,
+			       enum input_formats input_fmt,
+			       char *input_filename,
+			       enum digest_data_types output_fmt,
+			       int is_mutable);
+
+#endif /*_METADATA_H*/
diff --git a/include/rpm.h b/include/rpm.h
new file mode 100644
index 0000000..dad557e
--- /dev/null
+++ b/include/rpm.h
@@ -0,0 +1,36 @@
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
+ * File: rpm.h
+ *      Header of rpm.c.
+ */
+
+#ifndef _RPM_H
+#define _RPM_H
+
+#include <rpm/rpmlib.h>
+#include <rpm/header.h>
+#include <rpm/rpmts.h>
+#include <rpm/rpmdb.h>
+#include <rpm/rpmlog.h>
+
+#include "kernel_ima.h"
+
+/* rpmlegacy.h */
+int headerGetEntry(Header h, rpm_tag_t tag, rpm_tagtype_t *type,
+		   rpm_data_t *p, rpm_count_t *c);
+void get_rpm_filename(Header rpm, char *outdir, char *output_filename,
+		      enum digest_data_types output_fmt);
+int check_rpm_digest_algo(Header rpm, char *output_filename);
+void get_rpm_header_signature(Header rpm, u8 **signature,
+			      rpm_count_t *signature_len);
+int write_rpm_header(Header rpm, char *outdir, char *output_filename);
+
+#endif /* _RPM_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
