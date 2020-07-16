Return-Path: <SRS0=RuUe=A3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A6BC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9005220775
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBsHBa53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGPKTl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGPKTk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2DEC061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so6460407wrp.7
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKwwx9SCPSgGKTUvHlHZPqNVtziKFzsn6pWTO18XHYo=;
        b=pBsHBa532OY6Xt5ROhZcFRge7ztceKG4qg/VZnJ8AqgbO3zB+JLVKQ0Fr5eH+8Ztxg
         SpTvD/X2vjXATuSdJim9AF4Q1ckIPH0WrhfqGo7oHCKd9h7XmMbxZfXl7O9PoQT2b4+V
         VLPjhWNwjPeveZRBkWH3wux4NRB2vrXMJwDxlECp4RgDemrupE87+syLk86Dh9X9Wlfp
         qWAyvHSYjeJ+wNZApCEca+EhLS9U1gYlf/eX9pYLvCZRTS/zJ7C0zj4c2oP1JxEK/CH1
         uB5XYBk0Pi2yFWASGg3h86xEpUMm1W1+32OpiOMOwe4bDQ/fehSca6pDBye0/c2DPKyz
         0Hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKwwx9SCPSgGKTUvHlHZPqNVtziKFzsn6pWTO18XHYo=;
        b=IQm/KGCXYiFmPVzSxDUJCTDNoPtpR4TS4IssTYJw8AJqK0nkklcHqjhkB2W5cdUigT
         Bwp95X4RJouXdTjW0fVYQkj9Z3A2V+ptZhqUGFgTMPd+kZbbGzwwIRXvOzdtqsv200Ha
         sWl2SmeGjnu/GVF9KBj0CsF9TEksHwWNQX2nPwWsO13v2ducxIu7oyUwN+5Q/yLFb/sM
         EjvRplnrVMMyYyxHCqw+04Z7J97KBW01VMMjzUHnkS1dHNiFUj63LAfBiqNACK/NMEF3
         QZK8ytumyNDpyoZ5YTecpZ8fLI8IWS7SK5pOJk5zS71CUSPDwFnXwKlSwBqJI+FguaZU
         4ZsA==
X-Gm-Message-State: AOAM531+zlGQWvCJ+bcAoRrPSw719erKns4qELe3kTbF2CyEZWDbNsIf
        iLhKWDwonBwjKC+mLdFSvbk=
X-Google-Smtp-Source: ABdhPJx5FP3+ODoDoxqnf8GAED34DdikQLeNgEfpQtwRYna+qkz1+F45fGYbpNtxuSO48zMtl4aBnA==
X-Received: by 2002:adf:e944:: with SMTP id m4mr4521670wrn.252.1594894778899;
        Thu, 16 Jul 2020 03:19:38 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id k20sm7587194wmi.27.2020.07.16.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:38 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 16/16] capsh.c: Spelling fixes in usage() message
Date:   Thu, 16 Jul 2020 12:18:27 +0200
Message-Id: <20200716101827.162793-16-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 progs/capsh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/progs/capsh.c b/progs/capsh.c
index 94bf57d..7bed98e 100644
--- a/progs/capsh.c
+++ b/progs/capsh.c
@@ -879,10 +879,10 @@ int main(int argc, char *argv[], char *envp[])
 		   "  --delamb=xxx   remove xxx,... capabilities from ambient\n"
 		   "  --noamb        reset (drop) all ambient capabilities\n"
 		   "  --caps=xxx     set caps as per cap_from_text()\n"
-		   "  --inh=xxx      set xxx,.. inheritiable set\n"
+		   "  --inh=xxx      set xxx,.. inheritable set\n"
 		   "  --secbits=<n>  write a new value for securebits\n"
 		   "  --iab=...      use cap_iab_from_text() to set iab\n"
-		   "  --keep=<n>     set keep-capabability bit to <n>\n"
+		   "  --keep=<n>     set keep-capability bit to <n>\n"
 		   "  --uid=<n>      set uid to <n> (hint: id <username>)\n"
 		   "  --cap-uid=<n>  libcap cap_setuid() to change uid\n"
 		   "  --is-uid=<n>   exit 1 if uid != <n>\n"
-- 
2.26.2

