Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60216C4360C
	for <linux-security-module@archiver.kernel.org>; Mon, 17 May 2021 13:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B194611C2
	for <linux-security-module@archiver.kernel.org>; Mon, 17 May 2021 13:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhEQNnd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 May 2021 09:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237450AbhEQNnd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 May 2021 09:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621258936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/7ogBL+LNdJ2jZ956/DJsdJPCwqblJZYhGffkhc86o=;
        b=ZCPdplf7xjWolRvZNz1FR7EgBV3s7iUVPOiVe2GbwiCTV7sg869UWgbguRHZsFaP37nm1h
        Mxd/wn+MQg1TySFOhOQNWKvu6qQgdQQTwix+4iLhXH58Mb0ZCPNnwcqdZljaMfAAS9mvHG
        jHARWuyOhCSVOJqp1eI1jVyKVVRUudw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428--SMv2C_7N9amdn10nBB30Q-1; Mon, 17 May 2021 09:42:10 -0400
X-MC-Unique: -SMv2C_7N9amdn10nBB30Q-1
Received: by mail-ed1-f69.google.com with SMTP id cn20-20020a0564020cb4b029038d0b0e183fso3925047edb.22
        for <linux-security-module@vger.kernel.org>; Mon, 17 May 2021 06:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/7ogBL+LNdJ2jZ956/DJsdJPCwqblJZYhGffkhc86o=;
        b=fw2m0eI7LGDPHxqzXofnc4vcjKBy3i2JjoDu0QFpDyG2mBXMcJmdn8QhU3rKEwDA6E
         dfW+JkZLrpspq+V/cvCBvUvZydLN+bS/BKQOYav2/wUO2i92kU+rymFYz4VZqhX1S5s3
         0MHupXiaP5ZhMBWnGEsC7/z9iyfg9lwnNcCM4+MLObrPKq4I0MIGPQnu1VwGjhh6lpW9
         3kHSXf7edWddSmT2BSi318bd6flCrOVwJfPg5DuNAY7M7LfWXx1S6Bw4at200uGtSY1A
         NqJuhTeJK9WsdQc5rlH5WTimoEUBEJmQPIxluyLcLXz/C0n62LerBsrAFSAnDNBNuNwA
         md1w==
X-Gm-Message-State: AOAM5327mGdvON08cufmw4ZWd5JXBqVveeH4G2Mct2htw3jkWEEwZQar
        TQmMAYG3rOdQKVm5QzqrBPfa/LCO2EDTywa1Jd+ncADvSmyZaas3JX30FH74z3b1kdpZickjHzS
        xlbIduHyyEOXZs1iUHohoJ1SVjQ8Rx79A9UQASQrd8KttaUiOFq7EgliXRK1QFr6e+0Hm/OUn8M
        tJig3SitXOG5aB
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr63552972ejb.183.1621258927861;
        Mon, 17 May 2021 06:42:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwmY87sB+RI/eYOHiE4Q0GrYf2Jge+7AHgcZqApEDJVyA57Z96Ks3gQhOvtduuLmn2qVC3iQ==
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr63552938ejb.183.1621258927634;
        Mon, 17 May 2021 06:42:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id f7sm11302466edd.5.2021.05.17.06.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:42:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH v2 2/2] selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
Date:   Mon, 17 May 2021 15:42:01 +0200
Message-Id: <20210517134201.29271-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517134201.29271-1-omosnace@redhat.com>
References: <20210517134201.29271-1-omosnace@redhat.com>
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
index 041529cbf214..367e7739cb18 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -734,7 +734,24 @@ static int selinux_set_mnt_opts(struct super_block *sb,
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
2.31.1

