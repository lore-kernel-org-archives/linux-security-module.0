Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048445;
	b=AlTlzs9xVeaBE3BZOuElqmRXVNvWdwBeWKW3wmHOsn/RVobZ/yjYKIMZOA4RpqvN3coa
	 07ra6xzXNezokbCNWZNJ+s97xT67owCYJ+Win8Ut+qpEYzIIrrL6e5leBR4BaFj44X+0E
	 EfogA5zbWUhQFpCUrM6TC4l8C9dlnf86FyEpwacatHE0sS4TUw3l5jvSbAXAiJqdR6Q08
	 a1LEKtqx+oIYiv/tjH4PvzmUAQ2N0H+VoJQBONxnAd7PZPTaW8SUs0JUjDfRAb96eDgK6
	 7jGjRDnfNwrjIxjpBuiK02fZVIP3XwNUPIBuu5jssKMChm5/GxKsTj8NMJK7wMLuBxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=/QAf07cAiyxBwSWgq7Tjim9fLXjZh7SPBHX/IjDGa5I=;
	b=3d5Gfzo1tgon5/rdpQ/WUGdN3Yj8ojzPvSnwWhuXtaDAJXjel4HwjUWWIR1Kj2O2QsQp
	 ugYiuEJ+a5YmnED0d836qInPzrJjr3Eufhzk9COpP/qtvQ5niXnwb665jy6troOW0qv/V
	 5yvuYfQAG8gGCaSou6FRb0IUr1PqGuxcjuamJFcPiSLyUqSTAA7RK2IFJDTZeRjDNvOeZ
	 GVueaR6NrLbeMLFkqKJ2/+3eXpKiR/diWuWGLAWAIhObOBCFCOB82Pmw2hclNyYgRWXSf
	 Sc3op7tAowAL4+emGSlugGOKsKAtNA4sBitzkU1L9htJVNnJzLtudNRFmvaOtTh83NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JJjDzY6m;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463D606A325
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B463D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JJjDzY6m
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917997ab0d9so37393036d6.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793048444; x=1793653244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/QAf07cAiyxBwSWgq7Tjim9fLXjZh7SPBHX/IjDGa5I=;
        b=JJjDzY6mRQXVGyCZW/IhtD+6+MiXzySE7VeNXGvBcJhUaI0POuQrCCJKubT+O3b9i4
         vl8w/dEYzEdbNxT6jNdyJ/ZIHyaq5oEg7Te0ElW4+IL0yiClIGXoqqCAMzqVVuzTnaBP
         U/x0NMK0HbLCyBcgP+lgKsjqlVu8CTXQ4oMfDig5ld3dTkM6m9rb1Y2jX5faCwMRhBf4
         RPA/7itSlbb8W7ifHCD6V3eXoLsdYBqF1hYZdhPVS091sKzyC7WqLD6CFNGAZi/WtfSP
         G4+j8yrsiLMiJNoi6Nn80qMSZyWE/ejeIiUgsYcYk0j3T5FTtK9LAgF/0DMNNmwh1Qqk
         TTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048444; x=1793653244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QAf07cAiyxBwSWgq7Tjim9fLXjZh7SPBHX/IjDGa5I=;
        b=cXEKjca11QZRnJ4ZWi8Qc3f/N9aH2WcR43lAnwV88GXbOSDcS0PEPcthfrlo2LzpAA
         0eA17N8+YIPzhSWDoNdYKi8qxzb/ESEYDEnzZUMKrbAGd7LH0jWwQ9d1mNmymCA3dVkT
         INvQCdB0wfq7qqYwnExHLoZ4z6EGRLWW6saVlHXpOvM7ReA4Vg2deTlyMKseVPcjTsg4
         xKa79X81zSlLjDoWNl51BZbFj5xgz62vZtZ/vP+kr5pUgckqJJRJ42SH6IwhByb84MTV
         1eH0gdc9hudqFGkF5WaTIMNtkxxCi6rKLeBlk5678PlDQuwrCX74PrBh5iHVIKeb6Npn
         aYlQ==
X-Forwarded-Encrypted: i=1; AKwUvByZ6kgN43U0MtY8rj08OZBEyh3kbCVJVAC2qk0x+FUJB3Emz4UN4XVLAd6BtU5ugV95DgDcjN0cWKRRwfG+zzboaHnte7Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/a23csmF8Scfe/1UR42f6h7QiqREsLb5OEfGXpIbLGY4BOWAQ
	SRF6VFfIFoxH/Cfh63SFl2rf0oDt2hpbxEY2wh9CLUsJgILOGRZ1DvyYtGsjswcuKDo=
