Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF50C7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53903206C2
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 21:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfGPVq6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:46:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfGPVq6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 17:46:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF9BF307CDEA;
        Tue, 16 Jul 2019 21:46:57 +0000 (UTC)
Received: from x2.localnet (ovpn-116-76.phx2.redhat.com [10.3.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7C5A5C220;
        Tue, 16 Jul 2019 21:46:52 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
Date:   Tue, 16 Jul 2019 17:46:52 -0400
Message-ID: <2517266.eHZzEmjMsX@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com> <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Jul 2019 21:46:57 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tuesday, July 16, 2019 5:25:21 PM EDT Paul Moore wrote:
> On Tue, Jul 16, 2019 at 2:41 PM Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> > On 7/16/2019 11:06 AM, Steve Grubb wrote:
> > > On Tuesday, July 16, 2019 1:43:18 PM EDT Paul Moore wrote:
> > >> On Tue, Jul 16, 2019 at 1:30 PM Casey Schaufler
> > >> <casey@schaufler-ca.com>
> > > 
> > > wrote:
> > >>> On 7/16/2019 10:12 AM, Paul Moore wrote:
> > >>>> On Mon, Jul 15, 2019 at 6:56 PM Steve Grubb <sgrubb@redhat.com> 
wrote:
> > >>>>> On Monday, July 15, 2019 5:28:56 PM EDT Paul Moore wrote:
> > >>>>>> On Mon, Jul 15, 2019 at 3:37 PM Casey Schaufler
> > >>>>>> <casey@schaufler-ca.com>
> > >>>>> 
> > >>>>> wrote:
> > >>>>>>> On 7/15/2019 12:04 PM, Richard Guy Briggs wrote:
> > >>>>>>>> On 2019-07-13 11:08, Steve Grubb wrote:
> > >>>> ...
> > >>>> 
> > >>>>>>>> Steve's answer is the obvious one, ideally allocating a seperate
> > >>>>>>>> range
> > >>>>>>>> to each LSM with each message type having its own well defined
> > >>>>>>>> format.
> > >>>>>>> 
> > >>>>>>> It doesn't address the issue of success records, or records
> > >>>>>>> generated outside the security modules.
> > >>>>>> 
> > >>>>>> Yes, exactly.  The individual LSM will presumably will continue to
> > >>>>>> generate their own audit records as they do today and I would
> > >>>>>> imagine
> > >>>>>> that the subject and object fields could remain as they do today
> > >>>>>> for
> > >>>>>> the LSM specific records.
> > >>>>>> 
> > >>>>>> The trick is the other records which are not LSM specific but
> > >>>>>> still
> > >>>>>> want to include subject and/or object information.  Unfortunately
> > >>>>>> we
> > >>>>>> are stuck with some tough limitations given the current audit
> > >>>>>> record
> > >>>>>> format and Steve's audit userspace tools;
> > >>>>> 
> > >>>>> Not really. We just need to approach the problem thinking about how
> > >>>>> to
> > >>>>> make it work based on how things currently work.
> > >>>> 
> > >>>> I suppose it is all somewhat "subjective" - bad joke fully intended
> > >>>> :)
> > >>>> - with respect to what one considers good/bad/limiting.  My personal
> > >>>> view is that an ideal solution would allow for multiple independent
> > >>>> subj/obj labels without having to multiplex on a single subj/obj
> > >>>> field.  My gut feeling is that this would confuse your tools, yes?
> > >>>> 
> > >>>>> For example Casey had a list of possible formats. Like this one:
> > >>>>> 
> > >>>>> Option 3:
> > >>>>>         lsms=selinux,apparmor subj=x:y:z:s:c subj=a
> > >>>>> 
> > >>>>> I'd suggest something almost like that. The first field could be a
> > >>>>> map
> > >>>>> to
> > >>>>> decipher the labels. Then we could have a comma separated list of
> > >>>>> labels.
> > >>>>> 
> > >>>>> lsms=selinux,apparmor subj=x:y:z:s:c,a
> > >>>> 
> > >>>> Some quick comments:
> > >>>> 
> > >>>> * My usual reminder that new fields for existing audit records must
> > >>>> be
> > >>>> added to the end of the record.
> > >>>> 
> > >>>> * If we are going to multiplex the labels on a single field (more on
> > >>>> that below) I might suggest using "subj_lsms" instead of "lsms" so
> > >>>> we
> > >>>> leave ourself some wiggle room in the future.
> > >>>> 
> > >>>> * Multiplexing on a single "subj" field is going to be difficult
> > >>>> because picking the label delimiter is going to be a pain.  For
> > >>>> example, in the example above a comma is used, which at the very
> > >>>> least
> > >>>> is a valid part of a SELinux label and I suspect for Smack as well
> > >>>> (I'm not sure about the other LSMs).  I suspect the only way to
> > >>>> parse
> > >>>> out the component labels would be to have knowledge of the LSMs in
> > >>>> use, as well as the policies loaded at the time the audit record was
> > >>>> generated.
> > >>>> 
> > >>>> This may be a faulty assumption, but assuming your tools will fall
> > >>>> over if they see multiple "subj" fields, could we do something like
> > >>>> 
> > >>>> the following (something between option #2 and #3):
> > >>>>   subj1_lsm=smack subj1=<smack_label> subj2_lsm=selinux
> > >>>> 
> > >>>> subj2=<selinux_label> ...
> > >>> 
> > >>> If it's not a subj= field why use the indirection?
> > >>> 
> > >>>         subj_smack=<smack_label> subj_selinux=<selinux_label>
> > >>> 
> > >>> would be easier.
> > >> 
> > >> Good point, that looks reasonable to me.
> > > 
> > > But doing something like this will totally break all parsers. To be
> > > honest, I don't know if I'll ever see more than one labeled security
> > > system running at the same time. And this would be a big penalty to
> > > pay for the flexibility that someone, somewhere just might possibly do
> > > this.
> > 
> > While I have never seen multiple-LSM plans from RedHat/IBM I
> > have seen them from Ubuntu. This isn't hypothetical. I know that
> > it's a hard problem, which is why we need to get it as right as
> > possible.
> 
> Agreed.  While I'm not going to be on a specific Linux release, I do
> believe that at some point in the future the LSM stacking work is
> going to land in Linus' tree.  Perhaps you'll never see it Steve, but
> we need to prepare the code to handle it when it happens.

And I agree with that. I'm saying that if we push it all in subj= then it is 
not a big penalty. It saves major breakage. Every single event is required to 
have a subj= field if its a MAC system. By changing it to lsm_subj= it changes 
the layout of every single event. And it make more to parse. And searching 
the labels is worse because it has to iterate over a list of *_subj to match 
it. This will hurt performance because it is for every single event.

> For my own sanity, here is a quick summary of the constraints as I
> currently see them, please feel free to add/disagree:
> 
> * We can't have multiple "subj" fields in a single audit record.
> * The different LSMs all have different label formats and allowed
> characters.  Further, a given label format may not be unique for a
> given LSM; for example, Smack could be configured with a subset of
> SELinux labels.
> * Steve's audit tools appear to require a "subj" and "obj" fields for
> LSM information or else they break into tiny little pieces.

It changes all knowledge of where to look for things. And considering 
considering that events could be aggregated from systems of different ages/
distributions, audit userspace will always have to be backwards compatible.
 
> What if we preserved the existing subj/obj fields in the case where
> there is only one "major" LSM (SELinux, Smack, AppArmor, etc.):
> 
>   subj=<lsm_label>
> 
> ... and in the case of multiple major LSMs we set the subj value to
> "?" and introduce new subj_X fields (as necessary) as discussed above:
> 
>   subj=? subj_smack=<smack_label> subj_selinux=<selinux_label> ...
> 
> ... I believe that Steve's old/existing userspace tools would simply
> report "?"/unknown LSM credentials where new multi-LSM tools could
> report the multiple different labels. 

Common Criteria as well as other standards require subject labels to be 
searchable. So, changing behavior based on how many modules will still cause 
problems with performance because I'll always have to assume it could be 
either way and try both.

> While this may not be perfect,
> it avoids having to multiplex the different labels into a single field
> (which is a big win IMHO) with the only issue being that multi-LSM
> solutions will need an updated audit toolset to see the new labels
> (which seems like a reasonable requirement).

Why would not multiplexing different labels in the same field be a big win? Its 
a big loss in my mind. Using the same field preserves backward compatibility, 
is more compact in bytes, creates performance problems, changes all mapping 
of what things means, etc. IOW, this makes things much worse.

-Steve


