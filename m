Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA82C4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Oct 2022 21:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJMVtO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJMVtH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C8196B42
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 14:49:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso6655853pjv.0
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj7DYXRn/lwcs5aiTYIeKDOFw4+lQjw1vEVLiJXMDzU=;
        b=uv0ocZU3ciB5Mu/CgbO+C9FW9iMg7BIF5Z+0ArnVELFpUpgAA/blyPPZa5VUVAzsMy
         8ss/XiIdtSPaYo1Hq3UQm/u06YP+RqByPscv060LCUaUQzNKoo8O6GvB7q2We9YP6FWw
         jRSh1EupQujK4IRK4oHevTPIawLykDK13ApeShMITlCcQISsIGELRa1l9Jt0GHRSph1c
         dj8IUZeaa0/jd9UAv5YTQZ3xKO6C/B/zkbp/agj42SrIGLLFVg6K6yqYKBuzddJJIxfK
         JdwyYielzGNljVqX9sgZqXXp4agHyz7hVB9Pp36eFkJEdFaiP6zl3/6g6dzP+CGE3pdr
         Pesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj7DYXRn/lwcs5aiTYIeKDOFw4+lQjw1vEVLiJXMDzU=;
        b=L3ZR63xZ0G+7LXWhM8Hbj9BgbUZ/rgFrAX9/EFIoPHVsk7g7RwCs923yRKwOhQrucF
         g0TSJpTxhTiWMtjvYKv9Si6hQqfb8IGdEteLxVF6cprINWmnJobL7KtQyQjry1J9jpEU
         RQ9d7woDkkAsOx3DCpJLynwWFD4xEgC8ptjfck7p3KR0vFI57bgu1GOvBtIr/T1s5Rah
         Bkw6uPOztBjan4HYuUq2TfPTtIvlmKwum/24RCqtT53vrONJHI+j5gScTQsq6U++dxa9
         VB+qDLVDvc8+y8GuJJWIBzjLo1nIc9izRxqTg5kpp126U6+Z6OKun3m4WVjBDY7AgqyB
         zrcQ==
X-Gm-Message-State: ACrzQf1QTMPuOZMWe2wYFA0R99SGvlGAAAO7NegqsC+NLt8dURYCSSaC
        eIRNQDFMTs4nSZOZGX6yUO4joA==
X-Google-Smtp-Source: AMsMyM5JRji+Ck9EEzDOpU/prtu9nNzoo+5EQ62VP0n5mfMjSIUrKoZs3BbPS3y2ac90l5O+O3MKoQ==
X-Received: by 2002:a17:90b:1c87:b0:20a:e485:4e21 with SMTP id oo7-20020a17090b1c8700b0020ae4854e21mr2025804pjb.194.1665697741676;
        Thu, 13 Oct 2022 14:49:01 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b00178aaf6247bsm333100plb.21.2022.10.13.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:01 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for cschaufler
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30807-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index daadd0de77a9..019cdb48e254 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18723,7 +18723,7 @@ M:	Casey Schaufler <casey@schaufler-ca.com>
 L:	linux-security-module@vger.kernel.org
 S:	Maintained
 W:	http://schaufler-ca.com
-T:	git git://github.com/cschaufler/smack-next
+T:	git https://github.com/cschaufler/smack-next
 F:	Documentation/admin-guide/LSM/Smack.rst
 F:	security/smack/
 
-- 
2.38.0

