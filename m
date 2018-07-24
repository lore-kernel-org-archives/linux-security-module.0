From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 23 Jul 2018 20:05:54 -0600
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <ee0f0ccf-f757-a7d4-bf55-316f81fb490b@intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
	<20180723201956.GB26824@linux.intel.com>
	<fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
	<1532380412.4112.22.camel@HansenPartnership.com>
	<7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
	<20180723215620.GH532@ziepe.ca>
	<dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
	<20180723220822.GJ532@ziepe.ca>
	<ee0f0ccf-f757-a7d4-bf55-316f81fb490b@intel.com>
Message-ID: <20180724020554.GL532@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 23, 2018 at 04:42:38PM -0700, Tadeusz Struk wrote:
> On 07/23/2018 03:08 PM, Jason Gunthorpe wrote:
> > On Mon, Jul 23, 2018 at 03:00:20PM -0700, Tadeusz Struk wrote:
> >> On 07/23/2018 02:56 PM, Jason Gunthorpe wrote:
> >>> The proposed patch doesn't clear the data_pending if the entire buffer
> >>> is not consumed, so of course it is ABI breaking, that really isn't OK.
> >> The data_pending will be cleared by the timeout handler if the user doesn't
> >> read the response fully before the timeout expires. The is the same situation
> >> if the user would not read the response at all.
> > That causes write() to fail with EBUSY
> > 
> > NAK from me on breaking the ABI like this
> 
> What if we introduce this new behavior only for the non-blocking mode
> as James suggested? Or do you have some other suggestions?

I think you should do it entirely in userspace.

But something sensible linked to O_NONBLOCK could be OK.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
