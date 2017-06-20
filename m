From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Jun 2017 22:33:04 +0200
Subject: [PATCH] apparmor: add braces around optional statement
Message-ID: <20170620203331.609995-1-arnd@arndb.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

We get a warning when AA_BUG() compiles to an nothing:

security/apparmor/label.c: In function '__label_update':
security/apparmor/label.c:2055:3: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]

There are two things we can do about this:

- add the missing braces in the call site, which also
  brings the code in line with the regular Linux coding style

- redefine the macro so it is not empty but instead uses
  no_printk() in AA_BUG_FMT() to perform format checking.

Both seem like good ideas, so this does both at once.

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/apparmor/label.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index e052eaba1cf6..f8e08d94a8a6 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -2051,8 +2051,9 @@ static struct aa_label *__label_update(struct aa_label *label)
 			write_lock_irqsave(&ls->lock, flags);
 			goto remove;
 		}
-	} else
+	} else {
 		AA_BUG(labels_ns(label) != labels_ns(new));
+	}
 
 	tmp = __label_insert(labels_set(label), new, true);
 remove:
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
