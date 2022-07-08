Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034EC43334
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Jul 2022 20:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbiGHUfE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiGHUeu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Jul 2022 16:34:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24CC07
        for <linux-security-module@vger.kernel.org>; Fri,  8 Jul 2022 13:34:48 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bs20so29065557qtb.11
        for <linux-security-module@vger.kernel.org>; Fri, 08 Jul 2022 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=P+NDxjG5p2WkS1OKQANMTohazWEYMgQmzwlveXW4yO4=;
        b=Ykh3UzosympJSsfRNakZcuq0tKTV7KfNTQ21GsiIbkivfC13BMwRhRByw7/D8YXZj+
         uYESzSmSXFlwCi3PsSVMBru6VWRzuGsIOqPtCt4OhUFkSYCBwjskJyaX7c+j3ri3Envc
         JaH/X9Lf7SG1llyve20QMwxKKWcJRRq3LfmqDk0z73rDaWvCuAld2iRjSrRqGiT4ZuhL
         7XXihttQBRZmDyCF3qYTNKF0aRTXXjkJbGbTLhIjy9KESZlf37Us5yDcbq9D5bsfI05i
         MQEScKWtCNHVig92IzShqTCIj/e7vpDMvRBhlpFSW5n3aEK5aazXDwYLSfW2cicML8f7
         C8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=P+NDxjG5p2WkS1OKQANMTohazWEYMgQmzwlveXW4yO4=;
        b=RUYlYgl7RqHXx5SLH551OR1cKHGRsU1l7VZFUV8LfXx64AuWrsdUxaAYWRNe0bDr6+
         pdXc0UmvgbOgQuzIuRwBnGWJxKTGU9Xf85LkJ6nf0KnUKuTCOkqBV2Lj3Gwdv4Gajv1F
         kKosZ8jDjt8XAYsPDoy//HFTN5wl1FMY+paMrZ9RDDHOprKqqC2g0YItmi7BA+fu/ssG
         v8rVfla3GARB8vBbG0KB5TxWy7MQXeMsvDDYT8icakXuEF2bw5BByqpNbIvqCtB3vGAb
         ndj0sIw24oq67CdfiWmTyDyA6KRB7nEfd+yueoeLwdVpxoY711reUuy608sbavL4GgWd
         du1Q==
X-Gm-Message-State: AJIora9jgN3HIQT00U9CoLyU/dldhdytLCD7DKOeb6QQIQxSTYkgAv4I
        BXo20K0RARBBEpIiToLndkbZnLFUVN8Q
X-Google-Smtp-Source: AGRyM1vxP3FAS302jDpSAKhigDDkl4dzsYeCt/JQmL1Dj3n28t1kl+rbyHhSpEdnRzID3r+yPe+QPw==
X-Received: by 2002:a05:6214:e87:b0:473:129e:224a with SMTP id hf7-20020a0562140e8700b00473129e224amr4354896qvb.29.1657312487098;
        Fri, 08 Jul 2022 13:34:47 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id dt42-20020a05620a47aa00b006b55df40976sm3550069qkb.27.2022.07.08.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:34:46 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: update the LSM maintainer info
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Date:   Fri, 08 Jul 2022 16:34:46 -0400
Message-ID: <165731248606.335227.15503387932450699761.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

After many years of shepherding the LSM layer, and Linux kernel
access control in general, James has decided to take a small step
away from his technical role and has asked me to assume the
day-to-day maintenance tasks for the LSM.  This patch makes the
necessary updates to the MAINTAINERS file.

Thanks for all you patience and stewardship over the years James,
I promise to do my best not to screw it all up :)

Cc: linux-security-module@vger.kernel.org
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..5c7c5d04b99d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17909,12 +17909,13 @@ S:	Supported
 F:	Documentation/admin-guide/security-bugs.rst
 
 SECURITY SUBSYSTEM
+M:	Paul Moore <paul@paul-moore.com>
 M:	James Morris <jmorris@namei.org>
 M:	"Serge E. Hallyn" <serge@hallyn.com>
 L:	linux-security-module@vger.kernel.org (suggested Cc:)
 S:	Supported
 W:	http://kernsec.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	security/
 X:	security/selinux/
 

