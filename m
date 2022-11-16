Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A1C433FE
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 19:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKPT0m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiKPT0l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Nov 2022 14:26:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101954B1B
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 11:26:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d20so17338039plr.10
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RijC22/SdwWwg/bVfJzaGWhRZ22gyvsY9MCYb3HpSxY=;
        b=WQddw7AQUG58WBNwtzFfChA6jc5qW8cC0yityyraiaiSt71wJQ8GsDoEZOoBRmp3MZ
         Tr4YLCLhGsNc5wqaWjb5aC2QDWh87piwicrRRhdh1w7X76luhS02KBieKcG7DA9wLjYV
         RJCn/iGsRHkslnIFGtBC6En/Ibg/VOzx/fJk8opvWY7TBSTEnvszEcMzsu8nvprRIeKx
         ANOb9Uf3699OL/Jhrf06cezPYP4/YfF9EcyBAeZOslsDiRRD4uiBgoJsMiYohqNIMf8m
         qCP1Cg2XQFTecvrA/bqnWnWg3oaHrlc1aVM+wA76XwYw9gAxiL5+uswFoVbxZQzp42JR
         XWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RijC22/SdwWwg/bVfJzaGWhRZ22gyvsY9MCYb3HpSxY=;
        b=74GPG0lJuqZT+jy5C0XXFA9N/u04jUA1YQdWAjdZq8qxdqc3aDtJqHOrqFcYSNxpkc
         GcWR08mp9lXgKz2/jSdFKbz48PSmxEPm/8dDytoxCo45Q72uYIiY2LRmmFd/IVOMIDnY
         asB/vdd+YMB3/aj2uBq2mmbacPhJLlhPBiqmigBTzv6OixXLPWEpJ1LK+j8FwjxBUkVP
         yzwog6tX7buebLTQVsO8a28xQnQHk1Cvudso4YDMXAqUtc+l84a4DpsYMikOm+Wtzl6B
         JjkdJKXdnr8ccIMfjlpY0spqXO8Q47hSebESTT9hrvNSs5qwPZ2zSnHLOZHR72DeXLxB
         G82Q==
X-Gm-Message-State: ANoB5pmu94veCMt0cyIw21u7mK3LGNctXMX6Y4cgsyP/nuUDMmgmpnGx
        ETRUFZjSOjq3FwkuqrXloSVafSlJJJKreAz0hG/M
X-Google-Smtp-Source: AA0mqf7am7h9iKe0yzgEn70nyDj/uDKD9TXuJUVccZD5sBXsE9AtUSPcexgIiBTALKY70i6fsFyrnq2E3b+srOvIGsE=
X-Received: by 2002:a17:902:be04:b0:17b:4ace:b67f with SMTP id
 r4-20020a170902be0400b0017b4aceb67fmr10827665pls.12.1668626800083; Wed, 16
 Nov 2022 11:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-3-roberto.sassu@huaweicloud.com> <CAHC9VhQjtU0DFoVGav-nBh-09QXh+X=Cf8RgJz6nAjvcyNQ-5A@mail.gmail.com>
 <dd9215b603d9ff511c5c23998b4597b0eb55f0a7.camel@huaweicloud.com>
In-Reply-To: <dd9215b603d9ff511c5c23998b4597b0eb55f0a7.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 14:26:29 -0500
Message-ID: <CAHC9VhQU+L1djE2xEGx2frPBqx5OPcbxWDSEpeoFTH01+rj76g@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/4] lsm: Add missing return values doc in
 lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 16, 2022 at 3:07 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2022-11-15 at 21:23 -0500, Paul Moore wrote:
> > On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Ensure that for non-void LSM hooks there is a description of the return
> > > values. Also replace spaces with tab for indentation, remove empty lines
> > > between the hook description and the list of parameters and add the period
> > > at the end of the parameter description.
> > >
> > > Finally, replace the description of the sb_parse_opts_str hook, which was
> > > removed with commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()"),
> > > with one for the new hook sb_add_mnt_opt.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/lsm_hooks.h | 123 ++++++++++++++++++++++++++------------
> > >  1 file changed, 86 insertions(+), 37 deletions(-)
> >
> > ...
> >
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index f40b82ca91e7..c0c570b7eabd 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -176,18 +183,22 @@
> > >   *     Set the security relevant mount options used for a superblock
> > >   *     @sb the superblock to set security mount options for
> > >   *     @opts binary data structure containing all lsm mount data
> > > + *     Return 0 on success, error on failure.
> > >   * @sb_clone_mnt_opts:
> > >   *     Copy all security options from a given superblock to another
> > >   *     @oldsb old superblock which contain information to clone
> > >   *     @newsb new superblock which needs filled in
> > > - * @sb_parse_opts_str:
> > > - *     Parse a string of security data filling in the opts structure
> > > - *     @options string containing all mount options known by the LSM
> > > - *     @opts binary data structure usable by the LSM
> > > + *     Return 0 on success, error on failure.
> > > + * @add_mnt_opt:
> > > + *     Add a new mount option @option with value @val and length @len to the
> > > + *     existing mount options @mnt_opts.
> > > + *     Return 0 if the option was successfully added, a negative value
> > > + *     otherwise.
> >
> > I really appreciate the effort to improve the LSM hook comments/docs,
> > but the "sb_add_mnt_opt" hook was removed in 52f982f00b22
> > ("security,selinux: remove security_add_mnt_opt()").
>
> Right, sorry, didn't notice.

No problem.  I just wanted to make it clear that I really like this
patch, and if you can fix the above and double-check the others I'll
gladly merge this.  As a general rule I *love* doc improvements :)

-- 
paul-moore.com
