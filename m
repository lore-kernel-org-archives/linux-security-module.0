Return-Path: <SRS0=88KC=QN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D934C282D7
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 00:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4690D2183E
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Feb 2019 00:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jnjL1lGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfBFABz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:01:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42325 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfBFABz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 19:01:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so4026833lfh.9
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 16:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtb4u8vAn6E85kevz/Wb8pS9wsxJHSuYa6gDWy8SHJ0=;
        b=jnjL1lGoYuuwXAg+Fdznh5cH81xJgm8LybQlMSJjU75bGhOROeGETz60MLNOz1ZIjo
         6z1tnkWfjOIspVVRwDvZHlZvJARdYc61+I7Qa3l2vYVuKtVjcT8JliKQot4kPiBFiu+J
         xhbDNBtLcXcypTBr4PMTJNkU6pwUKjl+syqNN2bfuBKK1cxDIJVKsfLshGFokZCik4qJ
         lSQD3ID27qYs37+6ZA/3+7NMetk6N5RoaKs8SKFn+jFQvolOUFOacb9RVCw99O7aPypH
         A7FnrAXvkvzm0caDlOVq7cOhAMKpv9FdH2buGIYnghCg4HpZ+d2F27WHFMejLhHvyTQB
         gzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtb4u8vAn6E85kevz/Wb8pS9wsxJHSuYa6gDWy8SHJ0=;
        b=Qtg4zpbl/u14+IeVkSDaA1qNtWfkzMivKq0vAYSixREWBhcYBeSEJQ1vWKV1wp/Kne
         HeLc3zFuIuRjKu7YX89gVgoofJD8nDXRZYO+Nf1n4tEeIozxHD+z+v6sVkkgAi3TH9w6
         iOJoahqXxS7uC+1APiXUPgasFlYKqpx4VwisiA1AL4yvrS71i5xy7ijSN4fA9Mio7i11
         p0Og+ELPuHI6adGIvCvNPn1usuEmVqpbQR3ezQx3VG8NPFgTL+6NWsgWS8nuUEKO3UyX
         MKNujYKysD4l7Hr1Hic6977eDwdtS1a8j+BywL3RS3uVL9uRmU7SR55ccZJyp46FGLdf
         tqSg==
X-Gm-Message-State: AHQUAubiktyQEfBG2EFj1Htm3lmAZ58kSDtQuP3EH8sAsOUD+Ok+UCTA
        NbTVJQ3oxARgZI4iZyNacmPtZaTQOU2Kdgq1LG/8N68dHA==
X-Google-Smtp-Source: AHgI3IZcPvmY0APRG0DrauWLRepTcccUiovgmU3KJ1DvRxrjr2mYlMhKwm9Qq4P3iPwyKk9RG/ToeUdMwUlZnKI4SN8=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr4674065lfb.72.1549411311211;
 Tue, 05 Feb 2019 16:01:51 -0800 (PST)
MIME-Version: 1.0
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com> <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
In-Reply-To: <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Feb 2019 19:01:39 -0500
Message-ID: <CAHC9VhQ6p=LoEN6Rqze48FrVDsX0mfXHY4BvEaxU97w1azP4YQ@mail.gmail.com>
Subject: Re: New LSM hooks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 5, 2019 at 3:04 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/5/2019 10:15 AM, Paul Moore wrote:
> > On Tue, Feb 5, 2019 at 12:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Full disclosure: This is all about me and my interests.
> >>
> >> Developers propose new LSM hooks for many reasons. Often,
> >> it's in support of an exotic feature such as Infiniband.
> >> Sometimes it's because someone got clever when they optimized
> >> an otherwise mundane feature and bypassed the usual hooks,
> >> as is being proposed for kernfs. Usually there is a particular
> >> security module (i.e. SELinux) that is targeted for the hook.
> >> In almost all cases a hook is provided for that LSM, but not
> >> for any other. In many cases the developers don't even include
> >> the LSM email list in the discussions. LSM maintainers find
> >> out about the new hooks after the fact.
> >
> > I think it is each LSM maintainer's job to ensure that patches which
> > affect the LSM hooks, either through modification or addition, are
> > CC'd to the LSM list for discussion.  I've tried to be good about
> > this, but I'm sure I've missed some over the years.
>
> It's often not the LSM maintainer, but the developer of
> the feature that introduces the hook. That's the case that
> has been a problem.

I believe that will always be a problem, no matter what we do.  The
point I was trying to make was that everyone, especially the
maintainers, need to watch for this when patches are posted and make
sure the patch author posts to the LSM list in addition to any of the
relevant LSM specific lists.

> >> Prior to 2008, when there was only one LSM, this made perfect
> >> sense. Since then, it's been a regular practice justified by
> >> the notion that it's the LSM maintainer's option to use the
> >> hook or not. That also makes sense in cases where the use is
> >> strictly optional, as it is in binder. It does not make sense,
> >> however, when a core system facility like kernfs is involved.
> >
> > The term "optional" is tricky here.  In all the cases I can think of
> > where a LSM hook has been added to an existing bit of kernel
> > functionality, the hook has almost always been optional if for no
> > other reason than it didn't exist in the previous kernel.  I suppose
> > one could argue that there is a functional disparity between LSMs if
> > one LSM implements the hook and the others do not, but that is a
> > different issue.
>
> Agreed that there's ambiguity about what should be done for
> an "optional" feature. If RedHat adds support for a feature
> they have every reason to make sure it works correctly with
> SELinux and no incentive to implement AppArmor hooks.

