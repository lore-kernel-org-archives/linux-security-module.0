From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 13 Mar 2017 14:43:14 -0600
Subject: [PATCH v2] tpm_crb: request and relinquish locality 0
In-Reply-To: <20170313201235.tvcyugdh7awqfrfq@intel.com>
References: <20170311130216.21419-1-jarkko.sakkinen@linux.intel.com>
	<20170313163452.GD22997@obsidianresearch.com>
	<20170313201235.tvcyugdh7awqfrfq@intel.com>
Message-ID: <20170313204314.GB3390@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 13, 2017 at 10:12:35PM +0200, Jarkko Sakkinen wrote:
> > I think you should also put a relinquish_locality inside tpm_remove ?
> 
> Right. I was wondering why release_locality is called inside
> tpm_tis_remove().

I also wonder that.. It sort of makes send to idle the TPM, but it is
kinda goofy to have paired function calls that are not ultimately
paried.

> So is the idea of checking pendingRequest such that the release
> part is "lazy" and not like what I'm doing in tpm_crb (always
> relinquish).
>
> Is that done for performance reasons? Should I do the same (pr
> similar in tpm_crb?

No idea, sorry. This stuff is so old and locality has never been an
exposed API by the kernel, AFAIK. Wouldn't surprise me at all if it
doesn't work right.

But.. If you don't need 'force' for CRB, I suggest that we drop the
'force' from the public API. TIS can do its special !force behavior in
its own remove as it does today.

However.. if we want to do some kind of locality caching for
performance then I think the core code should do it, not the
individual drivers.

Why do we need to reliquish the locality on every command anyhow? Does
the firmware interact with this?

Why are you adding locality to crb without a user anyhow?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
