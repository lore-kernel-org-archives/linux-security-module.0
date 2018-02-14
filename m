From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 14 Feb 2018 10:36:09 -0500
Subject: [RFC PATCH 2/4] ima: fail signature verification on
	unprivileged & untrusted filesystems
In-Reply-To: <20180214151637.GA2671@mail.hallyn.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
	<20180214144903.GA1953@mail.hallyn.com>
	<1518620899.5667.10.camel@linux.vnet.ibm.com>
	<20180214151637.GA2671@mail.hallyn.com>
Message-ID: <1518622569.5667.26.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-02-14 at 09:16 -0600, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> > On Wed, 2018-02-14 at 08:49 -0600, Serge E. Hallyn wrote:
> > > Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> > > > Files on untrusted filesystems, such as fuse, can change at any time,
> > > > making the measurement(s) and by extension signature verification
> > > > meaningless.
> > > > 
> > > > FUSE can be mounted by unprivileged users either today with fusermount
> > > > installed with setuid, or soon with the upcoming patches to allow FUSE
> > > > mounts in a non-init user namespace.
> > > > 
> > > > This patch always fails the file signature verification on unprivileged
> > > > and untrusted filesystems.  To also fail file signature verification on
> > > 
> > > Why only untrusted?  Fuse could cause the same issue if it just
> > > messes up when mounted from init userns right?
> > 
> > Right, whether it is an unprivileged mount or not, fuse can return
> > whatever it wants, whenever it wants. ?IMA can calculate the file hash
> > based based on what it reads, but fuse can return whatever it wants on
> > subsequent reads.
> 
> Ok but your patch seems to let privileged fuse mounts slide?  (see below)

Unprivileged fuse mounts hasn't been upstreamed yet, so we wouldn't be
breaking existing userspace.

> 
> > Refer to the discussion with Linus -?http://kernsec.org/pipermail/linu
> > x-security-module-archive/2018-February/005200.html
> > 
> > > > privileged, untrusted filesystems requires a custom policy.
> > > 
> > > (I'm not saying you shouldn't do this, but) does this mean that
> > > a container whose rootfs is fuse-mounted by the unprivileged user
> > > cannot possibly use IMA?
> > 
> > How would you suggest to differentiate between your unprivileged fuse
> > mounts from unintended, unintended malicious ones?
> 
> I wouldn't.

What happened to the requirement that systems should be "fail-safe"?
Ok, hard coding this rule probably is not a good idea. ?For those
wanting to take this liability on their systems, we can make this
configurable, like for privileged fuse mounts. ?Unlike for privileged
fuse mounts, the builtin policies, I think, should be fail safe and
include the "fail" rule for unprivileged fuse mounts.

> 
> > The remaining patches are policy based.
> > 
> > > Good thing we can partially work around that by intercepting real
> > > mount calls with Tycho's new patchset :)
> > 
> > Can you provide a little more details?
> 
> It would allow a container runtime to intercept mount(2) and perform
> a real mount on the user's behalf.  Assuming the runtime is privileged,
> of course, otherwise it would intercept and do a fuse mount which is
> no help here :)
> 
> https://lkml.org/lkml/2018/2/4/28

thanks!

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
