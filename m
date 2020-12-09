Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE4C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Dec 2020 10:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC0723B79
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Dec 2020 10:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgLIKOK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgLIKOJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Dec 2020 05:14:09 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF5C061794
        for <linux-security-module@vger.kernel.org>; Wed,  9 Dec 2020 02:13:29 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id h6so577361vsr.6
        for <linux-security-module@vger.kernel.org>; Wed, 09 Dec 2020 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQQ1cftUs+z76vK6Lt731SlO6kCrFdJIO/2nHU2yT40=;
        b=o/bXVedngN5pBxJH9KaF1htfa8gkhRjfiZvttaWZRToXJRtG+QqS8OSvQkhoND4ds6
         8gLvFQLHhyGLVUZNOAdOIMFep9yf6detoqQLZk944USazgAMRCEgAuMgdlpjrMWdeGNF
         ZdmnLWUhd+cDms8Du28ybWfG6vGi9quEFLNrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQQ1cftUs+z76vK6Lt731SlO6kCrFdJIO/2nHU2yT40=;
        b=Hfv3sxNnpZDlef1laJFfwVNibF2zmqHyKMlyP7XUM+fJraQsseopWtB0GqyQDjybxJ
         S2IYZqvxqKaU615gBTxTZ/0Yer7+yaee4GsoXGhfujX9a2h9/oSoWNXwfYp2Qp6Ez304
         8CRNnB0TeZ4Ro4oLWL63rDgm6LUkN/sMdFKJWaTcMGfr9v/UPxTT6kjWXsvT5dPkciJ2
         wRslRtHDr3x3kahoK0o4lcVVmLhm1RQaomPZb+1cUNCjqais58+AdWxW6y3qI2x1BqbW
         4TgjHS+GNCqSW/etxNt/PIu6htYFVq3GbM9Q1b+KbzM+2CoSvXBkWVu4zXewse5TzO+L
         6x8w==
X-Gm-Message-State: AOAM533wASqxYxaB0gajuG72AFfPw9JkxxEYaMj9ld5C5l+YHqp5JtjN
        LDQwJsIszJ2fehkoZN60Ntl+SSk2HkdHn2ON/RzUsg==
X-Google-Smtp-Source: ABdhPJzREqcFmVRiyHTHLToKAaVH2NKuecCoZyx8wfazBSxTrTVhIRS7jyFnBaKgTWOjW7kai9p6aOWj8y5f7/0D+t0=
X-Received: by 2002:a67:ed57:: with SMTP id m23mr926246vsp.7.1607508808505;
 Wed, 09 Dec 2020 02:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-4-mszeredi@redhat.com>
 <CAOQ4uxhti+COYB3GhfMcPFwpfBRYQvr98oCO9wwS029W5e0A5g@mail.gmail.com>
In-Reply-To: <CAOQ4uxhti+COYB3GhfMcPFwpfBRYQvr98oCO9wwS029W5e0A5g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 9 Dec 2020 11:13:17 +0100
Message-ID: <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ovl: check privs before decoding file handle
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 8, 2020 at 2:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 7, 2020 at 6:36 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > CAP_DAC_READ_SEARCH is required by open_by_handle_at(2) so check it in
> > ovl_decode_real_fh() as well to prevent privilege escalation for
> > unprivileged overlay mounts.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/namei.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > index a6162c4076db..82a55fdb1e7a 100644
> > --- a/fs/overlayfs/namei.c
> > +++ b/fs/overlayfs/namei.c
> > @@ -156,6 +156,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
> >         struct dentry *real;
> >         int bytes;
> >
> > +       if (!capable(CAP_DAC_READ_SEARCH))
> > +               return NULL;
> > +
>
> If the mounter is not capable in init ns, ovl_check_origin() and
> ovl_verify_index()
> will not function as expected and this will break index and nfs export features.

NFS export is clear-cut.

Hard link indexing should work without fh decoding, since it is only
encoding the file handle to search for the index entry, and encoding
is not privileged.

Not sure how ovl_verify_index will choke on that, will have to try...
but worse case we just need to disable verification.

And yeah, using .overlay.origin attribute for inode number consistency
won't work either, but it should fail silently (which is probably a
good thing).  Haven't tested this yet, though.

Thanks,
Miklos
