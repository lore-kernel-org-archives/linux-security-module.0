Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE566C7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 21:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EAB2173E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 21:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="q5Pml+W1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfGPVZg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:25:36 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37017 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfGPVZf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 17:25:35 -0400
Received: by mail-lj1-f169.google.com with SMTP id z28so21486535ljn.4
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLu2QS7jPdsPIdUdlCTEP+akEGDUkSiemEDJqgb+oDo=;
        b=q5Pml+W1wAl4L6H2nyzr2d4ovrQMOK6HoV/vm4A1YWYHFAt9S1/jxGtWwmJnaUqI5n
         TTLqba+RjmZ7hhslBuz+2IPVI/W2XWiCNg3QTphQDG8G3iv73+TKkH1pOeKHsH+rv09A
         osuj6nDalzYtfrxP+cgvDsLWkCSLAw1iFYKHnzilJ8fxbBlkGplgROPQp5mN0Pd1EoQn
         /WXWC0ZkUODNd3eRUhSbl8wLUpp6Mll6p4uZD1BllLg0QiEqI6+aFflRzJ1KrASOCe6+
         qj2sAdJN5KkgI0Sf9/2A3tK43rMxnUPjfdLTwHTAIVWwWWAGf97854tT1+NhlHh4B0j7
         AXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLu2QS7jPdsPIdUdlCTEP+akEGDUkSiemEDJqgb+oDo=;
        b=IRn6o0rw8EVWbwanBY3mjiTrw6x1c9ipJ52v5kx55BBIVKXqmHB5a8auHJOI2j09ld
         UshSEGbcqCgVGj0I7mPYyCKEkeSXIoXj+YMsec21LNZ0YcQeLVkOJUL3QlIs0DhymYDq
         YbzqGbECp4zc2MEdNyPGsqPnfWQhsAkjO3mU25QSo/nETyrCYvtqWT4aJu++d6QWKb5W
         kJndTbh44NOkk7l2qO6KuL13TxPXqC+qspSufr4cHyILGWaNog+71jVjN6HsnaU8uIjp
         43QTZGoZ5jHB55Ye7O9c4KT3aGjEOB3S8g7//8jK5usYJFzY3jUzdnn7fonusWFkA4Ct
         DuSQ==
X-Gm-Message-State: APjAAAXO+siMs7TaG2igq5SaKqZcevhQllWTfZSgiGYJcND7zAlkxiJx
        rYR58EyRURDqEVUig8ZZK0ZNgt9JuzSaJsyCPw==
X-Google-Smtp-Source: APXvYqwffhV7djgA1ztBwXL1BKJAC0M4l0j73YrEUwmOo/NKtwnZ2AsvDGqHRcXO6kxxPgXGPKXNXeWBalH4obg1DWY=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr18660869lja.85.1563312332818;
 Tue, 16 Jul 2019 14:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <c993f63a-7c2d-c6c8-cfa6-3cfba410770d@schaufler-ca.com> <CAHC9VhSTwvueKcK2yhckwayh9YGou7gt2Gny36DOTaNkrck+Mg@mail.gmail.com>
 <2477603.130G60v5SE@x2> <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
In-Reply-To: <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Jul 2019 17:25:21 -0400
Message-ID: <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
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

