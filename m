From: paul@paul-moore.com (Paul Moore)
Date: Fri, 2 Feb 2018 15:19:36 -0500
Subject: [PATCH-selinuxns] selinux: Annotate lockdep for services locks
In-Reply-To: <52754014-7f0f-bd9a-483f-b12fb90cb044@sony.com>
References: <20180202080554.9689-1-peter.enderborg@sony.com>
	<1517580659.28460.9.camel@tycho.nsa.gov>
	<52754014-7f0f-bd9a-483f-b12fb90cb044@sony.com>
Message-ID: <CAHC9VhT=HcWyej=e-Ji1nEoz_q=Hwm-e332RemwfpW4s-dE60w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Feb 2, 2018 at 9:40 AM, peter enderborg
<peter.enderborg@sony.com> wrote:
> I will send the patches to pauls next tree. Im abit confused on when that is
> appropriate. Obviously there will be collisions with the namespace, but
> the patches also solves few of my prerequisite topics.

In an effort to clear up any confusion, here is the tentative plan ...
While I generally try to avoid rebasing the selinux/next branch, there
are a few things that we probably want to pull in from Linus' tree, so
after the merge window closes (I expect that to happen next weekend)
I'll rebase selinux/next to v4.16-rc1.  I always send a note to the
list when I rebase the selinux/next branch.

>From there, it's a matter of sorting out the merging logistics; I
suspect Stephen will probably just rebase his own selinuxns patches
(and presumably incorporate any feedback), but I tend to be a bit more
forgiving about manual fixups when merging patches after a rebase.
After Stephen's patches are merged we can merge the other bits that
rely on them.

Does that make sense?

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
