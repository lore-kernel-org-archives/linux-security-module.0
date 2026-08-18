Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85964379991
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082706; cv=none; b=ISGEUCMtGNtH3lZ99hrqA0nmukGr8OdW4KALS8AmBvzRgGN3U3CenQBAop77wsfCQtH0DiVu82s0ER3UUCGbUiKfv4tdRY1Wmj0cuwIcyiRjV4vC9Ifv84lSQk51KOZF7XSfl/d0M0zSbzfS4YjcTcKVUV0Pas3xcramvB2it3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082706; c=relaxed/simple;
	bh=9uHRP1QAod/qRgNxXnmI4WhcZ+rp1J5wXAIzmWkxjdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpstABfHB/gzNbCUBOlvhK/kxt7OoEiTJM631YwLKm3AKnTwvuY+iZ+qZRdtY7K8F8RRZnskpwZ65Jw1WhiQWA2L+fil3ZNMg2OJU/gKANU/rxEIsY3X8VSsJoPx44K2sTrDE74HyV/0IJf9VFZtjxnxE/duwLZsffM7/3DIzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aS6NsC11; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aS6NsC11"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4994d67d260so2105e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787082703; x=1787687503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/48NguWRU9bZx//FrJDrEgNODvcpOLG3InPhFqPXnRg=;
        b=aS6NsC11xNWTYTPjNvVViDvzInYuo0G58cgpXYX1gfE0NBXqS2CNLrXZYsjUKcWJgx
         dBXQHR935uEXNhfJs4qg0DvtzD6k450zVbUJ2+BTXkpYVL5Uyew5DF5sVyRevietP6cg
         9EYgfYqooHdmZ8cJrEqQmCaGnunDqchYNvthqIdT5bBIV1/Y9ohJAhZ+6TjY2+w5jsyb
         BvYbtV9a54aa6taTxoi4ckjKS+uVaIrZ2Wzrla9B+nJcpucRcQyZeJ4iEqtNNCKdaCpK
         PYzvAjJNF8ruom+NsG9nsx9LLQ3NDFR9jfMuuyuYOY+43+GfQjzFPZTN/kEQtzGGW3v+
         Clrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082703; x=1787687503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/48NguWRU9bZx//FrJDrEgNODvcpOLG3InPhFqPXnRg=;
        b=R5BsgYQZG87yzc0DkjIGNpxqwJ92Mv80Mr57+4jKjMnuxtiBoOAZf/Ft/ybWa6Vegf
         TTKb6kvi/+aAgOS35RvvDSDcPDCOFhKJrU4uEe6vVQwqfW2BTBEbhhNIWeM2s2hXBnHC
         fiOS9I/cvDroDkSuZ27a8xGc+dXapXg/yl16vqXhPulEgIfnNSboZ0WIeN3QT9/ONQQk
         TZaB0tkdtGFxjRyt2IRTPLc63pqJKT6I6ZtlekwcP3CRAFDZbiXWb/9EtOhbnzJ0AZ3S
         A1qhR5ZUAS+V73JQvwu5915VLEaVFjd1mLcfGXTMcjKDHk2pTTqlyS5e78TcDfI3Zkkm
         wVXw==
X-Forwarded-Encrypted: i=1; AHgh+RrXnmnRXP86yRsbwSs53k8m1A2PAxfSSRlT+KQ6urZ0pmvbjYdIdXSBCOLwNemEsrqciMoFAHBVlEhl1waTLzSJCLL9Jl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMAoTNFs3uxU916RWZa4oIz8VUO5wUvmx8toHM08qeKn0wDu1A
	UxI09I5bXswghDxJvxZ/v2FoG2Xle897I0OdXiHrpushF8FmECS4yEySrgdfeJ5/uQ==
