From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon,  9 Oct 2017 17:22:49 -0700
Subject: [PATCH RFC tip/core/rcu 15/15] keyring: Remove now-redundant
	smp_read_barrier_depends()
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-15-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Now that the associative-array library properly heads dependency chains,
the various smp_read_barrier_depends() calls in security/keys/keyring.c
are no longer needed.  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <keyrings@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>
---
 security/keys/keyring.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4fa82a8a9c0e..fb44c9169125 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -712,7 +712,6 @@ static bool search_nested_keyrings(struct key *keyring,
 		 * doesn't contain any keyring pointers.
 		 */
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		if ((shortcut->index_key[0] & ASSOC_ARRAY_FAN_MASK) != 0)
 			goto not_this_keyring;
 
@@ -722,8 +721,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	}
 
 	node = assoc_array_ptr_to_node(ptr);
-	smp_read_barrier_depends();
-
 	ptr = node->slots[0];
 	if (!assoc_array_ptr_is_meta(ptr))
 		goto begin_node;
@@ -735,7 +732,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	kdebug("descend");
 	if (assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		ptr = READ_ONCE(shortcut->next_node);
 		BUG_ON(!assoc_array_ptr_is_node(ptr));
 	}
@@ -743,7 +739,6 @@ static bool search_nested_keyrings(struct key *keyring,
 
 begin_node:
 	kdebug("begin_node");
-	smp_read_barrier_depends();
 	slot = 0;
 ascend_to_node:
 	/* Go through the slots in a node */
@@ -791,14 +786,12 @@ static bool search_nested_keyrings(struct key *keyring,
 
 	if (ptr && assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		ptr = READ_ONCE(shortcut->back_pointer);
 		slot = shortcut->parent_slot;
 	}
 	if (!ptr)
 		goto not_this_keyring;
 	node = assoc_array_ptr_to_node(ptr);
-	smp_read_barrier_depends();
 	slot++;
 
 	/* If we've ascended to the root (zero backpointer), we must have just
-- 
2.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
