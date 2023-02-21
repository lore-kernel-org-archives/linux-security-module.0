Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7AC636D7
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Feb 2023 16:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjBUQwQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjBUQwP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Feb 2023 11:52:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C22CC5F;
        Tue, 21 Feb 2023 08:52:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k37so764326wms.0;
        Tue, 21 Feb 2023 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzis0Bciaa3Y7LYjvE8aSfC0aoJCUi4Vc/8GrLyMyF8=;
        b=eeFr+iA6heQSSLBUeZYbuUtu/SEztMCCHq/nvBCeNm1vShLuvneU3py1DFwTSgiqTM
         kxgXoz49k18kp//rEoXlTmLXoCOgftzWh5hT+u2E5FXEsrCTDV4PcTW+tzwAMCqrPsyA
         d2rEb3P10cWFY0VL2vFlk/O0i8O8Jm7kroGWQe7o1+IanuaJ+r/PCigASESU4RQyDOvx
         08bi1A7dhy1P6h9BN8IJRh7Hhq9fPa0f181f8w62k8scoOyoFO7X+7n2BO9pT/6DdN3p
         MXa+Syfjoz/g4b0QSKiPc83/6U4BMF+nPP4XcKiCOtBoXfAcC1VNX28tJsLt2IXM2Fnh
         5lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zzis0Bciaa3Y7LYjvE8aSfC0aoJCUi4Vc/8GrLyMyF8=;
        b=TWYOl1AwuNrt1/pcmtagPeBPy9iZB7cbHN0Gpu5Hn1Ct/t7zJ7eOz7OIxdJe7/xEfm
         wXvjyWUVRn/gfkgY/ykfvU7ke4NDObyR6Lxto4+yDzJzGdstnt8OxWW4z6kJXI2q2yrk
         qyYW9/ytYdyQ9+OX55FQWhrkDzUcBPBovRbZqVXrOc77BQoHkv1SECPZ30hIYAkIzyaW
         uoq2BvF04n4ip+rLjp70v3+4w+f/eYju5ewfeCfpgiIDPLc6r+c3e1NXJkupRSerT09w
         RJ+B7NgHT9w/w92BJEcXxs7Y5VXLYLNZ+pLwIBVn2UnHnIUdtiQQugLoiupyZUmt2pig
         WXzA==
X-Gm-Message-State: AO0yUKUiCLeeknsUaZUf/G0Pmm0fdQIvYr9ABTLRwtmPgmwJPENVxEc1
        q322k4/jNyITVH46FpfXu+lTZWRkv4k=
X-Google-Smtp-Source: AK7set/1YQqeQVqQ2DwUPIZlD3K/y6yN2zBSZCePOvw0fGQ0HeJRXq5cxOJDpqL8zavotiiu07bnFg==
X-Received: by 2002:a05:600c:164a:b0:3e2:20c7:6556 with SMTP id o10-20020a05600c164a00b003e220c76556mr10896079wmn.35.1676998328986;
        Tue, 21 Feb 2023 08:52:08 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id r26-20020a05600c2f1a00b003db0bb81b6asm4447172wmn.1.2023.02.21.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:52:08 -0800 (PST)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v4] landlock: Clarify documentation for the LANDLOCK_ACCESS_FS_REFER right
Date:   Tue, 21 Feb 2023 17:52:05 +0100
Message-Id: <20230221165205.4231-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Clarify the "refer" documentation by splitting up a big paragraph of text.

- Call out specifically that the denial by default applies to ABI v1 as well.
- Turn the three additional constraints for link/rename operations
  into bullet points, to give it more structure.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h | 46 +++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f3223f96469..81d09ef9aa5 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -130,21 +130,37 @@ struct landlock_path_beneath_attr {
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
+ *   ABI.
+ *
+ *   This is the only access right which is denied by default by any ruleset,
+ *   even if the right is not specified as handled at ruleset creation time.
+ *   The only way to make a ruleset grant this right is to explicitly allow it
+ *   for a specific directory by adding a matching rule to the ruleset.
+ *
+ *   In particular, when using the first Landlock ABI version, Landlock will
+ *   always deny attempts to reparent files between different directories.
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

base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.39.2

