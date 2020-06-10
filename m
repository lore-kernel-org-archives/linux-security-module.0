Return-Path: <SRS0=uCN1=7X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F5C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Jun 2020 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0916F2081A
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Jun 2020 06:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxpLUCsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgFJG5z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJG5x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Jun 2020 02:57:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF9C03E96B
        for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2020 23:57:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so932556wrt.5
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2020 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEs396PvYoTVXTs6aaCClr5a690E8PPQODHKGBcfJ0Y=;
        b=pxpLUCsTUVHLQ85bzQncA61leFmjuUXlmPemn7odmjtvlIn5E9jHESg1BityE0DfdU
         KGTRlcucfDBPQ5zrj4MIQrjZ8sK+8SYaRmtdSf2EkqMGqSHnJlacmcqlLMfyyLWhntCe
         cO44O92Q3TvG+1x5oP0DpZlWfpTv4OSbw6p1Q6vKwiXWDuZ5Bw+GbSC+Ijeb43RSQjEd
         eZyXzPIf3gMZKDoZDBYSUFf+kwX6oU1VhPmm5xNWOrhjbP4UlXcA7lmni9dKzQH9qY5e
         V9rjy+RbBmya+8JYOUmSg37Hp1lG5JqAGmDar49pbkC1v83u48FCgOODWXLqAKnr2f4A
         T5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EEs396PvYoTVXTs6aaCClr5a690E8PPQODHKGBcfJ0Y=;
        b=dJjqkcmMx7eUKfojWctYfON9eEMmwIi2svGPCgxEbiaOCuaiXgCFlWzjpJMg7oBgDV
         DriWgFOJZvNAmEJNJoKS3P3RF61ZqQJsn4m/eoMXCmszwe63F+f39KGzr5eBs/rvJaLn
         /FX6JDYLgO4BoE63AySRkvJlKJxJkyvLo/0GmluptfWix89SUcy2ZV2HzGQp5JdWlmXU
         jZ41by8b9uc0mVQ3ZBesXPvzVMYlaMDbOkbulPc2Oz5+6/x0Qjyow20H9mT+dlA9J+Ni
         BOKecjdjHScqsjdtV/IOxvB/1cl2T+DQmX3zLCHxlHIDebI75SzMbPrFb4afZeZAaZP1
         gD/Q==
X-Gm-Message-State: AOAM531DiYKWDXgotINKvpmpgZF3V1eqRYdtlJS2aR4a4xzWT6xD8owt
        uB04/kg4q0KZPHZMB8WX+xg=
X-Google-Smtp-Source: ABdhPJzX/s4Tq6dK9YFxc1xRkHwIBK4rv5ncpLkrhAcGe0wuJsGMcUhnJrvCK51OArUGmJCUA1U3MA==
X-Received: by 2002:adf:bb02:: with SMTP id r2mr1971910wrg.143.1591772270865;
        Tue, 09 Jun 2020 23:57:50 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id g18sm5889977wme.17.2020.06.09.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:57:50 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 1/4] cap_get_proc.3: Typo fixes
Date:   Wed, 10 Jun 2020 08:57:32 +0200
Message-Id: <20200610065735.3975740-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_proc.3 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index 3eef3f7..c2ce212 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -87,7 +87,7 @@ with a
 .I  cap
 as an argument returns the current value of this bounding set
 capability flag in effect for the current process. This operation is
-unpriveged. Note, a macro function
+unprivileged. Note, a macro function
 .BR "CAP_IS_SUPPORTED(cap_value_t " cap )
 is provided that evaluates to true (1) if the system supports the
 specified capability,
@@ -216,7 +216,7 @@ On failure,
 .I errno
 is set to
 .BR EINVAL ,
-.BR EPERM,
+.BR EPERM ,
 or
 .BR ENOMEM .
 .SH "CONFORMING TO"
@@ -298,7 +298,7 @@ Linux.  Note that, by default, the only processes that have
 available to them are processes started as a kernel thread.
 (Typically this includes
 .BR init (8),
-kflushd and kswapd). You will need to recompile the kernel to modify
+kflushd and kswapd.) You will need to recompile the kernel to modify
 this default.
 .SH EXAMPLE
 The code segment below raises the
-- 
2.26.2

