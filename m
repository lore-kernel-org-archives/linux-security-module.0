Return-Path: <SRS0=Vtm6=VO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA099C76186
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 12:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B41217F9
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 12:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YwK2iX9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfGQMOr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:14:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34181 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQMOq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jul 2019 08:14:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so9044984lfq.1
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2019 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8//XbOhkKVpJiK+q5UMQizMtrSss/8pHXbVWHOnp8M=;
        b=YwK2iX9W1nWVBOwPM4N/KC0f3fzRB5TC9Kvv/Nqic/BN1lVsgjCZTYyNwhSQqjw9Mv
         uw43maB2a4lzQ2w1AwD1WOj3g5HZp7Yi1Km3bWmeG/tRhvLiUq12SNSJCDNEAflvit6d
         un1YiwkV/Jhi6SunngBIQP/gFoFJKYdKKnQdeC5O8aSBnG447Ce63Xn8s4TqHotG8154
         5g87d7YqouzL9cbjv9oqlz7sUSpZyml6mr0jy4BqXtEjnjY+3Gh2ibcA+/k2Mh3Ukj4Z
         xkAbCl9KQkz+HTZEHAyFMG8JcgouJRw9F/6VrHyx7B5Mpwd7fGJx7S2Tfbv+hkQjpnRw
         h6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8//XbOhkKVpJiK+q5UMQizMtrSss/8pHXbVWHOnp8M=;
        b=IOowY6HHqi5ovfMsrDAQ0gm/mgvFchGhRWq5ZWW5uzSj29dlAn1XSgVCy60tDWJrHn
         8AcwBjvtlBagyr9aJP8w+aRU2BbPrjRANcGIB2Xa31lgCz36o1XS31jIwb64kVCUqJlx
         OhSmghAXs7iipmwg1qHxeaAh9hIuoX1RdrH6/X/t5LIhjQjwMeBgOptIxkb/fIrBJr6T
         0aYTyL/odCNatHXPoIIZ6YHOlhKpD99JMMU+duEZnSf+9fgVcibOYm+QR8rgXwoszczo
         slgR9TudZTuCrhWQdB5W/o3grPSoH9j+FRxpgGoos6rLqgrML32FQPJTn7v/esJrndxc
         BsTg==
X-Gm-Message-State: APjAAAXLG7uwWo/YGSTYgD/OQdrPcCmFrF3YcfUstSCjSH3iKbiQbqqp
        ReCfXGq+f7cHPA3HP/28IwSS0Uo66ZJFdZ4wj2O5LWI=
X-Google-Smtp-Source: APXvYqyniYh0/blvwu0++qJJJXZh/FE1QwpFlNlIdDMPfquzHJM4sxsvXSx/ATMHZd1IVN8o4497thCr8hvFn4BhkfY=
X-Received: by 2002:a19:4349:: with SMTP id m9mr17398623lfj.64.1563365684685;
 Wed, 17 Jul 2019 05:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2> <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com> <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
In-Reply-To: <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Jul 2019 08:14:33 -0400
Message-ID: <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
Subject: Re: Preferred subj= with multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 16, 2019 at 7:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/16/2019 4:13 PM, Paul Moore wrote:
> > On Tue, Jul 16, 2019 at 6:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> It sounds as if some variant of the Hideous format:
> >>
> >>         subj=selinux='a:b:c:d',apparmor='z'
> >>         subj=selinux/a:b:c:d/apparmor/z
> >>         subj=(selinux)a:b:c:d/(apparmor)z
> >>
> >> would meet Steve's searchability requirements, but with significant
> >> parsing performance penalties.
> > I think "hideous format" sums it up nicely.  Whatever we choose here
> > we are likely going to be stuck with for some time and I'm near to
> > 100% that multiplexing the labels onto a single field is going to be a
> > disaster.
>
> If the requirement is that subj= be searchable I don't see much of
> an alternative to a Hideous format. If we can get past that, and say
> that all subj_* have to be searchable we can avoid that set of issues.
> Instead of:
>
>         s = strstr(source, "subj=")
>         search_after_subj(s, ...);

This example does a lot of hand waving in search_after_subj(...)
regarding parsing the multiplexed LSM label.  Unless we restrict the
LSM label formats (which seems both wrong, and too late IMHO) we have
a parsing nightmare; can you write a safe multiplexed LSM label parser
without knowledge of each LSM label format?  Can you do that for each
LSM without knowing their loaded policy?  What happens when the policy
and/or label format changes?  What happens in a few years when another
LSM is added to the kernel?

> we have
>
>         s = source
>         for (i = 0; i < lsm_slots ; i++) {
>                 s = strstr(s, "subj_")
>                 if (!s)
>                         break;
>                 s = search_after_subj_(s, lsm_slot_name[i], ...)

The hand waving here in search_after_subj_(...) is much less;
essentially you just match "subj_X" and then you can take the field
value as the LSM's label without having to know the format, the policy
loaded, etc.  It is both safer and doesn't require knowledge of the
LSMs (the LSM "name" can be specified as a parameter to the search
tool).

> There's enough ugly to go around either way.
> And I'm not partial to either approach, but do would very
> much like to get the code done so I can get on to the next
> set of amazing challenges.
>
> Oh, and I don't want to pick on subj= as obj= has the exact same issues.

Yes, I stopped talking about both subj and obj some time ago in this
thread because I figure we can use the same approach for both.

-- 
paul moore
www.paul-moore.com
