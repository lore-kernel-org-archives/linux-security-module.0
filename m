Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E4C2BB3F
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Nov 2023 16:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjKOQss (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Nov 2023 11:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOQss (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Nov 2023 11:48:48 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF25A6
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 08:48:44 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b6f4d8ddccso1579051b6e.0
        for <linux-security-module@vger.kernel.org>; Wed, 15 Nov 2023 08:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700066923; x=1700671723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTCtRmi3R6T0gzFTGbQDmRMBKPICk48rXlPZScrWm7A=;
        b=ZFK8uaGp/xtCZ8Rv/iu5M9M1xe7v3WtQyEstWb8HE66Pb31osYXOEk/kgJoD4n6Ndf
         0p/dh0S/vuhSjEljIeYwYjMup+pUD1sskLgZlu++reKD0+st4WeRIQJn5JTEHpwNz/sC
         iuzaFbZ9NbUyHbhfWYMkeIpoA7Hp2x8jDJb5anG7b72JnkMGCLdXHMCiYUxMkaRUZmKB
         Meypq/+J+VrpqwynTFpwoFWBUwyIQ433s3CmgxPYDMJ06vjpnk8YX9d/fWPwnpuTQoxC
         6/JdN49yfWumywTC+Btm+4YT/+I+DgXECxCEh7MOOcZrlKDJe98MNGqMKwYdUBffFCLo
         yIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066923; x=1700671723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTCtRmi3R6T0gzFTGbQDmRMBKPICk48rXlPZScrWm7A=;
        b=qCLDwQN6fRvs6231pgvHbB1DD2WCwtcPwjHXzjz+6Xx6kg62X8ISSJQYZIPiQds1t2
         b40qxIW6IkkFXg9Ng7Z3V8WBN9wpKcZ0ntErXekEBwX0qyVBCqGRPkZVDtRlgZCa90Pe
         oaobAJLQ5cW0qhf1wE7h+g9AlT9VJ+7HYR8S0qirDlAfFXoiwSBUoPUhRxsjQpopT6UK
         6djAppr/Kp8ExVbLlBq0cjNAae5RJSnZz7qj2YdEb45VLaAFL1ZbPEwe6lnrBJTJ35Xn
         4rDymhDbnVpenx2JCb5Nye9Us5kukUUPdEdid0Fl0MaKeOwh/GkussI5m8ZlKuv+oP2l
         +quw==
X-Gm-Message-State: AOJu0YxE2aFPoOlteLpWvMWgXa8/Zj06RCeKu3kNe3jPzHlF76Jw5APb
        XMRr0UE38Lk0XuyCgD0WNuJ+s/xUqyWVYubQ2g==
X-Google-Smtp-Source: AGHT+IHCf/xB7WdvUl39gjR3VRAmgBJUxhraD++XcyJzUpJwN1hZgl3CVjBQO4Ng1Pzq3jWxCRDenA==
X-Received: by 2002:aca:2214:0:b0:3a9:b9eb:998e with SMTP id b20-20020aca2214000000b003a9b9eb998emr11295964oic.51.1700066923448;
        Wed, 15 Nov 2023 08:48:43 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id rb18-20020a05620a8d1200b0077bc5299c85sm3590668qkn.124.2023.11.15.08.48.42
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:48:42 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update the LSM entry
Date:   Wed, 15 Nov 2023 11:48:33 -0500
Message-ID: <20231115164832.100894-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=paul@paul-moore.com; h=from:subject; bh=x2kNMPfETqnacBId+alqcYSStJDvNTLI9POSEAtMe2Q=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlVPZhBzZoI4tr0z0NmKJHEGp55rT+GB+FAlN+o NfhWDLSxh+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZVT2YQAKCRDqIPLalzeJ c7neD/4te9DsRQaKjTpTSTXupKePc1CRv3BfVBcKchOqI8OSnIqZf8wufKJ2aopromyg1WSy955 LZPyFwNnqFxT9/NvLvTd4yrdoKkUWsJgn8J5jhqiYTHTEcQa6mTj8bR5tBB4WPIxKvB9HWPfvpG GPrQC29DkhQ0miuruNL09u86n3d8UxVxayjfn3VvqlUyBDLjLvmfexs2/t5wNimTrg9TLA6sgjE 4Z/fy/+1tA8qloE+zlSqbi7W1kdyBTMgWoiAkd8HZKnB6r0GjUrGkTl7R7f0pA9sXX7tHhHkDji N3sKkoAyC/H0NMrw4JYzDK0w5XitheLveUKSN8+/JDSqU2FCndh52BABB7GUELgVgbiC0q+rP+I drQnoUnpfvuSI7cK8w4C0p1HWTMZrBYxu0faGzriiq5ss6MZb4lbveWXexvWusoT9Rfur3kmYos wXjxhK9GOPJeMvyDif/mRZJE0l32KyLk1dH+i5+6/PiebhK1nQG97+5JVHLyUZ55SRAcgtNO8yA A+EvZAZ+f0HfafKnaLyiZ6KD9OsZwVnWIz7xgykH2zFwCmEmwcRCKWkMQiC2AIEJWWr2+mqhIiD nnK2/O5lEG9/nRNXS0wLEg/sckU0/goa2YaSUKsy0BHTM2vu34ESfype4fXS5A3PoyJXkyqqzFW rs7rdrRXafNU8uQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Bring the LSM / "SECURITY SUBSYSTEM" entry up to date with the
following changes:

* Remove the "(suggested Cc:)" note on the mailing list.  I don't
really care if the LSM list is on the To: or Cc: line, I just want
folks to include it when appropriate.

* Remove the website link.  The website isn't really maintained in
any meaningful way so we're going to go ahead and remove it so we
lessen the chance of conflicting or confusing information in the
future.

* Add our patchwork link.  I'm not sure this is of much use for
anyone but the maintainer, but there is a provision for including it
here so we might as well include it.

* Add a bug report URI.  I suspect most everyone knows to send mail
to the mailing list if they hit a bug, but let's make it official.

* Add a link to the LSM tree process/management documentation.  While
the doc exists both in the canonical kernel.org location and the
GitHub mirror, provide a link to the mirror as GitHub does a better
job rendering the Markdown.

* Aside from changes to the LSM code itself, we also would like to be
notified when the LSMM call sites are changed so we are adding a
security_XXX(...) regex to try and catch all of the callers.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2482b40fd786..007e43ee3e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19507,14 +19507,17 @@ SECURITY SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
 M:	James Morris <jmorris@namei.org>
 M:	"Serge E. Hallyn" <serge@hallyn.com>
-L:	linux-security-module@vger.kernel.org (suggested Cc:)
+L:	linux-security-module@vger.kernel.org
 S:	Supported
-W:	http://kernsec.org/
+Q:	https://patchwork.kernel.org/project/linux-security-module/list
+B:	mailto:linux-security-module@vger.kernel.org
+P:	https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/uapi/linux/lsm.h
 F:	security/
 F:	tools/testing/selftests/lsm/
 X:	security/selinux/
+K:	\bsecurity_[a-z_0-9]\+\b
 
 SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
-- 
2.42.1

