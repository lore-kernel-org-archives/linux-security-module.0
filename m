Return-Path: <SRS0=B56X=3F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D0CC33CB6
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jan 2020 18:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7102077B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jan 2020 18:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPGCKqX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbgAPS7Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:59:16 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39397 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388966AbgAPS7P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jan 2020 13:59:15 -0500
Received: by mail-wr1-f47.google.com with SMTP id y11so20278849wrt.6;
        Thu, 16 Jan 2020 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2DWGq5gFkTQz9Z549OauU3Snuf7YD40/bBF5v2Ql2zI=;
        b=FPGCKqX8kIQmBKqhTOE7gZhpo0QuSqWtC+dsBEgOG4E7mC53Z+oSsmnmea0gX5KtBa
         x13xSnB5MFoQRcweDldi6GH/tXwG13MC70BJ99ln5HLxKodLzQtFRtGEF+BRKTTp38vC
         D2+p7XWDwpMH9ow/nXhBj+agKPHm6eAxYFOheFPbageZxC5nn4M+YkjlROPwkwcjjxKW
         la3wIBzi8kfv9ZgxXqmeq0fFxAG1Dr+iJjDuzppPEH8MD43TcYBbIBruUTItQ92hj9LJ
         fVfigSkyjIoezbBZ3l372/nK0FTMFpdqG90aERrWS4U86uy2FreCmFsS9E0pd6W9RZXV
         GeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2DWGq5gFkTQz9Z549OauU3Snuf7YD40/bBF5v2Ql2zI=;
        b=ffmGQO8D+Crg7hP+3El5oN73ZkSDP90FsEgbgaKmOvPA/uNL61rfmcpHaR9sK+9PdW
         3lLVHg4hv7DoS+1kqK3Bvq0XWyQEc/rGAlkI08HEegnj1B9rS3AQ3MCSUUowrKjKJg0K
         iqETcPn3mlwXq3W1KCZ71BgFSxoYgBgXeG7cAW2MTXv+z1vcZPGfMOUW61w9oHmDI0h5
         uoqWXGo5zOW1jAgGtEoJHTh5VEUcBssyk5jDAWDol33xm5UID+1tM80xYliDiAFucAAi
         wRGAtOrTl/fKBncfwsV4EEJQFlrvIiz8SpCSvkQXXzLQQSmphkcyEL8tRsQhSxc1WRR1
         9H1Q==
X-Gm-Message-State: APjAAAWc0n6Akm1Df2Nerqv218E/IrWszqg9qssBbkNKOUVp5OqAEPD8
        qxSm6eloNAurYtMAFZMwcto=
X-Google-Smtp-Source: APXvYqzYjPgwGGI5+FIdKtuP92i9axf1hPbcu9ABihedq39Srwjpw3NK58jyqgqVSEltCvdwE6yY/A==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr4863743wrn.146.1579201153435;
        Thu, 16 Jan 2020 10:59:13 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dbe:4a00:e092:254d:41ed:2e49])
        by smtp.gmail.com with ESMTPSA id f207sm974443wme.9.2020.01.16.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:59:13 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Micah Morton <mortonm@chromium.org>
Cc:     Joe Perches <joe@perches.com>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: fix style in SAFESETID SECURITY MODULE
Date:   Thu, 16 Jan 2020 19:58:44 +0100
Message-Id: <20200116185844.11201-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit fc5b34a35458 ("Add entry in MAINTAINERS file for SafeSetID LSM")
slips in some formatting with spaces instead of tabs, which
./scripts/checkpatch.pl -f MAINTAINERS complains about:

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14394: FILE: MAINTAINERS:14394:
  +M:     Micah Morton <mortonm@chromium.org>

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14395: FILE: MAINTAINERS:14395:
  +S:     Supported

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14396: FILE: MAINTAINERS:14396:
  +F:     security/safesetid/

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14397: FILE: MAINTAINERS:14397:
  +F:     Documentation/admin-guide/LSM/SafeSetID.rst

Fixes: fc5b34a35458 ("Add entry in MAINTAINERS file for SafeSetID LSM")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.5-rc6 and next-20200116
Micah, please pick this patch.

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a66cb722c675..d2aa9db61ab6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14415,10 +14415,10 @@ F:	drivers/media/pci/saa7146/
 F:	include/media/drv-intf/saa7146*
 
 SAFESETID SECURITY MODULE
-M:     Micah Morton <mortonm@chromium.org>
-S:     Supported
-F:     security/safesetid/
-F:     Documentation/admin-guide/LSM/SafeSetID.rst
+M:	Micah Morton <mortonm@chromium.org>
+S:	Supported
+F:	security/safesetid/
+F:	Documentation/admin-guide/LSM/SafeSetID.rst
 
 SAMSUNG AUDIO (ASoC) DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-- 
2.17.1

