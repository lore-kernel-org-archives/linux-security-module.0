Return-Path: <SRS0=Y89O=VQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E319FC7618F
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 21:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0682186A
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 21:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="n95Gc178"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfGSVWO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:22:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35086 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfGSVWN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Jul 2019 17:22:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so32084448ljh.2
        for <linux-security-module@vger.kernel.org>; Fri, 19 Jul 2019 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmyIx3tRb/tlcUVPTSOrwnPlwWKZg8Em0s+OM8jX8mI=;
        b=n95Gc178eFcY2xnjYB5CgYvzAJGwYVBwb4KlO97D+AV45meU9rJzJ6K6LAL/fQgs/H
         jSnOI29QFKbgXqF5eqP4lgLijrLvfzvl1j56g81dK6S0vqSTwSdxhj58sBQBQpqgBGG/
         5yt37H9y7lH1RTsCUnfvFHtnSp6f2wB/yiFvPSH0k5o2Cy/azLVEp3OyVzi0BWMle/4k
         GHQX1TVzdH2h5xYYQO6GhISVzz9inHjjpTwWia6e1ejAt5n+WuT5Y0Ve3vFakidnDnxB
         qX5smBBO46hQlwvLOwRQUA7jD26AB2tlbUpjIxXJsNOhQAycSf6OL6nRp2MnW6MIJCbh
         9UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmyIx3tRb/tlcUVPTSOrwnPlwWKZg8Em0s+OM8jX8mI=;
        b=GyV4QSG/g4y72IQScpa1T5X1GSx0QGgCRAX50IJzYeMpvkwuFLIUQxQbkk6ncIV1TJ
         zvxHJP91hOL+txNMyxjXajXATWPe3eUaQqt7uNZRzPT3Plun0cxGLR6B5eYI8cSz4tu8
         4Xz8KEbxnMNz1F86itzVAmMWWw+xed20uteQlz/+RJtnvJMDzVfpJcyTdwW0hvRle9sQ
         s+t287hHi74WGUot6VL1eaThYLqHAA4H3DxX7G9w3p29wypd+MRIg6AzU+pC9TObOMua
         k0TRq2jIdcjscqybp9FKFvUyYCOLReBexoL+DdvcU9hQo2lFmKt6/oCSvmujEX6/r57A
         +rPQ==
X-Gm-Message-State: APjAAAVWzrHVeSHp23UxtiRtXeoLJq3IsXmrnhaP0SE8LaayUYUNqXO3
        mnVADHWmiAYZeuPy6KMm48WqtlQC2mdRGZvv/g==
X-Google-Smtp-Source: APXvYqxTbwQCTR5hYf1qyFYRX5A72KKEmIRlHouK+WfC+E33TShZ6S7z0CO7DF9IYhLBPGs5qdCe1cLcDQOij/GJ70M=
X-Received: by 2002:a2e:86c3:: with SMTP id n3mr29852522ljj.129.1563571330913;
 Fri, 19 Jul 2019 14:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2> <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com> <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com> <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
In-Reply-To: <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Jul 2019 17:21:58 -0400
Message-ID: <CAHC9VhTf0yYDZBxOtfv2E5=GtrBYonoqr46hyBy7qdNdjVLoVg@mail.gmail.com>
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

