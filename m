From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 16 May 2017 14:53:43 +0200
Subject: [PATCH 3/7] ima: use ima_parse_buf() to parse template data
In-Reply-To: <20170516125347.10574-1-roberto.sassu@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
Message-ID: <20170516125347.10574-4-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The binary_field_data structure definition has been removed from
ima_restore_template_data(). The lengths and data pointers are directly
stored into the template_data array of the ima_template_entry structure.
For template data, both the number of fields and buffer end checks can
be done, as these information are known (respectively from the template
descriptor, and from the measurement header field).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_template.c | 44 +++++++++++------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 624e2a1..7412d02 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -277,13 +277,6 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 				     int template_data_size,
 				     struct ima_template_entry **entry)
 {
-	struct binary_field_data {
-		u32 len;
-		u8 data[0];
-	} __packed;
-
-	struct binary_field_data *field_data;
-	int offset = 0;
 	int ret = 0;
 	int i;
 
@@ -293,30 +286,19 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	if (!*entry)
 		return -ENOMEM;
 
+	ret = ima_parse_buf(template_data, template_data + template_data_size,
+			    NULL, template_desc->num_fields,
+			    (*entry)->template_data, NULL, NULL,
+			    ENFORCE_FIELDS | ENFORCE_BUFEND, "template data");
+	if (ret < 0) {
+		kfree(*entry);
+		return ret;
+	}
+
 	(*entry)->template_desc = template_desc;
 	for (i = 0; i < template_desc->num_fields; i++) {
-		field_data = template_data + offset;
-
-		/* Each field of the template data is prefixed with a length. */
-		if (offset > (template_data_size - sizeof(*field_data))) {
-			pr_err("Restoring the template field failed\n");
-			ret = -EINVAL;
-			break;
-		}
-		offset += sizeof(*field_data);
-
-		if (ima_canonical_fmt)
-			field_data->len = le32_to_cpu(field_data->len);
-
-		if (offset > (template_data_size - field_data->len)) {
-			pr_err("Restoring the template field data failed\n");
-			ret = -EINVAL;
-			break;
-		}
-		offset += field_data->len;
-
-		(*entry)->template_data[i].len = field_data->len;
-		(*entry)->template_data_len += sizeof(field_data->len);
+		struct ima_field_data *field_data = &(*entry)->template_data[i];
+		u8 *data = field_data->data;
 
 		(*entry)->template_data[i].data =
 			kzalloc(field_data->len + 1, GFP_KERNEL);
@@ -324,8 +306,8 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 			ret = -ENOMEM;
 			break;
 		}
-		memcpy((*entry)->template_data[i].data, field_data->data,
-			field_data->len);
+		memcpy((*entry)->template_data[i].data, data, field_data->len);
+		(*entry)->template_data_len += sizeof(field_data->len);
 		(*entry)->template_data_len += field_data->len;
 	}
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
