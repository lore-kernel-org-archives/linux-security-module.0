Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFF3C636CC
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Feb 2023 18:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjBRSD4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 18 Feb 2023 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRSDz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 18 Feb 2023 13:03:55 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 145DF14EAA
        for <linux-security-module@vger.kernel.org>; Sat, 18 Feb 2023 10:03:53 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31II3WvJ011443;
        Sat, 18 Feb 2023 12:03:32 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31II3UOC011442;
        Sat, 18 Feb 2023 12:03:30 -0600
Date:   Sat, 18 Feb 2023 12:03:30 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-security-module@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH 08/14] Implement TSEM control plane.
Message-ID: <20230218180330.GA10864@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-9-greg@enjellic.com> <Y+TZa60YQlehJtJu@kroah.com> <20230211001806.GA30741@wind.enjellic.com> <Y+d1B2+McB0pxuOn@kroah.com> <20230212065439.GA5189@wind.enjellic.com> <Y+3S6COr4U86wi8A@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3S6COr4U86wi8A@kroah.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 18 Feb 2023 12:03:32 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 16, 2023 at 07:53:28AM +0100, Greg KH wrote:
> On Sun, Feb 12, 2023 at 12:54:40AM -0600, Dr. Greg wrote:
> > On Sat, Feb 11, 2023 at 11:59:19AM +0100, Greg KH wrote:
> > 
> > Looping in Paul Moore in order to get his thoughts.
> > 
> > > On Fri, Feb 10, 2023 at 06:18:06PM -0600, Dr. Greg wrote:
> > > > On Thu, Feb 09, 2023 at 12:30:51PM +0100, Greg KH wrote:
> > > > 
> > > > Good afternoon Greg, thanks for taking the time to review the patches
> > > > and pass along comments.
> > > > 
> > > > > On Fri, Feb 03, 2023 at 11:09:48PM -0600, Dr. Greg wrote:
> > > > > > The fs.c file contains the implementation of the TSEM control
> > > > > > plane that is in the form of a pseudo-filesystem mounted on the
> > > > > > following directory:
> > > > > > 
> > > > > > /sys/fs/tsem
> > > > 
> > > > > Why are you using sysfs to mount this?
> > 
> > > > We followed the lead of the SMACK and SeLinux LSM's, both of which
> > > > create the mount points for their control plane filesystems in
> > > > /sys/fs.
> > > > 
> > > > In addition, as a filesystem, we chose to have tsemfs closely follow
> > > > their design for continuity across the LSM's.  So they share similar
> > > > functionality and design, modulo of course, the event description and
> > > > trajectory export files that we will chat about below.
> > > > 
> > > > We can't use securityfs, secondary to the fact that it doesn't
> > > > implement pollable files, which are a requirement for trust
> > > > orchestrators based on external Trusted Modeling Agents.
> > 
> > > Why not fix securityfs to provide pollable files?  Other than that,
> > > why can't you just use securityfs?
> > 
> > Now that we have had some additional bandwidth to look at issues after
> > the first round release, it may be more straight forward to implement
> > the pollable files in securityfs than we thought.  We will take
> > another run at this and see what is possible without having to meddle
> > with the internals of securityfs proper.

> It's ok to mess around with securityfs to get it to work properly
> for your use case, there's no reason to create a whole new
> filesystem just because of one missing functionality.

As I noted before, we followed the lead of SMACK and SeLinux, both of
which have their filesystems planted in /sys/fs.

Paul, FWIW, it may be worthwhile to add something to the LSM authors
guidance indicating that, moving forward, any control plane filesystem
functionality should be placed in securityfs, in order to avoid
wasting both developer and reviewer bandwidth.

> > As the diffstat for the patch series indicates, we spent considerable
> > time working to implement TSEM without touching anything outside its
> > implementation directory.  I think this is something that anyone who
> > has tried to upstream functionality into the mainline kernel would
> > understand the merit of.

> No, that's not how kernel development works, it's ok to touch other
> portions when needed, otherwise you duplicate lots of extra code and
> functionality as you are doing here.  Please do not do that.

Not the place for it here, but there is an interesting conversation
regarding Linux kernel development to be had, regarding the economic
barriers to mainstreaming code, that is posed by the 'Serving multiple
masters dilemma'.

