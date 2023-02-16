Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B613C61DA4
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Feb 2023 06:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBPGxg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 01:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPGxf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 01:53:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59721F5E1
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 22:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F600B825DD
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 06:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3497C433D2;
        Thu, 16 Feb 2023 06:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676530411;
        bh=CrpWTlwyl4ID4FNJzF7Ia5Irp6XcDH+IwFTRdbRBAOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmLXTzO5fxnkf4FmY8IVVeDvLEB+ewOxUcmsQekOnvcg4El25skx/qW/1SIBlwDnU
         /TkVw972gAUQXv41ym4viY+vC/q/NkLKlLvIOsfX2z3iZ/6Xa+hfqa12bZfazB9lXY
         IvtNhGl6UD+2WDhsoNeD9CxZxk4Ik79TIvIYczW0=
Date:   Thu, 16 Feb 2023 07:53:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH 08/14] Implement TSEM control plane.
Message-ID: <Y+3S6COr4U86wi8A@kroah.com>
References: <20230204050954.11583-1-greg@enjellic.com>
 <20230204050954.11583-9-greg@enjellic.com>
 <Y+TZa60YQlehJtJu@kroah.com>
 <20230211001806.GA30741@wind.enjellic.com>
 <Y+d1B2+McB0pxuOn@kroah.com>
 <20230212065439.GA5189@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212065439.GA5189@wind.enjellic.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Feb 12, 2023 at 12:54:40AM -0600, Dr. Greg wrote:
> On Sat, Feb 11, 2023 at 11:59:19AM +0100, Greg KH wrote:
> 
> Looping in Paul Moore in order to get his thoughts.
> 
> > On Fri, Feb 10, 2023 at 06:18:06PM -0600, Dr. Greg wrote:
> > > On Thu, Feb 09, 2023 at 12:30:51PM +0100, Greg KH wrote:
> > > 
> > > Good afternoon Greg, thanks for taking the time to review the patches
> > > and pass along comments.
> > > 
> > > > On Fri, Feb 03, 2023 at 11:09:48PM -0600, Dr. Greg wrote:
> > > > > The fs.c file contains the implementation of the TSEM control
> > > > > plane that is in the form of a pseudo-filesystem mounted on the
> > > > > following directory:
> > > > > 
> > > > > /sys/fs/tsem
> > > 
> > > > Why are you using sysfs to mount this?
> 
> > > We followed the lead of the SMACK and SeLinux LSM's, both of which
> > > create the mount points for their control plane filesystems in
> > > /sys/fs.
> > > 
> > > In addition, as a filesystem, we chose to have tsemfs closely follow
> > > their design for continuity across the LSM's.  So they share similar
> > > functionality and design, modulo of course, the event description and
> > > trajectory export files that we will chat about below.
> > > 
> > > We can't use securityfs, secondary to the fact that it doesn't
> > > implement pollable files, which are a requirement for trust
> > > orchestrators based on external Trusted Modeling Agents.
> 
> > Why not fix securityfs to provide pollable files?  Other than that,
> > why can't you just use securityfs?
> 
> Now that we have had some additional bandwidth to look at issues after
> the first round release, it may be more straight forward to implement
> the pollable files in securityfs than we thought.  We will take
> another run at this and see what is possible without having to meddle
> with the internals of securityfs proper.

It's ok to mess around with securityfs to get it to work properly for
your use case, there's no reason to create a whole new filesystem just
because of one missing functionality.

> As the diffstat for the patch series indicates, we spent considerable
> time working to implement TSEM without touching anything outside its
> implementation directory.  I think this is something that anyone who
> has tried to upstream functionality into the mainline kernel would
> understand the merit of.

No, that's not how kernel development works, it's ok to touch other
portions when needed, otherwise you duplicate lots of extra code and
functionality as you are doing here.  Please do not do that.

> > You are creating a new structure-type-api here, why not use a
> > already-designed protocol instead like varlink if you need userspace
> > to parse events in an atomic way?  Or heck even json would be better
> > as there are universal userspace tools for that today.
> 
> As an industry, we are in the middle of a software supply chain
> security crisis.

That has nothing to do with the kernel, sorry.

> In a trust orchestrated architecture, the trust
> orchestrators, and their Sancho TMA implementations, are the most
> security critical components on the system.  Our objective is to keep
> the supply chain footprint for Quixote as small as possible.
> 
> To that point:
> 
> size /usr/local/lib/libyajl.so.2.1.1:
>    text    data     bss     dec     hex filename
>   33333     784      16   34133    8555 /usr/local/lib/libyajl.so.2.1.1
> 
> size /u/usr/sources/quixote-1.4/SecurityModel/EventParser.o
>    text    data     bss     dec     hex filename
>    2520       0       0    2520     9d8 /u/usr/sources/quixote-1.4/SecurityModel/EventParser.o
> 
> If we were to use JSON, we would use yajl, it is probably as light as
> anything out there.  Given that, on face value, this would represent
> over an order of magnitude increase in code size to achieve the same
> objective, plus add an external dependency.

So you require people to trust your custom parser and format just
because you don't want to rely on a trusted tool that the whole world
depends on?

Again, not a valid argument, sorry, please use common parsing tools
otherwise you are guaranteed to make mistakes and everyone will have to
rely on your custom tools only, which is not something that you would
accept from any other kernel change.

And I don't see a link to the userspace tools anywhere, did I miss it?

thanks,

greg k-h
