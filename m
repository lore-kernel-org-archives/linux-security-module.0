From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 25 Jul 2017 17:44:16 +0200
Subject: [PATCH 05/12] ima: add functions to manage digest lists
In-Reply-To: <20170725154423.24845-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
Message-ID: <20170725154423.24845-6-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch first introduces a new structure called ima_digest, which will
contain a digest parsed from the digest list. It has been preferred to
ima_queue_entry, as the existing structure includes an additional member
(a list head), which is not necessary for digest lookup.

Then, this patch introduces functions to lookup and add a digest to
a hash table, which will be used by the parsers.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h       |  8 ++++++++
 security/integrity/ima/ima_queue.c | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d52b487..a0c6808 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -107,6 +107,11 @@ struct ima_queue_entry {
 };
 extern struct list_head ima_measurements;	/* list of all measurements */
 
+struct ima_digest {
+	struct hlist_node hnext;
+	u8 digest[0];
+};
+
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
 	u16 version;
@@ -150,6 +155,8 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
+struct ima_digest *ima_lookup_loaded_digest(u8 *digest);
+int ima_add_digest_data_entry(u8 *digest);
 int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
@@ -166,6 +173,7 @@ struct ima_h_table {
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 extern struct ima_h_table ima_htable;
+extern struct ima_h_table ima_digests_htable;
 
 static inline unsigned long ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index a02a86d..d1a3d3f 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -42,6 +42,11 @@ struct ima_h_table ima_htable = {
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
+struct ima_h_table ima_digests_htable = {
+	.len = ATOMIC_LONG_INIT(0),
+	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
+};
+
 /* mutex protects atomicity of extending measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
@@ -212,3 +217,37 @@ int ima_restore_measurement_entry(struct ima_template_entry *entry)
 	mutex_unlock(&ima_extend_list_mutex);
 	return result;
 }
+
+struct ima_digest *ima_lookup_loaded_digest(u8 *digest)
+{
+	struct ima_digest *d = NULL;
+	int digest_len = hash_digest_size[ima_hash_algo];
+	unsigned int key = ima_hash_key(digest);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(d, &ima_digests_htable.queue[key], hnext) {
+		if (memcmp(d->digest, digest, digest_len) == 0)
+			break;
+	}
+	rcu_read_unlock();
+	return d;
+}
+
+int ima_add_digest_data_entry(u8 *digest)
+{
+	struct ima_digest *d = ima_lookup_loaded_digest(digest);
+	int digest_len = hash_digest_size[ima_hash_algo];
+	unsigned int key = ima_hash_key(digest);
+
+	if (d)
+		return -EEXIST;
+
+	d = kmalloc(sizeof(*d) + digest_len, GFP_KERNEL);
+	if (d == NULL)
+		return -ENOMEM;
+
+	memcpy(d->digest, digest, digest_len);
+	hlist_add_head_rcu(&d->hnext, &ima_digests_htable.queue[key]);
+	atomic_long_inc(&ima_digests_htable.len);
+	return 0;
+}
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
