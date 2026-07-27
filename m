Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD83B71D4
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193736; cv=none; b=GRxcBEFW85RESYKInQct4kdI4tWjQJ35twoDh5giS1xlVRjd1VMtVZsdJrHZSlUuL4xmdXtFl7lr3xEeK3L4C8JupHt440cA0QkCnwXz0mswGazd3CsPidKDO1RmxDDPElxz0n6VpJf6QfnhnUviffovUG/Sj57Ap5E2iPNCTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193736; c=relaxed/simple;
	bh=HwPp48Z3MNVZ3M0foOM3C66IxdtsPhI617LsDo+pAno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMmg/quSWnIK/jhsYHO+MtPFH0ZbF0GQy4zcTHL2ecjADLGCPfdXsm/vTljcyqAhSIW8mDrBFSz80xzEzrGHL9UXfS7hseX+mj8I1qQWGqKxJaJ+laLNWNs/SFzNptGD9cxezZJqaTUWNn1CI9iWGYtGNRF2fuTC6z4KZX7TWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iprAPVQy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iprAPVQy"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80dc4a68e4aso35638777b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193732; x=1785798532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZQ4vHPKDDGtopEbq4Ch/3WFWoQE0qcoIPLa+dg4JfM=;
        b=iprAPVQyET0mGPjYKZAgkt4mzrn9KFuAxkr4Yp/B5rJGINmayvYUWvRkb09I/G5nmr
         h+wyW3FjOFy/Pi/UWPuqqRDL7khfmlwArgk1eyfb8rwZ8Dn028qwWT+iEeejQfXmSn2m
         mTxmmb+uuPxSQCBNn2Q4hgiQMEFRZEUToE27P+ZtjpPZHQp25z4Cgyk5gQyVVxjsOYwQ
         9yP+idpPv8wh71onjBczejeABqkB7ZJClIAE5Djv+H1diLOBHAU0h0Dtuvl4j97z5ZwM
         715DeXC6dQtxpgh+cQUc6k0d49YQYhgkvii+bJPQ3bYynJbY0pCF9I12vfyOUCCwYtLB
         RtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193732; x=1785798532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nZQ4vHPKDDGtopEbq4Ch/3WFWoQE0qcoIPLa+dg4JfM=;
        b=mhNznglcJRj2vNIyTlTGf7frq+oOnxJW0NBvTG/oq/a5L7uhIy8tvo1LKpW5typ9Dd
         581PRWrTOdS8zgrQBoEPa+s8o0RnXvLzSP4vo5YAGirn6Go4i/jNglYbWCoxlQzk66kq
         bKDMQuEUkY2mcFM3jLwC0oFF0TNkIqi9oCFan5K/RthzXmz3Stq7jRu+5BI+Pef7OFG0
         EQVvrqm5soDL5TfyMlnsBVkpr7O1A48TSAUr2q1iXl65Uwb/d2BWy8AYjTiLqKxaSPbd
         Uw4kKNG9hsQq4ZJGvhzrWF1C9Mi98mmhj2j6zrp4gi0p7UPyQvhyyZG+680+gggDrsTk
         0+cw==
X-Forwarded-Encrypted: i=1; AHgh+RpExqCO4MIG1yNheU83PapyZQ2yMSH14sysi1e4ioZpBoAon1Unjlq2QGWZjkgZT7xL3QCGER7tj15RcMlKVgKOdLF+3rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgKZMFGU5Tcs+yKt36uRTDFmR8HJ+jxvIc12p+YqWCsWFOxIM
	t+i6F8ET4FBLDRlpOVxcSriq5QY2Sbm6APE66M8pmm/JsAVZauW1enMI
X-Gm-Gg: AR+sD10cVRpMD4USFGCP2lYxndy4T/7MfRyh+knbQJ/pgY34YU35Jd8BiClZBeDKhUO
	qM5fwO9Iw7dJi7MyL8mp3V4aOxa/0y/ois7KnHOPgQsLQ3xNjcu2/vSan1zMGuJ78Q1CO9wiC8L
	z6a221qWe1ZSLLnWK6uB/DvU4EZF3eLlky/99+p4r/9Bz7pH191KOU0ysjObra50Rt/5k3ZsjQ9
	Le4nQTiw57bC6Rtp6s+ZDQh9hz+vbinF7d0aKov9/0Lc1GYmRCVbgurplQQxFiVe+EJvFhzyGZ9
	q6YH4GdEP7yMzBwz6bz0VKw+3jfzc8vEGP0btyUgBjx5OYOMJczDRSC8Da6+VpJOgNzqWywkZT8
	UM2RJDSu6oPPzizYRxwls0ui69wqh5vkl87in4SwtP0bdfiTXc0RAmgWzRP+EbLgqNbSwku2/FB
	OuoeVnPKAjRIeRYWTPrB7ecEdVWkTpynmul2J9
