Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC21C07E9A
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jul 2021 23:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C18600CD
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Jul 2021 23:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhGLXr3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhGLXr2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Jul 2021 19:47:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4A5C0613DD;
        Mon, 12 Jul 2021 16:44:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v7so19977337pgl.2;
        Mon, 12 Jul 2021 16:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZdcC4EOvokLDp7iGvpkIzf7OidD6sSk4XoFIM4xk3AU=;
        b=PhvZMt/qVfhwAJzYDBf6zlD0kGcx/nd81RJHYJm8GR1+RxH/GMwlQBDZuaIG37cQUn
         M9Du3K4PI829rOOvPbmaY8o1mUcsdT4ePldlyE0qI5RtHxDfxdmF/p2m6zCbsQKnYlSK
         sf0nj5mkoZLjPNjNy+LJ9BfGu56Z2Bm3Wmse3xhi7yqBENtoHeLbGTg49lmATzc9RXAL
         W7LaXVl/Owf3HHz7hfHfXAw1V1jr7cnlLAf3JqLw8FlNcgtNSnFrkNqKEjmFVpFQYwlD
         66nDUSPhgqnoXkT5iZmSuuMscOfy76QhVLeVyC3s0uo78rxb4AQ5Pgr+JnuQFUpvSHRQ
         DrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZdcC4EOvokLDp7iGvpkIzf7OidD6sSk4XoFIM4xk3AU=;
        b=op6I0sOqp5gAAb0cn3oAiJyZa4R8PWfqaqSoqAJjqq0D5l82KJrwkP2P6xrv0VS9Pc
         QGuxOeygZhY5aG5VMLQ86frO+U6/1GXtIq5XZ5N10M80ZzreNZWmIG+UXdt7cvXLCqls
         6v3xEypz5ELjRkC95MX3zXGPtvHVnTzLG6IfdPJ70cifhYh4/OO5FDnAnMODVIepYFc4
         UIp1Y7SYBFqxhmEROcm7YCZkE0waavKBm0VABz3IH7eA8jSOyKgAtkhQh2uyqEySBKTl
         /KZxBtSIWU5XnIdqFeCb1oidUMpi//kyTiMlKcJqN39bNBv5PtWwbk7m3/6NKkgjr49j
         /zLg==
X-Gm-Message-State: AOAM531+p4iauT5P84xWl61UlHUtr/ZByADjVjedLzLz8Wh7LjGWY+RD
        egHIx0V3qehX7L3NloC670k=
X-Google-Smtp-Source: ABdhPJxgaP0P3/dbLvfAzSerFWzwB4baHXqHZvqhQobpUQlynxpm5LosOM4joZQrtiRP2JeGCeylRA==
X-Received: by 2002:a63:b60c:: with SMTP id j12mr1501604pgf.393.1626133479231;
        Mon, 12 Jul 2021 16:44:39 -0700 (PDT)
Received: from raspberrypi ([210.183.35.240])
        by smtp.gmail.com with ESMTPSA id u8sm473837pjf.20.2021.07.12.16.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:44:38 -0700 (PDT)
Date:   Tue, 13 Jul 2021 00:44:34 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com, austindh.kim@gmail.com
Subject: [PATCH] LSM: add NULL check for kcalloc()
Message-ID: <20210712234434.GA29205@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Austin Kim <austin.kim@lge.com>

kcalloc() may return NULL when memory allocation fails.
So it is necessary to add NULL check after the call to kcalloc() is made.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/security.c b/security/security.c
index 09533cbb7221..f885c9e9bc35 100644
--- a/security/security.c
+++ b/security/security.c
@@ -321,6 +321,8 @@ static void __init ordered_lsm_init(void)
 
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
+	if (ordered_lsms)
+		return;
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
-- 
2.20.1

