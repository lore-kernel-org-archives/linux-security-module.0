Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F085C636D4
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Feb 2023 13:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjBONTR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Feb 2023 08:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjBONTL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Feb 2023 08:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4781204A
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 05:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676467091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GNRAJRBJk78AMaY6LlG/1w5pM2z+pgxQDuRTg4kTHH0=;
        b=bH60ijlw8fvaiC0q13PU6JsI7skuGxep8wz3BevrriabXqPvayrirRvo8M6nz/JxHzzkAf
        Hw7d7Njy3wJe+kwKGxsrIsaA4kcIOETbjEUiVfneL5qADyZrfnOrq4qy/75SM2pvW/wwyR
        LmjzdG6fECuVBAVxcWeCnZziqKQG6r0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-PkKXXcc2OICRJgvrf9OqXg-1; Wed, 15 Feb 2023 08:18:10 -0500
X-MC-Unique: PkKXXcc2OICRJgvrf9OqXg-1
Received: by mail-ej1-f71.google.com with SMTP id fy3-20020a1709069f0300b008a69400909fso12186159ejc.7
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 05:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNRAJRBJk78AMaY6LlG/1w5pM2z+pgxQDuRTg4kTHH0=;
        b=YK2C5t99wexfpvduLhAlK3za426R0OdiwAE5ShJCnA/0tErAatm/fukxyCjT1NOjW4
         +Q5m0LODO2ahLCJ6i3V2+6t+D232Q+SWoW8fUICp9xIYXTvrzLOo/BESvGMoxQ1N9uep
         S1A4kWOFw6LeVVgOftjsuz1dCkxnXBaXV9VGsSQXCoc13/qjwtrLXb+Ge62QyuEY/IoS
         L9dY2OYwzkA7v+RDGpKn99fZLdbG6l4n8mEJhF/93dOF7MV/RXc3tqizL1MPD2bK6dO1
         opSVix94Opxr7bH5foIrbe6EEfQato35o9qlhuQ6moNUdrfLk3vkelF1EgzoB4+peJeM
         4fvA==
X-Gm-Message-State: AO0yUKVHzb2r959kqumJJTiaFrIXkVshsvRih9M6hM20xfX9i3BIzjA/
        skpAdAxuyoEN7fTgS87Kis6nbjS1TUFWAOVEFcUcxzeB/XB2/WCJYsrw5gzc3hAfDHWxsK97ks2
        l8rAMRSqqpQN5N509Wc2czK+UOf+1uCXEoeg1
X-Received: by 2002:a17:906:8306:b0:8b1:1f2d:ecf1 with SMTP id j6-20020a170906830600b008b11f2decf1mr2014792ejx.67.1676467089433;
        Wed, 15 Feb 2023 05:18:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8KlViSY3Z6xGJ6y8G+OxoXecpesAwBikFFZKOpNWQbGo6ZdFQcN2Po50SGN4gTW6bGcum1DA==
X-Received: by 2002:a17:906:8306:b0:8b1:1f2d:ecf1 with SMTP id j6-20020a170906830600b008b11f2decf1mr2014779ejx.67.1676467089220;
        Wed, 15 Feb 2023 05:18:09 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w8-20020a50c448000000b0049668426aa6sm9438241edf.24.2023.02.15.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 05:18:08 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
Date:   Wed, 15 Feb 2023 14:18:07 +0100
Message-Id: <20230215131807.293556-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

1. First determine if CAP_SET[UG]ID is required and only then call
   ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
2. Do the capability check before prepare_creds() as an optimization.
3. Check for a no-op early as an optimization.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/sys.c | 69 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e8867..6fd88686cd06f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -664,6 +664,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	struct cred *new;
 	int retval;
 	kuid_t kruid, keuid, ksuid;
+	bool ruid_new, euid_new, suid_new;
 
 	kruid = make_kuid(ns, ruid);
 	keuid = make_kuid(ns, euid);
@@ -678,25 +679,29 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	if ((suid != (uid_t) -1) && !uid_valid(ksuid))
 		return -EINVAL;
 
