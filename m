Return-Path: <SRS0=1TXC=3Y=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C1DC3524A
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Feb 2020 04:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FFF2086A
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Feb 2020 04:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9P02RW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDEEu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:04:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38708 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDEEu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 23:04:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so1810703wmj.3;
        Mon, 03 Feb 2020 20:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T86mG0bltjiPTMfNeP1GOcuNJTtwAcIRWIfAg+3wbfQ=;
        b=J9P02RW6Y4diY3q5hZmw8DyihPLh54rTCa88cyaE0GFWGYu9sZf0TeOh4Qxyeb8BMO
         +s6h5ZYt524Es6UeBcRmBKLWZzGF72TMyXyoo8qZ2WjCT9zNpEglZ6uHsXgN2bV0wqF4
         aOGIPrOv/IrXDwsnPy1qX7UhVHCvckX9iSIL5RARnNfHEIISv1DHTOFvkODI90WMTTQz
         LLg/E0BanSUXMq3terW3K7I85yLvGz15P+3ozEiGOrd1IwwpufQJZPOo+4ja08EC4DXq
         hE64rm17+Qaxw23NhOu0RjOZKfwev34V+BtbhP5LNOlYjO6hGspEVlGmkEsREgLAax3b
         PH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T86mG0bltjiPTMfNeP1GOcuNJTtwAcIRWIfAg+3wbfQ=;
        b=moTauuhSH6lquUIlzqvILpc31RGKyK+x6RsTTiS5jlpjIqS4dN8Hhj9Fu13u2tKOY9
         eoRMeaW8JiW8GV/1Nrje0FfJJsLInfTerU0zDG0TBK+z2UNGuCvlnS7R41DFAXqoP4FT
         warhbsXs+1B3gVWthODHW2ZZQFbhdaBTN+3eW09l3PMmE414fm2MnvjjZsmcNU0bBOxK
         9Y+yjHAgGCvcJSoS7r3bdTJZ1NS6WoEYue8ZXZp6EOq8bZkmVTJsVoMW7UvDFRFPJUnm
         WUwix3SNklLrSnADLDV90XQJVIqDGo0n4AaUf+qpx1STq+Qa0LK7RGFPF6v88kWbkNWw
         JLpw==
X-Gm-Message-State: APjAAAUKjrJ9Oz09GtlcQQ9KX3RFIDsxKR+piuFdTc5lrAIU0U+GPRpT
        hZeo4DpkvSzvx+dYiG0HNcc=
X-Google-Smtp-Source: APXvYqy3zZLu0ZuoHgUuoiFa0e/pa0wnDN4n9oVpraD2cQHHCy2xseb2CJdY42n/cf6BN8oyJoRZyA==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr2990359wme.59.1580789087566;
        Mon, 03 Feb 2020 20:04:47 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2daa:dc00:2c0a:8928:125e:2b0f])
        by smtp.gmail.com with ESMTPSA id z19sm1914623wmi.35.2020.02.03.20.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 20:04:46 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Micah Morton <mortonm@chromium.org>
Cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH SECOND RESEND] MAINTAINERS: fix style in SAFESETID SECURITY MODULE
Date:   Tue,  4 Feb 2020 05:04:34 +0100
Message-Id: <20200204040434.7173-1-lukas.bulwahn@gmail.com>
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
applies cleanly on current master and next-20200203
Micah, please pick this patch.

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f77fb8cdde3..83c7879aa4b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14578,10 +14578,10 @@ F:	drivers/media/pci/saa7146/
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

