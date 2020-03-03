Return-Path: <SRS0=t7gL=4U=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16BC3F2D1
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Mar 2020 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887B12073B
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Mar 2020 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7sS+dvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgCCSbf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:31:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38050 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCCSbe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Mar 2020 13:31:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so4653919ljh.5;
        Tue, 03 Mar 2020 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aJ2rFn5flgOkG+OEZnpwAKdwkeZhcqGHzxlIeQ891xQ=;
        b=a7sS+dvluG8fFpEkTs3ZrJ/2PO/voWjPgmriGFPTzDiGHCqQabLnoQCQcQ9kqU29og
         Ugb6BC7dFVFpGKOIM0US07UBtVcsc1juKzEf+V+prvUfpGtHLyGatNPJOcTKOaqJV7sI
         8FkH5ULePee6dd+mPa0Ma8i08XsOBcZ0gv09nPnHdAVIYHtxcrSDs4rEPjdI2N21Ycnm
         e2HyKcqWZCW8ZMwTm+xyoaJZKgCA23O7INgMdCDqL3ns3y6sjbITFMU2xJKP1EiDeaKk
         tThlLB2cfvjGRqMNDuwpdzngeZirT91FWRHIuoU6tkLCbUa1xkOcsKoZR1uj3N8QNfUL
         RuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aJ2rFn5flgOkG+OEZnpwAKdwkeZhcqGHzxlIeQ891xQ=;
        b=KFrvycv9uCx/Zkx8zswEAH8dZIU9QhGiHrpHifnKkaW3CKs7Vp1Wl6DkTb57ZPSrxj
         +wznx1TFfNjRvNhZoTk5s2CLGGXOKS2ZapaC3H+Svlg2mgvf4Xe34cAEMXtXh1ZXIrBg
         0adhdHdMN3cQVQuNKmUAkyYvENPUgMDUQKF7JJIw8xsokgtb60sigIvFMYpIQZkm6usA
         w0cmQgqtp672WHPMZ1tM+eJ6J0j10fgY3nf+A7cPFaS3R9X5vMpBl9vk6/NbwKkHzJFA
         tsvFRYUW2y43k4ZVzekTyGSVmwvaAIzS90PSYVdXYW06qJ+Q4L4GgYbw1tyQCzCkEM+2
         vsUQ==
X-Gm-Message-State: ANhLgQ1w+kjPe2LVQFMLz20DH/XQKXB9yZwXhSAmtKZHYGaFVmipuNZj
        /hlmFkyhxNal4SefsRkmzcNNnXrB4zM=
X-Google-Smtp-Source: ADFU+vudtRjHczPH70jE7xnm+q7JqziinJZ/yBUVhKAhoH4rIY+/z0XL697yBOPaccSMoCD5LGXOWA==
X-Received: by 2002:a2e:96da:: with SMTP id d26mr3318900ljj.6.1583260292278;
        Tue, 03 Mar 2020 10:31:32 -0800 (PST)
Received: from localhost.localdomain (188.146.98.66.nat.umts.dynamic.t-mobile.pl. [188.146.98.66])
        by smtp.gmail.com with ESMTPSA id z67sm12525460lfa.50.2020.03.03.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 10:31:31 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, serge@hallyn.com,
        jmorris@namei.org, john.johansen@canonical.com
Subject: [PATCH] security/apparmor/label.c: Clean code by removing redundant instructions
Date:   Tue,  3 Mar 2020 19:30:23 +0100
Message-Id: <20200303183023.32004-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously 'label->proxy->label' value checking
and conditional reassigning were done twice in the same function.
The second one is redundant and can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 security/apparmor/label.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index ba3987242282..676eebcbfd68 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -311,8 +311,6 @@ int aa_vec_unique(struct aa_profile **vec, int n, int flags)
 
 static void label_destroy(struct aa_label *label)
 {
-	struct aa_label *tmp;
-
 	AA_BUG(!label);
 
 	if (!label_isprofile(label)) {
@@ -333,10 +331,6 @@ static void label_destroy(struct aa_label *label)
 
 	aa_free_secid(label->secid);
 
-	tmp = rcu_dereference_protected(label->proxy->label, true);
-	if (tmp == label)
-		rcu_assign_pointer(label->proxy->label, NULL);
-
 	aa_put_proxy(label->proxy);
 	label->proxy = (struct aa_proxy *) PROXY_POISON + 1;
 }
-- 
2.17.1