On Wed, Jul 17, 2019 at 7:02 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/17/2019 9:23 AM, Paul Moore wrote:
> > On Wed, Jul 17, 2019 at 11:49 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 7/17/2019 5:14 AM, Paul Moore wrote:
> >>> On Tue, Jul 16, 2019 at 7:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> On 7/16/2019 4:13 PM, Paul Moore wrote:
> >>>>> On Tue, Jul 16, 2019 at 6:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>>> It sounds as if some variant of the Hideous format:
> >>>>>>
> >>>>>>         subj=selinux='a:b:c:d',apparmor='z'
> >>>>>>         subj=selinux/a:b:c:d/apparmor/z
> >>>>>>         subj=(selinux)a:b:c:d/(apparmor)z
> >>>>>>
> >>>>>> would meet Steve's searchability requirements, but with significant
> >>>>>> parsing performance penalties.
> >>>>> I think "hideous format" sums it up nicely.  Whatever we choose here
> >>>>> we are likely going to be stuck with for some time and I'm near to
> >>>>> 100% that multiplexing the labels onto a single field is going to be a
> >>>>> disaster.
> >>>> If the requirement is that subj= be searchable I don't see much of
> >>>> an alternative to a Hideous format. If we can get past that, and say
> >>>> that all subj_* have to be searchable we can avoid that set of issues.
> >>>> Instead of:
> >>>>
> >>>>         s = strstr(source, "subj=")
> >>>>         search_after_subj(s, ...);
> >>> This example does a lot of hand waving in search_after_subj(...)
> >>> regarding parsing the multiplexed LSM label.  Unless we restrict the
> >>> LSM label formats (which seems both wrong, and too late IMHO)
> >> I don't think it's too late, and I think it would be healthy
> >> to restrict LSM "contexts" to character sets that make command
> >> line specification possible. Embedded newlines? Ewwww.
> > That would imply that the delimiter you would choose for the
> > multiplexed approach would be something odd (I think you suggested
> > 0x02, or similar, earlier) which would likely require the multiplexed
> > subj field to become a hex encoded field which would be very
> > unfortunate in my opinion and would technically break with the current
> > subj/obj field format spec.  Picking a normal-ish delimiter, and
> > restricting its use by LSMs seems wrong to me.
>
> Just say "no" to hex encoding!

Yes, it's best avoided.

> BTW, keys are not hex encoded.

The kernel keyring keys?  Not really relevant here I don't think.

> We've never had to think about having general rules on
> what security modules do before, because with only one
> active each could do whatever it wanted without fear of
> conflict. If there is already a character that none of
> the existing modules use, how would it be wrong to
> reserve it?

"We've never had to think about having general rules on what security
modules do before..."

We famously haven't imposed restrictions on the label format before
now, and this seems like a pretty poor reason to start.

> > It's important to remember that Steve's strstr() comment only reflects
> > his set of userspace tools.  When you start talking about log
> > aggregation and analytics, it seems very likely that there are other
> > tools in use, likely with their own parsers that do much more
> > complicated searches than a simple strstr() call.
>
> Point. But long term, they'll have to be updated to accommodate
> whatever we decide on. Which makes the "simple" case, where one
> security module is in use all the more important.

Both the multiplexed and subj_X proposals handle the single major LSM
case the same: identical to what we have now.  Regardless of how
important the single major LSM case may be, it isn't a distinguishing
factor in this discussion.

> >>>> we have
> >>>>
> >>>>         s = source
> >>>>         for (i = 0; i < lsm_slots ; i++) {
> >>>>                 s = strstr(s, "subj_")
> >>>>                 if (!s)
> >>>>                         break;
> >>>>                 s = search_after_subj_(s, lsm_slot_name[i], ...)
> >>> The hand waving here in search_after_subj_(...) is much less;
> >>> essentially you just match "subj_X" and then you can take the field
> >>> value as the LSM's label without having to know the format, the policy
> >>> loaded, etc.  It is both safer and doesn't require knowledge of the
> >>> LSMs (the LSM "name" can be specified as a parameter to the search
> >>> tool).
> >> You can do that with the Hideous format as well. I wouldn't
> >> say which would be easier without delving into the audit user
> >> space.
>
> > No, you can't.  You still need to parse the multiplexed mess, that's
> > the problem.
>
> You move the parsing problem to the record, where you have to
> look for subj_selinux= instead of having the parsing problem in
> the subj= field, where you look for something like selinux=
> within the field. Neither looks like the work of an afternoon to
> get right.

Finding subj_X in an audit record is no different than finding any
other field in a record.  Parsing the multiplexed label mess is a
whole different problem and prone to lots of mistakes.

> It probably looks like I'm arguing for the Hideous format option.
> That would require less work and code disruption, so it is tempting
> to push for it. But I would have to know the user space side a
> whole lot better than I do to feel good about pushing anything that
> isn't obviously a good choice. I kind of prefer Paul's "subj=?"
> approach, but as it's harder, I don't want to spend too much time
> on it if it gets me a big, juicy, well deserved NAK.

I didn't want to have to NAK this, but if that is what it is going to
take, so be it ... as it currently stands I'm NAK'ing the the
multiplexed approach.  You don't have to go with the subj_X approach,
but the multiplexed approach is a terrible idea and I can almost
guarantee that we would be regretting that choice in a few years time.

-- 
paul moore
www.paul-moore.com
