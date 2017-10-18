From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 17 Oct 2017 22:53:17 -0200
Subject: [PATCH v5 04/18] evm, ima: Remove more superfluous parentheses
In-Reply-To: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
References: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20171018005331.2688-5-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch removes unnecessary parentheses from all EVM and IMA files
not yet cleaned up by the previous patches.

It is separate from the previous one so that it can be easily dropped if
the churn and conflict potential is deemed not worth it.

Confirmed that the patch is correct by comparing the object files from
before and after the patch. They are identical.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/evm/evm_posix_acl.c | 8 ++++----
 security/integrity/ima/ima_fs.c        | 6 +++---
 security/integrity/ima/ima_queue.c     | 6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/integrity/evm/evm_posix_acl.c b/security/integrity/evm/evm_posix_acl.c
index 46408b9e62e8..0a32798cfc96 100644
--- a/security/integrity/evm/evm_posix_acl.c
+++ b/security/integrity/evm/evm_posix_acl.c
@@ -17,11 +17,11 @@ int posix_xattr_acl(const char *xattr)
 {
 	int xattr_len = strlen(xattr);
 
-	if ((strlen(XATTR_NAME_POSIX_ACL_ACCESS) == xattr_len)
-	     && (strncmp(XATTR_NAME_POSIX_ACL_ACCESS, xattr, xattr_len) == 0))
+	if (strlen(XATTR_NAME_POSIX_ACL_ACCESS) == xattr_len
+	    && strncmp(XATTR_NAME_POSIX_ACL_ACCESS, xattr, xattr_len) == 0)
 		return 1;
-	if ((strlen(XATTR_NAME_POSIX_ACL_DEFAULT) == xattr_len)
-	     && (strncmp(XATTR_NAME_POSIX_ACL_DEFAULT, xattr, xattr_len) == 0))
+	if (strlen(XATTR_NAME_POSIX_ACL_DEFAULT) == xattr_len
+	    && strncmp(XATTR_NAME_POSIX_ACL_DEFAULT, xattr, xattr_len) == 0)
 		return 1;
 	return 0;
 }
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 4d50b982b453..552f79fc4291 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -105,7 +105,7 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&qe->later == &ima_measurements) ? NULL : qe;
+	return &qe->later == &ima_measurements ? NULL : qe;
 }
 
 static void ima_measurements_stop(struct seq_file *m, void *v)
@@ -141,7 +141,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	if (e == NULL)
 		return -1;
 
-	template_name = (e->template_desc->name[0] != '\0') ?
+	template_name = e->template_desc->name[0] != '\0' ?
 	    e->template_desc->name : e->template_desc->fmt;
 
 	/*
@@ -228,7 +228,7 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	if (e == NULL)
 		return -1;
 
-	template_name = (e->template_desc->name[0] != '\0') ?
+	template_name = e->template_desc->name[0] != '\0' ?
 	    e->template_desc->name : e->template_desc->fmt;
 
 	/* 1st: PCR used (config option) */
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a02a86d51102..2ef7d33ba1fc 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -60,7 +60,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
 		rc = memcmp(qe->entry->digest, digest_value, TPM_DIGEST_SIZE);
-		if ((rc == 0) && (qe->entry->pcr == pcr)) {
+		if (rc == 0 && qe->entry->pcr == pcr) {
 			ret = qe;
 			break;
 		}
@@ -119,7 +119,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 		int size;
 
 		size = get_binary_runtime_size(entry);
-		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
+		binary_runtime_size = binary_runtime_size < ULONG_MAX - size ?
 		     binary_runtime_size + size : ULONG_MAX;
 	}
 	return 0;
@@ -132,7 +132,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
  */
 unsigned long ima_get_binary_runtime_size(void)
 {
-	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
+	if (binary_runtime_size >= ULONG_MAX - sizeof(struct ima_kexec_hdr))
 		return ULONG_MAX;
 	else
 		return binary_runtime_size + sizeof(struct ima_kexec_hdr);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
