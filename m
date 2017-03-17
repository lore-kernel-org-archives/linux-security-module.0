From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 17 Mar 2017 11:11:16 -0600
Subject: [PATCH v3] tpm_crb: request and relinquish locality 0
In-Reply-To: <878to3x2h2.fsf@redhat.com>
References: <20170315055738.11088-1-jarkko.sakkinen@iki.fi>
	<87h92uvtce.fsf@redhat.com> <87fuidx5mt.fsf@redhat.com>
	<20170316115543.jw23imcvkcriaam5@intel.com>
	<878to3x2h2.fsf@redhat.com>
Message-ID: <20170317171116.GA29996@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 17, 2017 at 10:00:41AM -0700, Jerry Snitselaar wrote:

> > Changing the return value to -EBUSY was a stupid mistake from my side.
> >
> > I'll try revise this a bit in a way that the API will allow positive
> > value for stating that the given locality has been already taking.
> 
> Is there a big performance hit with requesting and releasing locality?
> If instead it just released it when release_locality is called I think
> the changes are pretty minor.

If you can measure please let us know :)

This is all very old it may not actually make any sense..

.. and as I said earlier if we want to 'cache' the locality for
performance then the core code should do it.

I kinda thought the point of releasing the locality was to allow other
platform things to access the TPM, so I'm confused why TIS wouldn't
always release it as well..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
