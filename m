Return-Path: <SRS0=qmiK=PB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE77C676E3
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Dec 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D87E21850
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Dec 2018 17:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xWZp5GTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbeLXRCj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:02:39 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:32849 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbeLXRCj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Dec 2018 12:02:39 -0500
Received: by mail-lf1-f41.google.com with SMTP id i26so8528674lfc.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Dec 2018 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=G8FzPBtb4yXXXaWuLZ7xMf+SnfKeOS2EHYk5qzdzX3I=;
        b=xWZp5GTa95rq+nOQF+eA7nPDXNA4UPYNmSAkOLEuzWedAZVloHdPJnZh3/Xvd1nMZm
         ikUQcUGrKSBz1PW979NnpJ1ekC9QMfT7litK+VD5jM3q2suaV7CwHVYL/u1MU/yEEI1P
         Bti5Ybz56ZPqrTpDZNzhhBSp83pp9Ywrw66jZjhvQyeGuShDE2ON46qL09Z45bWAO28F
         QyvOA5sNVfH86RSn8TiMmsInd+IOliPdbE+klMh4uiwRdfi2f4u0f/8i13sX9LxuVn2g
         4u4FKH0HF/9n7KnxBNI5P1QCnoec5fgRkMpzWey4Uhb25aeQ6wtOl0+6zSMo2VM7SkJe
         RGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=G8FzPBtb4yXXXaWuLZ7xMf+SnfKeOS2EHYk5qzdzX3I=;
        b=ruj4+wKsuGaYvcDxDml4MoN0+GAgxOMGCE84nzzLFXODURctVGvv43nwKNd/AeBTsT
         +wzRQ6laarbOKgZVcd+7i6RNXaErRd2XuHlTpsl0vL51DGY/zTOdxjmB+GW1WovYYfpb
         Ga4YG5SEnBSDWLtBHb2K/vrmOUT77vbyZyDAxZsbycNTQPjUjnonqp6w0gFcAkXDEwIC
         AR01HaKfS9gYRBk1tCcSDGhcLraruQkwB3yxtpOslN624iX9iTYxozBkJiMHDOfpItn1
         myVYaLhKWrX40R65C0Ny+XnG3+fP7tEzdt212elne9qM7IIB31eQYcGjPDiCX9RXcGq8
         otTw==
X-Gm-Message-State: AA+aEWZxoGMSs6DcpYoO0vXUOIY34/UkW8KFysZgFAvY4UvcECxbrgiy
        8T3DgRUhEuvsHoW99OC2D6S2tusmRztGEfKIQHvs
X-Google-Smtp-Source: AFSGD/VZjAGXZHyU0vNP+GgPDWr6fG1hlHaIPKvY97oYzXoeD7cPl4GdtsQLsPEV3HjeXOXsgJ02pMKv5NyM19aRZMs=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr6794802lfa.40.1545670956833;
 Mon, 24 Dec 2018 09:02:36 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Dec 2018 12:02:25 -0500
Message-ID: <CAHC9VhSzkyh3Nj+25YX1y_gs9-Y+TEedo7hi-Qk7hd+qMERvyQ@mail.gmail.com>
Subject: [GIT PULL] SELinux patches v4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

I already used my best holiday pull request lines in the audit pull
request, so this one is going to be a bit more boring, sorry about
that.  To make up for this, we do have a birthday of sorts to
celebrate: SELinux turns 18 years old this December.  Perhaps not the
most exciting thing in the world for most people, but I think it's
safe to say that anyone reading this email doesn't exactly fall into
the "most people" category.

Back to business and the pull request itself.  Ondrej has five patches
in this pull request and I lump them into three categories: one patch
to always allow submounts (using similar logic to elsewhere in the
kernel), one to fix some issues with the SELinux policydb, and the
others to cleanup and improve the SELinux sidtab.  The other patches
from Alexey and Petr and trivial fixes that are adequately described
in their respective subject lines.  This is generally a pretty
standard set of patches, but there is one potential merge conflict
with the mount rework in the vfs tree.  If needed, the fixup is pretty
small and documented in the linux-next post below; if you have any
questions about the merge let us know.

* https://lore.kernel.org/lkml/20181218144858.58d8d1f8@canb.auug.org.au

With this last pull request of the year, I want to thank everyone who
has contributed patches, testing, and reviews to the SELinux project
this year, and the past 18 years.  Like any good open source effort,
SELinux is only as good as the community which supports it, and I'm
very happy that we have the community we do - thank you all!

-Paul
--
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

 Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20181224

for you to fetch changes up to ee1a84fdfeedfd7362e9a8a8f15fedc3482ade2d:

 selinux: overhaul sidtab to fix bug and improve performance
   (2018-12-05 16:12:32 -0500)

----------------------------------------------------------------
selinux/stable-4.21 PR 20181224

----------------------------------------------------------------
Alexey Dobriyan (1):
     selinux: make "selinux_policycap_names[]" const char *

Ondrej Mosnacek (5):
     selinux: policydb - fix byte order and alignment issues
     selinux: refactor sidtab conversion
     selinux: always allow mounting submounts
     selinux: use separate table for initial SID lookup
     selinux: overhaul sidtab to fix bug and improve performance

Petr Vorel (1):
     Documentation: Update SELinux reference policy URL

Documentation/admin-guide/LSM/SELinux.rst |   2 +-
security/selinux/hooks.c                  |   2 +-
security/selinux/include/security.h       |   2 +-
security/selinux/ss/mls.c                 |  24 +-
security/selinux/ss/mls.h                 |   3 +-
security/selinux/ss/policydb.c            |  61 +++-
security/selinux/ss/services.c            | 222 +++++------
security/selinux/ss/services.h            |   2 +-
security/selinux/ss/sidtab.c              | 609 ++++++++++++++++++---------
security/selinux/ss/sidtab.h              |  96 +++--
10 files changed, 626 insertions(+), 397 deletions(-)

-- 
paul moore
www.paul-moore.com
