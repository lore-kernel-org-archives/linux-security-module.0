Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF6AC433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 06:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860E564FC8
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 06:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCJGw5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Mar 2021 01:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhCJGw1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Mar 2021 01:52:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE00DC06174A
        for <linux-security-module@vger.kernel.org>; Tue,  9 Mar 2021 22:52:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id bt4so1047935pjb.5
        for <linux-security-module@vger.kernel.org>; Tue, 09 Mar 2021 22:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIcfFT367IDJKZN6LRt8pfpB8CHdlGVvwi8FF8cmlqE=;
        b=DfDNEyWMqiiBTNQtU5OnDDS+b27Dh1uR0+gmqHNpKfiJs4CIxc6goRyC7kKzZ3Lxt4
         saTWIY+WuNZ+U09WNQD1hgQKan/233ShIkIgStvyC98vgRDLScWQ9d3LBb9kkvJFiPZA
         uaKhV+kNj6+DSTVcXNWC+TTq7L1qpxi6C/1xaMrXGiqtFEzqPmyzGflohO3dEZsNoIjN
         K0PKvFYnOdua8xtdsLdS1JkL6QpLiVA0E9Z/U5hqR+hgodoT/Xs8S3ytvfcBcqpgoanf
         9yHROA7vkNeZ2XxyHbbwa+TTTJST6AvXvq8q5N4NNnJJZp44cj7nabNUcZPN8xXnCap2
         XYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zIcfFT367IDJKZN6LRt8pfpB8CHdlGVvwi8FF8cmlqE=;
        b=kf8CwO8iIlQFrLgDIAp0iS2j1z2bJKbf/REfDWVeC+15dI5YHwKFsaCx9qUWD1v4hZ
         sx3GW7/ofMprWWvibqshvn4aarevrsLfqQIODKffoIzd/STJaY+WVeQtaHojthbsAxDW
         OnCCtdNngTXXukqWrfx4O5zDI0IYH6PgYExt6th7siieCs3rDbnOihyRkWi7B3ULIhIs
         ECjHIcSz6g5u+DNEfMUasWF5sJvuJZEnWvilQO2nALFnu491lbV3k4cJertg2cwk0kBU
         l2YhBCOYVqWwkNN1TWTFzxeMLrrafR43983XdqrI060dRA4/IyVgXqJn+hzokMnxO4mX
         PKFg==
X-Gm-Message-State: AOAM5323awBkwcfiutXw8cZvNZRPiqeyej9vvPM5k19f3J3ioAqtgwCZ
        ALWtkT6FgoA344tSDo1q2wQ=
X-Google-Smtp-Source: ABdhPJxcsOE2s0rFnIZgl+Sa10N/Ut0ywb8ZK3b91gu/P5l8yPJ2Qda18lMNFwU57IoUC81v2+gD3w==
X-Received: by 2002:a17:902:f1c2:b029:e4:6c23:489f with SMTP id e2-20020a170902f1c2b02900e46c23489fmr1785590plc.62.1615359147372;
        Tue, 09 Mar 2021 22:52:27 -0800 (PST)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id e11sm8191362pfm.24.2021.03.09.22.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 22:52:27 -0800 (PST)
From:   Yanwei Gao <gaoyanwei.tx@gmail.com>
To:     mortonm@chromium.org, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        Yanwei Gao <gaoyanwei.tx@gmail.com>
Subject: [PATCH] LSM: SafeSetID: Fix code specification by scripts/checkpatch.pl
Date:   Wed, 10 Mar 2021 06:52:12 +0000
Message-Id: <20210310065212.174567-1-gaoyanwei.tx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

First, the code is found to be irregular through checkpatch.pl.
Then I found break is really useless here.

Signed-off-by: Yanwei Gao <gaoyanwei.tx@gmail.com>
---
 security/safesetid/lsm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 8a176b6adbe5..1079c6d54784 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -125,7 +125,6 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	case CAP_SETGID:
 		/*
 		* If no policy applies to this task, allow the use of CAP_SETGID for
@@ -140,11 +139,9 @@ static int safesetid_security_capable(const struct cred *cred,
 		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
 			__kuid_val(cred->uid));
 		return -EPERM;
-		break;
 	default:
 		/* Error, the only capabilities were checking for is CAP_SETUID/GID */
 		return 0;
-		break;
 	}
 	return 0;
 }
-- 
2.27.0

