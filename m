Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E46C636CC
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Feb 2023 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBOSdY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Feb 2023 13:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBOSdX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Feb 2023 13:33:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C40392AC
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 10:33:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c1so20573338edt.4
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yV8pmHAcGRjVtA7WzV8tc55Q4/+dh+A4FAyw2mHU88w=;
        b=MV9J4TqDSc8b7+jb1of/BQG+D93y+8MoxOCnjWRRMk+TQ32Fzn0E+Ykzng9qgH7Xc+
         ppSP1sy8q2Cz4sAsB09xZbhORuEmtHMtjHNOA09cAlTI8/Gf2HxNO+4SilrEWUjkOgwj
         m4H4l4XAPM8baZshkLdUgmmC32QC6cTga2YDaJoEVM8mOw7Cotdp1L1ORyEp1JfbjI7B
         sLhuO40Y3WhFtdi3ojffncma8eufnxqGuXKeyQcViM/VPcm2044MsLZcEuyY9sDGFgus
         My1vJOjrMY86CwROB//Z4WhzlPoxv+66uwuvp6c9xhgBERyM9KhjG1JzxDDZluAgrihd
         d/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV8pmHAcGRjVtA7WzV8tc55Q4/+dh+A4FAyw2mHU88w=;
        b=m/PNuxW4xVsB+9FgSMeNKu1rb5ttPo8rmWuy7MfnHNmTnAptj9DwKgdd9tr3351GlB
         NbkJGoNmEldRCHIbddC5BETBEhoJTQ5ducAOjQ97znSGCAxWTNFBvxY8JlUJO7id/ltv
         pLx5cv5DcEBDpnLZBt5ItueYNGsbKamLpZSuA0xoaAA0gWnPWhJnTOspIl5gKsvYA+S+
         xIWX8y9dzuMyd/g8SsiRAOouvwa1n1v50LtwAgueC4BOLfwSieWAgzF2IDkjqPn4Dule
         ai/C2x24jX5sQ2Q+i4IBTtDfJE68aRAheNAtqCJpmXY5yeEzQ+W769WeieJn8g4uGa1p
         pZWg==
X-Gm-Message-State: AO0yUKUzDErTjLH958dih6p3KHglwrL7VENwgM7z5UM5BlDfcaZ/Hsrb
        BtDR6ZnpXH2AjdQ41TaN9pk6fy8rHXI=
X-Google-Smtp-Source: AK7set8jEKnNIK463fiGaTrGvGq12DvFmS9T383tVdnfVbwNR9M778ggrR43CcPVB42PSrcwAefuig==
X-Received: by 2002:a17:907:208f:b0:8b1:3add:5432 with SMTP id pv15-20020a170907208f00b008b13add5432mr3299310ejb.19.1676486000152;
        Wed, 15 Feb 2023 10:33:20 -0800 (PST)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b00871f66bf354sm9910848ejp.204.2023.02.15.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:33:19 -0800 (PST)
Date:   Wed, 15 Feb 2023 19:33:15 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH v2] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Message-ID: <Y+0la4VBbkV8rlkD@galopp>
References: <20230213210115.5150-1-gnoack3000@gmail.com>
 <d8112efe-d270-3013-97e6-bcc7c5237c02@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8112efe-d270-3013-97e6-bcc7c5237c02@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for the feedback, Mickaël!

See some proposals for rephrasings inline. I tried to avoid passive
voice to make it easier to follow. Please let me know what you think.

(Any native English speakers are more than welcome to chime in as well. 8-))

–-Günther

