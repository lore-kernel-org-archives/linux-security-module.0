Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63792C74A5B
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Mar 2023 23:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjCWXhV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Mar 2023 19:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCWXhU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Mar 2023 19:37:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53F24127
        for <linux-security-module@vger.kernel.org>; Thu, 23 Mar 2023 16:37:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p15so282463ybl.9
        for <linux-security-module@vger.kernel.org>; Thu, 23 Mar 2023 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679614638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5DqnFNdwoRsvRD9gY7AVflhKHmqWJvLpG3CELYJwy4=;
        b=MvmzhjViCPcj6Nhc+3xUZBlHLNZc4r6lPParcd8U1SVaNbw7wKC7ctiSLNtETXsbZR
         SfRHOqCYRqd1uqAwWuo9yiMFLI0eaNDRiZlTA6cLo/WgAikQelZ1tHGFpIZZPWcjT35o
         RAn0baZ5sYIIGCdLt+R9DAyKHRnnJXL0EwkWhxKR9y3ewPQOPLqgHbZlIjayJV65Q4zv
         5Lw4K4PXz4x9XgSVjgC27sSASSJW5nHoZurlVklnEY9HZZJhC9oqu0bxuU17lvaxiU3a
         kl+1LdimUZ3SdVmvRmCVK2t7FT3bIF4MTO+fvC6g4axqIpSiLufJkJgHH86Rqinq42Ye
         nNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5DqnFNdwoRsvRD9gY7AVflhKHmqWJvLpG3CELYJwy4=;
        b=J0qdqpI/glCzmXSwH9WuyeD1Gc9HVDLSQ+hJDZWDMRmUeFeyuRFarMetX4r1j8hT+2
         pQZrkpm5LkRee8aWnk0mskbJWVkYcdHDux6g2S3/fImTHGC0eIoSyjujIqUhYxw5/EyP
         PzsGJeuxmXR2JycoBHueVQk+xz08uEag2UAY/kZt3iiSpQLqv+F82x27EnONWdayPxqp
         58olKq/0E1F5a+E7ATPWgoFU79Bd0dyyRePnuwDpQXG6GDxFthzXPZeniv87vNkFm+Wj
         5SE+odBVsme7Wb8NqAKOQOqxKppbv85ztwW7S4cTlJKar2JMCJ/AkiJA30VgEQJaUoi0
         +jlA==
X-Gm-Message-State: AAQBX9d49s3ywTMnVWEeu63HkqSQ9pKDvgulJLh+6M4+sbxszDW4Yvba
        S8e1LRbO6GJoIkv4N3Z9I426G2rngb7OhCxMsCLv
X-Google-Smtp-Source: AKy350aKUo52lrEIhVqCcrwLfuJGssfxNEL6IV2NSjb63kt7Z52L3fpiOf67Jiyy9HPq6D2tt3ioTIkNycC6sWUe3fE=
X-Received: by 2002:a05:6902:18c7:b0:b72:fff0:2f7f with SMTP id
 ck7-20020a05690218c700b00b72fff02f7fmr715296ybb.4.1679614638263; Thu, 23 Mar
 2023 16:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com> <20230314081720.4158676-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230314081720.4158676-3-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Mar 2023 19:37:07 -0400
Message-ID: <CAHC9VhSPMs6k4zm0rACiZZYuB84Avg9t+AnGBH4F+iiLsNgzkg@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] ocfs2: Switch to security_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 14, 2023 at 4:18=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for removing security_old_inode_init_security(), switch to
> security_inode_init_security().
>
> Extend the existing ocfs2_initxattrs() to take the
> ocfs2_security_xattr_info structure from fs_info, and populate the
> name/value/len triple with the first xattr provided by LSMs.
>
> As fs_info was not used before, ocfs2_initxattrs() can now handle the cas=
e
> of replicating the behavior of security_old_inode_init_security(), i.e.
> just obtaining the xattr, in addition to setting all xattrs provided by
> LSMs.
>
> Supporting multiple xattrs is not currently supported where
> security_old_inode_init_security() was called (mknod, symlink), as it
> requires non-trivial changes that can be done at a later time. Like for
> reiserfs, even if EVM is invoked, it will not provide an xattr (if it is
> not the first to set it, its xattr will be discarded; if it is the first,
> it does not have xattrs to calculate the HMAC on).
>
> Finally, since security_inode_init_security(), unlike
> security_old_inode_init_security(), returns zero instead of -EOPNOTSUPP i=
f
> no xattrs were provided by LSMs or if inodes are private, additionally
> check in ocfs2_init_security_get() if the xattr name is set.
>
> If not, act as if security_old_inode_init_security() returned -EOPNOTSUPP=
,
> and set si->enable to zero to notify to the functions following
> ocfs2_init_security_get() that no xattrs are available.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/namei.c |  2 ++
>  fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
>  2 files changed, 28 insertions(+), 4 deletions(-)

Merged into lsm/next, thanks.

--=20
paul-moore.com
