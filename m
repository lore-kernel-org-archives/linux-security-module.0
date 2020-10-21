Return-Path: <SRS0=8N7l=D4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D633BC55178
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734042224E
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 15:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Lg4SyFJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502349AbgJUPT7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502344AbgJUPT6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Oct 2020 11:19:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B9C0613CE
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2020 08:19:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l2so1289959pjt.5
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2020 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hmO+mhbzoYH/GVwbytgH/sAwdgqzz47G17aTAhhRQ8=;
        b=Lg4SyFJrAGKmMg6tKEON5sq5UQvRWRT9njDtU86HrhpkL0D0RdFN95O/iD+u7kC/4r
         ahEy6DJB22RvhcXOWtpd4G1oxyqNVqToJqGqqUs1YqCpH2pXiY1c5d/0pzhbzSnYT69M
         nqknNaLQF80VCLDCS9BeJ3heSe/9QtMbQljDx+DCvH0VNLMd/6p9Qqsw79r2qTLa69LX
         R/bAIsTRcvhLiUbCjOhNRPhWsBrblxRy6nLLJDIlIAzaR7RQCmbvWYcaM06CO7pnHIQI
         4XcufkDp9mMo7ZlREAiInwPH2LB+50E15mLIPFIh/Q71X2Y7y1PHShJVIl54u4zodyis
         BSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hmO+mhbzoYH/GVwbytgH/sAwdgqzz47G17aTAhhRQ8=;
        b=UjDc333GCJZZ7DQ7LSfjJuE8AStR6BNd8wGoIAxklNfUPtQSoObkSn1g1THpiX/pGP
         1aQHcnGUTZkk7syRjoKT+EAMJAUQLgfZg1corgOAzEz99lbOjjPBzJwnAYw/2b5Cg1ee
         C53jYOgrWH2smGE+lpPQ6bf4TTjeBHnV+F+dAJXrBNIH/+GkgKz8cPYUm2KXUhYQ79+K
         AGrObdpNo8q19F/jyE4ObwnilPJ9bn/MpqAeNgHrCPFJLu12cnYfZgtoyyCTz9D/eDhu
         Epla/0y5mjEwTKG+yPDNGRI6dk5fNF/fseRP9oXQL8DnFSP1vqSE1r18x8/b2H8sG0eP
         Gc6w==
X-Gm-Message-State: AOAM532wCLcd9c/5HoQU6ao5+OroJImEeyCb6xi4eV8JboWRPwkTexID
        hR7vTDtrNWv9idSP/TPNNI0SsA==
X-Google-Smtp-Source: ABdhPJz/qcBUTmMYFz604l9m4rFbwcPGK6tFrbID3W5xqQgE0s1q2+B4QDvOzg5odG59Fj+FHRoowg==
X-Received: by 2002:a17:902:c24b:b029:d3:f3e6:1915 with SMTP id 11-20020a170902c24bb02900d3f3e61915mr4132119plg.56.1603293598087;
        Wed, 21 Oct 2020 08:19:58 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id s10sm2409646pji.7.2020.10.21.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:19:57 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <john.stultz@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: [RESEND PATCH v18 4/4] overlayfs: inode_owner_or_capable called during execv
Date:   Wed, 21 Oct 2020 08:19:03 -0700
Message-Id: <20201021151903.652827-5-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021151903.652827-1-salyzyn@android.com>
References: <20201021151903.652827-1-salyzyn@android.com>
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
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: 05acefb4872da ("ovl: check permission to open real file")
C: linux-fsdevel@vger.kernel.org
C: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: selinux@vger.kernel.org

v18 - rebase

v17 - rebase

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

