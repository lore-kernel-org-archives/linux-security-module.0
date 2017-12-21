From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 21 Dec 2017 15:30:49 -0700
Subject: [PATCH] tpm: Fix the driver cleanup code
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582898918B@ORSMSX109.amr.corp.intel.com>
References: <1513887422-123222-1-git-send-email-azhar.shaikh@intel.com>
	<20171221202652.GH20015@ziepe.ca>
	<5FFFAD06ADE1CA4381B3F0F7C6AF5828989144@ORSMSX109.amr.corp.intel.com>
	<20171221203853.GI20015@ziepe.ca>
	<5FFFAD06ADE1CA4381B3F0F7C6AF582898918B@ORSMSX109.amr.corp.intel.com>
Message-ID: <20171221223049.GJ20015@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Dec 21, 2017 at 09:54:26PM +0000, Shaikh, Azhar wrote:

> Yes, I checked this part. What I was referring to is any other
> callback function similar to clk_enable if gets added in future and
> then needs to Access ops even after it is set to NULL...

You can't call callback functions after tpm_unregister_chip, it isn't
allowed.

This is a special case where we know the specific implementation of
this specific callback is OK.

> But yes I get your point now.
> 
> So do you mean something like this?

Yes

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