+	old = current_cred();
+
+	/* check for no-op */
+	if ((ruid == (uid_t) -1 || uid_eq(kruid, old->uid)) &&
+	    (euid == (uid_t) -1 || (uid_eq(keuid, old->euid) &&
+				    uid_eq(keuid, old->fsuid))) &&
+	    (suid == (uid_t) -1 || uid_eq(ksuid, old->suid)))
+		return 0;
+
+	ruid_new = ruid != (uid_t) -1        && !uid_eq(kruid, old->uid) &&
+		   !uid_eq(kruid, old->euid) && !uid_eq(kruid, old->suid);
+	euid_new = euid != (uid_t) -1        && !uid_eq(keuid, old->uid) &&
+		   !uid_eq(keuid, old->euid) && !uid_eq(keuid, old->suid);
+	suid_new = suid != (uid_t) -1        && !uid_eq(ksuid, old->uid) &&
+		   !uid_eq(ksuid, old->euid) && !uid_eq(ksuid, old->suid);
+	if ((ruid_new || euid_new || suid_new) &&
+	    !ns_capable_setid(old->user_ns, CAP_SETUID))
+		return -EPERM;
+
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
 
-	old = current_cred();
-
-	retval = -EPERM;
-	if (!ns_capable_setid(old->user_ns, CAP_SETUID)) {
-		if (ruid != (uid_t) -1        && !uid_eq(kruid, old->uid) &&
-		    !uid_eq(kruid, old->euid) && !uid_eq(kruid, old->suid))
-			goto error;
-		if (euid != (uid_t) -1        && !uid_eq(keuid, old->uid) &&
-		    !uid_eq(keuid, old->euid) && !uid_eq(keuid, old->suid))
-			goto error;
-		if (suid != (uid_t) -1        && !uid_eq(ksuid, old->uid) &&
-		    !uid_eq(ksuid, old->euid) && !uid_eq(ksuid, old->suid))
-			goto error;
-	}
-
 	if (ruid != (uid_t) -1) {
 		new->uid = kruid;
 		if (!uid_eq(kruid, old->uid)) {
@@ -761,6 +766,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	struct cred *new;
 	int retval;
 	kgid_t krgid, kegid, ksgid;
+	bool rgid_new, egid_new, sgid_new;
 
 	krgid = make_kgid(ns, rgid);
 	kegid = make_kgid(ns, egid);
@@ -773,23 +779,28 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	if ((sgid != (gid_t) -1) && !gid_valid(ksgid))
 		return -EINVAL;
 
+	old = current_cred();
+
+	/* check for no-op */
+	if ((rgid == (gid_t) -1 || gid_eq(krgid, old->gid)) &&
+	    (egid == (gid_t) -1 || (gid_eq(kegid, old->egid) &&
+				    gid_eq(kegid, old->fsgid))) &&
+	    (sgid == (gid_t) -1 || gid_eq(ksgid, old->sgid)))
+		return 0;
+
+	rgid_new = rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
+		   !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid);
+	egid_new = egid != (gid_t) -1        && !gid_eq(kegid, old->gid) &&
+		   !gid_eq(kegid, old->egid) && !gid_eq(kegid, old->sgid);
+	sgid_new = sgid != (gid_t) -1        && !gid_eq(ksgid, old->gid) &&
+		   !gid_eq(ksgid, old->egid) && !gid_eq(ksgid, old->sgid);
+	if ((rgid_new || egid_new || sgid_new) &&
+	    !ns_capable_setid(old->user_ns, CAP_SETGID))
+		return -EPERM;
+
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
-	old = current_cred();
-
-	retval = -EPERM;
-	if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
-		if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
-		    !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
-			goto error;
-		if (egid != (gid_t) -1        && !gid_eq(kegid, old->gid) &&
-		    !gid_eq(kegid, old->egid) && !gid_eq(kegid, old->sgid))
-			goto error;
-		if (sgid != (gid_t) -1        && !gid_eq(ksgid, old->gid) &&
-		    !gid_eq(ksgid, old->egid) && !gid_eq(ksgid, old->sgid))
-			goto error;
-	}
 
 	if (rgid != (gid_t) -1)
 		new->gid = krgid;
-- 
2.39.1

