Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E331EC61DA4
	for <linux-security-module@archiver.kernel.org>; Sat, 11 Feb 2023 10:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBKK73 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBKK72 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 Feb 2023 05:59:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD7F6A75
        for <linux-security-module@vger.kernel.org>; Sat, 11 Feb 2023 02:59:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6446560C0A
        for <linux-security-module@vger.kernel.org>; Sat, 11 Feb 2023 10:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6538AC4339B;
        Sat, 11 Feb 2023 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676113162;
        bh=ukDWNpPeICd+/iOpZ7SHPLgeRPfWQrcbZ5wcvmOAZ5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7TFP5c0z+LY3u0MFeh6Vm+oAP4ZS+TYZHt8iuV3/OodhE5yUhC63/aUedmMxOJ5U
         +0d/d2ckYJ+DNJE0CoZSSE5e44W33uy6xrMi9DBK2etVHh44ZKdqg5rx49chKVnsJ+
         6shqyUV4D6A+MVPkRE2pBlJxeFRcUD40TebJaJPw=
Date:   Sat, 11 Feb 2023 11:59:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/14] Implement TSEM control plane.
Message-ID: <Y+d1B2+McB0pxuOn@kroah.com>
References: <20230204050954.11583-1-greg@enjellic.com>
 <20230204050954.11583-9-greg@enjellic.com>
 <Y+TZa60YQlehJtJu@kroah.com>
 <20230211001806.GA30741@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211001806.GA30741@wind.enjellic.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 10, 2023 at 06:18:06PM -0600, Dr. Greg wrote:
> On Thu, Feb 09, 2023 at 12:30:51PM +0100, Greg KH wrote:
> 
> Good afternoon Greg, thanks for taking the time to review the patches
> and pass along comments.
> 
> > On Fri, Feb 03, 2023 at 11:09:48PM -0600, Dr. Greg wrote:
> > > The fs.c file contains the implementation of the TSEM control
> > > plane that is in the form of a pseudo-filesystem mounted on the
> > > following directory:
> > > 
> > > /sys/fs/tsem
> 
> > Why are you using sysfs to mount this?
> 
> We followed the lead of the SMACK and SeLinux LSM's, both of which
> create the mount points for their control plane filesystems in
> /sys/fs.
> 
> In addition, as a filesystem, we chose to have tsemfs closely follow
> their design for continuity across the LSM's.  So they share similar
> functionality and design, modulo of course, the event description and
> trajectory export files that we will chat about below.
> 
> We can't use securityfs, secondary to the fact that it doesn't
> implement pollable files, which are a requirement for trust
> orchestrators based on external Trusted Modeling Agents.

Why not fix securityfs to provide pollable files?  Other than that, why
can't you just use securityfs?

> > > +static void show_event(struct seq_file *c, struct tsem_event *ep, char *file)
> > > +{
> > > +	seq_printf(c, "event{process=%s, filename=%s, type=%s, task_id=%*phN}",
> > > +		   ep->comm, file ? file : "none", tsem_names[ep->event],
> > > +		   WP256_DIGEST_SIZE, ep->task_id);
> > > +	seq_printf(c, " COE{uid=%d, euid=%d, suid=%d, gid=%d, egid=%d, sgid=%d, fsuid=%d, fsgid=%d, cap=0x%llx} ",
> > > +		   ep->COE.uid, ep->COE.euid, ep->COE.suid, ep->COE.gid,
> > > +		   ep->COE.egid, ep->COE.sgid, ep->COE.fsuid, ep->COE.fsgid,
> > > +		   ep->COE.capability.value);
> > > +}
> 
> > You are printing out a lot of specific data in a specific format
> > that is documented no where that I can see :(
> 
> It appears you found the ABI documentation in the second patch that
> was posted in the series, hopefully it was found to be complete, we
> are currently in 13th position out of 494 files with respect to
> quantity of ABI documentation... :-)
> 
> For the sake of 'lore':
> 
> After applying the patch series, the control plane API is documented in the
> following file:
> 
> Documentation/ABI/testing/tsemfs
> 
> The TSEM LSM documentation proper will be in the following file:
> 
> Documentation/admin-guide/LSM/tsem.rst
> 
> Where we currently hold the poll position.
> 
> > Also, you are making the same mistake that /proc made decades ago,
> > creating files that must be parsed and can NEVER be changed in the
> > future.  Why not make this a one-value-per-file filesystem instead
> > so that you have flexibility going forward?
> 
> Personally, I've been working on Linux since late 1991, so we, as a
> team, are well aware, and sensitive, to the issues and discussions
> surrounding the file formatting decisions that were made with the
> /proc filesystem.  So we did not make the decision with respect to
> formatted output lightly.
> 
> In fact, I presumed that the top two things we would hear about with
> respect to TSEM, would be about the introduction of CAP_TRUST from
> Casey and the format of the event export and execution trajectory
> files from you.
> 
> The issue is that the kernel needs to present to trust orchestrators,
> a description of each LSM security hook, in the form of an atomic
> update or transaction.
> 
> To help clarify the discussion, here are examples of records that are
> output for a file_open and socket_bind hook event:
> 
> pid{1186} event{process=quixote-us, filename=/opt/Quixote/bin/runc, type=file_open, task_id=0000000000000000000000000000000000000000000000000000000000000000} COE{uid=0, euid=0, suid=0, gid=0, egid=0, sgid=0, fsuid=0, fsgid=0, cap=0x3ffffffffff} file{flags=32800, uid=2, gid=2, mode=0100755, name_length=21, name=4829ead93d026770746f9cdebc76cc4d2a27f45db2d3ac436aa6fce4e2640415, s_magic=0xef53, s_id=xvda, s_uuid=feadbeaffeadbeaffeadbeaffeadbeaf, digest=7c1a43eb99fa739056d6554001d450ca1c9c184ca7e2d8a785bd1e5fd53bad8c}
> 
> pid{1204} event{process=ncat, filename=none, type=socket_bind, task_id=a5bc0eb22141657132f29e80ca6ea9b211e8443ead1f4b6b766935a14995040f} COE{uid=0, euid=0, suid=0, gid=0, egid=0, sgid=0, fsuid=0, fsgid=0, cap=0x20000420} socket_bind{family=2, port=28695, addr=0}
> 
> TSEM is currently modeling 84 LSM hooks.  We would certainly be open
> to suggestions as to how we would architect the one-value-per-file
> filesystem model in a manner that would scale, both with respect to
> pseudo-filesystem complexity and system call overhead.

You are creating a new structure-type-api here, why not use a
already-designed protocol instead like varlink if you need userspace to
parse events in an atomic way?  Or heck even json would be better as
there are universal userspace tools for that today.

Or use the audit interface, this feels very close to that, why not just
tie into that subsystem instead?

thanks,

greg k-h
