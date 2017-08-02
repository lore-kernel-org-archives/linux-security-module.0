From: tycho@docker.com (Tycho Andersen)
Date: Wed, 2 Aug 2017 15:48:41 -0600
Subject: [RFC PATCH 3/5] ima: mamespace audit status flags
In-Reply-To: <2848EE0A-2DB8-420B-A611-60967EB90F5C@linux.vnet.ibm.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-4-mkayaalp@linux.vnet.ibm.com>
	<20170801171702.f2szj5huzbt7fdfl@docker>
	<2848EE0A-2DB8-420B-A611-60967EB90F5C@linux.vnet.ibm.com>
Message-ID: <20170802214841.hw4pzjenxw47rcyp@docker>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 01, 2017 at 01:25:31PM -0400, Mehmet Kayaalp wrote:
> >> +unsigned long iint_flags(struct integrity_iint_cache *iint,
> >> +			 struct ns_status *status)
> >> +{
> >> +	if (!status)
> >> +		return iint->flags;
> >> +
> >> +	return iint->flags & (status->flags & IMA_NS_STATUS_FLAGS);
> > 
> > Just to confirm, is there any situation where:
> > 
> >    iint->flags & IMA_NS_STATUS_FLAGS != status->flags & IMA_NS_STATUS_FLAGS
> > 
> > ? i.e. can this line just be:
> > 
> >    return status->flags & IMA_NS_STATUS_FLAGS;
> > 
> 
> As Guilherme had pointed out, the first & should be |.

Sorry, that mail got filtered somehow, thanks. Per your discussion, I
guess the most defensive way is:

iint->flags & ~IMA_NS_STATUS_FLAGS | status->flags & IMA_NS_STATUS_FLAGS

in case something comes along and sets IMA_AUDITED on the root iint,
we don't want it to propagate to this ns' status unnecessarily.

Anyway, thanks!

Tycho
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
