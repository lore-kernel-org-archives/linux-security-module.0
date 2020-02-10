Return-Path: <SRS0=iK7v=36=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FEBC352A5
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC9A2070A
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="t2h8CUoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBJV1z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:27:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44457 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBJV1z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Feb 2020 16:27:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so2106840eds.11
        for <linux-security-module@vger.kernel.org>; Mon, 10 Feb 2020 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FsSlvm/Axt7sRTfVXvar8r8VgRRFNW92E5RmRgg0FNo=;
        b=t2h8CUoWU6lO/TpiUHXzrdlMs9sL6OymwU/3XgYBNaZ7GG+QIs2krf1qGUYApv4ife
         QMRvwPCjaeuPQ2C7woIJ6j4rFRP0kF4asBbCsM5peS8yN0p8kqbCGbOR0HyGVGYJ6kjY
         YRWdVPoJhTbRXNqhafmOzRyeesqZ42VMilkkMmjMC7RkFIYbl5rbq+H7DUlqeyZIuSe3
         Wy9w8Jsz3DiBPClC4o8QBxIdtGN5xMJHv2350ixjhO0ChLErc70NPj3CS8CFaGTQR3kI
         MZUmz/wXwG5GBc9Mj4tCBRqxtukRCEh/0bPBrBZwNHOjLM0mgtiYkrVeC6PZsbdrYRgw
         zfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FsSlvm/Axt7sRTfVXvar8r8VgRRFNW92E5RmRgg0FNo=;
        b=gX77wP30nrSs2YAKJjJ/GJARcVc4hQLgNL4voqYnpzaYZBOKIMn+0Jk3k3G+awT1+C
         h/uURkuO/8gXTRFxbxVyCAm/2ONGs/Tphxu0BK4s982aiDZ7fVluNBsuoquBH7NFSOu5
         s3l+mYO6hszdNby9qJGCothReM2Fd/FEz0rUkyLBln1T0pdsk7DS2g8LG4VTktUdWYW0
         S8IBwF59To9SqhhBbl8CM1NfCPjAvK3ZmglT3HR4HFYW1f5HtTAZpoq7IHLC5xKfDwdc
         ws4RQE81kVr5Ox2ChCB9naUt7f82rgRLgXQmjHnRVg1zT5o0aoNksmQ+R0gzjMO1PsUd
         u8LA==
X-Gm-Message-State: APjAAAW1M4HQnarj6BKuUSZ6enmKyf2HkP04UQK6OwXJOqXGYa7fKrDt
        39Nby4wQmpf13e5mW9jBlCbFzmCNubVoIyNESbdN
X-Google-Smtp-Source: APXvYqw6cQpdwc83SlSrKVH9MBzQRS1LOB8fuQYZ+BoKOqEcwlHzK4oUfMSGgZoOBdq/XgSdOkR5rBTuh0R6GPbhJmc=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr3014459edw.269.1581370073082;
 Mon, 10 Feb 2020 13:27:53 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Feb 2020 16:27:42 -0500
Message-ID: <CAHC9VhRegJC9MP2pAGV_htOVNiBYSzxJ3xBFk7trwRpLniBY+w@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.6 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Two small fixes for v5.6-rcX: one fixes a locking problem in the
recently merged label translation code, the other fixes an
embarrassing "binderfs"/"binder" filesystem name check.

Please merge for the next -rcX release, thank you.

-Paul

--
The following changes since commit 98aa00345de54b8340dc2ddcd87f446d33387b5e:

 selinux: fix regression introduced by move_mount(2) syscall
   (2020-01-20 07:42:37 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20200210

for you to fetch changes up to 39a706fbcf2694bfb651bed9041d44c3f4fa8078:

 selinux: fix sidtab string cache locking (2020-02-05 18:31:10 -0500)

----------------------------------------------------------------
selinux/stable-5.6 PR 20200210

----------------------------------------------------------------
Hridya Valsaraju (1):
     selinux: fix typo in filesystem name

Ondrej Mosnacek (1):
     selinux: fix sidtab string cache locking

security/selinux/hooks.c     |  2 +-
security/selinux/ss/sidtab.c | 12 +++---------
2 files changed, 4 insertions(+), 10 deletions(-)

-- 
paul moore
www.paul-moore.com
