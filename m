From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 25 Jul 2017 17:44:19 +0200
Subject: [PATCH 08/12] ima: added parser for RPM data type
In-Reply-To: <20170725154423.24845-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
Message-ID: <20170725154423.24845-9-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces a parser for RPM packages. It extracts the digests
from the RPMTAG_FILEDIGESTS header section and converts them to binary data
before adding them to the hash table.

The advantage of this data type is that verifiers can determine who
produced that data, as headers are signed by Linux distributions vendors.
RPM headers signatures can be provided as digest list metadata.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_list.c | 84 +++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index c1ef79a..11ee77e 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -19,11 +19,13 @@
 #include "ima.h"
 #include "ima_template_lib.h"
 
+#define RPMTAG_FILEDIGESTS 1035
+
 enum digest_metadata_fields {DATA_ALGO, DATA_DIGEST, DATA_SIGNATURE,
 			     DATA_FILE_PATH, DATA_REF_ID, DATA_TYPE,
 			     DATA__LAST};
 
-enum digest_data_types {DATA_TYPE_COMPACT_LIST};
+enum digest_data_types {DATA_TYPE_COMPACT_LIST, DATA_TYPE_RPM};
 
 enum compact_list_entry_ids {COMPACT_LIST_ID_DIGEST};
 
@@ -33,6 +35,20 @@ struct compact_list_hdr {
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
@@ -80,6 +96,69 @@ static int ima_parse_compact_list(loff_t size, void *buf)
 	return 0;
 }
 
+static int ima_parse_rpm(loff_t size, void *buf)
+{
+	void *bufp = buf, *bufendp = buf + size;
+	struct rpm_hdr *hdr = bufp;
+	u32 tags = be32_to_cpu(hdr->tags);
+	struct rpm_entryinfo *entry;
+	void *datap = bufp + sizeof(*hdr) + tags * sizeof(struct rpm_entryinfo);
+	int digest_len = hash_digest_size[ima_hash_algo];
+	u8 digest[digest_len];
+	int ret, i, j;
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
+		if (be32_to_cpu(entry->tag) != RPMTAG_FILEDIGESTS)
+			continue;
+
+		datap += be32_to_cpu(entry->offset);
+
+		for (j = 0; j < be32_to_cpu(entry->count) &&
+		     datap < bufendp; j++) {
+			if (strlen(datap) == 0) {
+				datap++;
+				continue;
+			}
+
+			if (datap + digest_len * 2 + 1 > bufendp) {
+				pr_err("RPM header read at invalid offset\n");
+				return -EINVAL;
+			}
+
+			hex2bin(digest, datap, digest_len);
+
+			ret = ima_add_digest_data_entry(digest);
+			if (ret < 0 && ret != -EEXIST)
+				return ret;
+
+			datap += digest_len * 2 + 1;
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
 static int ima_parse_digest_list_data(struct ima_field_data *data)
 {
 	void *digest_list;
@@ -107,6 +186,9 @@ static int ima_parse_digest_list_data(struct ima_field_data *data)
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
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
