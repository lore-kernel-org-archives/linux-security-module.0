From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 15 Nov 2017 14:39:23 +0100
Subject: [USER SPACE][RFC][PATCH 2/5] digest-list-tools: library
In-Reply-To: <20171115133926.20108-1-roberto.sassu@huawei.com>
References: <20171115133926.20108-1-roberto.sassu@huawei.com>
Message-ID: <20171115133926.20108-3-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch adds the library necessary to generate/verify the compact and
RPM digest lists and digest list metadata. Some functions have been taken
from the Linux kernel.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 lib/compact_list.c | 160 +++++++++++++++++++++
 lib/kernel_ima.c   | 409 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kernel_lib.c   | 130 +++++++++++++++++
 lib/lib.c          | 101 +++++++++++++
 lib/metadata.c     | 125 ++++++++++++++++
 lib/rpm.c          |  99 +++++++++++++
 6 files changed, 1024 insertions(+)
 create mode 100644 lib/compact_list.c
 create mode 100644 lib/kernel_ima.c
 create mode 100644 lib/kernel_lib.c
 create mode 100644 lib/lib.c
 create mode 100644 lib/metadata.c
 create mode 100644 lib/rpm.c

diff --git a/lib/compact_list.c b/lib/compact_list.c
new file mode 100644
index 0000000..26f6260
--- /dev/null
+++ b/lib/compact_list.c
@@ -0,0 +1,160 @@
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
+ * File: compact_list.c
+ *      Writes compact digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+#include "compact_list.h"
+
+int compact_list_from_rpm(Header rpm, char *outdir, char *output_filename)
+{
+	int digest_len = hash_digest_size[ima_hash_algo];
+	int ret, fd, datalen = 0, i;
+
+	rpm_tagtype_t data_type;
+	rpm_count_t data_count;
+	char **data;
+
+	u8 *output;
+
+	struct compact_list_hdr hdr = {0, 0, 0};
+
+	get_rpm_filename(rpm, outdir, output_filename, DATA_TYPE_COMPACT_LIST);
+
+	ret = check_rpm_digest_algo(rpm, output_filename);
+	if (ret < 0)
+		return ret;
+
+	ret = headerGetEntry(rpm, RPMTAG_FILEDIGESTS, &data_type,
+			     (void **)&data, &data_count);
+	if (ret < 0)
+		return -EINVAL;
+
+	output = malloc(digest_len * data_count);
+	if (output == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < data_count; i++) {
+		if (strlen(data[i]) == 0)
+			continue;
+
+		hex2bin(output + datalen, data[i], digest_len);
+		hdr.count++;
+		datalen += digest_len;
+	}
+
+	hdr.entry_id = COMPACT_DIGEST;
+	hdr.entry_id = cpu_to_le16(hdr.entry_id);
+	hdr.count = cpu_to_le32(hdr.count);
+	hdr.datalen = cpu_to_le32(datalen);
+
+	fd = open(output_filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+	if (fd < 0)
+		return -EACCES;
+
+	write(fd, &hdr, sizeof(hdr));
+	write(fd, output, datalen);
+
+	close(fd);
+	free(output);
+	return 0;
+}
+
+int compact_list_from_digest_list_ascii(char *input_filename, char *outdir,
+					char *output_filename, int is_mutable)
+{
+	const char *algo_name = hash_algo_name[ima_hash_algo];
+	int algo_prefix_len = strlen(algo_name) + 1;
+	int digest_len = hash_digest_size[ima_hash_algo];
+	u8 digest[digest_len];
+	char *data, *datap, *line, *input_basename;
+	int datalen = 0;
+	struct stat st;
+	int ret = 0, inputfd = -1, outputfd;
+
+	struct compact_list_hdr hdr = {0, 0, 0};
+
+	if (stat(input_filename, &st) != 0)
+		return -EACCES;
+
+	if (st.st_size == 0)
+		return -EINVAL;
+
+	inputfd = open(input_filename, O_RDONLY);
+	if (inputfd < 0)
+		return -EACCES;
+
+	data = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE, inputfd, 0);
+	if (data == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	datap = data;
+
+	input_basename = rindex(input_filename, '/');
+	if (input_basename == NULL)
+		input_basename = input_filename;
+	else
+		input_basename += 1;
+
+	snprintf(output_filename, MAX_FILENAME_LENGTH, "%s/compact-%s",
+		 outdir, input_basename);
+
+	outputfd = open(output_filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+	if (outputfd < 0) {
+		printf("Unable to write %s\n", output_filename);
+		ret = -EACCES;
+		goto out;
+	}
+
+	lseek(outputfd, sizeof(hdr), SEEK_SET);
+
+	while (true) {
+		line = strsep(&datap, "\n");
+		if (line == NULL)
+			break;
+
+		if (strlen(line) < algo_prefix_len + digest_len * 2)
+			continue;
+
+		if (strncmp(line, algo_name, algo_prefix_len - 1)) {
+			printf("Digest algorithm mismatch, expected: %s\n",
+			       algo_name);
+			return -EINVAL;
+		}
+
+		hex2bin(digest, line + algo_prefix_len, digest_len);
+		write(outputfd, digest, digest_len);
+		hdr.count++;
+		datalen += digest_len;
+	}
+
+	hdr.entry_id = is_mutable ? COMPACT_DIGEST_MUTABLE : COMPACT_DIGEST;
+	hdr.entry_id = cpu_to_le16(hdr.entry_id);
+	hdr.count = cpu_to_le32(hdr.count);
+	hdr.datalen = cpu_to_le32(datalen);
+
+	lseek(outputfd, 0, SEEK_SET);
+	write(outputfd, &hdr, sizeof(hdr));
+	close(outputfd);
+out:
+	close(inputfd);
+	if (data)
+		munmap(data, st.st_size);
+
+	return ret;
+}
diff --git a/lib/kernel_ima.c b/lib/kernel_ima.c
new file mode 100644
index 0000000..38bc49a
--- /dev/null
+++ b/lib/kernel_ima.c
@@ -0,0 +1,409 @@
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
+ * File: kernel_ima.c
+ *      Includes IMA functions.
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+#include "kernel_ima.h"
+
+int digests;
+
+int ima_add_digest_data_entry(u8 *digest, u8 is_mutable)
+{
+	digests++;
+	return 0;
+}
+
+int ima_get_buflen(int maxfields, struct ima_field_data *fields,
+		   unsigned long *len_mask)
+{
+	int len = 0, i;
+
+	for (i = 0; i < maxfields; i++) {
+		if (len_mask == NULL || !test_bit(i, len_mask))
+			len += sizeof(u32);
+
+		len += fields[i].len;
+	}
+
+	return len;
+}
+
+int ima_hash_algo = HASH_ALGO_SHA256;
+
+int ima_hash_setup(char *str)
+{
+	int i;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++) {
+		if (strcmp(str, hash_algo_name[i]) == 0) {
+			ima_hash_algo = i;
+			break;
+		}
+	}
+
+	if (i == HASH_ALGO__LAST)
+		return -EINVAL;
+
+	return 0;
+}
+
+#define RPMTAG_FILEDIGESTS 1035
+#define RPMTAG_FILEMODES 1030
+
+struct rpm_hdr {
+	u32 magic;
+	u32 reserved;
+	u32 tags;
+	u32 datasize;
+} __attribute__((packed));
+
+struct rpm_entryinfo {
+	int32_t tag;
+	u32 type;
+	int32_t offset;
+	u32 count;
+} __attribute__((packed));
+
+
+int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
+		  int maxfields, struct ima_field_data *fields, int *curfields,
+		  unsigned long *len_mask, int enforce_mask, char *bufname)
+{
+	void *bufp = bufstartp;
+	int i;
+
+	for (i = 0; i < maxfields; i++) {
+		if (len_mask == NULL || !test_bit(i, len_mask)) {
+			if (bufp > (bufendp - sizeof(u32)))
+				break;
+
+			fields[i].len = le32_to_cpu(*(u32 *)bufp);
+
+			bufp += sizeof(u32);
+		}
+
+		if (bufp > (bufendp - fields[i].len))
+			break;
+
+		fields[i].data = bufp;
+		bufp += fields[i].len;
+	}
+
+	if ((enforce_mask & ENFORCE_FIELDS) && i != maxfields) {
+		pr_err("%s: nr of fields mismatch: expected: %d, current: %d\n",
+		       bufname, maxfields, i);
+		return -EINVAL;
+	}
+
+	if ((enforce_mask & ENFORCE_BUFEND) && bufp != bufendp) {
+		pr_err("%s: buf end mismatch: expected: %p, current: %p\n",
+		       bufname, bufendp, bufp);
+		return -EINVAL;
+	}
+
+	if (curfields)
+		*curfields = i;
+
+	if (bufcurp)
+		*bufcurp = bufp;
+
+	return 0;
+}
+
+int ima_write_buf(void *bufstartp, void *bufendp, void **bufcurp,
+		  int maxfields, struct ima_field_data *fields, int *curfields,
+		  unsigned long *len_mask, int enforce_mask, char *bufname)
+{
+	void *bufp = bufstartp;
+	int i;
+
+	for (i = 0; i < maxfields; i++) {
+		if (len_mask == NULL || !test_bit(i, len_mask)) {
+			u32 field_len = fields[i].len;
+
+			if (bufp > (bufendp - sizeof(u32)))
+				break;
+
+			field_len = cpu_to_le32(field_len);
+
+			memcpy(bufp, &field_len, sizeof(field_len));
+
+			bufp += sizeof(u32);
+		}
+
+		if (bufp > (bufendp - fields[i].len))
+			break;
+
+		memcpy(bufp, fields[i].data, fields[i].len);
+		bufp += fields[i].len;
+	}
+
+	if ((enforce_mask & ENFORCE_FIELDS) && i != maxfields) {
+		pr_err("%s: nr of fields mismatch: expected: %d, current: %d\n",
+		       bufname, maxfields, i);
+		return -EINVAL;
+	}
+
+	if ((enforce_mask & ENFORCE_BUFEND) && bufp != bufendp) {
+		pr_err("%s: buf end mismatch: expected: %p, current: %p\n",
+		       bufname, bufendp, bufp);
+		return -EINVAL;
+	}
+
+	if (curfields)
+		*curfields = i;
+
+	if (bufcurp)
+		*bufcurp = bufp;
+
+	return 0;
+}
+
+static int ima_parse_compact_list(loff_t size, void *buf)
+{
+	void *bufp = buf, *bufendp = buf + size;
+	int digest_len = hash_digest_size[ima_hash_algo];
+	struct compact_list_hdr *hdr;
+	u8 is_mutable = 0;
+	int ret, i;
+
+	while (bufp < bufendp) {
+		if (bufp + sizeof(*hdr) > bufendp) {
+			pr_err("compact list, missing header\n");
+			return -EINVAL;
+		}
+
+		hdr = bufp;
+
+		hdr->entry_id = le16_to_cpu(hdr->entry_id);
+		hdr->count = le32_to_cpu(hdr->count);
+		hdr->datalen = le32_to_cpu(hdr->datalen);
+
+		switch (hdr->entry_id) {
+		case COMPACT_DIGEST_MUTABLE:
+			is_mutable = 1;
+		case COMPACT_DIGEST:
+			break;
+		default:
+			pr_err("compact list, invalid data type\n");
+			return -EINVAL;
+		}
+
+		bufp += sizeof(*hdr);
+
+		for (i = 0; i < hdr->count &&
+		     bufp + digest_len <= bufendp; i++) {
+			ret = ima_add_digest_data_entry(bufp, is_mutable);
+			if (ret < 0 && ret != -EEXIST)
+				return ret;
+
+			bufp += digest_len;
+		}
+
+		if (i != hdr->count ||
+		    bufp != (void *)hdr + sizeof(*hdr) + hdr->datalen) {
+			pr_err("compact list, invalid data\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int ima_parse_rpm(loff_t size, void *buf)
+{
+	void *bufp = buf, *bufendp = buf + size;
+	struct rpm_hdr *hdr = bufp;
+	u32 tags = be32_to_cpu(hdr->tags);
+	struct rpm_entryinfo *entry;
+	void *datap = bufp + sizeof(*hdr) + tags * sizeof(struct rpm_entryinfo);
+	void *digests = NULL, *modes = NULL;
+	u32 digests_count, modes_count;
+	int digest_len = hash_digest_size[ima_hash_algo];
+	u8 digest[digest_len];
+	int ret, i;
+
+	const unsigned char rpm_header_magic[8] = {
+		0x8e, 0xad, 0xe8, 0x01, 0x00, 0x00, 0x00, 0x00
+	};
+
+	if (size < sizeof(*hdr)) {
+		pr_err("Missing RPM header\n");
+		return -EINVAL;
+	}
+
+	if (memcmp(bufp, rpm_header_magic, sizeof(rpm_header_magic))) {
+		pr_err("Invalid RPM header\n");
+		return -EINVAL;
+	}
+
+	bufp += sizeof(*hdr);
+
+	for (i = 0; i < tags && (bufp + sizeof(*entry)) <= bufendp;
+	     i++, bufp += sizeof(*entry)) {
+		entry = bufp;
+
+		if (be32_to_cpu(entry->tag) == RPMTAG_FILEDIGESTS) {
+			digests = datap + be32_to_cpu(entry->offset);
+			digests_count = be32_to_cpu(entry->count);
+		}
+		if (be32_to_cpu(entry->tag) == RPMTAG_FILEMODES) {
+			modes = datap + be32_to_cpu(entry->offset);
+			modes_count = be32_to_cpu(entry->count);
+		}
+		if (digests && modes)
+			break;
+	}
+
+	if (digests == NULL)
+		return 0;
+
+	for (i = 0; i < digests_count && digests < bufendp; i++) {
+		u8 is_mutable = 0;
+		u16 mode;
+
+		if (strlen(digests) == 0) {
+			digests++;
+			continue;
+		}
+
+		if (modes) {
+			if (i < modes_count &&
+			    modes + (i + 1) * sizeof(mode) > bufendp) {
+				pr_err("RPM header read at invalid offset\n");
+				return -EINVAL;
+			}
+
+			mode = be16_to_cpu(*(u16 *)(modes + i * sizeof(mode)));
+			if (!(mode & (S_IXUGO | S_ISUID | S_ISVTX)) &&
+			    (mode & S_IWUGO))
+				is_mutable = 1;
+		}
+
+		if (digests + digest_len * 2 + 1 > bufendp) {
+			pr_err("RPM header read at invalid offset\n");
+			return -EINVAL;
+		}
+
+		ret = hex2bin(digest, digests, digest_len);
+		if (ret < 0)
+			return -EINVAL;
+
+		ret = ima_add_digest_data_entry(digest, is_mutable);
+		if (ret < 0 && ret != -EEXIST)
+			return ret;
+
+		digests += digest_len * 2 + 1;
+	}
+
+	return 0;
+}
+
+static int ima_parse_digest_list_data(struct ima_field_data *data)
+{
+	int digest_len = hash_digest_size[ima_hash_algo];
+	u8 digest[digest_len];
+	void *digest_list;
+	loff_t digest_list_size;
+	u16 data_algo = le16_to_cpu(*(u16 *)data[DATA_ALGO].data);
+	u16 data_type = le16_to_cpu(*(u16 *)data[DATA_TYPE].data);
+	int ret, fd;
+
+	if (data_algo != ima_hash_algo) {
+		pr_err("Incompatible digest algorithm, expected %s\n",
+		       hash_algo_name[ima_hash_algo]);
+		return -EINVAL;
+	}
+
+	fd = kernel_read_file_from_path((char *)data[DATA_FILE_PATH].data,
+					&digest_list, &digest_list_size,
+					0, READING_DIGEST_LIST);
+	if (fd < 0) {
+		pr_err("Unable to open file: %s (%d)\n",
+		       data[DATA_FILE_PATH].data, fd);
+		return fd;
+	}
+
+	calc_digest(digest, digest_list, digest_list_size, ima_hash_algo);
+	if (memcmp(digest, data[DATA_DIGEST].data, data[DATA_DIGEST].len)) {
+		pr_err("Digest verification for %s failed\n",
+		       data[DATA_FILE_PATH].data);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = ima_add_digest_data_entry(digest, 0);
+	if (ret < 0) {
+		if (ret == -EEXIST)
+			ret = 1;
+
+		goto out;
+	}
+
+	switch (data_type) {
+	case DATA_TYPE_COMPACT_LIST:
+		ret = ima_parse_compact_list(digest_list_size, digest_list);
+		break;
+	case DATA_TYPE_RPM:
+		ret = ima_parse_rpm(digest_list_size, digest_list);
+		break;
+	default:
+		pr_err("Parser for data type %d not implemented\n", data_type);
+		ret = -EINVAL;
+	}
+
+	if (ret < 0)
+		pr_err("Error parsing file: %s (%d)\n",
+		       data[DATA_FILE_PATH].data, ret);
+out:
+	munmap(digest_list, digest_list_size);
+	close(fd);
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
+			    ENFORCE_FIELDS, "digest list entry");
+	if (ret < 0)
+		goto out;
+
+	ret = ima_parse_buf(entry.data, entry.data + entry.len, NULL,
+			    DATA__LAST, entry_data, NULL, data_mask,
+			    ENFORCE_FIELDS | ENFORCE_BUFEND,
+			    "digest list entry data");
+	if (ret < 0)
+		goto out;
+
+	ret = ima_parse_digest_list_data(entry_data);
+out:
+	return ret < 0 ? ret : bufp - buf;
+}
diff --git a/lib/kernel_lib.c b/lib/kernel_lib.c
new file mode 100644
index 0000000..2ea4650
--- /dev/null
+++ b/lib/kernel_lib.c
@@ -0,0 +1,130 @@
+/*
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
+ * File: kernel_lib.c
+ *      Libraries from the Linux kernel.
+ */
+#include "kernel_lib.h"
+
+/* from lib/bitmap.c */
+void bitmap_zero(unsigned long *dst, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		*dst = 0UL;
+	else {
+		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+		memset(dst, 0, len);
+	}
+}
+
+void bitmap_set(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_set >= 0) {
+		*p |= mask_to_set;
+		len -= bits_to_set;
+		bits_to_set = BITS_PER_LONG;
+		mask_to_set = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		*p |= mask_to_set;
+	}
+}
+
+/* from crypto/hash_info.c */
+const char *const hash_algo_name[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]         = "md4",
+	[HASH_ALGO_MD5]         = "md5",
+	[HASH_ALGO_SHA1]        = "sha1",
+	[HASH_ALGO_RIPE_MD_160] = "rmd160",
+	[HASH_ALGO_SHA256]      = "sha256",
+	[HASH_ALGO_SHA384]      = "sha384",
+	[HASH_ALGO_SHA512]      = "sha512",
+	[HASH_ALGO_SHA224]      = "sha224",
+	[HASH_ALGO_RIPE_MD_128] = "rmd128",
+	[HASH_ALGO_RIPE_MD_256] = "rmd256",
+	[HASH_ALGO_RIPE_MD_320] = "rmd320",
+	[HASH_ALGO_WP_256]      = "wp256",
+	[HASH_ALGO_WP_384]      = "wp384",
+	[HASH_ALGO_WP_512]      = "wp512",
+	[HASH_ALGO_TGR_128]     = "tgr128",
+	[HASH_ALGO_TGR_160]     = "tgr160",
+	[HASH_ALGO_TGR_192]     = "tgr192",
+	[HASH_ALGO_SM3_256]     = "sm3-256",
+};
+
+const int hash_digest_size[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]         = MD5_DIGEST_SIZE,
+	[HASH_ALGO_MD5]         = MD5_DIGEST_SIZE,
+	[HASH_ALGO_SHA1]        = SHA1_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_160] = RMD160_DIGEST_SIZE,
+	[HASH_ALGO_SHA256]      = SHA256_DIGEST_SIZE,
+	[HASH_ALGO_SHA384]      = SHA384_DIGEST_SIZE,
+	[HASH_ALGO_SHA512]      = SHA512_DIGEST_SIZE,
+	[HASH_ALGO_SHA224]      = SHA224_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_128] = RMD128_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_256] = RMD256_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_320] = RMD320_DIGEST_SIZE,
+	[HASH_ALGO_WP_256]      = WP256_DIGEST_SIZE,
+	[HASH_ALGO_WP_384]      = WP384_DIGEST_SIZE,
+	[HASH_ALGO_WP_512]      = WP512_DIGEST_SIZE,
+	[HASH_ALGO_TGR_128]     = TGR128_DIGEST_SIZE,
+	[HASH_ALGO_TGR_160]     = TGR160_DIGEST_SIZE,
+	[HASH_ALGO_TGR_192]     = TGR192_DIGEST_SIZE,
+	[HASH_ALGO_SM3_256]     = SM3256_DIGEST_SIZE,
+};
+
+/* from lib/hexdump.c */
+
+/**
+ * hex_to_bin - convert a hex digit to its real value
+ * @ch: ascii character represents hex digit
+ *
+ * hex_to_bin() converts one hex digit to its actual value or -1 in case of bad
+ * input.
+ */
+int hex_to_bin(char ch)
+{
+	if ((ch >= '0') && (ch <= '9'))
+		return ch - '0';
+	ch = tolower(ch);
+	if ((ch >= 'a') && (ch <= 'f'))
+		return ch - 'a' + 10;
+	return -1;
+}
+
+/**
+ * hex2bin - convert an ascii hexadecimal string to its binary representation
+ * @dst: binary result
+ * @src: ascii hexadecimal string
+ * @count: result length
+ *
+ * Return 0 on success, -1 in case of bad input.
+ */
+int hex2bin(u8 *dst, const char *src, size_t count)
+{
+	while (count--) {
+		int hi = hex_to_bin(*src++);
+		int lo = hex_to_bin(*src++);
+
+		if ((hi < 0) || (lo < 0))
+			return -1;
+
+		*dst++ = (hi << 4) | lo;
+	}
+	return 0;
+}
diff --git a/lib/lib.c b/lib/lib.c
new file mode 100644
index 0000000..ad4b852
--- /dev/null
+++ b/lib/lib.c
@@ -0,0 +1,101 @@
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
+ * File: lib.c
+ *      Includes libraries.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+#include "lib.h"
+
+char *digest_list_path;
+
+int calc_digest(u8 *digest, void *data, int len, enum hash_algo algo)
+{
+	EVP_MD_CTX *mdctx = EVP_MD_CTX_create();
+	const EVP_MD *md = EVP_get_digestbyname(hash_algo_name[algo]);
+
+	if (mdctx == NULL)
+		return -EINVAL;
+
+	if (EVP_DigestInit_ex(mdctx, md, NULL) != 1)
+		return -EINVAL;
+
+	if (EVP_DigestUpdate(mdctx, data, len) != 1)
+		return -EINVAL;
+
+	if (EVP_DigestFinal_ex(mdctx, digest, NULL) != 1)
+		return -EINVAL;
+
+	EVP_MD_CTX_destroy(mdctx);
+	return 0;
+}
+
+int calc_file_digest(char *path, u8 *digest, enum hash_algo algo)
+{
+	void *data;
+	struct stat st;
+	int fd, ret = 0;
+
+	if (stat(path, &st) != 0)
+		return -EACCES;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -EACCES;
+
+	data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (data == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = calc_digest(digest, data, st.st_size, algo);
+out:
+	if (data)
+		munmap(data, st.st_size);
+
+	close(fd);
+	return ret;
+}
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	struct stat st;
+	const char *cur_path = path, *basename;
+	char tmp_path[256];
+	int fd;
+
+	if (digest_list_path) {
+		basename = rindex(path, '/');
+		snprintf(tmp_path, sizeof(tmp_path), "%s/%s",
+			 digest_list_path, basename ? basename : path);
+		cur_path = tmp_path;
+	}
+
+	fd = open(cur_path, O_RDONLY);
+	if (fd < 0)
+		return -EINVAL;
+
+	stat(cur_path, &st);
+	*buf = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
+		    fd, 0);
+	if (*buf == NULL)
+		return -ENOMEM;
+
+	*size = st.st_size;
+	return fd;
+}
diff --git a/lib/metadata.c b/lib/metadata.c
new file mode 100644
index 0000000..74618cf
--- /dev/null
+++ b/lib/metadata.c
@@ -0,0 +1,125 @@
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
+ * File: metadata.c
+ *      Writes digest list metadata.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+
+#include "metadata.h"
+
+static int ima_add_list_metadata(char *metadata_filename, u16 data_algo,
+				 u32 digest_len, u8 *digest, u32 signature_len,
+				 u8 *signature, u32 file_path_len,
+				 char *file_path, u16 data_type)
+{
+	struct ima_field_data entry_data[DATA__LAST] = {
+		[DATA_ALGO] = {.len = sizeof(u16)},
+		[DATA_TYPE] = {.len = sizeof(u16)},
+	};
+
+	DECLARE_BITMAP(data_mask, DATA__LAST);
+	int ret, metadata_len, fd;
+	u8 *data;
+
+	bitmap_zero(data_mask, DATA__LAST);
+	bitmap_set(data_mask, DATA_ALGO, 1);
+	bitmap_set(data_mask, DATA_TYPE, 1);
+
+	entry_data[DATA_ALGO].data = (u8 *)&data_algo;
+	entry_data[DATA_DIGEST].len = digest_len;
+	entry_data[DATA_DIGEST].data = digest;
+	entry_data[DATA_SIGNATURE].len = signature_len;
+	entry_data[DATA_SIGNATURE].data = signature;
+	entry_data[DATA_FILE_PATH].len = file_path_len;
+	entry_data[DATA_FILE_PATH].data = (unsigned char *)file_path;
+	entry_data[DATA_REF_ID].len = 0;
+	entry_data[DATA_TYPE].data = (u8 *)&data_type;
+
+	metadata_len = ima_get_buflen(DATA__LAST, entry_data, data_mask);
+	data = malloc(metadata_len);
+	if (data == NULL) {
+		printf("Out of memory\n");
+		return -ENOMEM;
+	}
+
+	ret = ima_write_buf(data, data + metadata_len, NULL,
+			    DATA__LAST, entry_data, NULL, data_mask,
+			    ENFORCE_FIELDS | ENFORCE_BUFEND, "entry data");
+	if (ret < 0)
+		goto out;
+
+	fd = open(metadata_filename, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		goto out;
+
+	metadata_len = cpu_to_le32(metadata_len);
+	write(fd, &metadata_len, sizeof(u32));
+	write(fd, data, metadata_len);
+	close(fd);
+out:
+	free(data);
+	return ret;
+}
+
+int write_digests_and_metadata(Header hdr, char *outdir,
+			       char *metadata_filename,
+			       enum input_formats input_fmt,
+			       char *input_filename,
+			       enum digest_data_types output_fmt,
+			       int is_mutable)
+{
+	int ret;
+	char digest_list_filename[MAX_FILENAME_LENGTH];
+	int digest_len = hash_digest_size[ima_hash_algo];
+	u16 data_algo = cpu_to_le16(ima_hash_algo);
+	u16 data_type = cpu_to_le16(output_fmt);
+	u8 digest[digest_len];
+	unsigned int signature_len = 0;
+	u8 *signature;
+
+	if (input_fmt == INPUT_FMT_DIGEST_LIST_ASCII)
+		ret = compact_list_from_digest_list_ascii(input_filename,
+							  outdir,
+							  digest_list_filename,
+							  is_mutable);
+	else if (output_fmt == DATA_TYPE_COMPACT_LIST)
+		ret = compact_list_from_rpm(hdr, outdir, digest_list_filename);
+	else if (output_fmt == DATA_TYPE_RPM)
+		ret = write_rpm_header(hdr, outdir, digest_list_filename);
+
+	if (ret < 0) {
+		if (ret == -ENOENT)
+			return 0;
+
+		printf("Failed to write digest list, ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = calc_file_digest(digest_list_filename, digest, ima_hash_algo);
+	if (ret < 0) {
+		printf("Failed to calculate metadata digest, ret: %d\n", ret);
+		return ret;
+	}
+
+	if (output_fmt == DATA_TYPE_RPM)
+		get_rpm_header_signature(hdr, &signature, &signature_len);
+
+	ret = ima_add_list_metadata(metadata_filename, data_algo,
+				    digest_len, digest, signature_len,
+				    signature, strlen(digest_list_filename) + 1,
+				    digest_list_filename, data_type);
+	if (ret < 0)
+		printf("Failed to write metadata, ret: %d\n", ret);
+
+	return ret;
+}
diff --git a/lib/rpm.c b/lib/rpm.c
new file mode 100644
index 0000000..f717b3a
--- /dev/null
+++ b/lib/rpm.c
@@ -0,0 +1,99 @@
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
+ * File: rpm.c
+ *      Writes RPM digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+
+#include "rpm.h"
+
+static int algo_mapping[HASH_ALGO__LAST] = {
+	[PGPHASHALGO_SHA1] = HASH_ALGO_SHA1,
+	[PGPHASHALGO_SHA256] = HASH_ALGO_SHA256,
+};
+
+void get_rpm_filename(Header rpm, char *outdir, char *output_filename,
+		      enum digest_data_types output_fmt)
+{
+	char *pkg_name, *pkg_version, *pkg_release, *pkg_arch;
+	char *prefix = (output_fmt == DATA_TYPE_RPM) ? "rpm" : "compact";
+
+	headerGetEntry(rpm, RPMTAG_NAME, NULL, (void **)&pkg_name, NULL);
+	headerGetEntry(rpm, RPMTAG_VERSION, NULL, (void **)&pkg_version, NULL);
+	headerGetEntry(rpm, RPMTAG_RELEASE, NULL, (void **)&pkg_release, NULL);
+	headerGetEntry(rpm, RPMTAG_ARCH, NULL, (void **)&pkg_arch, NULL);
+
+	snprintf(output_filename, MAX_FILENAME_LENGTH, "%s/%s-%s-%s-%s.%s",
+		 outdir, prefix, pkg_name, pkg_version, pkg_release, pkg_arch);
+}
+
+int check_rpm_digest_algo(Header rpm, char *output_filename)
+{
+	u32 *rpm_digestalgo;
+	rpm_tagtype_t data_type;
+	rpm_count_t data_count;
+	int ret;
+
+	ret = headerGetEntry(rpm, RPMTAG_FILEDIGESTALGO, &data_type,
+			     (void **)&rpm_digestalgo, &data_count);
+	if (ret < 0) {
+		printf("%s: unable to retrieve digest algorithm\n",
+		       output_filename);
+		return -EINVAL;
+	}
+
+	if (strstr(output_filename, "gpg-pubkey") != NULL)
+		return -ENOENT;
+
+	if (algo_mapping[*rpm_digestalgo] != ima_hash_algo) {
+		printf("%s: digest algorithm mismatch, expected: %s, "
+		       "current: %s\n", output_filename,
+		       hash_algo_name[ima_hash_algo],
+		       hash_algo_name[algo_mapping[*rpm_digestalgo]]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void get_rpm_header_signature(Header rpm, u8 **signature,
+			      rpm_count_t *signature_len)
+{
+	headerGetEntry(rpm, RPMTAG_RSAHEADER, NULL, (void **)signature,
+		       signature_len);
+}
+
+int write_rpm_header(Header rpm, char *outdir, char *output_filename)
+{
+	char **data;
+	rpm_count_t data_size;
+	int ret, fd;
+
+	get_rpm_filename(rpm, outdir, output_filename, DATA_TYPE_RPM);
+
+	ret = check_rpm_digest_algo(rpm, output_filename);
+	if (ret < 0)
+		return ret;
+
+	headerGetEntry(rpm, RPMTAG_HEADERIMMUTABLE, NULL,
+		       (void **)&data, &data_size);
+
+	fd = open(output_filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+	if (fd < 0)
+		return -EACCES;
+
+	write(fd, rpm_header_magic, sizeof(rpm_header_magic));
+	write(fd, data, data_size);
+	close(fd);
+	return 0;
+}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
