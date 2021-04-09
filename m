Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58077C43470
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5136100A
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhDILNX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233899AbhDILNR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Apr 2021 07:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9DLwVwuEa/TUYn9CBVZYDMdn9III6hdDzVPKN/l5PE=;
        b=TNbu4hSgwSHyroeNGFXCAN0DgVkj5cj/YhmaRSzMSds4QH+CbNWghCdpfuRua5DBVe/7IU
        wAzbXhDckHUX9Vx9KGhyk38togowdDdVVuH7f8aoDFgXYSXqBiaJw6JpWHXMqzcXB5UKvb
        xk4E5orWNlSRzulWrGL6hWwXkd/6GY8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-2TA2j7daNc291PvZ0muIaQ-1; Fri, 09 Apr 2021 07:13:03 -0400
X-MC-Unique: 2TA2j7daNc291PvZ0muIaQ-1
Received: by mail-ed1-f69.google.com with SMTP id bo11so2471969edb.21
        for <linux-security-module@vger.kernel.org>; Fri, 09 Apr 2021 04:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9DLwVwuEa/TUYn9CBVZYDMdn9III6hdDzVPKN/l5PE=;
        b=Ap2/gyBzHKLfwPcOhFI0h7/H/nyTWlxDsdYZSmvjtvFvHOJ2YcjlvYOweO3niO89gX
         7sLozWxtW7dBPMwRLhT9Ij/3/5iSI8YggiLb34lkslHxbDrHbNKk2s4L4YHx0OT9UUZp
         FKFL8riFvFzDSAY8bhmZErQLRTV75Jh13C/9Kk3PRLrXuRfTSJ5BmT3tCVSPQWZ79EGp
         QIpLbYIUClvCvIKLdjEETKv1qvSfZ5Q7Gef2e2u4SlM82qD8fBw4OO49mEUZ1/KtCtya
         n+T3fd+b+G64x7wpJ9BAYKuw2v71uWn6A0IFdA52s+zpQtZ0x9yLJZTyolQW45FRt7/G
         UBAg==
X-Gm-Message-State: AOAM5321wNTpl99+PqGsxUn0na9MuHWjhBmS/SjlEzvC/xIEJjOTFB4F
        xfrPB3mNczsa574MkUktYIiLLD600vbbtzqgmTk+rtZKNSiuUITEGF3Fwby0BHdBX7CfNXY8FPE
        Bk+uTQr6QUR4dw3UyxJkfjGWXIvoI1lBwSdILL/aEjYw2jCJ6XDYA+N036q/6wIAWw3UkTUpCUq
        Rzbz+IvOwVIhwE
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr6751977ejb.42.1617966781403;
        Fri, 09 Apr 2021 04:13:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN01aC0ArployKcFNzWC+455t509jtFprEos2SXUsaUxRWFCvmE9PBB5j0Mfpph1bCkHvNIw==
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr6751940ejb.42.1617966781061;
        Fri, 09 Apr 2021 04:13:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id w18sm1046854ejq.58.2021.04.09.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:13:00 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
Date:   Fri,  9 Apr 2021 13:12:54 +0200
Message-Id: <20210409111254.271800-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409111254.271800-1-omosnace@redhat.com>
References: <20210409111254.271800-1-omosnace@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When mounting an NFS export that is a mountpoint on the host, doing the
same mount a second time leads to a security_sb_set_mnt_opts() call on
an already intialized superblock, which leaves the
SECURITY_LSM_NATIVE_LABELS flag unset even if it's provided by the FS.
NFS then obediently clears NFS_CAP_SECURITY_LABEL from its server
capability set, leading to any newly created inodes for this superblock
to end up without labels.

To fix this, make sure to return the SECURITY_LSM_NATIVE_LABELS flag
when security_sb_set_mnt_opts() is called on an already initialized
superblock with matching security options.

While there, also do a sanity check to ensure that
SECURITY_LSM_NATIVE_LABELS is set in kflags if and only if
sbsec->behavior == SECURITY_FS_USE_NATIVE.

Minimal reproducer:
    # systemctl start nfs-server
    # exportfs -o rw,no_root_squash,security_label localhost:/
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # ls -lZ /mnt
    [all labels are system_u:object_r:unlabeled_t:s0]

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1daf7bec4bb0..b8efb14a1d1a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -741,7 +741,24 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		/* previously mounted with options, but not on this attempt? */
 		if ((sbsec->flags & SE_MNTMASK) && !opts)
 			goto out_double_mount;
+
+		/*
+		 * If we are checking an already initialized mount and the
+		 * options match, make sure to return back the
+		 * SECURITY_LSM_NATIVE_LABELS flag if applicable. If the
+		 * superblock has the NATIVE behavior set and the FS is not
+		 * signaling its support (or vice versa), then it is a
+		 * programmer error, so emit a WARNING and return -EINVAL.
+		 */
 		rc = 0;
+		if (sbsec->behavior == SECURITY_FS_USE_NATIVE) {
+			if (WARN_ON(!(kern_flags & SECURITY_LSM_NATIVE_LABELS)))
+				rc = -EINVAL;
+			else
+				*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
+		} else if (WARN_ON(kern_flags & SECURITY_LSM_NATIVE_LABELS)) {
+			rc = -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.30.2

