Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084975;
	b=RXg88JmR88yIqlcXIHqUbl8KgAklwHG/tYXLSuorgi63FZsCyVKNr4XJ740wkGth/tjc
	 V5b+noA+wYJxGehvwPEZhYyUNRrCPSoDYvbn4HfL7pU1H2lgrc/tCrhGQBhGXAJs6qN2P
	 iD3zbBeX8FXcGQuHb9j3qmXJoiob42vtMcCmyKAfoDyWCBTbptsYZZOth/q6Db9Kw0dT7
	 QvKOk0BRiyDQQrzoEmInHzSSDFYov3M0e5gbWf6Ux8NewDiD2+x2hKx/FCv/feuXf4nEY
	 a8WKfUbw0X1hyIbLUYNv1QZ2jolAff/1yTlSSg9AyyXQEINOZGfWxVk8vBBp3l/tIrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=K0VpW7YvMhl0iK0xeqDJ+A8D6OVh/Im/AWHWGl8sSUs=;
	b=gcPU9NReeT61CI9kX4A1ON6+ww66u/u/zqZ3KxGEjR1cG0ymf7AQQy2alMkHy0F2Br14
	 HoBNcuXZETTFmSkRKN4FkBSOWXuaD0FDuqSeHHvLnP8gNb8qTe/TeE7CUWDHLQJisDF6v
	 jPuENhVpuD/0VLBWL+F2oJMZxHW9ej/hdm9mGn2b7ZKbhM3KRJdsAWgXyxi+KptuXC5oD
	 ovFRLjnao2df3PDSHaACi1/gzS7CEBGv+nbfCtCnb2Ka+N4SnUxny/0vmDBGGxKd2LKGE
	 +q/xvv/4FRwKnLZ9Pes1477vrbOARKoQ1jaIa87rAzwYfe6UL9IN+jIsc1hHDbZv4Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dYYJaJLY;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9260A2600
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 10:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD9260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dYYJaJLY
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b6f881bcc4so2705536a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795084972; x=1795689772; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0VpW7YvMhl0iK0xeqDJ+A8D6OVh/Im/AWHWGl8sSUs=;
        b=dYYJaJLYMnEy4RHfL1CMb2r8JwhR8Fj05tJ5NNGuIVCdKhXdZJxcZh0i9PI4QL5XN2
         pX2zoZMJBYFwTVHH92MwlpzaaH/gNBWrCtjMftVfCzEBCAdXVhVZx27dt2YfyaoiaPls
         +rc55ASA21ddeIQf6fCsdB+Gc89M0UK079O4SVd+CyEqaQtcdDRgshmU9sW1Xo6rC/4N
         JSF8BcFF/A9NCp8sA1fZyVWzRkXRFobcHIJTYRvZS3FOXKdhNiOQFfe3pVHVPjpfYalT
         M9uL8yqgrgumxmIEE+ZtZfMMd9pGyIQzxQ52pEwVY4asW/QsZI16y9dGpYiHSaXJhMI8
         6SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084972; x=1795689772;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0VpW7YvMhl0iK0xeqDJ+A8D6OVh/Im/AWHWGl8sSUs=;
        b=Vn4kVEfS4WXpPxbJnZzbeEScRQE3doC9ufy0H6jlStVrfPxl796d7OxBegJSPtYk1Y
         bG4ZsnesgPiWhVVRILCXrMpX1iOFJGKYVU2TTrPLMoDTRVgFAQhIjhK4uGLlrJrE4RI4
         +eaJQlCawR5yAtvWPdUOqEGHvq9B7YoJC64nRRDqx6cP8uz6wZnP7tfbA9vCTCdkJvU+
         2AzM4x52PsfMjRxIFGkpMfQW+P/uxJ7klxPAHtsFy/m/QTPJ4iloPcxlUUl/Sb+Ri4yU
         R/ziGLLiDFdsK+EKKuyaMSlm5zIHwTYm6WGxYFg5uvtyccG0OlDO0zqOY8gxls/FAPBI
         JMrg==
X-Forwarded-Encrypted: i=1; AL+hErHinc8+use5jIS1/MYXYWUWyrW9p/bdyfrjE8F8s6uOmXIzRDm1aSpfOfRnGojBgj0/yJ0tiu2YmlM+PXXCUnOPPmsk48U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/F2c8xxv1nyAY8RfGaJ0dAb3npO/6TPG5OBE76a98EGxBvNgO8
	y3TYoTL0M2UVGuwgt7m7G0yE9q3yPgY+4HAUsgqflqG7qjyPmoc5N+1RxmS59rxj4j0Wl1skBw=
	=