On Tue, Feb 14, 2023 at 01:04:04PM +0100, Mickaël Salaün wrote:
> 
> On 13/02/2023 22:01, Günther Noack wrote:
> > Clarify the "refer" documentation by splitting up a big paragraph of text.
> > 
> > - Call out specifically that the denial by default applies to ABI v1 as well.
> > - Turn the three additional constraints for link/rename operations
> >    into bullet points, to give it more structure.
> > 
> > Includes wording and semantics corrections by Mickaël Salaün.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
> >   1 file changed, 26 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index f3223f96469..f6bccd87aa0 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -130,21 +130,32 @@ struct landlock_path_beneath_attr {
> >    * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create (or rename or link) a block device.
> >    * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create (or rename or link) a symbolic link.
> >    * - %LANDLOCK_ACCESS_FS_REFER: Link or rename a file from or to a different
> > - *   directory (i.e. reparent a file hierarchy).  This access right is
> > - *   available since the second version of the Landlock ABI.  This is also the
> > - *   only access right which is always considered handled by any ruleset in
> > - *   such a way that reparenting a file hierarchy is always denied by default.
> > - *   To avoid privilege escalation, it is not enough to add a rule with this
> > - *   access right.  When linking or renaming a file, the destination directory
> > - *   hierarchy must also always have the same or a superset of restrictions of
> > - *   the source hierarchy.  If it is not the case, or if the domain doesn't
> > - *   handle this access right, such actions are denied by default with errno
> > - *   set to ``EXDEV``.  Linking also requires a ``LANDLOCK_ACCESS_FS_MAKE_*``
> > - *   access right on the destination directory, and renaming also requires a
> > - *   ``LANDLOCK_ACCESS_FS_REMOVE_*`` access right on the source's (file or
> > - *   directory) parent.  Otherwise, such actions are denied with errno set to
> > - *   ``EACCES``.  The ``EACCES`` errno prevails over ``EXDEV`` to let user space
> > - *   efficiently deal with an unrecoverable error.
> > + *   directory (i.e. reparent a file hierarchy).
> > + *
> > + *   This access right is available since the second version of the Landlock
> > + *   ABI.  This is also the only access right which is always considered
> > + *   handled by any ruleset in such a way that reparenting a file hierarchy is
> 
> This is from me, but do you think "reparenting a file hierarchy" is not
> confusing? What about "reparenting a file or a directory"? Not sure which
> one is better.

I find that sentence confusing as well, but the "reparenting a file"
part is not the confusing part to me.

Proposal for this paragraph:

  This access right is available since the second version of the
  Landlock.  This is also the only access right which is implicitly
  handled by any ruleset, even if the right is not specified at the
  time of creating the ruleset.  So by default, Landlock will deny
  linking and reparenting files between different directories, and
  only grant this right when it is explicitly permitted to a directory
  by adding a rule.

  When using the first Landlock ABI version, Landlock will always deny
  the reparenting of files between different directories.

> 
> I'm not sure either if we should use "deny" or "forbidden". Is there a
> difference? According to https://www.wikidiff.com/deny/forbid it seems that
> "deny" would be more appropriate because Landlock rules add exceptions to a
> forbidden set of actions… However, "deny" needs to be followed by "access"
> for the same use, which makes your wording correct. Just a thought.
> 
> 
> > + *   always denied by default.  If left unspecified during the creation of a
> > + *   ruleset, linking and renaming files between different directories will be
> > + *   forbidden, which is also the case when using the first Landlock ABI.
> > + *
> > + *   In addition to permitting this access right, the following constraints
> > + *   must hold for the access rights on the source and destination directory:

Proposal for this paragraph:

  In addition to the source and destination directories having the
  %LANDLOCK_ACCESS_FS_REFER access right, the attempted link or rename
  operation must meet the following constraints:

> > + *
> > + *   * The destination directory may not grant any access rights which are
> > + *     forbidden for the source file. Otherwise, the operation results in an
> 
> The files/directories don't grant accesses but the sandbox/domain do grant
> some accesses for a set of file hierarchies.
> 
> What about "Any forbidden actions on the source file must also be forbidden
> on the destination file."
> Or "Any denied accesses on the source file…"

Both valid points. How about the following phrasing which is
formulated a bit closer to the actual goal (not creating a loophole
through which you can gain more access rights for a file):

  * The reparented file may not attain more access rights in the
    destination directory than it previously had in the source
    directory.  If this is attempted, the operation results in an
    ``EXDEV`` error.

> This seems a bit weird according to the previous "must hold for the access
> rights on the source and destination directory" though.

+1, I reformulated that too above.

> 
> 
> > + *     ``EXDEV`` error.
> > + *
> > + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for
> > + *     the respective file type is required in the destination directory.
> 
> s/is required in the destination/must be granted for the destination/ ?

Done.

> 
> 
> > + *     Otherwise, the operation results in an ``EACCES`` error.
> > + *
> > + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
> > + *     respective file type is required in the source directory.  Otherwise,
> 
> Same "must be granted for"

Done.

> 
> 
> > + *     the operation results in an ``EACCES`` error.
> > + *
> > + *   If multiple requirements are not met, the ``EACCES`` error code takes
> > + *   precedence over ``EXDEV``.
> >    *
> >    * .. warning::
> >    *
> > 
> > base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
