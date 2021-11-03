Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B646C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 07:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD88E60EB4
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 07:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhKCHRN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Nov 2021 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCHRN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Nov 2021 03:17:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E52C061714;
        Wed,  3 Nov 2021 00:14:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id om14so658290pjb.5;
        Wed, 03 Nov 2021 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vIcH6VSb3RqnkaS/PUnjKDu1+Sak6IV6g8yYKpiakmU=;
        b=Lq5t1Y4fLvypYia5nTI2xau1T/c6ci6WmenoecOI0/EYYq51iqq3ULJaR9RqbMMP8H
         LkJXe7eDNfl67/7SrsD3VSs9G+w+9woXU0ZAQvREk+QKm1xCeBDvkE7hxlL4E+aLvGf6
         Cx3JWyauaKqkkf34sr7zHUa2LS2z8wHaO7mWt03pn3aCk6LDPX5bbsVhMfTiK8UJvNsw
         KlNP7JHgduTn2nGadl9EmWfhzsVAjGy84eyuI/7SgRu8Tps8dPRWJi9MrMwAzsetyBWB
         sL5n3s/d77wrYrgWtKvkbmNgIqYFxNUpck16KH0FoNCtwAQT0e2nHyzbs3u95ZroBpr+
         315A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vIcH6VSb3RqnkaS/PUnjKDu1+Sak6IV6g8yYKpiakmU=;
        b=3MvplVEKaLOU0eMfQnyttOuyL3Vkwf4xcisM6/Rq/YNP1cG9rHcIfdqngLgngfk1pZ
         CXV4WA+llA7S2LlIzRr9psU6+APhUJnfZhH4TT6lIHGQjJSJEDdrmRcuGHINapAoROPa
         8uL/38jBDnJfs8MCGysAqQGXx1OQ7rt7hSas5U0LtMvn1KEbtMpIPOd4nidlhS1g9jRB
         uzn3xCjYi/WH/N0OKIbblR3M2Jy+nIDDkUVqZmtT4fhwBFNhd89ACDKCggSwnQ73KPIs
         KlWDR5Hx/4agvRm5d+FgCMVT2NaRPURaN9Rh7L624HBepVP0HeGFa58hHeXsaL3Ys5Rl
         MU9A==
X-Gm-Message-State: AOAM531YAdBcgCDVbU+Cj7N2uXapX8k3mFGki1IH3tIacPmelttXr+Xf
        4FjWWB3lTQfHYyCBamTZaMP0MpCglRHeSg==
X-Google-Smtp-Source: ABdhPJxPiQGFTlOLn9RJQgWr5NAmGQkkFVuVTaEgQKpQUJp0krt0Qrl0llC2xJX1+iQHwiLbBjYxQg==
X-Received: by 2002:a17:90b:3b4c:: with SMTP id ot12mr12699054pjb.196.1635923672440;
        Wed, 03 Nov 2021 00:14:32 -0700 (PDT)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id n9sm4387701pjk.3.2021.11.03.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:14:32 -0700 (PDT)
Date:   Wed, 3 Nov 2021 07:14:27 +0000
From:   Austin Kim <austindh.kim@gmail.com>
To:     mic@digikod.net, serge@hallyn.com
Cc:     serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austindh.kim@gmail.com
Subject: [PATCH] landlock: Initialize kernel stack variables properly
Message-ID: <20211103071427.GA13854@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In case kernel stack variables are not initialized properly, there might 
be a little chance of kernel information disclosure. So it is better for 
kernel stack variables to be initialized with null characters.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 security/landlock/syscalls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 32396962f04d..50a6f7091428 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -320,6 +320,8 @@ SYSCALL_DEFINE4(landlock_add_rule,
 	if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
+	memset(&path_beneath_attr, 0, sizeof(path_beneath_attr));
+
 	/* Copies raw user space buffer, only one type for now. */
 	res = copy_from_user(&path_beneath_attr, rule_attr,
 			sizeof(path_beneath_attr));
-- 
2.20.1

