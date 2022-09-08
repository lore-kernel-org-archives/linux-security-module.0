Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0FFC54EE9
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Sep 2022 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIHUJV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIHUJU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Sep 2022 16:09:20 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DF41017E8
        for <linux-security-module@vger.kernel.org>; Thu,  8 Sep 2022 13:09:18 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1280590722dso13908656fac.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Sep 2022 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=szzH6V0BbcIyW/LN6sXrwvHzpvjLGqgZKN0b69l/Scw=;
        b=m1C72J0J86sNTQWwrYwDy6Bo9GpjHYOIAgNzFvbqRR2+PzdDfGHpwN2vhM91wYnL3R
         P5fEzev4bWq4COchzdOkkDHg+P6x6QpNAHYFAkEKUgjYysLjkKodABxytNx49ws88800
         Jtpz+QoukKFE3aeLTj52CujGWGQJnzwKXwH2ou3CDSsPpZDI2609s3WktA6y8V9YmAon
         eN5hPJWcLVAOPqFpkdOvja01JEW/vmTbFn+1uL2L9b51DiaasEXdPp0f2pdmfcPrgHmu
         HDvFODCLDcGDNPphTlRKqhhU/Ol7Ed6ZmVXrIWQPt8p7OkqH52gwOOIbZpzklFWi5ret
         VGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=szzH6V0BbcIyW/LN6sXrwvHzpvjLGqgZKN0b69l/Scw=;
        b=qOnt5fjdB2dXsmqYMF+3IqDzG94m2fM9tZukVK+F9WPso1pzeOsbueo0DSuT95tRzL
         MJEGc73PIJQU87gg6UIWK85qUN1Gya+m7ygx8R9g5LOUA8KhMeCbNzV7evMiewLKcUtp
         KKcB5vF3rouaG4y3VkuqdlnSolWcVwaYXVRIa9J6JaRORY0zi58bRFoUHjCsqDRZzJMm
         xO5zIcz2aIwouMMBMx/1P1qxiRmTncJNphoQAwXNivKlFQDbctelxXjFyGc0dHrjR4Xc
         +iGV5PFvBMvmpeStca8LubeT1wqDbrot8FDQlf9wfpHcYKFSrXaDg1Zg5ZN/koJJGZD7
         Yz7Q==
X-Gm-Message-State: ACgBeo2qTH4ILnRzVxXVkzp2HSrEAmQGfURySowygtYFkqks9H4eD2tT
        fUnVGXOWQPWejI31OaouJwsl5GmLrxGeg28GwACB
X-Google-Smtp-Source: AA6agR5cUaupCfrXTem8xPb3qa/PvsDumKXP4uBIPQCGq9k7077D3Z+NjdMMKMHy2FcnNvE36C+qJOImFB1NaEeUYPs=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr2267780oie.41.1662667757355; Thu, 08 Sep
 2022 13:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220908195805.128252-1-gnoack3000@gmail.com> <20220908195805.128252-2-gnoack3000@gmail.com>
In-Reply-To: <20220908195805.128252-2-gnoack3000@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Sep 2022 16:09:06 -0400
Message-ID: <CAHC9VhSmjF1sYoP-Z8vj+O4=NPQMdw+L4=iFZtDbHzJg7ey6vA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] security: create file_truncate hook from
 path_truncate hook
To:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 8, 2022 at 3:58 PM G=C3=BCnther Noack <gnoack3000@gmail.com> wr=
ote:
>
> Like path_truncate, the file_truncate hook also restricts file
> truncation, but is called in the cases where truncation is attempted
> on an already-opened file.
>
> This is required in a subsequent commit to handle ftruncate()
> operations differently to truncate() operations.
>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  fs/namei.c                    |  6 +++---
>  fs/open.c                     |  4 ++--
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/apparmor/lsm.c       |  6 ++++++
>  security/security.c           |  5 +++++
>  security/tomoyo/tomoyo.c      | 13 +++++++++++++
>  7 files changed, 36 insertions(+), 5 deletions(-)

We need to get John and Tetsuo's ACKs on this patch, but in addition
to that I have two small comments (below).

> diff --git a/fs/namei.c b/fs/namei.c
> index 53b4bc094db2..52105873d1f8 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -53,8 +53,8 @@
>   * The new code replaces the old recursive symlink resolution with
>   * an iterative one (in case of non-nested symlink chains).  It does
>   * this with calls to <fs>_follow_link().
> - * As a side effect, dir_namei(), _namei() and follow_link() are now
> - * replaced with a single function lookup_dentry() that can handle all
> + * As a side effect, dir_namei(), _namei() and follow_link() are now
> + * replaced with a single function lookup_dentry() that can handle all

Since this patch(set) is likely to go in via the Landlock tree, it is
very important to keep changes outside of security/landlock to a bare
minimum of what is required both to reduce merge conflicts and
highlight the significant changes.  This change doesn't appear
necessary ... and I'm having a hard time spotting the difference in
the lines.

> diff --git a/fs/open.c b/fs/open.c
> index 8a813fa5ca56..0831433e493a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1271,7 +1271,7 @@ struct file *filp_open(const char *filename, int fl=
ags, umode_t mode)
>  {
>         struct filename *name =3D getname_kernel(filename);
>         struct file *file =3D ERR_CAST(name);
> -
> +

See my comment above about unnecessary changes.

--=20
paul-moore.com
