From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 3 Nov 2017 22:25:29 +0800
Subject: [PATCH v10 00/20] simplify crypto wait for async op
In-Reply-To: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
References: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
Message-ID: <20171103142528.GL9011@gondor.apana.org.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 18, 2017 at 08:00:32AM +0100, Gilad Ben-Yossef wrote:
> Many users of kernel async. crypto services have a pattern of
> starting an async. crypto op and than using a completion
> to wait for it to end.
> 
> This patch set simplifies this common use case in two ways:
> 
> First, by separating the return codes of the case where a
> request is queued to a backlog due to the provider being
> busy (-EBUSY) from the case the request has failed due
> to the provider being busy and backlogging is not enabled
> (-ENOSPC).
> 
> Next, this change is than built on to create a generic API
> to wait for a async. crypto operation to complete.
> 
> The end result is a smaller code base and an API that is
> easier to use and more difficult to get wrong.
> 
> The patch set was boot tested on x86_64 and arm64 which
> at the very least tests the crypto users via testmgr and
> tcrypt but I do note that I do not have access to some
> of the HW whose drivers are modified nor do I claim I was
> able to test all of the corner cases.
> 
> The patch set is based upon linux-next release tagged
> next-20171017.

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
