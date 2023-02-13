Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8284CC636CC
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Feb 2023 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBMVBY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBMVBX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Feb 2023 16:01:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006CB211CD
        for <linux-security-module@vger.kernel.org>; Mon, 13 Feb 2023 13:01:21 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ml19so35204692ejb.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Feb 2023 13:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUiAm2l/6Zb3xl0Ks2w1uYwOE0O5dcUh8agCC8Bje1Q=;
        b=NzjhVAOu+afAEZB90x+fDNR6Tuj4zHll+IlALeTU1HCBPQR9tx8GPCtj2MTnxVo+sh
         ibZEkN2lvVZsZuT4Julva6pIA95NSwmfqZvaDNhQPXXituXn8xwcK5A8ybE8FGZBLBvA
         JNEbuYN5SIqK3U2SDP/zocM0OWjsgo6s8Qm5BvhTSi6fHyBr/85vim2wfxUlhmaWd5Q9
         U7JpEJfb4Wp1Gp4/V+jwkb+EknWgTSvmSR+TIFXiZ54NSkQWMMhv4lt9IiqBqLwzZZWi
         hVbBaXpfEjgOaM1t3feLXqp10nKJC48WvQqUIlK3ZCbjseQWSv4a0xIo6k6HCgom/+eV
         WtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUiAm2l/6Zb3xl0Ks2w1uYwOE0O5dcUh8agCC8Bje1Q=;
        b=DsX8kvZ+GwxKppy7CBU7HCu3n2Kxpyo7Cy1JkTgBgAybV27z+MpmjRsGBvBEH7HGAO
         Jmnyf2v5iyfQs0ykJwUzQZMZplLWAQOGKA0xys4CZbMPYyyJhWxKL1wpvvlgyKPnW61k
         Qpdg6GH5Oepuo8iUwVq+Spmw0SqxXJvyet/A+/cA8RiR/IKsUVqVsX5sq1M6vYRywNNB
         FRk9wzIInNQizUNl8rXqnNXtJzfvWIB8i/vmLJhqZRQxkY4jwpufwZyCDwQ6rNsSYHAc
         1hBwQjbiBLQk/gOqzOh9q/Jf8So3CdgQFsOGtZ7jPEZGpGDdfjp5XwjkvYf/yXNoyj5Q
         iv6g==
X-Gm-Message-State: AO0yUKUb19DxutSfB2JGf+rbV5C46+GsNu8i4CiSakRohnG52Enk4ulE
        gqJ8R3VjBtVn9xy5pKh5Kjc=
X-Google-Smtp-Source: AK7set+8bHNqOCaavadUOwmukdZ9rNY2AkSNYr0vaXfYQOoxyVL6ydzDsxFRxlIbJskNJPMXmFGHWg==
X-Received: by 2002:a17:906:9ac8:b0:8b1:29ed:e206 with SMTP id ah8-20020a1709069ac800b008b129ede206mr308816ejc.28.1676322080551;
        Mon, 13 Feb 2023 13:01:20 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id y24-20020a17090668d800b00878130e170bsm7213848ejr.131.2023.02.13.13.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:01:19 -0800 (PST)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2] landlock: Clarify documentation for the LANDLOCK_ACCESS_FS_REFER right
Date:   Mon, 13 Feb 2023 22:01:15 +0100
Message-Id: <20230213210115.5150-1-gnoack3000@gmail.com>
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
 include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f3223f96469..f6bccd87aa0 100644
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
+ *   forbidden, which is also the case when using the first Landlock ABI.
+ *
+ *   In addition to permitting this access right, the following constraints
+ *   must hold for the access rights on the source and destination directory:
+ *
+ *   * The destination directory may not grant any access rights which are
+ *     forbidden for the source file. Otherwise, the operation results in an
+ *     ``EXDEV`` error.
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

base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
-- 
2.39.1

