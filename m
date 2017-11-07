From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:37:03 +0100
Subject: [PATCH v2 08/15] ima: add parser of RPM package headers
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-9-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces a parser of RPM package headers. It extracts the
digests from the RPMTAG_FILEDIGESTS header section and converts them to
binary data before adding them to the hash table.

The advantage of this data type is that verifiers can determine who
produced that data, as headers are signed by Linux distribution vendors.
RPM header signatures can be provided as digest list metadata.

The parser also checks the RPMTAG_FILEMODES section. If the file is not
executable, the setuid/setgid/sticky bits are not set and has write
permission, the digest is marked as mutable (file updates are permitted if
appraisal is in enforcing mode).

Changelog

v1:
- Moved parser of file digests outside the first loop
- Added support for immutable/mutable files

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_list.c | 110 ++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index 6ad00ba32c94..664a4994efbb 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -19,11 +19,14 @@
 #include "ima.h"
 #include "ima_template_lib.h"
 
+#define RPMTAG_FILEDIGESTS 1035
+#define RPMTAG_FILEMODES 1030
+
 enum digest_metadata_fields {DATA_ALGO, DATA_DIGEST, DATA_SIGNATURE,
 			     DATA_FILE_PATH, DATA_REF_ID, DATA_TYPE,
 			     DATA__LAST};
 
-enum digest_data_types {DATA_TYPE_COMPACT_LIST};
+enum digest_data_types {DATA_TYPE_COMPACT_LIST, DATA_TYPE_RPM};
 
 enum compact_list_entry_ids {COMPACT_DIGEST, COMPACT_DIGEST_MUTABLE};
 
@@ -33,6 +36,20 @@ struct compact_list_hdr {
 	u32 datalen;
 } __packed;
 
+struct rpm_hdr {
+	u32 magic;
+	u32 reserved;
+	u32 tags;
+	u32 datasize;
+} __packed;
+
+struct rpm_entryinfo {
+	int32_t tag;
+	u32 type;
+	int32_t offset;
+	u32 count;
+} __packed;
+
 static int ima_parse_compact_list(loff_t size, void *buf)
 {
 	void *bufp = buf, *bufendp = buf + size;
@@ -86,6 +103,94 @@ static int ima_parse_compact_list(loff_t size, void *buf)
 	return 0;
 }
 
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
+			if (modes + (i + 1) * sizeof(mode) > bufendp) {
+				pr_err("RPM header read at invalid offset\n");
+				return -EINVAL;
+			}
+
+			mode = be16_to_cpu(*(u16 *)(modes + i * sizeof(mode)));
+			if (!(mode & (S_IXUGO | S_ISUID | S_ISGID | S_ISVTX)) &&
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
 static int ima_parse_digest_list_data(struct ima_field_data *data)
 {
 	void *digest_list;
@@ -113,6 +218,9 @@ static int ima_parse_digest_list_data(struct ima_field_data *data)
 	case DATA_TYPE_COMPACT_LIST:
 		ret = ima_parse_compact_list(digest_list_size, digest_list);
 		break;
+	case DATA_TYPE_RPM:
+		ret = ima_parse_rpm(digest_list_size, digest_list);
+		break;
 	default:
 		pr_err("Parser for data type %d not implemented\n", data_type);
 		ret = -EINVAL;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