X-Gm-Gg: AR+sD10K0k3yz5tD/gjU2B+Wa2YOiO0TVaWmjS8w4cj4w5aOr8iSvuZ5jOS6pAfqT1O
	aQBU937GqtOobWcvU/AK5rkGJz8acArQN60Cjo5I1q38yO/frMNCJVnrxvtxQbFQR+T29vyleVT
	eZ/Q6O7sPCdWt16ziW+7WYbsqrKYfb5eZkkdAAY5/uKVFbf/kgnuS6Hw7LUHe8UC1gMN2PRXrr/
	G2dk4CV9raumIrtIovhSpWuWljnhN22LDzCXnFDiiGIq7bpDvvIwJvntivDVywGFV1spXwdFDw2
	hhTGGmixq75eRzKuTPMSlbdRm6YuMh9WaC+eW2Jkhmn/G9CqJBx2rH/YTepRUoVXlaA8m1+jD62
	Wz0tXSnWDGXqmqnHHeEFUVW8H4ARN2/efmIIorgbxQh96CkDCBZTf7jx2i2727noOwotmo1+4ZN
	K5CtV8VjRLnaTs1+jDLyq9oUmvxQXsXKeUzQIATPWsUzfsTKfAr6N8QuhphMhXNAaVvD4djpGow
	GqPOcl9UkaLQqBMDfKEO8L8Z6GX89cV7fvOS07Nh0KhgwWM
X-Received: by 2002:a7b:cd0c:0:b0:493:a96b:f9fe with SMTP id 5b1f17b1804b1-499a9574768mr34305e9.4.1787082702506;
        Tue, 18 Aug 2026 12:51:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:f466:5a15:1301:318d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14946986f8f.16.2026.08.18.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:51:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 18 Aug 2026 21:51:06 +0200
Subject: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
In-Reply-To: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787082694; l=5164;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=9uHRP1QAod/qRgNxXnmI4WhcZ+rp1J5wXAIzmWkxjdk=;
 b=QhCD/dpVyuHUA59IInGgknlAukZUxr309hmljE5BsC20XSQv0XHxJumcEMH0epWxltedJEorj
 9o+qlp6IUXyD/NlvzGKNvAyNi+iK04kMVoV2ZDdmCLoy/D2vjaJ0P/7
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
good opportunity to block a process from overwriting read-only code in its
own address space through FOLL_FORCE writes via /proc/self/mem.
The security_ptrace_access_check() LSM hook is bypassed when a process
opens /proc/self/mem because this is considered "introspection".

This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
that a process cannot create executable anonymous pages.

PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
accesses are only possible when the LSM allows ptrace() attachment; but it
is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
environments running lots of third-party code, such as Android.

So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
such "introspective" accesses.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c                |  6 ++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 15 +++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index bec6197329dc..3dfaef49bb70 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 /* private_data for proc_mem_operations */
 struct mem_private {
 	struct mm_struct *mm;
+	/* Was the ptrace access check bypassed due to introspection? */
+	bool introspection;
 };
 
 static int mem_open(struct inode *inode, struct file *file)
@@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct file *file)
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
 	if (IS_ERR_OR_NULL(priv->mm))
 		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->introspection = priv->mm == current->mm;
 	file->private_data = no_free_ptr(priv);
 	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 {
+	struct mem_private *priv = file->private_data;
 	struct task_struct *task;
 	bool ptrace_active = false;
 
@@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 		}
 		return ptrace_active;
 	default:
+		if (priv->introspection)
+			return security_introspect_mem_foll_force(file->f_cred) == 0;
 		return true;
 	}
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..67452f71bedf 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
+LSM_HOOK(int, 0, introspect_mem_foll_force, const struct cred *subject)
 LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
 	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
 LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..f8483be58bc8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
+int security_introspect_mem_foll_force(const struct cred *subject);
 int security_capget(const struct task_struct *target,
 		    kernel_cap_t *effective,
 		    kernel_cap_t *inheritable,
@@ -676,6 +677,11 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
 	return cap_ptrace_traceme(parent);
 }
 
+static inline int security_introspect_mem_foll_force(const struct cred *subject)
+{
+	return 0;
+}
+
 static inline int security_capget(const struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..d0f790a534eb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -595,6 +595,21 @@ int security_ptrace_traceme(struct task_struct *parent)
 	return call_int_hook(ptrace_traceme, parent);
 }
 
+/**
+ * security_introspect_mem_foll_force() - Check if introspective FOLL_FORCE is allowed
+ * @subject: credentials of the process accessing its own memory
+ *
+ * Check if FOLL_FORCE is allowed for a process accessing its own memory, which
+ * bypasses the security_ptrace_access_check() hook.
+ * This is only used when the system is configured with PROC_MEM_FORCE_ALWAYS.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_introspect_mem_foll_force(const struct cred *subject)
+{
+	return call_int_hook(introspect_mem_foll_force, subject);
+}
+
 /**
  * security_capget() - Get the capability sets for a process
  * @target: target process

-- 
2.55.0.737.g08866a6d13-goog

