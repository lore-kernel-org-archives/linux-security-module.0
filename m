From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 4 Apr 2017 13:14:32 +0200
Subject: [PATCH 2/3] selinux: Return an error code only as a constant in
	sidtab_insert()
In-Reply-To: <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
Message-ID: <61cd20e9-211e-b974-3525-fcb5fdf8fa7e@users.sourceforge.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Apr 2017 11:33:53 +0200

* Return an error code without storing it in an intermediate variable.

* Delete the local variable "rc" and the jump label "out" which became
  unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/sidtab.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index f6915f257486..c5f436b15d19 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -32,13 +32,11 @@ int sidtab_init(struct sidtab *s)
 
 int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 {
-	int hvalue, rc = 0;
+	int hvalue;
 	struct sidtab_node *prev, *cur, *newnode;
 
-	if (!s) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!s)
+		return -ENOMEM;
 
 	hvalue = SIDTAB_HASH(sid);
 	prev = NULL;
@@ -48,21 +46,17 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 		cur = cur->next;
 	}
 
-	if (cur && sid == cur->sid) {
-		rc = -EEXIST;
-		goto out;
-	}
+	if (cur && sid == cur->sid)
+		return -EEXIST;
 
 	newnode = kmalloc(sizeof(*newnode), GFP_ATOMIC);
-	if (!newnode) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!newnode)
+		return -ENOMEM;
+
 	newnode->sid = sid;
 	if (context_cpy(&newnode->context, context)) {
 		kfree(newnode);
-		rc = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	if (prev) {
@@ -78,8 +72,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 	s->nel++;
 	if (sid >= s->next_sid)
 		s->next_sid = sid + 1;
-out:
-	return rc;
+	return 0;
 }
 
 static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
