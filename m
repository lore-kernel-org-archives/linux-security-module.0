Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7824FC636D3
	for <linux-security-module@archiver.kernel.org>; Sun, 12 Feb 2023 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBLGzG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Feb 2023 01:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLGzF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Feb 2023 01:55:05 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D212514233
        for <linux-security-module@vger.kernel.org>; Sat, 11 Feb 2023 22:55:03 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31C6sfvD007305;
        Sun, 12 Feb 2023 00:54:41 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31C6se2B007304;
        Sun, 12 Feb 2023 00:54:40 -0600
Date:   Sun, 12 Feb 2023 00:54:40 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-security-module@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH 08/14] Implement TSEM control plane.
Message-ID: <20230212065439.GA5189@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-9-greg@enjellic.com> <Y+TZa60YQlehJtJu@kroah.com> <20230211001806.GA30741@wind.enjellic.com> <Y+d1B2+McB0pxuOn@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+d1B2+McB0pxuOn@kroah.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 12 Feb 2023 00:54:41 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Feb 11, 2023 at 11:59:19AM +0100, Greg KH wrote:

Looping in Paul Moore in order to get his thoughts.

> On Fri, Feb 10, 2023 at 06:18:06PM -0600, Dr. Greg wrote:
> > On Thu, Feb 09, 2023 at 12:30:51PM +0100, Greg KH wrote:
> > 
> > Good afternoon Greg, thanks for taking the time to review the patches
> > and pass along comments.
> > 
> > > On Fri, Feb 03, 2023 at 11:09:48PM -0600, Dr. Greg wrote:
> > > > The fs.c file contains the implementation of the TSEM control
> > > > plane that is in the form of a pseudo-filesystem mounted on the
> > > > following directory:
> > > > 
> > > > /sys/fs/tsem
> > 
> > > Why are you using sysfs to mount this?

> > We followed the lead of the SMACK and SeLinux LSM's, both of which
> > create the mount points for their control plane filesystems in
> > /sys/fs.
> > 
> > In addition, as a filesystem, we chose to have tsemfs closely follow
> > their design for continuity across the LSM's.  So they share similar
> > functionality and design, modulo of course, the event description and
> > trajectory export files that we will chat about below.
> > 
> > We can't use securityfs, secondary to the fact that it doesn't
> > implement pollable files, which are a requirement for trust
> > orchestrators based on external Trusted Modeling Agents.

> Why not fix securityfs to provide pollable files?  Other than that,
> why can't you just use securityfs?

Now that we have had some additional bandwidth to look at issues after
the first round release, it may be more straight forward to implement
the pollable files in securityfs than we thought.  We will take
another run at this and see what is possible without having to meddle
with the internals of securityfs proper.

As the diffstat for the patch series indicates, we spent considerable
time working to implement TSEM without touching anything outside its
implementation directory.  I think this is something that anyone who
has tried to upstream functionality into the mainline kernel would
understand the merit of.

Paul, I know you are busy, but if you can, weigh in briefly with any
thoughts you may have on where we put the control plane so we can
optimize everyone's time with the second spin of the patch set.

