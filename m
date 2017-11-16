From: devtimhansen@gmail.com (Tim Hansen)
Date: Thu, 16 Nov 2017 12:03:34 -0500
Subject: [PATCH] net/netlabel: Add list_next_rcu() in rcu_dereference().
Message-ID: <20171116170334.GA141280@debian>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add list_next_rcu() for fetching next list in rcu_deference safely.

Found with sparse in linux-next tree on tag next-20171116.

Signed-off-by: Tim Hansen <devtimhansen@gmail.com>
---
 net/netlabel/netlabel_addrlist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_addrlist.h b/net/netlabel/netlabel_addrlist.h
index d0f38bc..ac709f0 100644
--- a/net/netlabel/netlabel_addrlist.h
+++ b/net/netlabel/netlabel_addrlist.h
@@ -87,7 +87,7 @@ static inline struct netlbl_af4list *__af4list_valid_rcu(struct list_head *s,
 	struct list_head *i = s;
 	struct netlbl_af4list *n = __af4list_entry(s);
 	while (i != h && !n->valid) {
-		i = rcu_dereference(i->next);
+		i = rcu_dereference(list_next_rcu(i));
 		n = __af4list_entry(i);
 	}
 	return n;
@@ -154,7 +154,7 @@ static inline struct netlbl_af6list *__af6list_valid_rcu(struct list_head *s,
 	struct list_head *i = s;
 	struct netlbl_af6list *n = __af6list_entry(s);
 	while (i != h && !n->valid) {
-		i = rcu_dereference(i->next);
+		i = rcu_dereference(list_next_rcu(i));
 		n = __af6list_entry(i);
 	}
 	return n;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
