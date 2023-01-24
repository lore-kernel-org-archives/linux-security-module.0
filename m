Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B8FC38142
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Jan 2023 17:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjAXRBA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjAXRA7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Jan 2023 12:00:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C346D55
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jan 2023 09:00:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so14654030pjl.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jan 2023 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NvlI0i6tuIH+cEsFMK651QuzmfDYjvdOyfnJQ4mWPaM=;
        b=fBCyoy0jsWCHcQ5tg6XSqYXIY6XFpXsrjLZ6mXT3WPizdVoFT6JVhQEWOkpHqjh6wd
         ngsgH5NdU4lVbh05bTwLfzo8vbU25MvXhkW7NPzn049LZvVCtXWQ38wIYoIYkz3gtNlN
         5YUbcMG5dqMJh67/3Z3i2GpSIA9l3JSInqAIhpIl1NkXTUjXaFXOqA5dEagK8pD/6z6y
         x6Uw73dClMjkTkQx0hS/sjlyaxOGmjFopku5JE1XKSHnHHXmK/H3ALIIad9NX0SUR5di
         ZbiNpEi1Y2sd/fQJ/WSWuycdhMHRhMbsEWnYRwc6HZn8+YIxs2nztaNFQaXsNjVH78uX
         VF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvlI0i6tuIH+cEsFMK651QuzmfDYjvdOyfnJQ4mWPaM=;
        b=EA6Hiw680xcB+h4zwWZat9jpkGxuBcR/SkyJFvuoDclAuARKNGRQKr2fijjZQnjgie
         bQmhob4Z4vU32NYxVSLKG5poxb6ySF9828lp1oJ81Bf08vvKf1PYdVPQUe8ne37SCoxu
         ezHFsv4MeudLSh7Fva0UN4PGGTMEi5en3GoXDbhuJAXaoWNkaITUAl8WhK2xgaV7tjIs
         8BmH2e0upver7ZK3kxaQpyf8YIahH3exlQEdgbdXunHeAqc9iPEef7jP4OIsJb2mIKzH
         Q2zpTmduRXUJsZMqoVyg8ubDqwcWP9V0kvmzhY6kPDiQ7cpA01Ll81dFnrauiO+6iXV7
         NRlg==
X-Gm-Message-State: AFqh2kp8XokkNUmdiSih1+poH1iQwg8NLw6NvX1RuAGeEuVOM3oHWacR
        FBviIN0Ee4Oz7bXGK5Dv+ayVjdcG/0C6f2IzHhzT
X-Google-Smtp-Source: AMrXdXs5LwusCrxpDA+RsriJbYMYR5uAig0mVQQF9cpIROxbArDIWF2uu/OmQcjY4r+XZtUpmQv4jd4LezcJvj0+/Zk=
X-Received: by 2002:a17:90a:17a1:b0:229:9ffe:135b with SMTP id
 q30-20020a17090a17a100b002299ffe135bmr3346473pja.72.1674579655647; Tue, 24
 Jan 2023 09:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com> <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
In-Reply-To: <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jan 2023 12:00:46 -0500
Message-ID: <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 24, 2023 at 5:16 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 1/23/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jan 20, 2023 at 7:50 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >> On 1/20/23, Paul Moore <paul@paul-moore.com> wrote:
> >> > On Mon, Jan 16, 2023 at 4:21 PM Mateusz Guzik <mjguzik@gmail.com>
> >> > wrote:
> >> >>
> >> >> access(2) remains commonly used, for example on exec:
> >> >> access("/etc/ld.so.preload", R_OK)
> >> >>
> >> >> or when running gcc: strace -c gcc empty.c
> >> >> % time     seconds  usecs/call     calls    errors syscall
> >> >> ------ ----------- ----------- --------- --------- ----------------
> >> >>   0.00    0.000000           0        42        26 access
> >> >>
> >> >> It falls down to do_faccessat without the AT_EACCESS flag, which in
> >> >> turn
> >> >> results in allocation of new creds in order to modify fsuid/fsgid and
> >> >> caps. This is a very expensive process single-threaded and most
> >> >> notably
> >> >> multi-threaded, with numerous structures getting refed and unrefed on
> >> >> imminent new cred destruction.
> >> >>
> >> >> Turns out for typical consumers the resulting creds would be identical
> >> >> and this can be checked upfront, avoiding the hard work.
> >> >>
> >> >> An access benchmark plugged into will-it-scale running on Cascade Lake
> >> >> shows:
> >> >> test    proc    before  after
> >> >> access1 1       1310582 2908735  (+121%)  # distinct files
> >> >> access1 24      4716491 63822173 (+1353%) # distinct files
> >> >> access2 24      2378041 5370335  (+125%)  # same file
> >> >
> >> > Out of curiosity, do you have any measurements of the impact this
> >> > patch has on the AT_EACCESS case when the creds do need to be
> >> > modified?
> >>
> >> I could not be arsed to bench that. I'm not saying there is literally 0
> >> impact, but it should not be high and the massive win in the case I
> >> patched imho justifies it.
> >
> > That's one way to respond to an honest question asking if you've done
> > any tests on the other side of the change.  I agree the impact should
> > be less than the advantage you've shown, but sometimes it's nice to
> > see these things.
>
> So reading this now I do think it was worded in quite a poor manner, so
> apologies for that.

Thanks, but no worries.  Work in this space long enough and everyone
eventually ends up sending a mail or two that could have been worded
better, myself included.

> Wording aside, I don't know whether this is just a passing remark or
> are you genuinely concerned about the other case.

My main concern is the duplication between the cred check and the cred
override functions leading to a bug at some unknown point in the
future.  Changes to credential checking, and access control in
general, always gets my attention and due to past bruises I'm very
sensitive to out-of-sync issues due to code duplication; so your patch
was a bit of a "perfect storm" of concern for me :)

The profiling questions were mainly there as a curiosity since it
looked like this was part of a larger performance oriented effort and
I thought you might have more data that didn't make it into the commit
description.

> >> These funcs are literally next to each other, I don't think that is easy
> >> to miss. I concede a comment in access_override_creds to take a look at
> >> access_need_override_creds would not hurt, but I don't know if a resend
> >> to add it is justified.
> >
> > Perhaps it's because I have to deal with a fair amount of code getting
> > changed in one place and not another, but I would think that a comment
> > would be the least one could do here and would justify a respin.
>
> I'm not going to *insist* on not adding that comment.
>
> Would this work for you?
>
> diff --git a/fs/open.c b/fs/open.c
> index 3c068a38044c..756177b94b04 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -407,6 +407,11 @@ static const struct cred *access_override_creds(void)
>         if (!override_cred)
>                 return NULL;
>
> +       /*
> +        * XXX access_need_override_creds performs checks in hopes of
> +        * skipping this work. Make sure it stays in sync if making any
> +        * changes here.
> +        */
>         override_cred->fsuid = override_cred->uid;
>         override_cred->fsgid = override_cred->gid;
>
> if not, can you phrase it however you see fit for me to copy-paste?

That wording looks good to me and would help me feel a bit better
about this change, thank you.

-- 
paul-moore.com
