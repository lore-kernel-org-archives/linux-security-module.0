From: dhowells@redhat.com (David Howells)
Date: Thu, 12 Oct 2017 21:16:11 +0100
Subject: [PATCH 02/15] FS-Cache: fix dereference of NULL user_key_payload
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
Message-ID: <150783937089.10956.12638762984670845378.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When the file /proc/fs/fscache/objects (available with
CONFIG_FSCACHE_OBJECT_LIST=y) is opened, we request a user key with
description "fscache:objlist", then access its payload.  However, a
revoked key has a NULL payload, and we failed to check for this.
request_key() *does* skip revoked keys, but there is still a window
where the key can be revoked before we access its payload.

Fix it by checking for a NULL payload, treating it like a key which was
already revoked at the time it was requested.

Fixes: 4fbf4291aa15 ("FS-Cache: Allow the current state of all objects to be dumped")
Reviewed-by: James Morris <james.l.morris@oracle.com>
Cc: <stable@vger.kernel.org>    [v2.6.32+]
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/object-list.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index b5ab06fabc60..0438d4cd91ef 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -331,6 +331,13 @@ static void fscache_objlist_config(struct fscache_objlist_data *data)
 	rcu_read_lock();
 
 	confkey = user_key_payload_rcu(key);
+	if (!confkey) {
+		/* key was revoked */
+		rcu_read_unlock();
+		key_put(key);
+		goto no_config;
+	}
+
 	buf = confkey->data;
 
 	for (len = confkey->datalen - 1; len >= 0; len--) {

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
