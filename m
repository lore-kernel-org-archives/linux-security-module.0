Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5B314D3C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254395; cv=none; b=PGWXyDSrAO6S9um2aCRY1tPumv8f+Cd/3RE9N+DEINS1jx364Kz1qsQs4zlSDTulEzhC4wPUTYgYTBr0QIzoFkJLcDv2L7Ex4MgDkYK3l9hwjwkpHeUFpqxeDlfadrFEC9pv9QDrB2KHdOaoSoyD1CAMPdQ+YgKM7eGT99fOTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254395; c=relaxed/simple;
	bh=ku1dmf4toeaGtX7VBobBNgDz1QSiC/bGi9Lw8fcbevM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=slf4oWnxlSlxC0uOhH9d7bzjIb7DuO/DuBK+FU/w/ur5RxfOBGXVHIEZVFPKnD839vdlLwKB45JSnrK1Xi6rWJCvr9HAfGOo/Bh9Igs49VGM9+WOmusfa1jDm2duZB121tpt6JPI5NzU2UX0BrJsyKcYhAi3dMjtlqqoEyTNDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3xfHUsC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3xfHUsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
	b=U3xfHUsCJW4+aVsi9JNtU7HOKR28m4ASuitzPvhalbhU6aQJHyk2j7HUui+bmGlDJCVWJN
	510Mrhd9GbQAZOhg+D7OVhjkDtHDY2fv3kLm+1PKeO+2qDsEqgKNUQmntkF4Hv9w6PNxn1
	mpXuJR03J/UUv8IKFB2D8JO19K40lrk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-z8w2kuMlOEOxGJSwpdjqYA-1; Mon, 16 Feb 2026 10:06:31 -0500
X-MC-Unique: z8w2kuMlOEOxGJSwpdjqYA-1
X-Mimecast-MFC-AGG-ID: z8w2kuMlOEOxGJSwpdjqYA_1771254390
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43624564fc9so3336529f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 07:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254390; x=1771859190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHwTYo0eyOVUxW79e4wmbJ3vj33NqFZ0GmFxn5mLB1o=;
        b=EO6VkF9119UyIGqyekGsMcnASuRV0l9nuF5kQwc5UAIsL5qXT4LFmFKTdJLKlgZpD/
         d7YxI+MMPuo34Sd1UCaZgkw06Hjm5q38t/Iz56jDKh4VeOTigYCueGobXNlfErLji0SM
         LQkjPni59lx7rpWrGeARdv12WOXqe3vdRx7sXD2ZoqgTu0RxWdjZNvtZcJpUz8yGDgcx
         XCQFN6fwobr/GR2XSeyxo/TqK0+PHH1+jkiRaG5OBQdP0u5cf2OuJyUEd0WsIZ4ti57A
         0NFCULKdhJ9FRArmA/hXSxYU3jeYWzi9Bws3PoTCAILTsO/3dVX6ScL8i56kfgjeAuRZ
         UYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUd6Uj4Wj8sKnNqJ5DEDUrAJJ8dQB+I0hdolRxHAbBwwHREK+n+cCswiHA/G4JlNOMdTv1ZQw4YNphb8agYzxVrPnuKyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2ppbCo+yTSXCpJQ5rSfBrgwr+NUrlH8fH0PgBFM497T/7mq+
	sZGUFEL+63xPh4WZcnGZCwWmMD0n59uBlKupSqTSmHAsCKSl2RXzH5rB3+7ekAM9bUHnNx/4eyq
	+Hn9Xj88K4iHzECaPslHLiMNvC3tDGpUOybRLXRTjjASn/RYKDLsDsZZ00ZVb2IcjFgDOxtTX1P
	b8Cg==
X-Gm-Gg: AZuq6aI6JPN5pdOsnVXvZnXipa6dieYmsnMpuR5oNvwSoU6OfJVwN8txp7m8+xdbBC2
	YS82DMmRHLiNNMgQyL2B3JtaIss/CU5xgalET7qFeO9lobEe/TewrLN9GagKBJwProOM8Eye0jR
	ddpNXpiRKiRVTLp6zYgmPCBXYRaN+YOYZlavhi3q+JMS3pvr5lT5b3ypewTY9AyFAQY6rQjPFO0
	eormvlKtijhYauTTl4GXzvfKbXxaz9DG42Bj1Vtmrj7VBL8CmKJZ9ujy/0vOQ2pqGdef3BKP7II
	7/9KD64M1Rke7oD9yR/cJeNcUlcwfda9VQ0w8T15asqm+HRkuO4oLIO6hFo8lbaJbv/0rQACwsW
	jbsXjzf0NV4nA10uuYjukM6bCpe58u5bJ3vO8K9E/16XlNzHp
X-Received: by 2002:a05:6000:2906:b0:431:369:e7b with SMTP id ffacd0b85a97d-4379db61b66mr14358253f8f.18.1771254390356;
        Mon, 16 Feb 2026 07:06:30 -0800 (PST)
X-Received: by 2002:a05:6000:2906:b0:431:369:e7b with SMTP id ffacd0b85a97d-4379db61b66mr14358189f8f.18.1771254389851;
        Mon, 16 Feb 2026 07:06:29 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:29 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
Date: Mon, 16 Feb 2026 16:06:24 +0100
Message-ID: <20260216150625.793013-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216150625.793013-1-omosnace@redhat.com>
References: <20260216150625.793013-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _tON1rxSu0qrYpl023Qgq9i1Wss5aaD2ON8xUSlWbuw_1771254390
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Make sure calling capable()/ns_capable() actually leads to access denied
when false is returned, because these functions emit an audit record
when a Linux Security Module denies the capability, which makes it
difficult to avoid allowing/silencing unnecessary permissions in
security policies (namely with SELinux).

Where the return value just used to set a flag, use the non-auditing
ns_capable_noaudit() instead.

Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d0b9b984002fe..9c9fca2976d2b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1615,17 +1615,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		/*
-		 * An unprivileged user can setup an fanotify group with
-		 * limited functionality - an unprivileged group is limited to
-		 * notification events with file handles or mount ids and it
-		 * cannot use unlimited queue/marks.
-		 */
-		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
-		    !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
-			return -EPERM;
+	/*
+	 * An unprivileged user can setup an fanotify group with
+	 * limited functionality - an unprivileged group is limited to
+	 * notification events with file handles or mount ids and it
+	 * cannot use unlimited queue/marks.
+	 */
+	if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
+	     !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
 
+	if (!ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 		/*
 		 * Setting the internal flag FANOTIFY_UNPRIV on the group
 		 * prevents setting mount/filesystem marks on this group and
@@ -1990,8 +1991,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * A user is allowed to setup sb/mount/mntns marks only if it is
 	 * capable in the user ns where the group was created.
 	 */
-	if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
-	    mark_type != FAN_MARK_INODE)
+	if (mark_type != FAN_MARK_INODE &&
+	    !ns_capable(group->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/*
-- 
2.53.0

