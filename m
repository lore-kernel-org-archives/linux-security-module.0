Return-Path: <SRS0=cm7D=Z7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F305AC3F68F
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Dec 2019 23:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01DE206D5
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Dec 2019 23:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="14tLFFKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfLIXmT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:42:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39966 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfLIXmT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Dec 2019 18:42:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so17687940ljs.7
        for <linux-security-module@vger.kernel.org>; Mon, 09 Dec 2019 15:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aThrcSk9eJO9ZEYp7MG17rWkIvsNKHgQ2G/tGY7+yOE=;
        b=14tLFFKpoHTBuxLubV+jJ4G64SOJMnFCScFUUU9UaiDMXiZdeG2vUaK4lyOGq7NC4w
         UTPyCCusyaPb50dHMWMotz1iv4mj3c0zWp3o3fLvU6hZXdgmhaTMsNKdnJ724em4bz/Q
         6WjkZbMLqbozo9qRqcnX/KkrmyT6IGc1TAQOfLh0K9pXRyX+VNZEfmtbScNsTz4lkpYG
         9qiUIem6CMOGSvATGX8ScnZshVcCrEochW3UtZeJb7xoQjpZhygzCrK0y8g4n+1fkGt/
         z7TocrnA5IKUW4EQVLertAQlotckPKaUdm06UdNXJVyH7WgO3bvJ7dF546k1404uL3oC
         2sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aThrcSk9eJO9ZEYp7MG17rWkIvsNKHgQ2G/tGY7+yOE=;
        b=Y+U4QPWwW6hXjxEwAl170z67BZYsmftZ//UydPC+aif6GesauFy+23AjHCDsynG1J6
         pTAbgFKATTLG5W8XyDrecSxJ76e7SntPmFXsShgBhoidJXvkoMHH6sOrxSBlUDhIySzO
         jAyxIJppmF95j+FfooPl1RnjUI/i5ZoveXXt08LIb1IsoZQRI+ZVgqJt00iUqc3Z3rUQ
         L6kbgRs7QlbCfE7AYU4ukqDWHGNuEaZfBKHKWm1GagMhLWQslowzQJ864m7fdlZ2BFNa
         GHD33IeSJVznC4E4eNhsRT5+sqFrQobuQB0mv8M4As1zHk+j4mnk/Nkf7NPG9tN1PpRl
         zb2Q==
X-Gm-Message-State: APjAAAVTYK62cQyDwYIRsU2CzqV3XhgwNyY0j9B5mvRUbbZc+ktZ48kv
        R/TeFIVQCL+nOWWaCXqDzXxkaBHqmGrcb7UdPCtN
X-Google-Smtp-Source: APXvYqwX6hbYsmadx0Ho/OJIPmZFzixXDc4j7x2P5It41no5mCwMWMtRc+w57pdQz3Ao2AxtB/uIFzSwPoizTOSw1+4=
X-Received: by 2002:a2e:b045:: with SMTP id d5mr5848186ljl.184.1575934936802;
 Mon, 09 Dec 2019 15:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20191122172245.7875-1-sds@tycho.nsa.gov>
In-Reply-To: <20191122172245.7875-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 18:42:05 -0500
Message-ID: <CAHC9VhRWx-1sUDLgKwkiL6PC9vXh-rUaWg4rOq3_U6=w1MOO8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: revert "stop passing MAY_NOT_BLOCK to the
 AVC upon follow_link"
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 22, 2019 at 12:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> This reverts commit e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK
> to the AVC upon follow_link"). The correct fix is to instead fall
> back to ref-walk if audit is required irrespective of the specific
> audit data type.  This is done in the next commit.
>
> Fixes: e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link")
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c         | 24 ++++++++++++++++++++++--
>  security/selinux/hooks.c       |  5 +++--
>  security/selinux/include/avc.h |  5 +++++
>  3 files changed, 30 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