X-Gm-Gg: AYBFou0TE3GeQEAChgnSGTIxPj5mx73pLDqBb193SVHWQLdea+cDPMvKJeF5y0Eeeq4
	s8YQWBhDO2BS+Nj6hH5cqZtwegOlllGdf5g3owxfgseEhuReJQjkv+fjlggPM4A7qYL5Mrfoqr/
	jcdC4KBU0Vd92RIpB9QzTn0f3jrwyDQHEB6XP+9nFT5JTnLljhMmgxt9huWIZWZPawhJ0Q4vcLb
	LChgrN5BNcY5/BxVVIy1+0p4J6LHXIR4e+Wmd2RftziH5TC7uea4n65WgcdMiBeiLW9tmbYCuvG
	xZxgRjb0KtC1uZ6NOWpFQx8bfeQZdykfRV4wNGG1B0C0viAoitH2NYnMG5V7KM1VI6UnWdmlrko
	cfW987ukhkGcNYStSKPMoDA5qgrC0b/gdtqvR8tskrdwjv+U/pmAnFfNK/CdNzO7+EXTGlidT7i
	pk6kubs2IN8cmOP+/u2f9XajbTGDHa0exJbWgVbp/SAnHRSBb6FUqo81MSbsB7ES71oxef7Y712
	T5JMdW4B9jjMviBsoE7690sJKRoRdy9+anExtgtWodYILtDNZonAYqoz/ZOJFN3AbgqY/aW
X-Received: by 2002:a05:6214:5f01:b0:91b:88fe:a426 with SMTP id 6a1803df08f44-91c48bb4b31mr132064296d6.0.1793048442189;
        Mon, 26 Oct 2026 14:00:42 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c6ffc2sm83286836d6.28.2026.10.26.14.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:00:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 21:00:23 +0000
Subject: [PATCH v7 5/6] capabilities: don't let ptrace borrow CAP_SETFCAP
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-setfcap-userns-v7-5-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793048427; l=5986;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=sZPBiHwnYa3YycPMYlN3oxrwhjCY5GQuMbx5FDiasfw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGPgOJBb00zRtv8vhwEzNekur96zrvSR77PeDyvsPS1vOk4EcnC5pCGQ3C0fOl5bSJi9WIzmWOy
 5lLQ+bhf0XQE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Tasks in a user namespace created by a task with CAP_SETFCAP may map uid
0 of the parent and write file capabilities that are honoured there.
That is the one privilege they keep outside of their namespace.  setns()
no longer lets anybody in who doesn't have it, but the ptrace checks
don't know about it: for a target in another user namespace
cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over the
target's namespace, which the owner rule hands to any task with the
right euid.

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    ptrace(PTRACE_ATTACH, A)
                                      uids match, euid == ns->owner
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities
                                      A is entitled -> allowed

The same goes for /proc/<pid>/mem, process_vm_writev() and pidfd_getfd().

Require for PTRACE_MODE_ATTACH and PTRACE_TRACEME what setns() requires
to get into the target's namespace: CAP_SETFCAP of the tracer has to
reach the root users of ancestors that tasks in the namespace can write
file capabilities for, or the tracer has CAP_SYS_PTRACE over the topmost
of those ancestors, which gives control of tasks there that have
CAP_SETFCAP anyway.  As in setns(), root users stored through an
idmapped mount are not considered.  A tracer in the target's namespace
got in with as much and always passes.

Targets in the initial namespace, in namespaces created without
CAP_SETFCAP (what unprivileged users create) and in namespaces that
don't map the root user of an ancestor (the usual container) are not
affected.  What remains is a tracer that gave up CAP_SETFCAP and
CAP_SYS_PTRACE and a target in a namespace that maps the root user of
an ancestor and was created by a task that didn't give it up, which the
tracer can't setns() into either.  PTRACE_MODE_READ is unchanged.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 4e0b00b7b1a3..91ed4a5f4b25 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -254,14 +254,41 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * Tasks in a user namespace have CAP_SETFCAP that can count in ancestors of
+ * the namespace, see cap_setfcap_level().  That is a privilege outside of the
+ * namespace, so capabilities over the namespace are not enough to take
+ * control of such a task.
+ */
+static bool cap_covers_setfcap(const struct cred *cred,
+			       const struct cred *child_cred)
+{
+	struct user_namespace *ns = child_cred->user_ns, *top;
+
+	/* setns() only lets in tasks whose CAP_SETFCAP reaches as far. */
+	if (cred->user_ns == ns)
+		return true;
+
+	top = setfcap_top(ns);
+	if (!top)
+		return true;
+
+	/* CAP_SYS_PTRACE up there gives control of tasks with CAP_SETFCAP. */
+	return cred_setfcap_reaches(cred, ns->parent, top->level) ||
+	       !cap_capable(cred, top, CAP_SYS_PTRACE, CAP_OPT_NOAUDIT);
+}
+
 /**
  * cap_ptrace_access_check - Determine whether the current process may access
  *			   another
  * @child: The process to be accessed
  * @mode: The mode of attachment.
  *
- * If we are in the same or an ancestor user_ns and have all the target
- * task's capabilities, then ptrace access is allowed.
+ * For PTRACE_MODE_ATTACH, if the target task may make use of CAP_SETFCAP in
+ * an ancestor of its user_ns that our CAP_SETFCAP or CAP_SYS_PTRACE doesn't
+ * reach, then ptrace access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -282,11 +309,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 		caller_caps = &cred->cap_effective;
 	else
 		caller_caps = &cred->cap_permitted;
+	if ((mode & PTRACE_MODE_ATTACH) &&
+	    !cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();
@@ -297,8 +328,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If current may make use of CAP_SETFCAP in an ancestor of its user_ns that
+ * parent's CAP_SETFCAP or CAP_SYS_PTRACE doesn't reach, then ptrace access
+ * is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -314,11 +348,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	rcu_read_lock();
 	cred = __task_cred(parent);
 	child_cred = current_cred();
+	if (!cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();

-- 
2.55.0

