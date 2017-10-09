From: ebiggers3@gmail.com (Eric Biggers)
Date: Mon,  9 Oct 2017 12:40:00 -0700
Subject: [PATCH v2] FS-Cache: fix dereference of NULL user_key_payload
Message-ID: <20171009194000.66958-1-ebiggers3@gmail.com>
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
---

Changed since v1: added Reviewed-by and resent as standalone patch.
Can this please be taken through the keyrings tree?

 fs/fscache/object-list.c | 7 +++++++
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
2.14.2.920.gcf0c67979c-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
