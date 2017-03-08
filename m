From: jmorris@namei.org (James Morris)
Date: Wed, 8 Mar 2017 17:04:51 +1100 (AEDT)
Subject: Kernel repository updated to v4.11-rc1
In-Reply-To: <1488823937.674.13.camel@tycho.nsa.gov>
References: <alpine.LRH.2.20.1703061115270.31922@namei.org>
	<1488823937.674.13.camel@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1703081704310.8741@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 6 Mar 2017, Stephen Smalley wrote:

> On Mon, 2017-03-06 at 11:18 +1100, James Morris wrote:
> > FYI, I've merged security-next with v4.11-rc1 and then merged the?
> > following queued patches:
> > 
> > ca97d939db114c8d1619e10a3b82af8615372dae security: mark LSM hooks as
> > __ro_after_init
> > dd0859dccbe291cf8179a96390f5c0e45cb9af1d security: introduce
> > CONFIG_SECURITY_WRITABLE_HOOKS
> > 84e6885e9e6a818d1ca1eabb9b720b357ab07a8b selinux: fix kernel BUG on
> > prlimit(..., NULL, NULL)
> > 791ec491c372f49cea3ea7a7143454a9023ac9d4 prlimit,security,selinux:
> > add a security hook for prlimit
> > 
> > Please test!
> 
> Passes the SELinux testsuite for me, and correctly set or unset
> CONFIG_SECURITY_WRITABLE_HOOKS based on whether
> CONFIG_SECURITY_SELINUX_DISABLE is unset/set.

Thanks!

> 
> I noticed that CONFIG_SECURITY_SELINUX_DISABLE=y has crept into many
> defconfig files; might want to remove that at some point so that people
> don't enable it if they don't truly need it.

Ok, that's next.


-- 
James Morris
<jmorris@namei.org>