X-Received: by 2002:a05:690c:d07:b0:80d:fc34:a79e with SMTP id 00721157ae682-81f69e3c8a7mr36003697b3.35.1785193731889;
        Mon, 27 Jul 2026 16:08:51 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:732e:7f3e:f365:cf9a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65931411sm38644837b3.44.2026.07.27.16.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:08:51 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 6/6] landlock: Document LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Date: Mon, 27 Jul 2026 19:08:33 -0400
Message-ID: <20260727230833.138165-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727230833.138165-1-utilityemal77@gmail.com>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new SysV message queue scope restriction.  Make clear
that because these queues do not use persistent handles, subsequent
operations on a queue already obtained via msgget (or any other
means) may be restricted once this right is enforced.  Also note
that denials surface as -EACCES rather than -EPERM, since the
generic SysV IPC permission path maps every LSM denial to -EACCES.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/admin-guide/LSM/landlock.rst |  1 +
 Documentation/userspace-api/landlock.rst   | 30 +++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 8eb85c9381ff..ce5f9653b69a 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -63,6 +63,7 @@ AUDIT_LANDLOCK_ACCESS
     **scope.*** - IPC scoping restrictions (ABI 6+):
         - scope.abstract_unix_socket - Abstract UNIX socket connection denied
         - scope.signal - Signal sending denied
+        - scope.sysv_msg_queue - SysV message queue operation denied (ABI 11+)
 
     Multiple blockers can appear in a single event (comma-separated) when
     multiple access rights are missing. For example, creating a regular file
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5a63d4476c1c..7c5453747457 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -86,7 +86,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-            LANDLOCK_SCOPE_SIGNAL,
+            LANDLOCK_SCOPE_SIGNAL |
+            LANDLOCK_SCOPE_SYSV_MSG_QUEUE,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -140,6 +141,10 @@ version, and only use the available subset of access rights:
         ruleset_attr.handled_access_net &=
             ~(LANDLOCK_ACCESS_NET_BIND_UDP |
               LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+        __attribute__((fallthrough));
+    case 10:
+        /* Removes LANDLOCK_SCOPE_SYSV_MSG_QUEUE for ABI < 11 */
+        ruleset_attr.scoped &= ~LANDLOCK_SCOPE_SYSV_MSG_QUEUE;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -420,6 +425,22 @@ The operations which can be scoped are:
     A :manpage:`sendto(2)` on a socket which was previously connected will not
     be restricted.  This works for both datagram and stream sockets.
 
+``LANDLOCK_SCOPE_SYSV_MSG_QUEUE``
+    This limits the set of System V message queues to which we can perform
+    :manpage:`msgget(2)`, :manpage:`msgrcv(2)`, :manpage:`msgsnd(2)`, and
+    :manpage:`msgctl(2)` calls to only message queues which were created by a
+    process in the same or a nested Landlock domain.
+
+    Since System V message queues are IPC namespace global constructs and do
+    not use file descriptors, enforcement of a ruleset with this scoping may
+    cause subsequent operations on an msqid that were allowed prior to
+    enforcement to be denied.
+
+    Denials are reported as ``EACCES``.  Unlike other Landlock scopes,
+    the check runs in the generic SysV IPC permission path (the kernel's
+    ``ipcperms()`` helper), whose callers map every denial to ``EACCES``
+    before it reaches user space.
+
 IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
 If an operation is scoped within a domain, no rules can be added to allow access
 to resources or processes outside of the scope.
@@ -789,6 +810,13 @@ when at least one sys_landlock_add_rule() call is made for it with the
 ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
 object without this flag do not clear it.
 
+System V message queue (ABI < 11)
+---------------------------------
+
+Starting with the Landlock ABI version 11, it is possible to restrict
+operations on System V message queues by setting
+``LANDLOCK_SCOPE_SYSV_MSG_QUEUE`` to the ``scoped`` ruleset attribute.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.54.0

