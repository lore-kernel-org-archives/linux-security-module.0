From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 13 Mar 2017 11:07:37 -0400
Subject: Kernel repository updated to v4.11-rc1  *** reverted ??? ***
In-Reply-To: <20170313145318.GA20608@gmail.com>
References: <alpine.LRH.2.20.1703061115270.31922@namei.org>
	<1489406649.28954.143.camel@linux.vnet.ibm.com>
	<alpine.LRH.2.20.1703140123580.23070@namei.org>
	<20170313145318.GA20608@gmail.com>
Message-ID: <1489417657.28954.163.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-03-13 at 10:53 -0400, Konstantin Ryabitsev wrote:
> On Tue, Mar 14, 2017 at 01:40:14AM +1100, James Morris wrote:
> >On Mon, 13 Mar 2017, Mimi Zohar wrote:
> >
> >> On Mon, 2017-03-06 at 11:18 +1100, James Morris wrote:
> >> > FYI, I've merged security-next with v4.11-rc1 and then merged the
> >> > following queued patches:
> >> >
> >> > ca97d939db114c8d1619e10a3b82af8615372dae security: mark LSM hooks as __ro_after_init
> >> > dd0859dccbe291cf8179a96390f5c0e45cb9af1d security: introduce CONFIG_SECURITY_WRITABLE_HOOKS
> >> > 84e6885e9e6a818d1ca1eabb9b720b357ab07a8b selinux: fix kernel BUG on prlimit(..., NULL, NULL)
> >> > 791ec491c372f49cea3ea7a7143454a9023ac9d4 prlimit,security,selinux: add a security hook for prlimit
> >> >
> >> > Please test!
> >>
> >> The current tip of the linux-security #next branch has been reverted to
> >> commit 61841be6358c "tpm: declare tpm2_get_pcr_allocation() as static".
> >> Was this intentional?
> >>
> >
> >That's very odd.  It looks correct via git web:
> >https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/log/?h=next
> >
> >(ca97d939)
> >

From
"https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git", I'm seeing:

next	tpm: declare tpm2_get_pcr_allocation() as static	Jarkko Sakkinen	3 weeks

> >but when I clone a new tree, I see what you see (61841be6358c).
> >
> >Did you see a forced update message when you pulled?

> >Perhaps there was a disk restore at kernel.org?
> 
> Can you tell me precise origin paths for where things are correct and 
> where things are wrong?

For me, both the git repo and the URL are wrong:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
