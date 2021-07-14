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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE10C12002
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jul 2021 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FB361362
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jul 2021 21:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGNVyY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhGNVyY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Jul 2021 17:54:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF7C06175F;
        Wed, 14 Jul 2021 14:51:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h1so2134813plf.6;
        Wed, 14 Jul 2021 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xSXZsc9S1OE/57FZdD9wfjk5cX6z161zcXWV7Ia5wrw=;
        b=LB+yhlbbgc0eFOjSGF+B2qd/ql4FjkJ0tFzC3VFAdIl2+Hp31+VRl/MsPWq7msTIo8
         V0bV3GZY2nMR/MOZJQLRZzyOQ1RvrEOwdxemzGyqVdb6w9Oq349lZHwTs8MvjrSRZ7IR
         yiYC6lcqYVxZzLCwJITKDhs2Tq7rPQjBfXDHOe9rTwWd5vzMZwhoSr2ZSiQZ1vm0eqos
         bIYqgGK+O+pyQFDqDJiGYK4KXJ7sE8/fSrZqfDN9C5PPT2Eag2yrWJTZc34/6R4wazNm
         S4slxCQkdKkcCYUl2zT4KxfVMp+lTyNYZpeL/1Gr8CFZwb2ucFT0+rdPRWMyUPnTUz6e
         f0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xSXZsc9S1OE/57FZdD9wfjk5cX6z161zcXWV7Ia5wrw=;
        b=YCRD2B6uF1lpGx+1FpimnTUi2bfnNqpabmfWAPb7juA8dHJMN2JZsAUW0miAiIV3IW
         I2WUyXuaIO2Ynzu77eUQaQLXBqokx2jKu34n6fSLNxpqyqd8mn6OLu64SdgdeNgOekHu
         lTHUAdotzM9EUwtWwqBMMv0WszZHm5mOgiyIituGw0iq/9JmmCMC9EtRh4p/A6SU2+9h
         Rq4xv+vRwZDeAv623ozkvVHweUXogP34Nm3wVvjaTL1aLnKAGlTN3qvnAtcHvn7NBhx6
         SdLiCkJLsMFpV4tNB85mTLU/d9WJFmvy4kLyRoqANXsbA3nPh5zJJoe+quttsD6Hq8b6
         GPNA==
X-Gm-Message-State: AOAM533t2pAQDEgDLRVfdOKge/n8tchrS8Qn+Ydm75SduxGQUXMOAJwp
        qRzzQiUSZyHczIEt1zp2/s4=
X-Google-Smtp-Source: ABdhPJz+oG8T4/iIeiWnL3/H83fEezI8x4L0R8OtQeGzCFHIBq8l+Gg5bDpINORjG+ARyxdyO58ifQ==
X-Received: by 2002:a17:90a:4481:: with SMTP id t1mr13622pjg.232.1626299491614;
        Wed, 14 Jul 2021 14:51:31 -0700 (PDT)
Received: from raspberrypi ([210.183.35.240])
        by smtp.gmail.com with ESMTPSA id 10sm3679597pjc.41.2021.07.14.14.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:51:31 -0700 (PDT)
Date:   Wed, 14 Jul 2021 22:51:26 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com, austindh.kim@gmail.com
Subject: [PATCH v2] LSM: add NULL check for kcalloc()
Message-ID: <20210714215126.GA818@raspberrypi>
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
+	if (!ordered_lsms)
+		return;
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
-- 
2.20.1

