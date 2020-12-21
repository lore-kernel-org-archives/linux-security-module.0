Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A2C4332E
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6F422D49
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 18:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLUSfB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLUSfB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Dec 2020 13:35:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF654C061793
        for <linux-security-module@vger.kernel.org>; Mon, 21 Dec 2020 10:34:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a6so10789484wmc.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Dec 2020 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNhFGqo/g45Vw39PPzeyV/9od/qdXVkkF7FVMBHsoTk=;
        b=PEBojDmrW2ICkUlJoG7rstEV1q2Qd5KKTkAX1Ocy3nrq3C6N9DK9CKMg2149ZHxvHf
         bW832wfdAmyatfdGT1TuISj0fhu3+HMSoab9CCTPy024DA/qsM/LkQy1TxwGisU3cpkV
         oEgsuwe8/mhh/Q+cNJj8bAug/faf80c00egIMX4LQHKnOwaq4D6hicWc+SMAaxXY2p6c
         y+lA7I6B0Ja6PzTyNjJUhkkQxlyKRS3SRZTnviNRmHbCzq5eCdN+Du9jf5zQHA55ITB0
         euklkcWpcmfcZ/SZiebdTVzTdkSVzw7xBlj11C+ltq7mktHIyY7zVpNJUz2GdreWjMhn
         LqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNhFGqo/g45Vw39PPzeyV/9od/qdXVkkF7FVMBHsoTk=;
        b=IrHf68eUfgfDDU/Ge/YU2nuIstT3bLO108vZzmi5dguHlWbuLQhIpGNcEuFjoZ/q4Q
         GcfomeBnjr0weDBsjL9wpLkapsLSOfIMSLO0qBtladFc+ljee7HtgPHxZRo6+ferwM5B
         d3pqTBUhvj0B0ku5RXUGv1wQMD4F0/J7fjVrPA/YZraPacTBqvMRY82WD/95DZH77sJe
         vAAoXmYZ8NzFz6e5Leeduwr3GNumRasV6C5o29WouQRxpb83ShuzYs7mNnmlekaoI4vS
         BQOn/q5aoF5Orz7xxC6cXM/iKntEqgCWtGEm6oGJtLEksEbIbOMY0+7t8f4GVTke5o8C
         rgRA==
X-Gm-Message-State: AOAM532FRCKXdycnzv+oaIZHG0OGOldUqQmUNoOQA9JTsTop4wFEczmE
        Fd0EU7zv1wwwzoJqdWruVmA5rZKRCmY1ZIJm
X-Google-Smtp-Source: ABdhPJwh4/VMxQLwQHM4YMFeXfzZGicQy51sw83ZvDmuXwmkfbMUj92r4FfCX+R7X3v2fI7p8Q1U9Q==
X-Received: by 2002:a1c:dc87:: with SMTP id t129mr16860614wmg.52.1608561086676;
        Mon, 21 Dec 2020 06:31:26 -0800 (PST)
Received: from kali.fritz.box ([185.93.203.205])
        by smtp.gmail.com with ESMTPSA id n9sm26996726wrq.41.2020.12.21.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:31:26 -0800 (PST)
From:   Alexander Guril <alexander.guril02@gmail.com>
To:     john.johansen@canonical.com, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Alexander Guril <alexander.guril02@gmail.com>
Subject: [PATCH] Security/Apparmor: Fixed a bracket problem in audit.c
Date:   Mon, 21 Dec 2020 15:32:52 +0100
Message-Id: <20201221143252.32271-1-alexander.guril02@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch fixes a bracket problem in security/apparmor/audit.c

Signed-off-by: Alexander Guril <alexander.guril02@gmail.com>
---
 security/apparmor/audit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index f7e97c7e80f3..63c4367f97b7 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -61,9 +61,8 @@ static void audit_pre(struct audit_buffer *ab, void *ca)
 				 aa_audit_type[aad(sa)->type]);
 	}
 
-	if (aad(sa)->op) {
+	if (aad(sa)->op)
 		audit_log_format(ab, " operation=\"%s\"", aad(sa)->op);
-	}
 
 	if (aad(sa)->info) {
 		audit_log_format(ab, " info=\"%s\"", aad(sa)->info);
-- 
2.29.2