X-Received: from edev9-n1.prod.google.com ([2002:a05:6402:a2c9:10b0:6b7:77b0:4135])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:d411:0:b0:6b8:ac39:bb96
 with SMTP id 4fb4d7f45d1cf-6b8ac39c472mr2401311a12.12.1795084971484; Thu, 19
 Nov 2026 02:42:51 -0800 (PST)
Date: Thu, 19 Nov 2026 10:42:06 +0000
In-Reply-To: <20261119104208.782900-1-halg@google.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119104208.782900-1-halg@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119104208.782900-3-halg@google.com>
Subject: [PATCH v2 2/4] capability: bound ptrace and cred subset checks by
 userns ceilings
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Hallgrimur H. Gunnarsson" <halg@google.com>
Content-Type: text/plain; charset="UTF-8"

Same-namespace ptrace checks only compare cap_permitted (or
cap_effective), ignoring the userns capability ceiling. As a result, a
task with a lowered ceiling could trace a less-restricted same-UID task
in the same user namespace and use it to create a wider child user
namespace.

Require the tracee's cred_userns_bset() to be a subset of the tracer's
in the same-namespace check in cap_ptrace_access_check() and
cap_ptrace_traceme(). Cross-namespace implicit CAP_SYS_PTRACE via user
namespace ownership is already bounded by cap_capable_helper(), while
tracers holding explicit CAP_SYS_PTRACE retain access.

Also update cred_cap_issubset() so commit_creds() resets mm->dumpable
and pdeath_signal whenever a credential transition widens the effective
userns capability ceiling.

Suggested-by: Christian Brauner <brauner@kernel.org>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>
---
 kernel/cred.c        | 13 +++++++++----
 security/commoncap.c | 12 ++++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index d01df40a9a38..968122cdbf07 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -335,17 +335,22 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
 	 * the capabilities of subset are a subset of set.
 	 */
 	if (set_ns == subset_ns)
-		return cap_issubset(subset->cap_permitted, set->cap_permitted);
+		return cap_issubset(subset->cap_permitted,
+				    set->cap_permitted) &&
+			cap_issubset(cred_userns_bset(subset),
+				     cred_userns_bset(set));
 
 	/* The credentials are in a different user namespaces
 	 * therefore one is a subset of the other only if a set is an
 	 * ancestor of subset and set->euid is owner of subset or one
-	 * of subsets ancestors.
+	 * of subsets ancestors, and set's userns capability ceiling
+	 * covers subset's capabilities.
 	 */
 	for (;subset_ns != &init_user_ns; subset_ns = subset_ns->parent) {
-		if ((set_ns == subset_ns->parent)  &&
+		if (set_ns == subset_ns->parent &&
 		    uid_eq(subset_ns->owner, set->euid))
-			return true;
+			return cap_issubset(subset_ns->cap_bset,
+					    cred_userns_bset(set));
 	}
 
 	return false;
diff --git a/security/commoncap.c b/security/commoncap.c
index ddac8e917680..786f99eb6838 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -157,7 +157,8 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
  * @mode: The mode of attachment.
  *
  * If we are in the same or an ancestor user_ns and have all the target
- * task's capabilities, then ptrace access is allowed.
+ * task's capabilities (including its userns capability ceiling), then
+ * ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -179,7 +180,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 	else
 		caller_caps = &cred->cap_permitted;
 	if (cred->user_ns == child_cred->user_ns &&
-	    cap_issubset(child_cred->cap_permitted, *caller_caps))
+	    cap_issubset(child_cred->cap_permitted, *caller_caps) &&
+	    cap_issubset(cred_userns_bset(child_cred), cred_userns_bset(cred)))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
@@ -194,7 +196,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * @parent: The task proposed to be the tracer
  *
  * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * capabilities (including its userns capability ceiling), then ptrace
+ * access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -211,7 +214,8 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	cred = __task_cred(parent);
 	child_cred = current_cred();
 	if (cred->user_ns == child_cred->user_ns &&
-	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
+	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted) &&
+	    cap_issubset(cred_userns_bset(child_cred), cred_userns_bset(cred)))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
-- 
2.56.1.708.g77570a6a1d-goog

