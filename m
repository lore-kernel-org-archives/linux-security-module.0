From: jmorris@namei.org (James Morris)
Date: Wed, 7 Mar 2018 09:10:10 +1100 (AEDT)
Subject: [PATCH] usb,signal,security: only pass the cred, not the secid,
	to kill_pid_info_as_cred and security_task_kill
In-Reply-To: <8b1ea069-2389-5298-c187-647202762d72@schaufler-ca.com>
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
	<CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
	<alpine.LRH.2.21.1709090808200.15026@namei.org>
	<CAHC9VhQ3YRmk7k5DQO9zoGKRXi3CSTHvmRuLa891NVWsVNCZZA@mail.gmail.com>
	<8b1ea069-2389-5298-c187-647202762d72@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1803070909310.14366@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 6 Mar 2018, Casey Schaufler wrote:

> On 3/6/2018 11:01 AM, Paul Moore wrote:
> > On Fri, Sep 8, 2017 at 6:09 PM, James Morris <jmorris@namei.org> wrote:
> >> On Fri, 8 Sep 2017, Paul Moore wrote:
> >>> Looks fine to me from a SELinux perspective.  If Casey and John are
> >>> happy with this I can volunteer to pull it into the selinux/next tree
> >>> (once the merge window closes), otherwise if someone else wants to
> >>> merge this my ack is below.
> >> As this impacts multiple LSMs, I'd prefer to take it via my tree.
> > What happened to this James?  As best I can tell there were never any
> > objections, and plenty of ACKs, but I don't see it in Linus' tree.
> > I'll extend my offer to merge it, but I know you expressed a desire to
> > pull this via your tree.
> 
> I was also surprised that it had not been included.
> 
> >
> > * http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003156.html
> >

Oops,

Now applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing




-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
