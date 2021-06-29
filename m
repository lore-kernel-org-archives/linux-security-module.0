Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E2FC11F66
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jun 2021 13:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B2661D90
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jun 2021 13:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhF2NoU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhF2NoS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jun 2021 09:44:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A1C061767;
        Tue, 29 Jun 2021 06:41:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z4so1613791plg.8;
        Tue, 29 Jun 2021 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ecjztdsCL8Idb2y9jlcEGJ5wyQnjg16C2snI3Rv+1Vk=;
        b=J29cMXnef+QyTdsvQH6LJXpDoflmXHlZYU9hM+xHk8/sCc4AcL2n/goZMtNLlI31Nb
         vgkvEINjInTr7Y7NKwqT/mb3ZuXQxiu378nTJ38UPOs6tO2iCXCNfMZkDcxsseHy4rlb
         +Xg5K/hl4b0zjCs2UFfU4JSf/JztwH/zIk+tRJx5/sAjn8aCu/oZHcgDHeuk5LjnTv7i
         8EhdYIaQL/Fd63gQpUGNuxS8TcXh1N0hE3ykPuusPjCzofX9XPjbe4d6My0eTmlk95l1
         uS8d/sjiIPWVcnL11k1q6eyQnVo6UQPdz+lxdawwMQukRG/BvUMN1i2AvH/quIGoE7NJ
         2p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ecjztdsCL8Idb2y9jlcEGJ5wyQnjg16C2snI3Rv+1Vk=;
        b=VqDXMrSQzlrqZNPci10S4jfOaFr1mwawhmt0Kh2TNMv7H3uKmxXB0jckoh7XuFytrs
         QRwEIaoZgOuklWucXSk5hUdUTMDqZxavMgHH/TpRWbgSh6tx+WEr7JxlT5aKTd35pHuq
         n8R5iO8Rv7Bj9jLJg00x7GalyJfGQzra/gJMps0wfkcfdK2/fdxmXMb2AycsH6Y22x9e
         A7lDXMw/OU2Dk/4/IJHzJTX0couUZ7zTWfq0I87EpA+61P39Bs6XUKTqJX8xjwyjLu3r
         PzkzNvApIebEHjOeknt/i4WBJjEyVN2pm3CBGnvaCBCnEafYqILxNTDVcd0lp6Dylv9W
         8Pfw==
X-Gm-Message-State: AOAM532UzKBc0wcm0tcA6BzY66SzChx0eVQfDss0XeQeMhmzblPwi7nS
        WyMkslbXOBKp9vWLYY25Sxs=
X-Google-Smtp-Source: ABdhPJxch+337l3DMWR6X1WBiZfMTvf02kfOP2I/M+loIyKaYKq7kgcBtWGpwd5hjD9GoJvRMusfDw==
X-Received: by 2002:a17:90b:3912:: with SMTP id ob18mr44526657pjb.178.1624974109497;
        Tue, 29 Jun 2021 06:41:49 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id y5sm3676469pjy.2.2021.06.29.06.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:41:49 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:41:44 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        austindh.kim@gmail.com
Subject: [PATCH] smack: mark 'smack_enabled' global variable as __initdata
Message-ID: <20210629134144.GA1168@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Austin Kim <austin.kim@lge.com>

Mark 'smack_enabled' as __initdata
since it is only used during initialization code.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/smack/smack.h     | 2 +-
 security/smack/smack_lsm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index c3cfbdf4944a..99c3422596ab 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -302,7 +302,7 @@ int smack_populate_secattr(struct smack_known *skp);
 /*
  * Shared data.
  */
-extern int smack_enabled;
+extern int smack_enabled __initdata;
 extern int smack_cipso_direct;
 extern int smack_cipso_mapped;
 extern struct smack_known *smack_net_ambient;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 223a6da0e6dc..cacbe7518519 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -54,7 +54,7 @@
 static DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
 struct kmem_cache *smack_rule_cache;
-int smack_enabled;
+int smack_enabled __initdata;
 
 #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
 static struct {
-- 
2.20.1