On Tue, Jul 16, 2019 at 2:41 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/16/2019 11:06 AM, Steve Grubb wrote:
> > On Tuesday, July 16, 2019 1:43:18 PM EDT Paul Moore wrote:
> >> On Tue, Jul 16, 2019 at 1:30 PM Casey Schaufler <casey@schaufler-ca.com>
> > wrote:
> >>> On 7/16/2019 10:12 AM, Paul Moore wrote:
> >>>> On Mon, Jul 15, 2019 at 6:56 PM Steve Grubb <sgrubb@redhat.com> wrote:
> >>>>> On Monday, July 15, 2019 5:28:56 PM EDT Paul Moore wrote:
> >>>>>> On Mon, Jul 15, 2019 at 3:37 PM Casey Schaufler
> >>>>>> <casey@schaufler-ca.com>
> >>>>> wrote:
> >>>>>>> On 7/15/2019 12:04 PM, Richard Guy Briggs wrote:
> >>>>>>>> On 2019-07-13 11:08, Steve Grubb wrote:
> >>>> ...
> >>>>
> >>>>>>>> Steve's answer is the obvious one, ideally allocating a seperate
> >>>>>>>> range
> >>>>>>>> to each LSM with each message type having its own well defined
> >>>>>>>> format.
> >>>>>>> It doesn't address the issue of success records, or records
> >>>>>>> generated outside the security modules.
> >>>>>> Yes, exactly.  The individual LSM will presumably will continue to
> >>>>>> generate their own audit records as they do today and I would imagine
> >>>>>> that the subject and object fields could remain as they do today for
> >>>>>> the LSM specific records.
> >>>>>>
> >>>>>> The trick is the other records which are not LSM specific but still
> >>>>>> want to include subject and/or object information.  Unfortunately we
> >>>>>> are stuck with some tough limitations given the current audit record
> >>>>>> format and Steve's audit userspace tools;
> >>>>> Not really. We just need to approach the problem thinking about how to
> >>>>> make it work based on how things currently work.
> >>>> I suppose it is all somewhat "subjective" - bad joke fully intended :)
> >>>> - with respect to what one considers good/bad/limiting.  My personal
> >>>> view is that an ideal solution would allow for multiple independent
> >>>> subj/obj labels without having to multiplex on a single subj/obj
> >>>> field.  My gut feeling is that this would confuse your tools, yes?
> >>>>
> >>>>> For example Casey had a list of possible formats. Like this one:
> >>>>>
> >>>>> Option 3:
> >>>>>         lsms=selinux,apparmor subj=x:y:z:s:c subj=a
> >>>>>
> >>>>> I'd suggest something almost like that. The first field could be a map
> >>>>> to
> >>>>> decipher the labels. Then we could have a comma separated list of
> >>>>> labels.
> >>>>>
> >>>>> lsms=selinux,apparmor subj=x:y:z:s:c,a
> >>>> Some quick comments:
> >>>>
> >>>> * My usual reminder that new fields for existing audit records must be
> >>>> added to the end of the record.
> >>>>
> >>>> * If we are going to multiplex the labels on a single field (more on
> >>>> that below) I might suggest using "subj_lsms" instead of "lsms" so we
> >>>> leave ourself some wiggle room in the future.
> >>>>
> >>>> * Multiplexing on a single "subj" field is going to be difficult
> >>>> because picking the label delimiter is going to be a pain.  For
> >>>> example, in the example above a comma is used, which at the very least
> >>>> is a valid part of a SELinux label and I suspect for Smack as well
> >>>> (I'm not sure about the other LSMs).  I suspect the only way to parse
> >>>> out the component labels would be to have knowledge of the LSMs in
> >>>> use, as well as the policies loaded at the time the audit record was
> >>>> generated.
> >>>>
> >>>> This may be a faulty assumption, but assuming your tools will fall
> >>>> over if they see multiple "subj" fields, could we do something like
> >>>>
> >>>> the following (something between option #2 and #3):
> >>>>   subj1_lsm=smack subj1=<smack_label> subj2_lsm=selinux
> >>>>
> >>>> subj2=<selinux_label> ...
> >>> If it's not a subj= field why use the indirection?
> >>>
> >>>         subj_smack=<smack_label> subj_selinux=<selinux_label>
> >>>
> >>> would be easier.
> >>
> >> Good point, that looks reasonable to me.
> >
> > But doing something like this will totally break all parsers. To be honest, I
> > don't know if I'll ever see more than one labeled security system running at
> > the same time. And this would be a big penalty to pay for the flexibility that
> > someone, somewhere just might possibly do this.
>
> While I have never seen multiple-LSM plans from RedHat/IBM I
> have seen them from Ubuntu. This isn't hypothetical. I know that
> it's a hard problem, which is why we need to get it as right as
> possible.

Agreed.  While I'm not going to be on a specific Linux release, I do
believe that at some point in the future the LSM stacking work is
going to land in Linus' tree.  Perhaps you'll never see it Steve, but
we need to prepare the code to handle it when it happens.

For my own sanity, here is a quick summary of the constraints as I
currently see them, please feel free to add/disagree:

* We can't have multiple "subj" fields in a single audit record.
* The different LSMs all have different label formats and allowed
characters.  Further, a given label format may not be unique for a
given LSM; for example, Smack could be configured with a subset of
SELinux labels.
* Steve's audit tools appear to require a "subj" and "obj" fields for
LSM information or else they break into tiny little pieces.

What if we preserved the existing subj/obj fields in the case where
there is only one "major" LSM (SELinux, Smack, AppArmor, etc.):

  subj=<lsm_label>

... and in the case of multiple major LSMs we set the subj value to
"?" and introduce new subj_X fields (as necessary) as discussed above:

  subj=? subj_smack=<smack_label> subj_selinux=<selinux_label> ...

... I believe that Steve's old/existing userspace tools would simply
report "?"/unknown LSM credentials where new multi-LSM tools could
report the multiple different labels.  While this may not be perfect,
it avoids having to multiplex the different labels into a single field
(which is a big win IMHO) with the only issue being that multi-LSM
solutions will need an updated audit toolset to see the new labels
(which seems like a reasonable requirement).

-- 
paul moore
www.paul-moore.com
