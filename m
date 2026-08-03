Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45073515D5
	for <linux-security-module@vger.kernel.org>; Mon,  3 Aug 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796281; cv=none; b=j11s9fA+oI6EiKwtWznKSUCCNwuPAZrlZ2FnhNMwvS4+7s5CfDNo2AoGfrMUlJHDPeA8j6G5RBK/Crjq6fyENUbtwCBeeup0ZwCYl0NF1YzTiG3kr7I8oefY8xJ1LVGOleP/axIzlcM0NNgV/UMcobL8Xf+UGp8xjdL5IFK+o78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796281; c=relaxed/simple;
	bh=KhNmQPKvwOQ+mniwSSLAoC9sjghgdGDHBXnf9xXMVX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKGXtkpHuuOA1SmjYai+X8VRzJSEVDlCwNPVCfzYOz9NoC+Bmh9UxvQ2tKfh2WLvAZUk1pVYLLpi9FQUn3B8uM3imgku22T5tB6NhOlp/xmE2BeWGq0dkj9970crktZoi1VWQT84CI75HpppbZ6Ikz2Z58vr5LxMIA7REBGrdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB3oDy0Q; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB3oDy0Q"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664db84f074so5677810d50.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2026 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796279; x=1786401079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5s0xFKMZYCXt2wJGBakETq4pnBg/XsA2VPADzOv0sc=;
        b=PB3oDy0QD988WiidHp9mL8hfvIqXe0bNmwrEGjcX9LjZcnypQzM2wSiBT/XxSBC8OK
         2fAEnRAsjS9ddBFIf2MvuixQ9dNZ4iMF+WBCSGkktSIwuzupLy4ohH/CN3lfA3RwK+Cn
         u3Ofmoaonix7+RZkvEHFG/YU02C6LBBDXQqKp5TuCEBG4cpU/lKfHXg9kQ9rQhxeW/PB
         DRf4BLyTY803Hlcr5Veu6rc9eqOibMLIGHl8/UdwhXdkY0GrABPoqyuDrBIO+0zFLWoD
         z53Wy4n/uBQxGNbBECVmK2zeizenPOhKWdPZ8oO6C2mYnUDUGugQDT6pTU8+1vxhpQSj
         s5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796279; x=1786401079;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5s0xFKMZYCXt2wJGBakETq4pnBg/XsA2VPADzOv0sc=;
        b=W05cPn6j2vqPzfLakDEY4yQLzvYLmB9eTWkHz2Uqu2ZgjpD6yAorocXSyRxg46W08m
         jRYTO0S7CmzBpWNtOfiCrAvaslRV4RMoMGg+PAZ6E79vBHxsAxDcyfje8AvDTjLV/ySx
         80ogC0RD71POTMbOUms4tt2bRiljYIuEdlfTQZL5W1sWOmpR6T7rS3Hn5sw0m+3acG5R
         TphH0gTiRYG2gRaqGAWO11yMwGUVlq78pynyaN0nrL2YGB8mmZWiVLLB/eT+6O2snPhg
         tDNuWSFs+dSJEznhWMDKccE9GxMCSEHGkVzpksC/Vu+vX0FjruLUqza/AE5B30jTDPie
         tiMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoxrOPTrG0XJ5pq/S/+wyPlRm7Z8OA4PR3NjxErXVv3PGYrQiDtqFAQRpyah8Hv2jZ4rDxWTRwsZas9pCSNJA+LG9LOG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZAifj9bq98MjSlr1gWaDIZ8CBHzH6fhQ8rCYAld4Vv5lwOYj
	weGVZrwRrbCAgUK7ZJC7SHe+4SnoXsWFT4RX8n6/+v7SKDYWcoTNHTFF
X-Gm-Gg: AR+sD11ieIe4qxV5EsYGPrXYcXAgsKGOf2KIRxMNeNkpeHSmHbsaw4xnSDLIASXPPMd
	rHAO0uLs2DVZYLep85H6+gb/O8Dr+Cv7Tyz3VnvsbYA/mZA4kicN68b+skKiy7RbtQNtQvqC7BB
	s+gRAUEmWe1EE+9GOZHv/A5V6d3PkA2rf6B3rV2h3qSDTnFM5YC+Mdg57JC9WxdhiTNuMOIo8F/
	1OL+LBVoDotJvpk4FprQtojCoEPZopIdZf++j6h7Cy27qrw5ud2pnZ2UzqGDjeNjpvnPbvNlZOJ
	cDTHy4XunT6fcntO6M3LDS+hNEoLi+xHfekhpEMHFWuylCgAZFiLfVeCFSQj5BIKN5FgyXUFn7N
	OPfHqqa512BpBGJ+t85YlsnBWiJnB5IwD7HOULT8cPW6cCh2hvKuiS/7ktDYh3oWq5+idueN/RA
	d2/rGh3io+eI2sivA3UQGsWr/839ZOohuccjBPtK73agdGSZ1FheZK2o94m6T1o+HP6frI+msMI
	20IB9/9bB1KA0vdEZwFkK0=
X-Received: by 2002:a53:b4c9:0:b0:669:483e:c36a with SMTP id 956f58d0204a3-6694f17092amr10482172d50.34.1785796278794;
        Mon, 03 Aug 2026 15:31:18 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6253:b407:801c:a745])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6694903782fsm6420774d50.21.2026.08.03.15.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:31:18 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 3/4] landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Mon,  3 Aug 2026 18:31:07 -0400
Message-ID: <20260803223109.707353-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803223109.707353-1-utilityemal77@gmail.com>
References: <20260803223109.707353-1-utilityemal77@gmail.com>
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
    v2->v3:
    - Update the tutorial: restrict_flags per ABI version and prctl call
      skipped when LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS is used
    - Drop "Atomic" from the section title; describe the ordering instead
    - Explain that not setting no_new_privs is risky even when not required
    - Fix ABI 8/9 switch coverage (case 8 ... 10) and indentation

 Documentation/userspace-api/landlock.rst | 47 +++++++++++++++++++++---
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5085822d8930..0e4a73fd5ea4 100644
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
@@ -269,16 +270,36 @@ similar backwards compatibility check is needed for the restrict flags
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
+without it, but not setting no_new_privs is risky even when it is not
+required: sandboxed processes could still execute set-user-ID, set-group-ID
+or file-capability binaries, which would then run with elevated privileges
+while being restricted by a Landlock domain they may not expect, making them
+potential confused deputies.  Setting no_new_privs should only be avoided if
+such a privilege transition is expected.
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
@@ -792,6 +813,20 @@ when at least one sys_landlock_add_rule() call is made for it with the
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
+``PR_SET_NO_NEW_PRIVS`` call, and with it the ``CAP_SYS_ADMIN``
+requirement.  When combined with ``LANDLOCK_RESTRICT_SELF_TSYNC``,
+no_new_privs is set on all threads of the process.  As explained in the
+tutorial above, not setting no_new_privs is risky even when it is not
+required.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.54.0

