Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689ADC7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3822E20665
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 17:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NGLcJAMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfGPRnc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:43:32 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:38438 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPRnc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 13:43:32 -0400
Received: by mail-lf1-f53.google.com with SMTP id h28so14346236lfj.5
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eQh2FsjarxmlyZKMIfDjcEJRx+HYEFFQHdnWbI2w9g=;
        b=NGLcJAMA33cMJ1BJ47creGwoHRcgerp0L/VkkU8hB85Y1xRCqWJhPqFZH35s3y/9OF
         DI3g4bBnpc7c/DebOc69WwpQg22iPH5IZu+F0AGueoF3yaqyxpPpeNKOrcYq8ervg0Kx
         R2UxQQirwo1hJFhFqEB9wAFI0p5/7FTY0UJJ4qaSXqYB6enK+Nuynb8ars5UGRwbbMWQ
         3UhmzXzST/XABUXA0eyxMPlEU34RpvdQxVQn6YeEsFQORJvRbvTyyCnBlVSxj2KazrpN
         dARrgc4JM7+RO04Zg5ynTT4O5YjFEabeod9Q1CDBz/tEQH8A1ydFNnC+IozO/B6AkDkT
         j9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eQh2FsjarxmlyZKMIfDjcEJRx+HYEFFQHdnWbI2w9g=;
        b=NziZCMY73JZf4ovosXg8a8nuqwjrwWCcAyYrWAqqXrKvQxQIubXtnr5LAg5kBf/Stv
         iuYgxAvSB6r9LlAqwbLVRDi+1GiEhF6m35NhSLED0f/rELgNtb+WPSCwwsdOWkyPiOoG
         Vebu0BSAtdanpjFdNslgr3q4ID9oPxt0h8TiPwpRatpxrULx2IgSppGe5gel2e9Ruc6T
         YnEoLhuroZl1rghpGIqiQVUhfLyIfDi9b5a42wPk65CPXlgpp3R3iecPkJ6KfM/5n7CZ
         yNvvFwTeYYVFpVlyCrW/HPEgR/pPY6ccsdT4YFcbIYehSzsy465Ac3PAVhTvAattpc5a
         rz/Q==
X-Gm-Message-State: APjAAAWzRdN/KvF3cHnUyLEg4p8NBxSJXKwDxwb188EXTeGCbPSeIcR9
        8qFOIoC7ik4abJY3pNEXgubrMJdLqGaxgqOMlg==
X-Google-Smtp-Source: APXvYqxE+xTVNhGGq4k8vPE5IlwMtAXONeRrUaP9Egt7KBkW1T88YlZNfdM2VwVeJTYytw2eY1CXff+OE/hOtd0+/YQ=
X-Received: by 2002:a19:5e10:: with SMTP id s16mr14984006lfb.13.1563299010074;
 Tue, 16 Jul 2019 10:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <c46932ec-e38e-ba15-7ceb-70e0fe0ef5dc@schaufler-ca.com> <CAHC9VhQ08LKUmYS8ho_0-uDUFakPPq1bvR6JwWiLUrnwaRV6Aw@mail.gmail.com>
 <1979804.kRvuSoDnao@x2> <CAHC9VhSELVZN8feH56zsANqoHu16mPMD04Ww60W=r6tWs+8WnQ@mail.gmail.com>
 <c993f63a-7c2d-c6c8-cfa6-3cfba410770d@schaufler-ca.com>
In-Reply-To: <c993f63a-7c2d-c6c8-cfa6-3cfba410770d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Jul 2019 13:43:18 -0400
Message-ID: <CAHC9VhSTwvueKcK2yhckwayh9YGou7gt2Gny36DOTaNkrck+Mg@mail.gmail.com>
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

On Tue, Jul 16, 2019 at 1:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/16/2019 10:12 AM, Paul Moore wrote:
> > On Mon, Jul 15, 2019 at 6:56 PM Steve Grubb <sgrubb@redhat.com> wrote:
> >> On Monday, July 15, 2019 5:28:56 PM EDT Paul Moore wrote:
> >>> On Mon, Jul 15, 2019 at 3:37 PM Casey Schaufler <casey@schaufler-ca.com>
> >> wrote:
> >>>> On 7/15/2019 12:04 PM, Richard Guy Briggs wrote:
> >>>>> On 2019-07-13 11:08, Steve Grubb wrote:
> > ...
> >
> >>>>> Steve's answer is the obvious one, ideally allocating a seperate range
> >>>>> to each LSM with each message type having its own well defined format.
> >>>> It doesn't address the issue of success records, or records
> >>>> generated outside the security modules.
> >>> Yes, exactly.  The individual LSM will presumably will continue to
> >>> generate their own audit records as they do today and I would imagine
> >>> that the subject and object fields could remain as they do today for
> >>> the LSM specific records.
> >>>
> >>> The trick is the other records which are not LSM specific but still
> >>> want to include subject and/or object information.  Unfortunately we
> >>> are stuck with some tough limitations given the current audit record
> >>> format and Steve's audit userspace tools;
> >> Not really. We just need to approach the problem thinking about how to make
> >> it work based on how things currently work.
> > I suppose it is all somewhat "subjective" - bad joke fully intended :)
> > - with respect to what one considers good/bad/limiting.  My personal
> > view is that an ideal solution would allow for multiple independent
> > subj/obj labels without having to multiplex on a single subj/obj
> > field.  My gut feeling is that this would confuse your tools, yes?
> >
> >> For example Casey had a list of possible formats. Like this one:
> >>
> >> Option 3:
> >>         lsms=selinux,apparmor subj=x:y:z:s:c subj=a
> >>
> >> I'd suggest something almost like that. The first field could be a map to
> >> decipher the labels. Then we could have a comma separated list of labels.
> >>
> >> lsms=selinux,apparmor subj=x:y:z:s:c,a
> > Some quick comments:
> >
> > * My usual reminder that new fields for existing audit records must be
> > added to the end of the record.
> >
> > * If we are going to multiplex the labels on a single field (more on
> > that below) I might suggest using "subj_lsms" instead of "lsms" so we
> > leave ourself some wiggle room in the future.
> >
> > * Multiplexing on a single "subj" field is going to be difficult
> > because picking the label delimiter is going to be a pain.  For
> > example, in the example above a comma is used, which at the very least
> > is a valid part of a SELinux label and I suspect for Smack as well
> > (I'm not sure about the other LSMs).  I suspect the only way to parse
> > out the component labels would be to have knowledge of the LSMs in
> > use, as well as the policies loaded at the time the audit record was
> > generated.
> >
> > This may be a faulty assumption, but assuming your tools will fall
> > over if they see multiple "subj" fields, could we do something like
> > the following (something between option #2 and #3):
> >
> >   subj1_lsm=smack subj1=<smack_label> subj2_lsm=selinux
> > subj2=<selinux_label> ...
>
> If it's not a subj= field why use the indirection?
>
>         subj_smack=<smack_label> subj_selinux=<selinux_label>
>
> would be easier.

Good point, that looks reasonable to me.

-- 
paul moore
www.paul-moore.com
