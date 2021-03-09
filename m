Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE84C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 03:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3AF65224
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 03:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCID1D (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Mar 2021 22:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCID1A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Mar 2021 22:27:00 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A95C06174A;
        Mon,  8 Mar 2021 19:27:00 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id kx1so123131pjb.3;
        Mon, 08 Mar 2021 19:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1V0TYEWZIitXRQ75jvS2RULmplHPPS1DJC5SvHi8W0=;
        b=qPTdjRvtUf3eSJzHJ4bi5xS3TEytSWU7Dja5ArV1o1yum7kgUIEir0PXQPocMy+hyZ
         3YGkicw3jQbzQkWh99YN0I5hYaXxtGNsL5bNr0a8pS1vOkSWz0H7mMpALN53gI9+esKD
         E1iQTVt9jSxScTWyRjC9gvzgcEsNgBoBS6xQCNLt5oaTg3lzpbMd1kUtIth0QAANfdKO
         F2jf0qTetzp9Ez4rM3KJmOiQuQD5A1VjbfT9zTKI6OrK240dck1IsNmL+l15y8xoBCz1
         8ApUXDUPJu8sJGjKQv18pwpm0gBryfSlLFhHG4mrrabetd5l/sAzt9XvLVoIUB1h4iV4
         ixUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1V0TYEWZIitXRQ75jvS2RULmplHPPS1DJC5SvHi8W0=;
        b=reHRZw5Gtuas6bBe1laycV1wEOzIfFhVWMRQQQnun8fPMpOq+rGXhARDOgIFcn63tt
         cWIZC+z+uZJdeZM3ftgWhfRZ3Swn+1fMkyzYymzzyue+u/ay7NXLHkjExVfeuDanH0Gt
         vl2EU0wjIgOolc7q/oEAQeCjf0pxRQNOPrRFMmIicMmpPQfXEQ1hI5x2wz0+NByHW9zB
         0DLLoUQsEWyfpe6DkIBCpymA4IGMBzL8FU3k0Mbsj6W0NzLv+dnfj7ZmSf1FJcEjEzM9
         vbMCFQEomHUkxCOaWY4+SMWGxMV25cwpCoLTSW/kF6dPvQDI7O3UpBbUcqt3ZNAjFRNP
         Ykog==
X-Gm-Message-State: AOAM5309No1EW9J/Kw4ctWEx710adGjBGGNRM2kw70KvZB80z3c+lJWd
        Dp5r36KKdZ1BEkJulNVuXNU=
X-Google-Smtp-Source: ABdhPJwz89YIspgNgbV1tr2uOCFLZeaEnXQO2N0psxmSbGL4RDnza1cUp79CJGrD7gWHzSYg1hveUA==
X-Received: by 2002:a17:90b:1105:: with SMTP id gi5mr2370437pjb.26.1615260419103;
        Mon, 08 Mar 2021 19:26:59 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id v27sm9738335pfi.89.2021.03.08.19.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 19:26:58 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     john.johansen@canonical.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
Subject: [PATCH] security/apparmor: fix misspellings using codespell tool
Date:   Mon,  8 Mar 2021 19:26:52 -0800
Message-Id: <20210309032652.274356-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

A typo is found out by codespell tool in 204th line of apparmorfs.c:

$ codespell ./security/apparmor/
./apparmorfs.c:204: seting  ==> setting

Fix a typo found by codespell.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 security/apparmor/apparmorfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2ee3b3d29f10..79591fc131b0 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -201,7 +201,7 @@ static struct file_system_type aafs_ops = {
 /**
  * __aafs_setup_d_inode - basic inode setup for apparmorfs
  * @dir: parent directory for the dentry
- * @dentry: dentry we are seting the inode up for
+ * @dentry: dentry we are setting the inode up for
  * @mode: permissions the file should have
  * @data: data to store on inode.i_private, available in open()
  * @link: if symlink, symlink target string
-- 
2.25.1

