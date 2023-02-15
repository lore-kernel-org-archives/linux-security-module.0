Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872FDC636CC
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Feb 2023 20:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBOUeX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBOUeW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Feb 2023 15:34:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0413B3C4
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 12:34:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id my5so63531ejc.7
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IiZ4lVkvmdvqnTvwiiU7oC60CxyPpzsglEiyT80ru0U=;
        b=o3skMUJOa3UkdAPQvnThtZTsv6ZphDM/jOSJakAhrb81EDPneDJKOuPvfk9nNDvLcE
         to5Nepw0TUkRCsIY8s6UZFXVmrnQ3YFGJ/zURW/zBouBg15nRlL3fy4bbwUolXPsz3G/
         NzlXPum70Lgkt9Z9afiKDg9YX96W1Nx0X+UbmYwR5kzK0e7qQzcUba2Vy0aLBl4iC7tI
         NOXTlcw9i1y21DuygIVcsqWWiaR8piKBvAmcmPbjok30SdMW09XOVMccWGHjPOFwPn+D
         RAZMQMbKnmpIzE0tPoDFXIatYZmAZ6BGLqUGMdKNkip7qp86ffP+nXA2Z7np/smwkIYb
         KPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiZ4lVkvmdvqnTvwiiU7oC60CxyPpzsglEiyT80ru0U=;
        b=E5Vtwx1noyqNlVuPx2DWUlsw8C7tMcV+ifYb81sjT82XOF/FB5EsiEyI1uW3e7jf+L
         3yRQfZUpR2V7WafF0iNw8IC6huQ55vDN3H2bUGHUzl3LZih3YdFhYCNgnZwkQSQEHpUO
         E/qXcwJdxxPlwIvutYvkVV9mrK2wWLcOm61QybpXy2MtZAGD3jHXCKSPOXwmLJYD3jbf
         1c6HromwcrSEclkC3/vqM9H02l+ZccsBA3sMqop5KYoop6Ba9VjsgenvdK/rcqCntCoS
         OiDxqB3ZP9NQyjGIfqDpCGJsct1kAF/sOa2eycolU2Ftr1iXF+guIf/CZ15gYb4RFcDp
         2nkw==
X-Gm-Message-State: AO0yUKVdeKpjXMGccAN7kddkcb7+N66NV9eiBUocqFwQhghSOt5Oi247
        z42tkyvXTgeBqdrmCVcYAME=
X-Google-Smtp-Source: AK7set+rHm6JL4kmlh+AzJzpxI54HeXj6Jj7TO/IFbJceDwCfCP7vHBbJbRVC2N2s46v3atp60RcYg==
X-Received: by 2002:a17:907:da4:b0:878:6675:d07c with SMTP id go36-20020a1709070da400b008786675d07cmr5486870ejc.37.1676493257174;
        Wed, 15 Feb 2023 12:34:17 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id jo22-20020a170906f6d600b008b158cbac66sm26043ejb.210.2023.02.15.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 12:34:16 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:34:15 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH v2] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Message-ID: <Y+1BxwRbdY+PZXNA@galopp>
References: <20230213210115.5150-1-gnoack3000@gmail.com>
 <d8112efe-d270-3013-97e6-bcc7c5237c02@digikod.net>
 <Y+0la4VBbkV8rlkD@galopp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+0la4VBbkV8rlkD@galopp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 15, 2023 at 07:33:15PM +0100, Günther Noack wrote:
