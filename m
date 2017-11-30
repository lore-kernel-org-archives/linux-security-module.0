From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 30 Nov 2017 11:17:51 -0600
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171130003531.gwpl22bxmweifjz2@thunk.org>
References: <20171128211659.GP729@wotan.suse.de>
	<CAGXu5j+JaFCo+pZKvet==Kh7GQgNXi30P50SMF4cpOGoUw-8ug@mail.gmail.com>
	<20171129134612.72ccb53d@alans-desktop>
	<20171129.095014.1909386937628805919.davem@davemloft.net>
	<20171129155406.i2lyclquj75lvtn4@thunk.org>
	<20171129172852.GA14545@mail.hallyn.com>
	<20171130003531.gwpl22bxmweifjz2@thunk.org>
Message-ID: <20171130171751.GA5521@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 29, 2017 at 07:35:31PM -0500, Theodore Ts'o wrote:
> On Wed, Nov 29, 2017 at 11:28:52AM -0600, Serge E. Hallyn wrote:
> > 
> > Just to be clear, module loading requires - and must always continue to
> > require - CAP_SYS_MODULE against the initial user namespace.  Containers
> > in user namespaces do not have that.
> > 
> > I don't believe anyone has ever claimed that containers which are not in
> > a user namespace are in any way secure.
> 
> Unless the container performs some action which causes the kernel to
> call request_module(), which then loads some kernel module,

A local unprivileged user can do the same thing.  I reject the popular
notion that linux is a single user operating system.  More interesting
are the (very real) cases where root in a container can do something
which a local unprivileged user could not do.  Since a local unprivileged
user can always create a new namespace, *those* constitute a real and
interesting problem.

> potentially containing cr*p unmaintained code which was included when
> the distro compiled the world, into the host kernel.

> This is an attack vector that doesn't exist if you are using VM's.

Until the vm tenant uses a trivial vm escape.

> And in general, the attack surface of the entire Linux
> kernel<->userspace API is far larger than that which is exposed by the
> guest<->host interface.
> 
> For that reason, containers are *far* more insecure than VM's, since
> once the attacker gets root on the guest VM, they then have to attack
> the hypervisor interface.  And if you compare the attack surface of
> the two, it's pretty clear which is larger, and it's not the
> hypervisor interface.

Any time anyone spends a day looking at either the black hole that is
the hardware emulators or the xen and kvm code itself they walk away
with a set of cve's.  It *should* be more secure, it's not.  You're
telling me your house is safe because you put up a no tresspassing
sign.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
