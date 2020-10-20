Return-Path: <SRS0=DeF5=D3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12AC41604
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Oct 2020 19:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7463D2225C
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Oct 2020 19:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="B7i2YxzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438065AbgJTTSB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438055AbgJTTSA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Oct 2020 15:18:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFFCC0613D5
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2020 12:18:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so1743982pff.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2020 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhB4D3Qqks0KHT6wFulg0fVFOaiWDpRKJPkxF+EjUPY=;
        b=B7i2YxzQiX4ywyIQ7T2IluxWtdSzbMHDa7gjsTvpnwiCmX/zVEnzH0+Zi0DMEBnVwQ
         PFqs4GQSDMqkpZXfOQ+wQT3i1MR7BVH0bDQygYEZn3UopGZRsYU0jSbhPu9FoKMoaQOK
         R8/yZdGPnVkb9RsyMKUZbJLN1SvfBTz2gnhpMvoQkz+aM9U7ARA/dTMAT/bs/2TsfT3q
         sCSMMI9/sMP03LgEVwuNOlEe2ySrWYraI2bHU6T94VKrQ1X5S43qxqmV03MchyqqfhsC
         gxAjGIS4Ao/3u7zz9qVEG4G+Qt+bbFsd6dgZm4Ml/yrFU1Ajy5wUKv9Bs43UF0DET7bP
         owhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhB4D3Qqks0KHT6wFulg0fVFOaiWDpRKJPkxF+EjUPY=;
        b=P9+tq8ULekIj4ltFRVVj/D2uf4J5xBwEJw7Plbg4p5vaiFIwgcBESgW7I3D4AKdd3z
         RUH8T4ocNM99XLGNaDvtG3zI4EGhV5/d+pUDAArOPC1g35qAcpz2jSCm+2zvptRZPpiI
         SKeNigg3pCN0tm9xUuhWNVtXzbCbnaqxNRBHlPhfFgNCdRTFAxM6+XxXeunSuBoDUlFF
         +pEv+FHb9EjUCSH0+8GXqNJGsAndnDVO+E7uFFR+fKymIvwLU04S9RxNeoPVICQ9yV+Y
         KCm3MzC5Ylltk+xQt2HrQ9UL6zAjoZUXXJqTvt8PbTv+xnncUDe2l+6BIBqqMZwZPbYm
         5RJw==
X-Gm-Message-State: AOAM532710uOICDckLoUwlqb9z0D9ONU6V3LxMgWhQ7UeoQsRNk2iXvB
        xk1Yt/Qb1Z7FGhLG2UKfO8SpAQ==
X-Google-Smtp-Source: ABdhPJweqU78LH8AyiJYMHFlFTspVNfLD1dRowEZwySv0syk1hVhU7wNYb+7SLKhooDpuEc82uDo2Q==
X-Received: by 2002:a62:8348:0:b029:152:9d3c:c67e with SMTP id h69-20020a6283480000b02901529d3cc67emr1355225pfe.65.1603221479830;
        Tue, 20 Oct 2020 12:17:59 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id 204sm2855995pfz.74.2020.10.20.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 12:17:58 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v17 4/4] overlayfs: inode_owner_or_capable called during execv
Date:   Tue, 20 Oct 2020 12:17:32 -0700
Message-Id: <20201020191732.4049987-5-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020191732.4049987-1-salyzyn@android.com>
References: <20201020191732.4049987-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Using old_creds as an indication that we are not overriding the
credentials, bypass call to inode_owner_or_capable.  This solves
a problem with all execv calls being blocked when using the caller's
credentials.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: 05acefb4872da ("ovl: check permission to open real file")
To: linux-fsdevel@vger.kernel.org
To: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com

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

