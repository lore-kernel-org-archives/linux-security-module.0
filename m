From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Sun, 5 Nov 2017 19:27:04 -0700
Subject: [PATCH v2] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <20171105110506.usxmuzrvcjvxahr6@linux.intel.com>
References: <20171031200503.GC18578@ziepe.ca>
	<20171105110506.usxmuzrvcjvxahr6@linux.intel.com>
Message-ID: <20171106022704.GD26011@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Nov 05, 2017 at 01:05:06PM +0200, Jarkko Sakkinen wrote:

> I asked to create a series for a reason. Now this doesn't apply because I
> don't have an ancestor in my git history.

It would be unusual for me to put your patch into a series unless I am
also adopting it. eg what happens if there are more comments on it?

Also, I wasn't sure what branch your patch was against since my tree
didn't have history for it either..

Sometimes the maintainer has to sort stuff like this out... :)

> Please resend as series together with my patch. I can apply neither yet
> because they have zero tested-by's.

Hopefully PrasannaKumar can test both patches.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