> > > > +static void show_event(struct seq_file *c, struct tsem_event *ep, char *file)
> > > > +{
> > > > +	seq_printf(c, "event{process=%s, filename=%s, type=%s, task_id=%*phN}",
> > > > +		   ep->comm, file ? file : "none", tsem_names[ep->event],
> > > > +		   WP256_DIGEST_SIZE, ep->task_id);
> > > > +	seq_printf(c, " COE{uid=%d, euid=%d, suid=%d, gid=%d, egid=%d, sgid=%d, fsuid=%d, fsgid=%d, cap=0x%llx} ",
> > > > +		   ep->COE.uid, ep->COE.euid, ep->COE.suid, ep->COE.gid,
> > > > +		   ep->COE.egid, ep->COE.sgid, ep->COE.fsuid, ep->COE.fsgid,
> > > > +		   ep->COE.capability.value);
> > > > +}
> > 
> > > You are printing out a lot of specific data in a specific format
> > > that is documented no where that I can see :(
> > 
> > It appears you found the ABI documentation in the second patch that
> > was posted in the series, hopefully it was found to be complete, we
> > are currently in 13th position out of 494 files with respect to
> > quantity of ABI documentation... :-)
> > 
> > For the sake of 'lore':
> > 
> > After applying the patch series, the control plane API is documented in the
> > following file:
> > 
> > Documentation/ABI/testing/tsemfs
> > 
> > The TSEM LSM documentation proper will be in the following file:
> > 
> > Documentation/admin-guide/LSM/tsem.rst
> > 
> > Where we currently hold the poll position.
> > 
> > > Also, you are making the same mistake that /proc made decades ago,
> > > creating files that must be parsed and can NEVER be changed in the
> > > future.  Why not make this a one-value-per-file filesystem instead
> > > so that you have flexibility going forward?
> > 
> > Personally, I've been working on Linux since late 1991, so we, as a
> > team, are well aware, and sensitive, to the issues and discussions
> > surrounding the file formatting decisions that were made with the
> > /proc filesystem.  So we did not make the decision with respect to
> > formatted output lightly.
> > 
> > In fact, I presumed that the top two things we would hear about with
> > respect to TSEM, would be about the introduction of CAP_TRUST from
> > Casey and the format of the event export and execution trajectory
> > files from you.
> > 
> > The issue is that the kernel needs to present to trust orchestrators,
> > a description of each LSM security hook, in the form of an atomic
> > update or transaction.
> > 
> > To help clarify the discussion, here are examples of records that are
> > output for a file_open and socket_bind hook event:
> > 
> > pid{1186} event{process=quixote-us, filename=/opt/Quixote/bin/runc, type=file_open, task_id=0000000000000000000000000000000000000000000000000000000000000000} COE{uid=0, euid=0, suid=0, gid=0, egid=0, sgid=0, fsuid=0, fsgid=0, cap=0x3ffffffffff} file{flags=32800, uid=2, gid=2, mode=0100755, name_length=21, name=4829ead93d026770746f9cdebc76cc4d2a27f45db2d3ac436aa6fce4e2640415, s_magic=0xef53, s_id=xvda, s_uuid=feadbeaffeadbeaffeadbeaffeadbeaf, digest=7c1a43eb99fa739056d6554001d450ca1c9c184ca7e2d8a785bd1e5fd53bad8c}
> > 
> > pid{1204} event{process=ncat, filename=none, type=socket_bind, task_id=a5bc0eb22141657132f29e80ca6ea9b211e8443ead1f4b6b766935a14995040f} COE{uid=0, euid=0, suid=0, gid=0, egid=0, sgid=0, fsuid=0, fsgid=0, cap=0x20000420} socket_bind{family=2, port=28695, addr=0}
> > 
> > TSEM is currently modeling 84 LSM hooks.  We would certainly be open
> > to suggestions as to how we would architect the one-value-per-file
> > filesystem model in a manner that would scale, both with respect to
> > pseudo-filesystem complexity and system call overhead.

> You are creating a new structure-type-api here, why not use a
> already-designed protocol instead like varlink if you need userspace
> to parse events in an atomic way?  Or heck even json would be better
> as there are universal userspace tools for that today.

As an industry, we are in the middle of a software supply chain
security crisis.  In a trust orchestrated architecture, the trust
orchestrators, and their Sancho TMA implementations, are the most
security critical components on the system.  Our objective is to keep
the supply chain footprint for Quixote as small as possible.

To that point:

size /usr/local/lib/libyajl.so.2.1.1:
   text    data     bss     dec     hex filename
  33333     784      16   34133    8555 /usr/local/lib/libyajl.so.2.1.1

size /u/usr/sources/quixote-1.4/SecurityModel/EventParser.o
   text    data     bss     dec     hex filename
   2520       0       0    2520     9d8 /u/usr/sources/quixote-1.4/SecurityModel/EventParser.o

If we were to use JSON, we would use yajl, it is probably as light as
anything out there.  Given that, on face value, this would represent
over an order of magnitude increase in code size to achieve the same
objective, plus add an external dependency.

We can't claim to have dealt with varlink very much, but that actually
may make sense, down the road, given that TSEM can be conceptualized
as being about advertising resources that a client application needs
to provide a security service to the kernel.

Hopefully our concerns about software dependency issues make sense,
given the context that we wrote, and released, as part of Quixote, a
complete SGX Platform Software Implementation in order to avoid
exposing the SanchoSGX implementation to the 20+ shared library
dependencies that come with the Intel SGX software stack.

> Or use the audit interface, this feels very close to that, why not
> just tie into that subsystem instead?

I'm not sure the audit system is a good fit for all of this, but I
will defer to Paul on that, given that he stewards over audit as well
as the security sub-system.

So, I was doing some thinking, while I was cross-country skiing for
about 10 miles across what the weather service is calling the glacial
icepack that is currently covering our wheat and soybean fields out
here in eastern North Dakota.

How about this for an idea, why don't we let the trust orchestrators
select the output format for the security event description interfaces?

We can start with the format that we are currently using and then add
things like varlink or other alternatives down the road.  That allows
different trust orchestration implementations to select what they feel
is the most desirable output format and doesn't lock the kernel into a
specific ABI format until we are actually covered by the next ice age.

Unless I miss my guess, in 25 years, if we have a reunion of trust
orchestration architectects, it will be pretty cheap to buy a round of
drinks, even if everyone is drinking 25 year old McAllen.

Paul, thoughts, given that if we move this to securityfs it will be
completely in your domain?

> thanks,
> 
> greg k-h

Have a good remainder of the weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
