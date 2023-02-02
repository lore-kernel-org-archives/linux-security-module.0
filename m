Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335EBC05027
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Feb 2023 20:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjBBUrZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjBBUrF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Feb 2023 15:47:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB786E9B
        for <linux-security-module@vger.kernel.org>; Thu,  2 Feb 2023 12:46:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q19so3327352edd.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Feb 2023 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSmb6nChvUGXTjO54x/CLHY0j3czLgx8qRJeHGayAv0=;
        b=dgUjDmhZL0FDPqyn7DGIAJ+Kf9H4G5l2kyy49TfvjQdtgyAnr/mWRGMsgvYABr/8j6
         OoupmTvfz43PWL7sajT0ZLM8Unj+aHw2xvtefdUsLv63zl5T10CvQVg6UUrZ/dCoabJ5
         aNBrZLw7Ala09DjBb9FzBcDYadfrtrsazkMSafRq4SIoC5qsF2+SVYXYXOaYRO1vmDhr
         Eaxjil4BmqMD1/0fjHq8H3qka2itB1YkhWaAFW12gKXyW3SRLR7xkG4cKbYzH3J+CCCs
         yuydGP9uJnXhJ4QoIoZsH3j7jSsA0Loy6UewlQVCQvk/TxKpXZbizEuCkywdD+f5zm/G
         qm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSmb6nChvUGXTjO54x/CLHY0j3czLgx8qRJeHGayAv0=;
        b=Nhxq2A8K/7L9Y5Hnpt1FQS8wty+4Vxs7bf4g0p6og4O7kZAlD6mbodh0QWuaDy35cf
         m0LJZDnMnhdaOrCcZ6dkQh/hOfFl9MeBvaieHxdx1nUFH1ZKq/0OIEa4hQ+WPFIsWo7H
         pvoXXqNmXORfd4lsYdJ3Zj5Tq6zcSFG+xtC93JRuFC4ZdYndLh7E+5LwfcV7Jj1PRlX5
         ZotZa95aXysR/Lf7fs023hBJskGpBgHFcISxuOtNcuDfw7QW9gaxLgCtiWQ2aP+iW6gt
         UaKVoQ57SBCdG2BW66ycxeXnb03kwYAqw3OYpKR4eUFPD7RAsNMoH5Zq3XXXduFgEFY1
         pV4A==
X-Gm-Message-State: AO0yUKVImPgnsgGqku7WqiJpJ+pMIfW3sqP7NnmlKVLaCv7eGtx2kjon
        bM0B/0EwmgGEpvgzjw4kF5FRavsG35Y=
X-Google-Smtp-Source: AK7set/qYwmiz1rioD1CF9ZS3mA0GRrkWLLl5WeD9c3QuRRpitwxCwtjSinPMwnXCN1rEAtM9p3DzQ==
X-Received: by 2002:a50:e718:0:b0:499:d208:e8f4 with SMTP id a24-20020a50e718000000b00499d208e8f4mr7861806edn.19.1675370787105;
        Thu, 02 Feb 2023 12:46:27 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:485:9427:753:83a])
        by smtp.gmail.com with ESMTPSA id o11-20020a056402444b00b00495f4535a33sm190575edb.74.2023.02.02.12.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 12:46:26 -0800 (PST)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH] landlock: Clarify documentation for the LANDLOCK_ACCESS_FS_REFER right
Date:   Thu,  2 Feb 2023 21:46:23 +0100
Message-Id: <20230202204623.10345-1-gnoack3000@gmail.com>
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

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f3223f96469..0cc58e0361f 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -130,21 +130,32 @@ struct landlock_path_beneath_attr {
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
+ *   ABI.  This is also the only access right which is always considered
+ *   handled by any ruleset in such a way that reparenting a file hierarchy is
+ *   always denied by default.  If left unspecified during the creation of a
+ *   ruleset, linking and renaming files between different directories will be
+ *   forbidden, also when done on a kernel using Landlock ABI v1.
+ *
+ *   In addition to permitting this access right, the following constraints
+ *   must hold for the access rights on the source and destination directory:
+ *
+ *   * The destination directory may not grant any access rights which are
+ *     forbidden in the source directory.  Otherwise, the operation results in
+ *     an ``EXDEV`` error.
+ *
+ *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for
+ *     the respective file type is required in the destination directory.
+ *     Otherwise, the operation results in an ``EACCES`` error.
+ *
+ *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
+ *     respective file type is required in the source directory.  Otherwise,
+ *     the operation results in an ``EACCES`` error.
+ *
+ *   If multiple requirements are not met, the ``EACCES`` error code takes
+ *   precedence over ``EXDEV``.
  *
  * .. warning::
  *

base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
-- 
2.39.1