> Thanks for the feedback, Mickaël!
> 
> See some proposals for rephrasings inline. I tried to avoid passive
> voice to make it easier to follow. Please let me know what you think.
> 
> (Any native English speakers are more than welcome to chime in as well. 8-))
> 
> –-Günther
> 
> On Tue, Feb 14, 2023 at 01:04:04PM +0100, Mickaël Salaün wrote:
> > 
> > On 13/02/2023 22:01, Günther Noack wrote:
> > > Clarify the "refer" documentation by splitting up a big paragraph of text.
> > > 
> > > - Call out specifically that the denial by default applies to ABI v1 as well.
> > > - Turn the three additional constraints for link/rename operations
> > >    into bullet points, to give it more structure.
> > > 
> > > Includes wording and semantics corrections by Mickaël Salaün.
> > > 
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >   include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
> > >   1 file changed, 26 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > > index f3223f96469..f6bccd87aa0 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -130,21 +130,32 @@ struct landlock_path_beneath_attr {
> > >    * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create (or rename or link) a block device.
> > >    * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create (or rename or link) a symbolic link.
> > >    * - %LANDLOCK_ACCESS_FS_REFER: Link or rename a file from or to a different
> > > - *   directory (i.e. reparent a file hierarchy).  This access right is
> > > - *   available since the second version of the Landlock ABI.  This is also the
> > > - *   only access right which is always considered handled by any ruleset in
> > > - *   such a way that reparenting a file hierarchy is always denied by default.
> > > - *   To avoid privilege escalation, it is not enough to add a rule with this
> > > - *   access right.  When linking or renaming a file, the destination directory
> > > - *   hierarchy must also always have the same or a superset of restrictions of
> > > - *   the source hierarchy.  If it is not the case, or if the domain doesn't
> > > - *   handle this access right, such actions are denied by default with errno
> > > - *   set to ``EXDEV``.  Linking also requires a ``LANDLOCK_ACCESS_FS_MAKE_*``
> > > - *   access right on the destination directory, and renaming also requires a
> > > - *   ``LANDLOCK_ACCESS_FS_REMOVE_*`` access right on the source's (file or
> > > - *   directory) parent.  Otherwise, such actions are denied with errno set to
> > > - *   ``EACCES``.  The ``EACCES`` errno prevails over ``EXDEV`` to let user space
> > > - *   efficiently deal with an unrecoverable error.
> > > + *   directory (i.e. reparent a file hierarchy).
> > > + *
> > > + *   This access right is available since the second version of the Landlock
> > > + *   ABI.  This is also the only access right which is always considered
> > > + *   handled by any ruleset in such a way that reparenting a file hierarchy is
> > 
> > This is from me, but do you think "reparenting a file hierarchy" is not
> > confusing? What about "reparenting a file or a directory"? Not sure which
> > one is better.
> 
> I find that sentence confusing as well, but the "reparenting a file"
> part is not the confusing part to me.
> 
> Proposal for this paragraph:
> 
>   This access right is available since the second version of the
>   Landlock.  This is also the only access right which is implicitly
>   handled by any ruleset, even if the right is not specified at the
>   time of creating the ruleset.  So by default, Landlock will deny
>   linking and reparenting files between different directories, and
>   only grant this right when it is explicitly permitted to a directory
>   by adding a rule.
> 
>   When using the first Landlock ABI version, Landlock will always deny
>   the reparenting of files between different directories.

Sorry, correction (+ABI, s/to/for/):

  This access right is available since the second version of the
  Landlock ABI.  This is also the only access right which is
  implicitly handled by any ruleset, even if the right is not
  specified at the time of creating the ruleset. So, by default,
  Landlock will deny linking and reparenting files between different
  directories, and only grant this right when it is explicitly
  permitted for a directory by adding a rule.
 
  When using the first Landlock ABI version, Landlock will always deny
  the reparenting of files between different directories.
> 
> > 
> > I'm not sure either if we should use "deny" or "forbidden". Is there a
> > difference? According to https://www.wikidiff.com/deny/forbid it seems that
> > "deny" would be more appropriate because Landlock rules add exceptions to a
> > forbidden set of actions… However, "deny" needs to be followed by "access"
> > for the same use, which makes your wording correct. Just a thought.
> > 
> > 
> > > + *   always denied by default.  If left unspecified during the creation of a
> > > + *   ruleset, linking and renaming files between different directories will be
> > > + *   forbidden, which is also the case when using the first Landlock ABI.
> > > + *
> > > + *   In addition to permitting this access right, the following constraints
> > > + *   must hold for the access rights on the source and destination directory:
> 
> Proposal for this paragraph:
> 
>   In addition to the source and destination directories having the
>   %LANDLOCK_ACCESS_FS_REFER access right, the attempted link or rename
>   operation must meet the following constraints:
> 
> > > + *
> > > + *   * The destination directory may not grant any access rights which are
> > > + *     forbidden for the source file. Otherwise, the operation results in an
> > 
> > The files/directories don't grant accesses but the sandbox/domain do grant
> > some accesses for a set of file hierarchies.
> > 
> > What about "Any forbidden actions on the source file must also be forbidden
> > on the destination file."
> > Or "Any denied accesses on the source file…"
> 
> Both valid points. How about the following phrasing which is
> formulated a bit closer to the actual goal (not creating a loophole
> through which you can gain more access rights for a file):
> 
>   * The reparented file may not attain more access rights in the
>     destination directory than it previously had in the source
>     directory.  If this is attempted, the operation results in an
>     ``EXDEV`` error.
> 
> > This seems a bit weird according to the previous "must hold for the access
> > rights on the source and destination directory" though.
> 
> +1, I reformulated that too above.
> 
> > 
> > 
> > > + *     ``EXDEV`` error.
> > > + *
> > > + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for
> > > + *     the respective file type is required in the destination directory.
> > 
> > s/is required in the destination/must be granted for the destination/ ?
> 
> Done.
> 
> > 
> > 
> > > + *     Otherwise, the operation results in an ``EACCES`` error.
> > > + *
> > > + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
> > > + *     respective file type is required in the source directory.  Otherwise,
> > 
> > Same "must be granted for"
> 
> Done.
> 
> > 
> > 
> > > + *     the operation results in an ``EACCES`` error.
> > > + *
> > > + *   If multiple requirements are not met, the ``EACCES`` error code takes
> > > + *   precedence over ``EXDEV``.
> > >    *
> > >    * .. warning::
> > >    *
> > > 
> > > base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
