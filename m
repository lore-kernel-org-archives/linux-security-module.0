From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:36:56 +0100
Subject: [PATCH v2 01/15] ima: generalize ima_read_policy()
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-2-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Rename ima_read_policy() to ima_read_file(), and add file_id as new
parameter. If file_id is equal to READING_POLICY, ima_read_file() behavior
remains unchanged. ima_read_file() will be used to read digest list
metadata.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fa540c0469da..27de4558303e 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -272,7 +272,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(char *path)
+static ssize_t ima_read_file(char *path, enum kernel_read_file_id file_id)
 {
 	void *data;
 	char *datap;
@@ -285,16 +285,22 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, &size, 0, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, &size, 0, file_id);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
 	}
 
 	datap = data;
-	while (size > 0 && (p = strsep(&datap, "\n"))) {
-		pr_debug("rule: %s\n", p);
-		rc = ima_parse_add_rule(p);
+	while (size > 0) {
+		if (file_id == READING_POLICY) {
+			p = strsep(&datap, "\n");
+			if (p == NULL)
+				break;
+
+			pr_debug("rule: %s\n", p);
+			rc = ima_parse_add_rule(p);
+		}
 		if (rc < 0)
 			break;
 		size -= rc;
@@ -334,7 +340,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_policy(data);
+		result = ima_read_file(data, READING_POLICY);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("IMA: signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
