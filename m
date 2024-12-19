Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184519993B;
	Thu, 19 Dec 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629346; cv=none; b=GQdEwmQockK2vdakdRbqemIaCUGBg9UHcajmdgLADdXmMVO0X0F5/RwFgSRK33bceMC3JTyTgjrdkb8hMUMwXPgGIsytoGTwyyW4f1ZCpZxJzrp5fdijme520hRnXnMYeSinI1mRl0DPy/D4gBdHmnw7QCUfKGfY3XemNa02sGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629346; c=relaxed/simple;
	bh=OG71VB4Qva8tkPsIhdGjUmOZ0r8nsYa50op3JxkZUDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfXwKWzXRlhUVFn6HxVIT1ePnz48qAgynUX3Uu7C9GJsmEQ3hVSdVUvKjX1rJ1QtZGBjlgVYL974p3E1oiMzusnXTHn6PTd1lZOtFHce5PJdEty7fmUHPsUvbbJRgy/CKSdrvuIGHNmaG0nXPlrfWZYCUyOaj0juqh9shtjBHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eQJ/OBoQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eQJ/OBoQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=htjwRJ7qT+wAL9TnKmTfqMbgxIuyKdsF07QoxvvJCP8=; b=eQJ/OBoQG6UMEdno
	P4WtC2YKj9ujhlmguyFjXe4Ka+xUIczJ1s64c4rHDOI7vPoaPlpgdyYQdGSqZs+sCO9mnDMNYEBTL
	MWrCcR1GZLsLJ3k6RT5MzUxR2n6po/sbzj0znliPZ8S5qSawxQi/oUWen47MhoZT7THVfdEp0dluu
	RujDfQLX4A8ozJXohN/d6G8IrARYhTSnrc0DlDOoSL3j8K5d8DcVzbFONNVv040keRZqbUKrPs/tk
	JQSDN661j6IQSYzg4+PIGWq120rhHhRsCjhVU5r1d3KSDJkGsUNmELUru/dwlqFs3CGD9ZjP9qe6u
	7MEQ9/MtLpV6OzeIGg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tOKKa-006MR1-0U;
	Thu, 19 Dec 2024 17:29:00 +0000
From: linux@treblig.org
To: serge@hallyn.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] capability: Remove unused has_capability
Date: Thu, 19 Dec 2024 17:28:59 +0000
Message-ID: <20241219172859.188117-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The vanilla has_capability() function has been unused since 2018's
commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")

Remove it.

Fixup a comment in security/commoncap.c that referenced it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/capability.h |  5 -----
 kernel/capability.c        | 16 ----------------
 security/commoncap.c       |  9 +++++----
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 0c356a517991..1fb08922552c 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -139,7 +139,6 @@ static inline kernel_cap_t cap_raise_nfsd_set(const kernel_cap_t a,
 }
 
 #ifdef CONFIG_MULTIUSER
-extern bool has_capability(struct task_struct *t, int cap);
 extern bool has_ns_capability(struct task_struct *t,
 			      struct user_namespace *ns, int cap);
 extern bool has_capability_noaudit(struct task_struct *t, int cap);
@@ -150,10 +149,6 @@ extern bool ns_capable(struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
 extern bool ns_capable_setid(struct user_namespace *ns, int cap);
 #else
-static inline bool has_capability(struct task_struct *t, int cap)
-{
-	return true;
-}
 static inline bool has_ns_capability(struct task_struct *t,
 			      struct user_namespace *ns, int cap)
 {
diff --git a/kernel/capability.c b/kernel/capability.c
index dac4df77e376..67094b628ea9 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -289,22 +289,6 @@ bool has_ns_capability(struct task_struct *t,
 	return (ret == 0);
 }
 
-/**
- * has_capability - Does a task have a capability in init_user_ns
- * @t: The task in question
- * @cap: The capability to be tested for
- *
- * Return true if the specified task has the given superior capability
- * currently in effect to the initial user namespace, false if not.
- *
- * Note that this does not set PF_SUPERPRIV on the task.
- */
-bool has_capability(struct task_struct *t, int cap)
-{
-	return has_ns_capability(t, &init_user_ns, cap);
-}
-EXPORT_SYMBOL(has_capability);
-
 /**
  * has_ns_capability_noaudit - Does a task have a capability (unaudited)
  * in a specific user ns.
diff --git a/security/commoncap.c b/security/commoncap.c
index cefad323a0b1..7019d0e47e62 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -59,10 +59,11 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
  * Determine whether the nominated task has the specified capability amongst
  * its effective set, returning 0 if it does, -ve if it does not.
  *
- * NOTE WELL: cap_has_capability() cannot be used like the kernel's capable()
- * and has_capability() functions.  That is, it has the reverse semantics:
- * cap_has_capability() returns 0 when a task has a capability, but the
- * kernel's capable() and has_capability() returns 1 for this case.
+ * NOTE WELL: cap_capable() has reverse semantics to the capable() call
+ * and friends. That is cap_capable() returns an int 0 when a task has
+ * a capability, while the kernel's capable(), has_ns_capability(),
+ * has_ns_capability_noaudit(), and has_capability_noaudit() return a
+ * bool true (1) for this case.
  */
 int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
 		int cap, unsigned int opts)
-- 
2.47.1

