Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D3D320E;
	Sun, 15 Dec 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734281638; cv=none; b=IQnwECtxss3WFgmW8P2kuzh7e3gYLi3GdKSrXstftKsZUj7xVjJoXaQU0M9Up4NN3Wi0zLkZsgSBzkLzAGyHxCqxNn4izcYjZcKlNasuTUnBHZx8Iz/LqoMGPES52docCaAJW4Oier5FDKO/ztl/fXI5a8Gd7/TfEW3acFpaQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734281638; c=relaxed/simple;
	bh=lG/kQSjr0yvm2gYp09d1RITrtzJMlWKO3wDMYF21dD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KunDNOZrNxnZZW5finm3r6TNo/FV/yIns3eh6vtXJOCaSDwOiwaPkWC6XZbFNPt4ufIHMpSgnrAVMQ/tVI5wH/DG6Pd0v/FgEdqOCoWw97Af1dkOfvsefGiE9yPoBWkVJrKtFtRB0RXI5bYInhIW8t4pmCCEoc4cIfgu6J6pBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oSv2Uf/l; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oSv2Uf/l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VtjITOqJJ1i8Ijy5fAK1qVBLQmBOQlQpAcm0oT6U3kQ=; b=oSv2Uf/le6FbgHcK
	ry7FYj5b+/NlAbVJEYttAyqV6LZK8cuemwEa09t9EjAnbDlAmm+yx/5myJBSOvzbGINXUN6HxrxTj
	ifoMEhN7hoCSB1PsQ/yGYuZm0a01SsHmZXLmphgXNW3gPhlZwVM5XbzYw2kGjwMV1AxvsDthJAA8G
	3mFoPBQ51QxYfjvMJ7GkB3+5GvhSZ7O1ti2CUa2/gQXnEY9FQhzWN3zV1UymvzSt97IINwAHCWAIZ
	4DZRufSILvwQYjy3ZzXuidW/AO4ZUnaZYGUkxlVxYWzIV7V5o9nL50Cs7Gj8paBtQLLMlT2fL7dvT
	mUAwKfBIiy9CAWZnng==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tMrsO-005Txc-2y;
	Sun, 15 Dec 2024 16:53:52 +0000
From: linux@treblig.org
To: serge@hallyn.com,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] capability: Remove unused has_capability
Date: Sun, 15 Dec 2024 16:53:52 +0000
Message-ID: <20241215165352.186692-1-linux@treblig.org>
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

(There is still mention in a comment in security/commoncap.c
but I suspect rather than removing the entry it might be better
to expand the comment to talk about the other
has_[ns_]capability[_noaudit] variants).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/capability.h |  5 -----
 kernel/capability.c        | 16 ----------------
 2 files changed, 21 deletions(-)

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
-- 
2.47.1

