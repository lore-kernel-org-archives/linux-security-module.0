Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227BC4167B
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E686238E8
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgLGQeb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbgLGQe2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5e7kjkHucInmY6VdK0kaV1CkQzCu8JkZBTGnROzaxRs=;
        b=efO5smXbSmGkDHPtHdXGDxi7xQ0d2oYYka3vzlPsFBfs7zPRbg6BqHDVANyqhN/XH3Cdps
        3vKokKRWC/nqlkcLIxjNK8+027qpyrA/3W9HRABFt1B1YQk1aydsqvBFDBzPgPhdQ96Dpn
        W/h546rP6+w5izFCAB/0tIwYzXYaXqI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-eCqcMezTO1aGlx3U6fy91A-1; Mon, 07 Dec 2020 11:33:00 -0500
X-MC-Unique: eCqcMezTO1aGlx3U6fy91A-1
Received: by mail-ed1-f70.google.com with SMTP id c24so6004967edx.2
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5e7kjkHucInmY6VdK0kaV1CkQzCu8JkZBTGnROzaxRs=;
        b=opOslxVuy6dUiusdZCMhb1f85kkohGyZVYXdde0YrFVkwR4Wrs/H5SCn6JfzLcPJ4I
         cPBOZdS3LQcusiNdmYdDAx4WHynpFN7uHbaug6J5UvRI+Mn78EJsojk2+8XORGOpXE75
         5iNxfxkYPiCkBrujhzXyDgRMf2jFDFeOeoaUBpegplT7+7gv9h0sLJQZV+cwdafcKOhY
         +v0bILSLfhyKA8CxDChrjTGAbyCRi/bSWIyiS/LO6XRL/otjR/fzuq37+ZyGMVRxPsAO
         qHTCWX9VB7qcvdG1WsDEgSzh8oEXqNo0FU+EMY5Dwom/zrFI8G9wi6imvToOaQaovPI6
         Q6Xw==
X-Gm-Message-State: AOAM533cu6G5s4f5z/b5/QdxdXDClgy8H9eAAbuWgb3wPMFSYz6nLk2J
        dfdDSZacg19RIWW3aJA+9QuWMyS3brlwJwbuhY6sLOfHkqsOX69pZpTUGqK6U2xTqkT1dM22/Ph
        KPwp/AW5S/YunnHB7o/5R/NAnDqUD6jJj9B1U
X-Received: by 2002:a50:9991:: with SMTP id m17mr20534897edb.48.1607358779668;
        Mon, 07 Dec 2020 08:32:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyiWs/rTwHaBsh/+l8c/SlsiYGPKleuSTJhMPZmdQ1Awha2DjwFfkQcPHng6uKbXr0raglUg==
X-Received: by 2002:a50:9991:: with SMTP id m17mr20534881edb.48.1607358779439;
        Mon, 07 Dec 2020 08:32:59 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:32:58 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 00/10] allow unprivileged overlay mounts
Date:   Mon,  7 Dec 2020 17:32:45 +0100
Message-Id: <20201207163255.564116-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I've done some more work to verify that unprivileged mount of overlayfs is
safe.

One thing I did is to basically audit all function calls made by overlayfs
to see if it's normally called with any checks and whether overlayfs calls
it with the same (permission and other) checks.

Some of this work has already made it into 5.8 and this series contains
more fixes.

A general observation is that overlayfs does not call security_path_*()
hooks on the underlying fs.  I don't see this as a problem, because a
simple bind mount done inside a private mount namespace also defeats the
path based security checks.  Maybe I'm missing something here, so I'm
interested in comments from AppArmor and Tomoyo developers.

Eric, do you have thought about what to look for with respect to
unprivileged mount safety and whether you think this is ready for upstream?

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-unpriv-v2

Thanks,
Miklos


Miklos Szeredi (10):
  vfs: move cap_convert_nscap() call into vfs_setxattr()
  vfs: verify source area in vfs_dedupe_file_range_one()
  ovl: check privs before decoding file handle
  ovl: make ioctl() safe
  ovl: simplify file splice
  ovl: user xattr
  ovl: do not fail when setting origin xattr
  ovl: do not fail because of O_NOATIME
  ovl: do not get metacopy for userxattr
  ovl: unprivieged mounts

 fs/overlayfs/copy_up.c     |   3 +-
 fs/overlayfs/file.c        | 126 +++----------------------------------
 fs/overlayfs/inode.c       |  10 ++-
 fs/overlayfs/namei.c       |   3 +
 fs/overlayfs/overlayfs.h   |   8 ++-
 fs/overlayfs/ovl_entry.h   |   1 +
 fs/overlayfs/super.c       |  56 +++++++++++++++--
 fs/overlayfs/util.c        |  12 +++-
 fs/remap_range.c           |  10 ++-
 fs/xattr.c                 |  17 +++--
 include/linux/capability.h |   2 +-
 security/commoncap.c       |   3 +-
 12 files changed, 110 insertions(+), 141 deletions(-)

-- 
2.26.2

