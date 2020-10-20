Return-Path: <SRS0=DeF5=D3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B2C388F2
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Oct 2020 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E1320704
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Oct 2020 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="fpmWyaUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbgJTTRq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390847AbgJTTRq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Oct 2020 15:17:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91483C0613CE
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2020 12:17:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hk7so1465511pjb.2
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2020 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40suxBClyF8Di6DQt+UKjev7N9m+bLbT6C7IbLRaEmQ=;
        b=fpmWyaUCWWlb0Awn430c7GHDpZ4SNJ6+4xMApF0LtG5+rMmk6wV4PJR3pKTF3HhdvP
         /sRGVLnLXB54irACy7tkB1KrtKROemnUVp5kSRGLfS/vJTebcTp0ygQolXx/wUu7z9do
         zNOS9LmbOWmQEt+GXUE+Zp7qNGGDwU1LFzOWbLtyA9BZl5xeayTWp62ZajOQxZtjZl40
         sNbZ5yenLsRqO+4fymtQq1u3vh+NUShe7xqrL7OoRzd3jVzsUDvmffwhMbutRatu8rhz
         1+Ondnllvy/J2F8MyZUL8D61nERasqAOfalUXz5KqvmUfhqYFe0tnrVXkl1EIUizfed8
         ax/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40suxBClyF8Di6DQt+UKjev7N9m+bLbT6C7IbLRaEmQ=;
        b=bWuQ46N4Zdv1JJ4lzvDnsatOQFPYnxJ/TekWcjbsyHZwm2fVamFfS1txdzuxv9DXPl
         tH1gs/yrx7hWuOpstpXbA6RGEvOkFDdPc0nEa6pqLPwIDKF6vgVh4YIOw5q3AMRoNnZW
         An4iTsN5Mu9ON8rfzrgCUqXoANuhGF/qTL87jXCExibg8sH4S6jB5aULzsk6lYfdb7Z5
         pfpn3GmYRVa4rUVXl0iWkZZkh1uRrWMEPR1IrR3EG606Gwo792qrI5ZZBY0b67vKP1Rw
         EeRHNwUNZWUQClbubYeI5EsB03S8JCcqY/xctS5JQnXimscSNRmbDeS2NXRJRAOFw/gJ
         mJUg==
X-Gm-Message-State: AOAM530Nzvw7VRzXg4V0cJGv11GIXtzA/KncoR+gkEy9zQP9cdXFRj4D
        0vbr/zRilsjnjOwqsnggSrgJ1A==
X-Google-Smtp-Source: ABdhPJxg5AorFZDEX2PO5hFP6wSClbNCP4PmDEf/+3eJEf6fMVYfJ3vnc3tqPvcJC9nrkJOuFfhZLA==
X-Received: by 2002:a17:90a:ce8b:: with SMTP id g11mr4048979pju.94.1603221465962;
        Tue, 20 Oct 2020 12:17:45 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id 204sm2855995pfz.74.2020.10.20.12.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 12:17:45 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v17 0/4] overlayfs override_creds=off & nested get xattr fix
Date:   Tue, 20 Oct 2020 12:17:28 -0700
Message-Id: <20201020191732.4049987-1-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Mark Salyzyn (3):
  Add flags option to get xattr method paired to __vfs_getxattr
  overlayfs: handle XATTR_NOSECURITY flag for get xattr method
  overlayfs: override_creds=off option bypass creator_cred

Mark Salyzyn + John Stultz (1):
  overlayfs: inode_owner_or_capable called during execv

The first three patches address fundamental security issues that should
be solved regardless of the override_creds=off feature.

The fourth adds the feature depends on these other fixes.

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied for sepolicy, the
mounter's credentials might not overlap the credentials of the caller's
when accessing the overlayfs filesystem.  For example, a file that a
lower DAC privileged caller can execute, is MAC denied to the
generally higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/overlay_creds

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: John Stultz <john.stultz@linaro.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
To: linux-unionfs@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com

---

v17
- correct some zero-day build failrues
- fix up documentation

v16
- rebase and merge of two patches.
- add adjustment to deal with execv when overrides is off.

v15
- Revert back to v4 with fixes from on the way from v5-v14. The single
  structure argument passing to address the complaints about too many
  arguments was rejected by the community.
- Drop the udner discussion fix for an additional CAP_DAC_READ_SEARCH
  check. Can address that independently.
- ToDo: upstream test frame for thes security fixes (currently testing
  is all in Android).

v14:
- Rejoin, rebase and a few adjustments.

