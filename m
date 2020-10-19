Return-Path: <SRS0=+Ebz=D2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C96C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Oct 2020 11:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2957022276
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Oct 2020 11:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="NOmBCwJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgJSLxi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Oct 2020 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgJSLxd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Oct 2020 07:53:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F8C0613CE
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2020 04:53:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x13so5876124pgp.7
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2020 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAcwqmNfAmwXwu0i3bIxz+R5/n4Ik+l7yKLbYmcgPlU=;
        b=NOmBCwJXEnbqMWKYp9EX+FUE3rN7d6I9+W7Ynhnl4DEacejiUrwDLCdRnPBa/GxfLs
         ew0NegylxLreYjG5HPKEKbOIvmzALCiwkoe/KKmhRfW1cGRSwAcWwN2/tt960eRMzSpC
         JIgxoo11zZU75AgazfyIL26vlZTXCDcH4R1f4nO6AOW/wFxCevWNAdvIdSK7udmaTZ9d
         rxbG7nb9UQ4pxhKVwB8bpH8NJwSrjU36VZaF37q25K3/3pFZ0H8lhC8Wdd5iyNZEWOj3
         z1pZ8LTm+iLjkCPGpEtxgNczwDi3myTAoKIQt3RGVNQnImg2UlvxoZgfWt2hbnsP25kw
         QVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAcwqmNfAmwXwu0i3bIxz+R5/n4Ik+l7yKLbYmcgPlU=;
        b=Z23p7piFR+Lv/PmC4fJJsYM/OF6NTyOMax5UHZ1qKVyFbJouE3QFxB0yayZ5sEor4H
         GMX3sW8uFQfb4LGsX25X45VUiq4gsubuQ4Pj7siq9J6DosTObicoNo91PG6HXrD1FhMM
         GNMOotssNwWU3d0K2K+/J/xVwNr2medWmTyE0ZQCoDpUS9wKkjalSksj6USBVyRvPlCv
         RHbGWVj3DSA8evSaj41FYA/5m81HSZgjyE8D4aW92MPG4K7a6q8adSJ0PF7lF90xZYjs
         yNERBp+DIhQa7iD8HQ8q46Fg3zOqbZ3aRWkIOatgMNNYwEdraFGaZUKW7yBLGLDA9YId
         GceA==
X-Gm-Message-State: AOAM531QJ97ikBgzxnzcnhhPuU7tW0gpTx5jbA6GLwFJJwR2SjcgPDj/
        N1yMh0L41dG+iG+UNV+HAHiWfA==
X-Google-Smtp-Source: ABdhPJzLV5deOuiOvJDiKiswUd9e+45wYwwm0xVwiV3R4XXfSmm1D60wGrwFS//kaC1mgMkBVkh4oA==
X-Received: by 2002:a65:5c86:: with SMTP id a6mr13918432pgt.227.1603108411168;
        Mon, 19 Oct 2020 04:53:31 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id w68sm12128099pfb.108.2020.10.19.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 04:53:30 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <john.stultz@linaro.org>,
        Mark Salyzyn <salyzyn@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v16 4/4] overlayfs: inode_owner_or_capable called during execv
Date:   Mon, 19 Oct 2020 04:52:39 -0700
Message-Id: <20201019115239.2732422-5-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201019115239.2732422-1-salyzyn@android.com>
References: <20201019115239.2732422-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: John Stultz <john.stultz@linaro.org>

Using old_creds as an indication that we are not overriding the
credentials, bypass call to inode_owner_or_capable.  This solves
a problem with all execv calls being blocked when using the caller's
credentials.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Salyzyn <salyzyn@google.com>
Fixes: 05acefb4872da ("ovl: check permission to open real file")
To: linux-fsdevel@vger.kernel.org
To: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com

v16 - introduced fix over rebased series
---
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index b1357bb067d9..9ab9663b02d8 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,7 +53,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
+	} else if (old_cred && !inode_owner_or_capable(realinode)) {
 		realfile = ERR_PTR(-EPERM);
 	} else {
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
-- 
2.29.0.rc1.297.gfa9743e501-goog

