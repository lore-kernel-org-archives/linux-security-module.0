Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C886C636CC
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Feb 2023 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBPUHh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPUHh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 15:07:37 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63350340
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 12:07:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id dz21so7196571edb.13
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 12:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pv7j9p6MjWsD65462TqTWWfykNMkU8jl2uC1dMR7wZw=;
        b=AwFOXMrlc4jyJg4Kor/8afZsT53a3dnAeCr15TjM3GP40ZZVmrUTRabEk8r7WMwka6
         aMNl+5kp/UGtYmW48qwp72lqXCY/lX/X9jY8Gb+arIibSjcZ2xV6ThA+/2DsX78c4noG
         AiUcW8y8aLXfrc6UAHIOrSiJhTczWfgRXyydB1UXyehlCPDCW6T3Lu2OvyscM67yPEUN
         +76DCgQ2mEPeGosGL6jlB4xBfukfrg4E47WcBXt3PIFtUEibeyXsAYZGoHlXcC+W8JOY
         NHvpNqgIpw82zpwwhc40okI9T91uI23cCHEng+QkHv4Pi1/0IauDfFxNpo3dSarDbhG2
         IHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pv7j9p6MjWsD65462TqTWWfykNMkU8jl2uC1dMR7wZw=;
        b=bAP235Y26w/okFOG21nSs06fX49uXGxzDKTaRChI192meKgbd2hizm58ScBB9xo54m
         vObcGn78dIuaEFRcJOzQyRdAD/0Ocr1++OdO9y/QBEHlX4164oWhUfgimZMuk7v4c4nU
         y3NOlZbiVov80aH6mxske1eI++Bt+30ArJVhmemGuPSLxCu04uMjA6uXKKwuK2oORlU2
         iNrFL9ohBoQeUrDuJpccU9KegoXH1LvKM+aujeYlQrMYBTTMUSZv8Ctl2XdT1LU1t9Eu
         zo+rfPSN13mgShzs3jPe1zmTKxaGBmG/YFoBPpoQFdZ37ER0V4g+C8b0iNXsgPJblyDl
         Se2Q==
X-Gm-Message-State: AO0yUKW4pUX8P/IJJ+R55kiyx9AHqndRj6jLKJZXjdKCNIhsJdT2Uzf8
        DOXudI0p9xBIKJOO3pHV8C4=
X-Google-Smtp-Source: AK7set9K4zCuBPn3QTfivWKSUgoQteX05pzyLg2mZld0iWla2sENvG45gQX+WKkBhyhVYpyAUaG2nQ==
X-Received: by 2002:a17:906:ae50:b0:878:8249:bef6 with SMTP id lf16-20020a170906ae5000b008788249bef6mr7960779ejb.59.1676578054487;
        Thu, 16 Feb 2023 12:07:34 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id ke27-20020a17090798fb00b008b12b9c6c49sm1174247ejc.125.2023.02.16.12.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:07:34 -0800 (PST)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3] landlock: Clarify documentation for the LANDLOCK_ACCESS_FS_REFER right
Date:   Thu, 16 Feb 2023 21:07:29 +0100
Message-Id: <20230216200729.12438-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Clarify the "refer" documentation by splitting up a big paragraph of text.

- Call out specifically that the denial by default applies to ABI v1 as well.
- Turn the three additional constraints for link/rename operations
  into bullet points, to give it more structure.

Includes wording and semantics corrections by Mickaël Salaün.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h | 45 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f3223f96469..e549ad6360b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -130,21 +130,36 @@ struct landlock_path_beneath_attr {
  * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create (or rename or link) a block device.
  * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create (or rename or link) a symbolic link.
  * - %LANDLOCK_ACCESS_FS_REFER: Link or rename a file from or to a different
- *   directory (i.e. reparent a file hierarchy).  This access right is
- *   available since the second version of the Landlock ABI.  This is also the
- *   only access right which is always considered handled by any ruleset in
- *   such a way that reparenting a file hierarchy is always denied by default.
- *   To avoid privilege escalation, it is not enough to add a rule with this
- *   access right.  When linking or renaming a file, the destination directory
- *   hierarchy must also always have the same or a superset of restrictions of
- *   the source hierarchy.  If it is not the case, or if the domain doesn't
- *   handle this access right, such actions are denied by default with errno
- *   set to ``EXDEV``.  Linking also requires a ``LANDLOCK_ACCESS_FS_MAKE_*``
- *   access right on the destination directory, and renaming also requires a
- *   ``LANDLOCK_ACCESS_FS_REMOVE_*`` access right on the source's (file or
- *   directory) parent.  Otherwise, such actions are denied with errno set to
- *   ``EACCES``.  The ``EACCES`` errno prevails over ``EXDEV`` to let user space
- *   efficiently deal with an unrecoverable error.
+ *   directory (i.e. reparent a file hierarchy).
+ *
+ *   This access right is available since the second version of the Landlock
+ *   ABI.  This is also the only access right which is implicitly handled by any
+ *   ruleset, even if the right is not specified at the time of creating the
+ *   ruleset.  So, by default, Landlock will deny linking and reparenting files
+ *   between different directories, and will only grant this right when it is
+ *   explicitly permitted for a directory by adding a rule.
+ *
+ *   When using the first Landlock ABI version, Landlock will always deny the
+ *   reparenting of files between different directories.
+ *
+ *   In addition to the source and destination directories having the
+ *   %LANDLOCK_ACCESS_FS_REFER access right, the attempted link or rename
+ *   operation must meet the following constraints:
+ *
+ *   * The reparented file may not gain more access rights in the destination
+ *     directory than it previously had in the source directory.  If this is
+ *     attempted, the operation results in an ``EXDEV`` error.
+ *
+ *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for the
+ *     respective file type must be granted for the destination directory.
+ *     Otherwise, the operation results in an ``EACCES`` error.
+ *
+ *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
+ *     respective file type must be granted for the source directory.  Otherwise,
+ *     the operation results in an ``EACCES`` error.
+ *
+ *   If multiple requirements are not met, the ``EACCES`` error code takes
+ *   precedence over ``EXDEV``.
  *
  * .. warning::
  *

base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
-- 
2.39.1