v13:
- Pull out first patch and try to get it in alone feedback, some
  Acks, and then <crickets> because people forgot why we were doing i.

v12:
- Restore squished out patch 2 and 3 in the series,
  then change algorithm to add flags argument.
  Per-thread flag is a large security surface.

v11:
- Squish out v10 introduced patch 2 and 3 in the series,
  then and use per-thread flag instead for nesting.
- Switch name to ovl_do_vds_getxattr for __vds_getxattr wrapper.
- Add sb argument to ovl_revert_creds to match future work.

v10:
- Return NULL on CAP_DAC_READ_SEARCH
- Add __get xattr method to solve sepolicy logging issue
- Drop unnecessary sys_admin sepolicy checking for administrative
  driver internal xattr functions.

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation, drop rationalizations.
- pr_warn message adjusted to report consequences.

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v4:
- spelling and grammar errors in text

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.

 Documentation/filesystems/locking.rst   |  2 +-
 Documentation/filesystems/overlayfs.rst | 26 +++++++++++++++++-
 fs/9p/acl.c                             |  3 ++-
 fs/9p/xattr.c                           |  3 ++-
 fs/afs/xattr.c                          | 10 +++----
 fs/btrfs/xattr.c                        |  3 ++-
 fs/ceph/xattr.c                         |  3 ++-
 fs/cifs/xattr.c                         |  2 +-
 fs/ecryptfs/inode.c                     |  6 +++--
 fs/ecryptfs/mmap.c                      |  2 +-
 fs/erofs/xattr.c                        |  3 ++-
 fs/ext2/xattr_security.c                |  2 +-
 fs/ext2/xattr_trusted.c                 |  2 +-
 fs/ext2/xattr_user.c                    |  2 +-
 fs/ext4/xattr_hurd.c                    |  2 +-
 fs/ext4/xattr_security.c                |  2 +-
 fs/ext4/xattr_trusted.c                 |  2 +-
 fs/ext4/xattr_user.c                    |  2 +-
 fs/f2fs/xattr.c                         |  4 +--
 fs/fuse/xattr.c                         |  4 +--
 fs/gfs2/xattr.c                         |  3 ++-
 fs/hfs/attr.c                           |  2 +-
 fs/hfsplus/xattr.c                      |  3 ++-
 fs/hfsplus/xattr_security.c             |  3 ++-
 fs/hfsplus/xattr_trusted.c              |  3 ++-
 fs/hfsplus/xattr_user.c                 |  3 ++-
 fs/jffs2/security.c                     |  3 ++-
 fs/jffs2/xattr_trusted.c                |  3 ++-
 fs/jffs2/xattr_user.c                   |  3 ++-
 fs/jfs/xattr.c                          |  5 ++--
 fs/kernfs/inode.c                       |  3 ++-
 fs/nfs/nfs4proc.c                       |  9 ++++---
 fs/ocfs2/xattr.c                        |  9 ++++---
 fs/orangefs/xattr.c                     |  3 ++-
 fs/overlayfs/copy_up.c                  |  2 +-
 fs/overlayfs/dir.c                      | 17 +++++++-----
 fs/overlayfs/file.c                     | 26 +++++++++---------
 fs/overlayfs/inode.c                    | 23 ++++++++--------
 fs/overlayfs/namei.c                    |  6 ++---
 fs/overlayfs/overlayfs.h                |  7 +++--
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  8 +++---
 fs/overlayfs/super.c                    | 34 ++++++++++++++++++-----
 fs/overlayfs/util.c                     | 13 +++++++--
 fs/posix_acl.c                          |  2 +-
 fs/reiserfs/xattr_security.c            |  3 ++-
 fs/reiserfs/xattr_trusted.c             |  3 ++-
 fs/reiserfs/xattr_user.c                |  3 ++-
 fs/squashfs/xattr.c                     |  2 +-
 fs/ubifs/xattr.c                        |  3 ++-
 fs/xattr.c                              | 36 ++++++++++++-------------
 fs/xfs/xfs_xattr.c                      |  3 ++-
 include/linux/xattr.h                   |  9 ++++---
 include/uapi/linux/xattr.h              |  7 +++--
 mm/shmem.c                              |  3 ++-
 net/socket.c                            |  3 ++-
 security/commoncap.c                    |  6 +++--
 security/integrity/evm/evm_main.c       |  3 ++-
 security/selinux/hooks.c                | 11 +++++---
 security/smack/smack_lsm.c              |  5 ++--
 60 files changed, 242 insertions(+), 137 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog

