From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 5 Apr 2017 14:53:32 -0700
Subject: [PATCH RFC 06/11] Smack: remove socket blob free
In-Reply-To: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
Message-ID: <8bedea9f-5a6c-7ff3-dda8-0ad7415dd39f@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH RFC 06/11] Smack: remove socket blob free.

With stacking in place the infrastructure releases the
socket blob, so the module shouldn't.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 security/smack/smack_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7c8ffe4..e1264b9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2272,7 +2272,6 @@ static void smack_sk_free_security(struct sock *sk)
 		}
 		rcu_read_unlock();
 	}
-	kfree(sk->sk_security);
 }
 #endif
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
