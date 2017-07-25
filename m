From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 25 Jul 2017 17:44:18 +0200
Subject: [PATCH 07/12] ima: added parser for compact digest list
In-Reply-To: <20170725154423.24845-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
Message-ID: <20170725154423.24845-8-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces the parser for the compact digest list.
Its format is:

entry_id[2] count[4] data_len[4]
data[data_len]
entry_id[2] count[4] data_len[4]
data[data_len]
...

The parser supports the COMPACT_LIST_ID_DIGEST entry ID.

This format is suitable to store a large number of digests, as there is
no metadata provided for each. Digests (which have all the same size) are
concatenated together and placed after the header.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_list.c | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index 3e1ff69b..c1ef79a 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -23,6 +23,63 @@ enum digest_metadata_fields {DATA_ALGO, DATA_DIGEST, DATA_SIGNATURE,
 			     DATA_FILE_PATH, DATA_REF_ID, DATA_TYPE,
 			     DATA__LAST};
 
+enum digest_data_types {DATA_TYPE_COMPACT_LIST};
+
+enum compact_list_entry_ids {COMPACT_LIST_ID_DIGEST};
+
+struct compact_list_hdr {
+	u16 entry_id;
+	u32 count;
+	u32 datalen;
+} __packed;
+
+static int ima_parse_compact_list(loff_t size, void *buf)
+{
+	void *bufp = buf, *bufendp = buf + size;
+	int digest_len = hash_digest_size[ima_hash_algo];
+	struct compact_list_hdr *hdr;
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
+		if (ima_canonical_fmt) {
+			hdr->entry_id = le16_to_cpu(hdr->entry_id);
+			hdr->count = le32_to_cpu(hdr->count);
+			hdr->datalen = le32_to_cpu(hdr->datalen);
+		}
+
+		if (hdr->entry_id != COMPACT_LIST_ID_DIGEST) {
+			pr_err("compact list, invalid data type\n");
+			return -EINVAL;
+		}
+
+		bufp += sizeof(*hdr);
+
+		for (i = 0; i < hdr->count &&
+		     bufp + digest_len <= bufendp; i++) {
+			ret = ima_add_digest_data_entry(bufp);
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
 static int ima_parse_digest_list_data(struct ima_field_data *data)
 {
 	void *digest_list;
@@ -47,6 +104,9 @@ static int ima_parse_digest_list_data(struct ima_field_data *data)
 	}
 
 	switch (data_type) {
+	case DATA_TYPE_COMPACT_LIST:
+		ret = ima_parse_compact_list(digest_list_size, digest_list);
+		break;
 	default:
 		pr_err("Parser for data type %d not implemented\n", data_type);
 		ret = -EINVAL;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
