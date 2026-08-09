Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B023282F0E
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290357; cv=none; b=arop1IdfUdsvaSZt0uvciwq3DqzY6oXvKk2wvGyAXhtO5jic21lh9KYpaxWfRFTPgdhGCI7gdgVs158hCozdTXKqIWFNpLp2wudp5OlZAeFv0VnOELDm1uHV1iK+61Htv58UGi+DqXFcCVJKFVvJEsj1JGPgOZJMxmtmQroduLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290357; c=relaxed/simple;
	bh=9JZUzyBo+CbXJSkhEUaPm8GPC8AE4DGGZu0FmSVJVn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0R2CorQlB8QnpN489OGNkrXn8VrIDwFZLutHDB0KZYau5vnLD6/zrYPu2irCjUwB4go9mZQ0CNn2b0PFgBj/MWRCID5TCjhnleumEk2l54yU7xOBC1A0CwZMiKAacfUUt5fxPQkOpBCxZAHIIdxZKsGUcKGIaUe01IdSkyC5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phUZY5uZ; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phUZY5uZ"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664a09bc459so1545509d50.1
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786290355; x=1786895155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jg/kaf72XcXDaCB/gqQtAj1XATKp4pN9Sx21Fhzi3WM=;
        b=phUZY5uZta1tNJeezc/h8wAzpRncS5D3HVIpKeXo/aXlNd/dZlzzYh4G+DkIusaUST
         LmSvj5dm2mmHlZPIzvhfB6u33GcN5ncjQEY0AzyO3cMTZm1wGn/uxjeAZ77XwXv91h9h
         BFlPwsK8INroswa96TXrf8FaPRB1Bnx4S6j7tlp6KVPEqGAbpFUD/tytdDvUmSin3gvI
         rQzVsaL80TXRQS+utU3RJ/r3dQoZcP18IgI1yWkGZ7hw4XZQGP1xdzFgfgxsgfCaxxVD
         DDfioPy1TxzSGhv309ouBoWSXa/N2yxcb6HwBIJiv6eTnhUHq9s+XL99pzBkpAcxxgVb
         kJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786290355; x=1786895155;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jg/kaf72XcXDaCB/gqQtAj1XATKp4pN9Sx21Fhzi3WM=;
        b=oiy83qyjnemeudnJniISe4J5LiquxYURuh6YzDyj645iKFYAGk3yQyemgF/up4owhv
         LXwhMjD45reumFjdXpyH+Djw0uoXQFqLLXEKn3BlEsFEhXwCqXuoM8rC16xgMkrQt7va
         7+mG2oh/XY96pIFuspoEGse94rmliauukgc5if9F1NtAw97YrF2xE8u4qFx0ICsmCBUI
         WAafwcD4bd1d7kstq9mRGgjhFxa2xq9wZ6PWhE3k0LZeoj+Idjgu7RaI68vPI02qeIIl
         HoU2ro0iZ6lvNMtC+ba0kC1uWasArwXm8YHcZfaVUsTo0SIl9HPJrqrR2066Jxmi1j92
         gs8A==
X-Forwarded-Encrypted: i=1; AHgh+Rpu3f6/IgayY79bRKM95e3RXPeGPKDbNZSpCCz4pn7OdbEiICpgbww8nTBDPPgEFQUDjDokgjV/GghXng7YhYSwtYBIlVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjv5ltsYwvHAF6uvMOjF1p1622yDCAaM8ww+98bIk0bxOIXfP
	B/sVDsHfbYQti30YA6uDi2MY9AmXJSl/oI8yrVmSQc9tPdihlTdmaCc/
X-Gm-Gg: AR+sD10jMlU1d8D2opSU9ZAM634DmWdYN0sxlb1RcclP6R1KtYUokOMCsT8hvQjLOL2
	+H3IlPHg3SFBFzhyQcshYHP2gBHxDvO+fCuPqqbeKRNmSoVgad4A6vSswVRuLVp2/loNVFDFyAj
	fKiowKq/SkIC8HuxBUNCdI+0k4eD3UdzCSKAqpY50tA569v+tv4pu2eQjHesqBLm+dmME1WPA2K
	ekHNcvEUU/9o7jvKhicG3x7w+CUMYXKLpMsivWCaI6OYJIuCZbd/HaidWzI7B6U9s4W6AZ95fb7
	EDPiCwUNTg6yYFP6qqULlCIMPsNdpdlS9bjzEiiphnDtq0VgZIfW3P+IXIp6mijpGQAUJAUMrAR
	R4Zxn2SwzxEVXSA/QirH0+elVivHb3pYhjFOkSxrmu7Oxe8Di+rQlhcZoVn2sFtgGrtoZrPAaIU
	NFRkjkrep6ouvUDRFCwaIwnhYDFnmtZ3vXBDIt/06Fqc1ihOLtJqjOTEkP3R5lvPioKl+vyX+U/
	XSOo47Sc+rcI/uqszDCcGE=
