Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C59ECAAA1
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiHYVAg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbiHYVAd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 17:00:33 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694F2F677
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 14:00:32 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s199so24787906oie.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jP3IoOeZpSJxDg8/TU4UR55XSsBpnDuenNXaHQA9INI=;
        b=49pIApqV5+nbLoaVlHl9cXiLBqzz7aZ0GPCtO/PNzkwHuRwYNDIJtshNM2ZOVF5iKI
         mrHgew8rSBdGZfcn7+tCGGBc4WFKmFnbl37mtZmnCSNGovGBlgvmiddfJ+PKePp4Ccxh
         FZlBgMhKGk4morvPGT+rMaxRzzbImW5cEW/m9vU24iJsso4Pox7VBG+toXjSfZ7nfHmh
         tR+5ZacHLJ5Fz1il0NxMp0Y8QtiSypoyMDEPYBOh6XOQcZS5buZeOZr0iDTFL/HRwlBo
         mh85lvGnhyJMMg0DFkvIGv/xzoz07cTmzbzZuDS4gRtA2qb16hhq9niV3GhNHK9o6Cr8
         Vdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jP3IoOeZpSJxDg8/TU4UR55XSsBpnDuenNXaHQA9INI=;
        b=ftIOF4H9bPtxUhcRTPKqWUTNQfNBE0M9hjfOYifUqGeHoKpg7HnHgaHy2gSj5CCcHm
         wJL+VVpmjkC+whuqyfOlwzMKubF0SOYyTqQQgXykTwYujDBKpSLizgZFhqoFZBxoAO6h
         rdc9lcZ2oOpGG6sONAL2TJWFiFSypMgAnY51AeDIA/ADRpwGlLjSMPnUgtczg0RV0YUu
         g/mN7FJhgn6UiM24AYcEWWD4Vyi36AGiHVpBSSMqZczoU36vySxeFFzOsNhoEjCEojMr
         vAgQE9NVfj/Rc3cbwvLmJxYu5V3/i6nJC8fVnGculrCWUtyWD9VVzkPHKQN1Udj2zC5g
         augA==
X-Gm-Message-State: ACgBeo0NiCk4G1NK+YfWjYu0uUU16hR4viQvjjVcLJvTtXQn/zISD3GA
        D5Dayytu+1qDdA/DekerZtHGqJAVVQfNqsvZRjtG
X-Google-Smtp-Source: AA6agR7KfLRuTzWpIDbWS7YMLq9Mjf6zh3IXBmogCvBw7lLMp0taSzGn22XSk73cJv98tiDpUHteZ1WWBYpperzUszI=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr375588oie.41.1661461231631; Thu, 25 Aug
 2022 14:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220823144123.633721-1-mic@digikod.net>
In-Reply-To: <20220823144123.633721-1-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Aug 2022 17:00:20 -0400
Message-ID: <CAHC9VhRLeEZzKLtFosgSe8oQxk7D4hcRTjVYGRiA0ZprKjHO9g@mail.gmail.com>
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit LANDLOCK_ACCESS_FS_REFER
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 23, 2022 at 10:41 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
> With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
> globally denied-by-default access right.  Indeed, this lifted an initial
> Landlock limitation to rename and link files, which was initially always
> denied when the source or the destination were different directories.
>
> This led to an inconsistent backward compatibility behavior which was
> only taken into account if no domain layer were using the new
> LANDLOCK_ACCESS_FS_REFER right.  However, in a scenario where layers are
> using the first and the second Landlock ABI (i.e.
> LANDLOCK_ACCESS_FS_REFER or not), the access control behaves like if all
> domains were handling LANDLOCK_ACCESS_FS_REFER with their rules
> implicitely allowing such right.  Indeed, the not-handled access rights
> were allowed, which should not be the case for LANDLOCK_ACCESS_FS_REFER.
> It should be noted that this bug only allowed safe renames or links, but
> no privilege escalation because the LANDLOCK_ACCESS_FS_REFER properties
> were still enforced (e.g. only allowed to move a file according to all
> other access rights, and if it doesn't give more Landlock accesses).
>
> This change adds an ACCESS_INITIALLY_DENIED list of denied-by-default
> rights, which (only) contains LANDLOCK_ACCESS_FS_REFER.  All domains are
> treated as if they are also handling this list, but without modifying
> their fs_access_masks field, which enables correct domain audit.
>
> A side effect is that the errno code returned by rename(2) or link(2)
> *may* be changed from EXDEV to EACCES according to the enforced
> restrictions.  Indeed, we now have the mechanic to identify if an access
> is denied because of a required right (e.g. LANDLOCK_ACCESS_FS_MAKE_REG,
> LANDLOCK_ACCESS_FS_REMOVE_FILE) or if it is denied because of missing
> LANDLOCK_ACCESS_FS_REFER rights.  This may result in different errno
> codes than for the initial Landlock version, but this approach is better
> for rename/link compatibility reasons, and it wasn't possible before
> (hence no backport to ABI v1).  The layout1.rename_file test reflects
> this change.
>
> Add the layout1.refer_denied_by_default* tests to check that the
> behavior of a ruleset not handling LANDLOCK_ACCESS_FS_REFER (ABI v1) is
> unchanged even if another layer handles LANDLOCK_ACCESS_FS_REFER (i.e.
> ABI v1 precedence).  Make sure rule's absolute access rights are correct
> by testing with and without a matching path.
>
> Extend layout1.inval tests to check that a denied-by-default access
> right is not necessarily part of a domain's handled access rights.
>
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LAN=
DLOCK_ACCESS_FS_REFER")
> Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220823144123.633721-1-mic@digikod.net
> ---
>  security/landlock/fs.c                     |  28 +++--
>  tools/testing/selftests/landlock/fs_test.c | 133 +++++++++++++++++++--
>  2 files changed, 143 insertions(+), 18 deletions(-)

I'm still working on getting more confident of my Landlock
understanding, but the kernel code looks sane to me and I like how
this removes the compatibility hack in current_check_refer_path().

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