I want to be very clear on this point, I don't care who submits the
patches, or who may pay them to do it.  From an upstream perspective,
patches are patches.  The individual patch submitter may not see
things quite this same way, but it is everyone's responsibility to
make sure that we do the Right Thing, regardless of who may be paying
us for our work.

Earlier in the thread I advocated for each of the LSM maintainers to
work with patchset authors who introduce new LSM hooks but don't
provide an implementation for their LSM.  I think it is that
cooperation and discussion which is important.

> ... But is overlayfs an "optional" feature?

I'm not using overlayfs on this Linux system right now, so I would
have to say "yes".  I know it will shock many who read this, but you
can still run a Linux system these days without containers.

> If the container developers
> who wanted overlayfs only cared about an SELinux environment
> does that excuse them from introducing a feature that didn't
> work with Smack?

There is a big difference between "doesn't work" and "not yet
implemented".  I'm not sure where things stand with respect to
overlayfs support in the various LSMs, but have you or any of the
other LSM maintainers tried working with Vivek to add support wherever
it may be missing?  He's a nice guy, you should send him mail.

> >> I get a double whammy on these new LSM hooks. I have to try
> >> to figure out if Smack cares, and if it does, whether to proposed
> >> hook will solve the problem for Smack. Because Smack uses
> >> xattrs and process attributes differently from SELinux there are
> >> often problems with hooks that are provided with only an SELinux
> >> implementation. I also have to work out how the new hook will
> >> work in the stacked security module case. There are some existing
> >> hooks that are a special challenge there, and when a new hook is
> >> proposed that does the same kind of things (e.g. use of secid,
> >> secctx or list of xattrs) without considering the consequences
> >> for other modules.
> >
> > Once again, I think it is important to CC the LSM list on these sorts
> > of patchsets, and to get the patch author to consider other LSMs, but
> > I think asking the original author to preemptively add support to each
> > LSM for every new addition is too high a bar.
>
> Two edged sword. If someone introduced an LSM that worked
> with btrfs but broke ext4 and xfs it wouldn't be likely to
> make it upstream. I wouldn't expect the developer who wants
> to introduce a new hook to provide all the LSM versions, but
> I would like that developer to work with the LSM maintainers
> before the patch is submitted.

With that last sentence above I think we're pretty much saying the
same thing, the only real difference is that I don't particularly care
when the collaboration takes place so long as it takes place.  In my
opinion it would be foolish to hold off committing working support in
one LSM because support for another remains a work in progress.  The
LSM interface is not a protected interface that needs to be preserved,
if it is broken or doesn't meet our needs, we change it.  We've been
doing this for years, and regardless of what may come from this I
expect existing and future hooks will continue to change over time.
Predicting the future is impossible, agreeing to work together to deal
with the future as it comes is much easier.

> >   I would encourage the
> > individual LSMs (both maintainers and contributors) to work with patch
> > authors in a constructive manner to add support for new hooks when
> > they make sense for the given LSM.
>
> Yes.
>
> >> What do I want, I hear you cry? I want some sanity in the way
> >> LSM hooks are introduced. I want some standards or conventions
> >> on what is appropriate to pass into and out of LSM hooks. I
> >> want push back on special purpose hooks that are required to
> >> fix the deficiencies of a filesystem or bizarre hardware
> >> implementation. I want to stop spending all my time trying to
> >> deal with new, crazy LSM hooks. There are enough old ones to
> >> keep me entertained, thank you very much.
> > Yeah, good luck with that.
>
> Hey, if you don't play, you can't win. ;)
>
> > I think trying to legislate this too much
> > is a sure path to failure.
>
> There's not doubt that "too much" legislation would be a problem.
> Right now, we have *no* guidance or guidelines.

Sigh.  Be very careful what you wish for, we've got some pretty good
convention and established practices here, I would hate for your quest
for regulation to break what we've got going.  Especially when people
will use that regulation as a substitute for discussion.

> > Our saving grace is that the LSM hook
> > boundary is not a kernel/userspace boundary so we are free to change
> > it as needed, we just need to make sure if we change an existing hook
> > we don't break any of the existing in-tree LSMs.  We've done this in
> > the past without too much problem, even other subsystems have done
> > this for us (without much notification to the LSMs) and it has
> > generally worked out okay.
>
> Sure, but it's a royal pain to deal with the wild inconsistency
> of interfaces we have today.

We are writing hooks that deal with the entire system, there is
*always* going to be inconsistency; just look at the subsystems.
Further, just like the rest of the kernel, the hooks evolve over time
and often that evolution happens at different paces because the
different pieces of the kernel move at different paces.

> I would like to discourage new
> hooks that do things like expose filesystem or network protocol
> implementation details to the LSM interface.

Until something comes along and we need to break that abstraction.
Once again, if we're going to mandate anything, let's mandate that we
need to discuss changes to the LSM hooks and leave it at that.

> > I'm all for increased collaboration between LSMs, e.g. requiring hooks
> > changes to CC the LSM list, but I think mandating anything beyond that
> > is a fool's errand.
>
> VFS manages this, and I wouldn't call Al a fool.

You sir, are no Al Viro. :)  (and for the record, none of us are IMHO)

While the VFS subsystem may be the closest analogy to the LSM
subsystem, I think the two subsystems are quite different.  If nothing
else, the other kernel developers see the need for a working
filesystem and are willing to make compromises to keep their
filesystem working.  I think we can all name at least one subsystem
that would very much like to see the LSMs go away, and in order to
keep things functioning we sometimes have to get "creative", and that
can mean breaking abstractions.

-- 
paul moore
www.paul-moore.com
