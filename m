From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 3 Jul 2017 20:35:15 +0800
Subject: [PATCH v3 01/28] crypto: change backlog return code to
	-EIOCBQUEUED
In-Reply-To: <1499006535-19760-2-git-send-email-gilad@benyossef.com>
References: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
	<1499006535-19760-2-git-send-email-gilad@benyossef.com>
Message-ID: <20170703123515.GC30067@gondor.apana.org.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jul 02, 2017 at 05:41:43PM +0300, Gilad Ben-Yossef wrote:
> The crypto API was using the -EBUSY return value to indicate
> both a hard failure to submit a crypto operation into a
> transformation provider when the latter was busy and the backlog
> mechanism was not enabled as well as a notification that the operation
> was queued into the backlog when the backlog mechanism was enabled.
> 
> Having the same return code indicate two very different conditions
> depending on a flag is both error prone and requires extra runtime
> check like the following to discern between the cases:
> 
> 	if (err == -EINPROGRESS ||
> 	    (err == -EBUSY && (ahash_request_flags(req) &
> 			       CRYPTO_TFM_REQ_MAY_BACKLOG)))
> 
> This patch changes the return code used to indicate a crypto op
> was queued in the backlog to -EIOCBQUEUED, thus resolving both
> issues.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

So you're changing the success case from EBUSY to EIOCBQUEUED.
This results in a lot of churn as you have to change every single
driver and caller.

How about changing the error case to use something other than
EBUSY instead?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