> > > You are creating a new structure-type-api here, why not use a
> > > already-designed protocol instead like varlink if you need userspace
> > > to parse events in an atomic way?  Or heck even json would be better
> > > as there are universal userspace tools for that today.
> > 
> > As an industry, we are in the middle of a software supply chain
> > security crisis.

> That has nothing to do with the kernel, sorry.

A quick response to that, just for the historical record.

In a trust orchestrated system, the most security critical code
running are the TMA's, much more so than a TPM, since the TMA's
determine the security state of the kernel.  It has thus far seemed
wise to us to minimize the security scope and range of the
implementations as much as possible.

> > In a trust orchestrated architecture, the trust
> > orchestrators, and their Sancho TMA implementations, are the most
> > security critical components on the system.  Our objective is to keep
> > the supply chain footprint for Quixote as small as possible.
> > 
> > To that point:
> > 
> > size /usr/local/lib/libyajl.so.2.1.1:
> >    text    data     bss     dec     hex filename
> >   33333     784      16   34133    8555 /usr/local/lib/libyajl.so.2.1.1
> > 
> > size /u/usr/sources/quixote-1.4/SecurityModel/EventParser.o
> >    text    data     bss     dec     hex filename
> >    2520       0       0    2520     9d8 /u/usr/sources/quixote-1.4/SecurityModel/EventParser.o
> > 
> > If we were to use JSON, we would use yajl, it is probably as light as
> > anything out there.  Given that, on face value, this would represent
> > over an order of magnitude increase in code size to achieve the same
> > objective, plus add an external dependency.

> So you require people to trust your custom parser and format just
> because you don't want to rely on a trusted tool that the whole
> world depends on?

We are actually not advocating making the world use our format.

In my last reply we had suggested making the output format an option,
selected by the trust orchestrator at the time a modeling domain was
setup, given that by definition, the only thing that is going to be
reading that file is the trust orchestrator that sets it up.

That puts the compatibility onus on userspace and would provide a
mechanism for the kernel to deprecate formats.  Given the history of
this industry, JSON may be the rage now for the world's trusted
parsing tool, but who knows what the rage is going to be in five
years.  It wasn't too long ago that XML was thought to be all the
rage... :-)

> Again, not a valid argument, sorry, please use common parsing tools
> otherwise you are guaranteed to make mistakes and everyone will have to
> rely on your custom tools only, which is not something that you would
> accept from any other kernel change.

JSON it will be than, unless the community wants the userspace
selection option.

Paul, since securityfs is officially something that is in your
approval domain, do you have any issues with having pseudo-files in
that filesystem urping out JSON?

In addition, Paul or anyone else reading this; does anyone have any
recommendations or preferences with respect to how the data is
marshalled?

Unless we hear otherwise we will proceed with the following
implementation:

- All of the JSON encoded information will be output as a single
linefeed delimited record.

- The record will be a JSON array with named structures that use the
same names as the field description names in the current event
description format.

- All of the existing key=value pairs will be used in their current
documented form but in 'key : value' format.

- JSON encoding will be applied only to the trajectory, forensics and
event description pseudo-files.  All other pseudo-files will continue
outputting a single ASCII value.

> And I don't see a link to the userspace tools anywhere, did I miss it?

The links were in the second to the last paragraph in the cover letter
for the patch series and in the TBDHTTRAD section of the TSEM LSM
documentation file: Documentation/admin-guide/LSM/tsem.rst

The project download directory is as follows:

ftp://ftp.enjellic.com/pub/Quixote

At the current time, the URL for the source is as follows:

ftp://ftp.enjellic.com/pub/Quixote/Quixote-1.4.tar.gz

Pre-compiled binaries, that should run on any x86_64 platform, with no
dependencies, are available in the following forms:

ftp://ftp.enjellic.com/pub/Quixote/Quixote-1.4-1.x86_64.rpm

ftp://ftp.enjellic.com/pub/Quixote/quixote_1.4-2_amd64.deb

The -1 and -2 differences are meaningless, we missed the -k argument
to alien.

The code will compile on Ubuntu 22.04 with GCC plus the Cortex R/M
ARM-GCC compiler.  The trust orchestrators will build with MUSL but
will probably require the presence of some MUSL compiled libraries.

> thanks,
> 
> greg k-h

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