X-Received: by 2002:a05:690e:4396:b0:667:b164:3e04 with SMTP id 956f58d0204a3-6699a90f267mr17116820d50.22.1786290355019;
        Sun, 09 Aug 2026 08:45:55 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbea9sm4838001d50.3.2026.08.09.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:45:54 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v4 4/5] landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Sun,  9 Aug 2026 11:45:22 -0400
Message-ID: <20260809154544.1253100-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809154544.1253100-1-utilityemal77@gmail.com>
References: <20260809154544.1253100-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document setting no_new_privs with ruleset enforcement, following the
same compatibility section style as previous ABI additions.

Include a section explaining the tradeoffs of setting no_new_privs
through any means for privileged users of Landlock.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v3->v4:
        - Reword the tutorial paragraph on CAP_SYS_ADMIN and no_new_privs to
          remove the ambiguous "it"s, per Mickaël's feedback.
        - Use the suggested "call (or ``CAP_SYS_ADMIN`` use)" wording in the
          compatibility section.

 Documentation/userspace-api/landlock.rst | 47 +++++++++++++++++++++---
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5085822d8930..782e65020b77 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: July 2026
+:Date: August 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -250,7 +250,8 @@ similar backwards compatibility check is needed for the restrict flags
 
     __u32 restrict_flags =
         LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
-        LANDLOCK_RESTRICT_SELF_TSYNC;
+        LANDLOCK_RESTRICT_SELF_TSYNC |
+        LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     switch (abi) {
     case 1 ... 6:
         /* Removes logging flags for ABI < 7 */
@@ -269,16 +270,37 @@ similar backwards compatibility check is needed for the restrict flags
          * children (and not for all threads, including parents and siblings).
          */
         restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
+        __attribute__((fallthrough));
+    case 8 ... 10:
+        /* Removes no new privs flag for ABI < 11 */
+        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     }
 
 The next step is to restrict the current thread from gaining more privileges
-(e.g. through a SUID binary).  We now have a ruleset with the first rule
-allowing read and execute access to ``/usr`` while denying all other handled
-accesses for the filesystem, and two more rules allowing DNS queries.
+(e.g. through a SUID binary).  For unprivileged processes, setting the
+no_new_privs attribute is required by Landlock.
+
+Processes with ``CAP_SYS_ADMIN`` in their namespace can enforce a ruleset
+without setting no_new_privs, but leaving no_new_privs unset is risky even
+when Landlock does not require this attribute: sandboxed processes could
+still execute set-user-ID, set-group-ID or file-capability binaries, which
+would then run with elevated privileges while being restricted by a Landlock
+domain they may not expect, making them potential confused deputies.
+no_new_privs should only be left unset if such a privilege transition is
+expected.
+
+We now have a ruleset with the first rule allowing read and execute access to
+``/usr`` while denying all other handled accesses for the filesystem, and two
+more rules allowing DNS queries.
 
 .. code-block:: c
 
-    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+    /*
+     * If the ABI > 10, we can tie setting no_new_privs with successful ruleset
+     * enforcement and skip the manual prctl(PR_SET_NO_NEW_PRIVS, ...) call.
+     */
+    if (!(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
+        prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
         perror("Failed to restrict privileges");
         close(ruleset_fd);
         return 1;
@@ -792,6 +814,19 @@ when at least one sys_landlock_add_rule() call is made for it with the
 ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
 object without this flag do not clear it.
 
+no_new_privs flag (ABI < 11)
+----------------------------
+
+Starting with the Landlock ABI version 11, sys_landlock_restrict_self()
+accepts the ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` flag, which sets the
+no_new_privs attribute of the calling thread only once the enforcement of
+the ruleset succeeded: no_new_privs is set if and only if the call
+succeeds.  This removes the need for a prior :manpage:`prctl(2)`
+``PR_SET_NO_NEW_PRIVS`` call (or ``CAP_SYS_ADMIN`` use).  When combined
+with ``LANDLOCK_RESTRICT_SELF_TSYNC``, no_new_privs is set on all threads
+of the process.  As explained in the tutorial above, leaving no_new_privs
+unset is risky even when Landlock does not require it.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.55.0

