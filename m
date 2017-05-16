From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 16 May 2017 14:53:42 +0200
Subject: [PATCH 2/7] ima: use ima_parse_buf() to parse measurements headers
In-Reply-To: <20170516125347.10574-1-roberto.sassu@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
Message-ID: <20170516125347.10574-3-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The binary_hdr_v1 and binary_data_v1 structures defined in
ima_restore_measurement_list() have been replaced with an array of four
ima_field_data structures where pcr, digest, template name and
template data lengths and pointers are stored.

The length of pcr and digest in the ima_field_data array and the bits
in the bitmap are set before ima_parse_buf() is called. The ENFORCE_FIELDS
bit is set for all entries except the last one (there is still data to
parse), and ENFORCE_BUFEND is set only for the last entry.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_template.c | 80 ++++++++++++-----------------------
 1 file changed, 28 insertions(+), 52 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index cebb37c..624e2a1 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -19,6 +19,9 @@
 #include "ima.h"
 #include "ima_template_lib.h"
 
+enum header_fields { HDR_PCR, HDR_DIGEST, HDR_TEMPLATE_NAME,
+		     HDR_TEMPLATE_DATA, HDR__LAST };
+
 static struct ima_template_desc builtin_templates[] = {
 	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
 	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
@@ -337,27 +340,19 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 /* Restore the serialized binary measurement list without extending PCRs. */
 int ima_restore_measurement_list(loff_t size, void *buf)
 {
-	struct binary_hdr_v1 {
-		u32 pcr;
-		u8 digest[TPM_DIGEST_SIZE];
-		u32 template_name_len;
-		char template_name[0];
-	} __packed;
 	char template_name[MAX_TEMPLATE_NAME_LEN];
 
-	struct binary_data_v1 {
-		u32 template_data_size;
-		char template_data[0];
-	} __packed;
-
 	struct ima_kexec_hdr *khdr = buf;
-	struct binary_hdr_v1 *hdr_v1;
-	struct binary_data_v1 *data_v1;
+	struct ima_field_data hdr[HDR__LAST] = {
+		[HDR_PCR] = {.len = sizeof(u32)},
+		[HDR_DIGEST] = {.len = TPM_DIGEST_SIZE},
+	};
 
 	void *bufp = buf + sizeof(*khdr);
 	void *bufendp;
 	struct ima_template_entry *entry;
 	struct ima_template_desc *template_desc;
+	DECLARE_BITMAP(hdr_mask, HDR__LAST);
 	unsigned long count = 0;
 	int ret = 0;
 
@@ -380,6 +375,10 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		return -EINVAL;
 	}
 
+	bitmap_zero(hdr_mask, HDR__LAST);
+	bitmap_set(hdr_mask, HDR_PCR, 1);
+	bitmap_set(hdr_mask, HDR_DIGEST, 1);
+
 	/*
 	 * ima kexec buffer prefix: version, buffer size, count
 	 * v1 format: pcr, digest, template-name-len, template-name,
@@ -387,31 +386,25 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	 */
 	bufendp = buf + khdr->buffer_size;
 	while ((bufp < bufendp) && (count++ < khdr->count)) {
-		hdr_v1 = bufp;
-		if (bufp > (bufendp - sizeof(*hdr_v1))) {
-			pr_err("attempting to restore partial measurement\n");
-			ret = -EINVAL;
-			break;
-		}
-		bufp += sizeof(*hdr_v1);
+		int enforce_mask = ENFORCE_FIELDS;
 
-		if (ima_canonical_fmt)
-			hdr_v1->template_name_len =
-			    le32_to_cpu(hdr_v1->template_name_len);
+		enforce_mask |= (count == khdr->count) ? ENFORCE_BUFEND : 0;
+		ret = ima_parse_buf(bufp, bufendp, &bufp, HDR__LAST, hdr, NULL,
+				    hdr_mask, enforce_mask, "entry header");
+		if (ret < 0)
+			break;
 
-		if ((hdr_v1->template_name_len >= MAX_TEMPLATE_NAME_LEN) ||
-		    (bufp > (bufendp - hdr_v1->template_name_len))) {
+		if (hdr[HDR_TEMPLATE_NAME].len >= MAX_TEMPLATE_NAME_LEN) {
 			pr_err("attempting to restore a template name \
 				that is too long\n");
 			ret = -EINVAL;
 			break;
 		}
-		data_v1 = bufp += (u_int8_t)hdr_v1->template_name_len;
 
 		/* template name is not null terminated */
-		memcpy(template_name, hdr_v1->template_name,
-		       hdr_v1->template_name_len);
-		template_name[hdr_v1->template_name_len] = 0;
+		memcpy(template_name, hdr[HDR_TEMPLATE_NAME].data,
+		       hdr[HDR_TEMPLATE_NAME].len);
+		template_name[hdr[HDR_TEMPLATE_NAME].len] = 0;
 
 		if (strcmp(template_name, "ima") == 0) {
 			pr_err("attempting to restore an unsupported \
@@ -441,34 +434,17 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 			break;
 		}
 
-		if (bufp > (bufendp - sizeof(data_v1->template_data_size))) {
-			pr_err("restoring the template data size failed\n");
-			ret = -EINVAL;
-			break;
-		}
-		bufp += (u_int8_t) sizeof(data_v1->template_data_size);
-
-		if (ima_canonical_fmt)
-			data_v1->template_data_size =
-			    le32_to_cpu(data_v1->template_data_size);
-
-		if (bufp > (bufendp - data_v1->template_data_size)) {
-			pr_err("restoring the template data failed\n");
-			ret = -EINVAL;
-			break;
-		}
-		bufp += data_v1->template_data_size;
-
 		ret = ima_restore_template_data(template_desc,
-						data_v1->template_data,
-						data_v1->template_data_size,
+						hdr[HDR_TEMPLATE_DATA].data,
+						hdr[HDR_TEMPLATE_DATA].len,
 						&entry);
 		if (ret < 0)
 			break;
 
-		memcpy(entry->digest, hdr_v1->digest, TPM_DIGEST_SIZE);
-		entry->pcr =
-		    !ima_canonical_fmt ? hdr_v1->pcr : le32_to_cpu(hdr_v1->pcr);
+		memcpy(entry->digest, hdr[HDR_DIGEST].data,
+		       hdr[HDR_DIGEST].len);
+		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
+			     le32_to_cpu(*(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
 		if (ret < 0)
 			break;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
