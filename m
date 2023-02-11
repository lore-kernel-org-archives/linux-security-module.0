Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E81C05027
	for <linux-security-module@archiver.kernel.org>; Sat, 11 Feb 2023 00:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBKAS3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Feb 2023 19:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBKAS3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Feb 2023 19:18:29 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CAE475F62
        for <linux-security-module@vger.kernel.org>; Fri, 10 Feb 2023 16:18:27 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31B0I62T032457;
        Fri, 10 Feb 2023 18:18:06 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31B0I6ZM032456;
        Fri, 10 Feb 2023 18:18:06 -0600
Date:   Fri, 10 Feb 2023 18:18:06 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/14] Implement TSEM control plane.
Message-ID: <20230211001806.GA30741@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-9-greg@enjellic.com> <Y+TZa60YQlehJtJu@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+TZa60YQlehJtJu@kroah.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 10 Feb 2023 18:18:06 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 09, 2023 at 12:30:51PM +0100, Greg KH wrote:

Good afternoon Greg, thanks for taking the time to review the patches
and pass along comments.

> On Fri, Feb 03, 2023 at 11:09:48PM -0600, Dr. Greg wrote:
> > The fs.c file contains the implementation of the TSEM control
> > plane that is in the form of a pseudo-filesystem mounted on the
> > following directory:
> > 
> > /sys/fs/tsem

> Why are you using sysfs to mount this?

We followed the lead of the SMACK and SeLinux LSM's, both of which
create the mount points for their control plane filesystems in
/sys/fs.

In addition, as a filesystem, we chose to have tsemfs closely follow
their design for continuity across the LSM's.  So they share similar
functionality and design, modulo of course, the event description and
trajectory export files that we will chat about below.

We can't use securityfs, secondary to the fact that it doesn't
implement pollable files, which are a requirement for trust
orchestrators based on external Trusted Modeling Agents.

So the question is, where would you like us to put the control plane,
I'm assuming on a mount point created in /sys/kernel/security?

Which would seem to leave the question of why some LSM's put their
control planes in /sys/fs and others elsewhere.

> > The following file documents the interface provided by the
> > control plane:
> > 
> > Documentation/ABI/testing/tsemfs
> > 
> > The pseudo-files act on the modeling context of the process that
> > is acting on the file.  For example, reading the 'id'
> > pseudo-file, returns the modeling domain identifier that the
> > process is running in.
> > 
> > The ExternalTMA directory is used to segreate the pseudo-files
> > that are created in order to surface security event descriptions
> > to an external trust orchestrator.  The files in this directory
> > appear as the numeric value of the modeling domain they were
> > created for.
> > 
> > The 'control' pseudo-file is the only writable file in the plane
> > and is used to control the TSEM implementation.  The most
> > important and primary roles are to create namespaces and set the
> > trust status of a process modeled by an external TMA.
> > 
> > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > ---
> >  security/tsem/fs.c | 894 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 894 insertions(+)
> >  create mode 100644 security/tsem/fs.c
> > 
> > diff --git a/security/tsem/fs.c b/security/tsem/fs.c
> > new file mode 100644
> > index 000000000000..2898a1cc8c97
> > --- /dev/null
> > +++ b/security/tsem/fs.c
> > @@ -0,0 +1,894 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright (C) 2022 Enjellic Systems Development, LLC

> It's 2023 :)

Already fixed... :-)

> > + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> > + *
> > + * Implements the sysfs based control plane.

> This is NOT sysfs, it is your own filesystem, please don't confuse
> the two.

Mea culpa of course, the code now reads; 'Implements the tsemfs based
control plane'.

I think that sysfs tends to fall prey to the 'Kleenex' problem, with
control plane filesystems being generically referred to as 'sysfs'
filesystems, which of course, as you indicate, is technically
incorrect.

> > + */
> > +
> > +#include <linux/seq_file.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/namei.h>
> > +#include <linux/poll.h>
> > +#include <uapi/linux/magic.h>
> > +
> > +#include "tsem.h"
> > +
> > +static int fs_init_context(struct fs_context *context);
> > +static int fs_get_tree(struct fs_context *context);
> > +
> > +static struct file_system_type fs_definition = {
> > +	.name = "tsemfs",
> > +	.init_fs_context = fs_init_context,
> > +	.kill_sb = kill_litter_super
> > +};
> > +
> > +static struct fs_context_operations fs_operations = {
> > +	.get_tree = fs_get_tree
> > +};
> > +
> > +static struct vfsmount *fs_mount;
> > +
> > +static int fs_mount_cnt;
> > +
> > +static struct dentry *external_dentry;
> > +
> > +struct control_commands {
> > +	char *cmd;
> > +	enum tsem_control_type type;
> > +};
> > +
> > +static struct control_commands commands[9] = {
> > +	{"internal", TSEM_CONTROL_INTERNAL},
> > +	{"external", TSEM_CONTROL_EXTERNAL},
> > +	{"enforce", TSEM_CONTROL_ENFORCE},
> > +	{"seal", TSEM_CONTROL_SEAL},
> > +	{"trusted ", TSEM_CONTROL_TRUSTED},
> > +	{"untrusted ", TSEM_CONTROL_UNTRUSTED},
> > +	{"state ", TSEM_CONTROL_MAP_STATE},
> > +	{"pseudonym ", TSEM_CONTROL_MAP_PSEUDONYM},
> > +	{"base ", TSEM_CONTROL_MAP_BASE}
> > +};
> > +
> > +static bool can_access_fs(void)
> > +{
> > +	struct tsem_TMA_context *ctx = tsem_context(current);
> > +
> > +	if (ctx->external)
> > +		return false;
> > +	if (capable(TSEM_CONTROL_CAPABILITY))
> > +		return true;
> > +	if (ctx->sealed)
> > +		return false;
> > +	return true;
> > +}
> > +
> > +static int control_COE(pid_t pid, unsigned long cmd)
> > +{
> > +	bool wakeup = false;
> > +	int retn = -ESRCH;
> > +	struct task_struct *COE;
> > +	struct tsem_task *task;
> > +
> > +	rcu_read_lock();
> > +	COE = find_task_by_vpid(pid);
> > +	if (COE != NULL) {
> > +		task = tsem_task(COE);
> > +		if (cmd == TSEM_CONTROL_UNTRUSTED)
> > +			task->trust_status = TSEM_TASK_UNTRUSTED;
> > +		if (cmd == TSEM_CONTROL_TRUSTED) {
> > +			task->trust_status &= ~TSEM_TASK_TRUST_PENDING;
> > +			if (tsem_task_trusted(COE))
> > +				task->trust_status = TSEM_TASK_TRUSTED;
> > +		}
> > +
> > +		retn = 0;
> > +		wakeup = true;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	if (wakeup)
> > +		wake_up_process(COE);
> > +
> > +	return retn;
> > +}
> > +
> > +static int config_context(unsigned long cmd, char *bufr)
> > +{
> > +	int retn = -EINVAL;
> > +	unsigned int lp;
> > +	struct tsem_TMA_context *ctx = tsem_context(current);
> > +
> > +	if (ctx->sealed)
> > +		return -EPERM;
> > +
> > +	if (cmd == TSEM_CONTROL_SEAL) {
> > +		ctx->sealed = true;
> > +		retn = 0;
> > +	}
> > +
> > +	if (cmd == TSEM_CONTROL_ENFORCE) {
> > +		for (lp = 0; lp < ARRAY_SIZE(tsem_root_actions); ++lp)
> > +			ctx->actions[lp] = TSEM_ACTION_EPERM;
> > +		retn = 0;
> > +	}
> > +
> > +	return retn;
> > +}
> > +
> > +static int config_point(enum tsem_control_type type, u8 *arg)
> > +{
> > +	int retn = -EINVAL;
> > +	u8 mapping[WP256_DIGEST_SIZE];
> > +
> > +	if (*++arg == '\0')
> > +		goto done;
> > +	if (strlen(arg) != sizeof(mapping) * 2)
> > +		goto done;
> > +	if (hex2bin(mapping, arg, sizeof(mapping)))
> > +		goto done;
> > +
> > +	if (type == TSEM_CONTROL_MAP_STATE)
> > +		retn = tsem_model_load_point(mapping);
> > +	else if (type == TSEM_CONTROL_MAP_PSEUDONYM)
> > +		retn = tsem_model_load_pseudonym(mapping);
> > +	else {
> > +		tsem_model_load_base(mapping);
> > +		retn = 0;
> > +	}
> > +
> > + done:
> > +	return retn;
> > +}
> > +
> > +static void show_event(struct seq_file *c, struct tsem_event *ep, char *file)
> > +{
> > +	seq_printf(c, "event{process=%s, filename=%s, type=%s, task_id=%*phN}",
> > +		   ep->comm, file ? file : "none", tsem_names[ep->event],
> > +		   WP256_DIGEST_SIZE, ep->task_id);
> > +	seq_printf(c, " COE{uid=%d, euid=%d, suid=%d, gid=%d, egid=%d, sgid=%d, fsuid=%d, fsgid=%d, cap=0x%llx} ",
> > +		   ep->COE.uid, ep->COE.euid, ep->COE.suid, ep->COE.gid,
> > +		   ep->COE.egid, ep->COE.sgid, ep->COE.fsuid, ep->COE.fsgid,
> > +		   ep->COE.capability.value);
> > +}

> You are printing out a lot of specific data in a specific format
> that is documented no where that I can see :(

It appears you found the ABI documentation in the second patch that
was posted in the series, hopefully it was found to be complete, we
are currently in 13th position out of 494 files with respect to
quantity of ABI documentation... :-)

For the sake of 'lore':

After applying the patch series, the control plane API is documented in the
following file:

Documentation/ABI/testing/tsemfs

The TSEM LSM documentation proper will be in the following file:

Documentation/admin-guide/LSM/tsem.rst

Where we currently hold the poll position.

> Also, you are making the same mistake that /proc made decades ago,
> creating files that must be parsed and can NEVER be changed in the
> future.  Why not make this a one-value-per-file filesystem instead
> so that you have flexibility going forward?

Personally, I've been working on Linux since late 1991, so we, as a
team, are well aware, and sensitive, to the issues and discussions
surrounding the file formatting decisions that were made with the
/proc filesystem.  So we did not make the decision with respect to
formatted output lightly.

In fact, I presumed that the top two things we would hear about with
respect to TSEM, would be about the introduction of CAP_TRUST from
Casey and the format of the event export and execution trajectory
files from you.

The issue is that the kernel needs to present to trust orchestrators,
a description of each LSM security hook, in the form of an atomic
update or transaction.

To help clarify the discussion, here are examples of records that are
output for a file_open and socket_bind hook event:

pid{1186} event{process=quixote-us, filename=/opt/Quixote/bin/runc, type=file_open, task_id=0000000000000000000000000000000000000000000000000000000000000000} COE{uid=0, euid=0, suid=0, gid=0, egid=0, sgid=0, fsuid=0, fsgid=0, cap=0x3ffffffffff} file{flags=32800, uid=2, gid=2, mode=0100755, name_length=21, name=4829ead93d026770746f9cdebc76cc4d2a27f45db2d3ac436aa6fce4e2640415, s_magic=0xef53, s_id=xvda, s_uuid=feadbeaffeadbeaffeadbeaffeadbeaf, digest=7c1a43eb99fa739056d6554001d450ca1c9c184ca7e2d8a785bd1e5fd53bad8c}

pid{1204} event{process=ncat, filename=none, type=socket_bind, task_id=a5bc0eb22141657132f29e80ca6ea9b211e8443ead1f4b6b766935a14995040f} COE{uid=0, euid=0, suid=0, gid=0, egid=0, sgid=0, fsuid=0, fsgid=0, cap=0x20000420} socket_bind{family=2, port=28695, addr=0}

TSEM is currently modeling 84 LSM hooks.  We would certainly be open
to suggestions as to how we would architect the one-value-per-file
filesystem model in a manner that would scale, both with respect to
pseudo-filesystem complexity and system call overhead.

> > +static void show_file(struct seq_file *c, struct tsem_event *ep)
> > +{
> > +	seq_printf(c, "file{flags=%u, uid=%d, gid=%d, mode=0%o, name_length=%u, name=%*phN, s_magic=0x%0x, s_id=%s, s_uuid=%*phN, digest=%*phN}\n",
> > +		   ep->file.flags, ep->file.uid, ep->file.gid, ep->file.mode,
> > +		   ep->file.name_length, WP256_DIGEST_SIZE, ep->file.name,
> > +		   ep->file.s_magic, ep->file.s_id,
> > +		   (int) sizeof(ep->file.s_uuid), ep->file.s_uuid,
> > +		   WP256_DIGEST_SIZE, ep->file.digest);

> Same here, where is the documentation for all of this and what
> userspace tools parse it?

We will presume the documentation issue to be addressed.

The cover letter for the patch series, and the LSM documentation
itself, has the URL for the directory on our FTP server that has the
source code for the Quixote trust orchestration system as well as
compiled trust orchestration utilities and an SGX enclave, a Xen
stubdomain executable and micro-controller firmware for the SanchoSGX,
SachoXen and SanchoMCU implementations.

More specifically, the following URL's will, at the time of this
writing, February 2023... :-), pull the source and binaries:

ftp://ftp.enjellic.com/pub/Quixote/Quixote-1.4.tar.gz

ftp://ftp.enjellic.com/pub/Quixote/Quixote-1.4-1.x86_64.rpm

ftp://ftp.enjellic.com/pub/Quixote/quixote_1.4-2_amd64.deb

For some reason 'alien' bumps the release number when it creates the
.deb from the rpm.... :-(

After unpacking the source archive, the code that handles the parsing
of an exported security event description will be found in the
following files:

SecurityModel/EventParser.c

SecurityModel/SecurityEvent.c

SecurityModel/COE.c

SecurityModel/Cell.c

The formatted output was designed to be self-descriptive, extensible
and extremely low cost to parse, without the use of an external
library.  The same codebase runs in everything from a userspace
process, to a Xen stubdomin, through an SGX enclave and multiple
32-bit ARM micro-controller implementations.

The trust orchestration utilities that use the above code, and
implement drivers for the various Sancho trust roots, are in the
'Quixote' directory in the source tree.

> thanks,
> 
> greg k-h

As I indicated above, we are all ears if someone has a better idea on
how to handle the security event description export issue.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
