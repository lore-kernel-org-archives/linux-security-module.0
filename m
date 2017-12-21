From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 21 Dec 2017 13:38:53 -0700
Subject: [PATCH] tpm: Fix the driver cleanup code
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF5828989144@ORSMSX109.amr.corp.intel.com>
References: <1513887422-123222-1-git-send-email-azhar.shaikh@intel.com>
	<20171221202652.GH20015@ziepe.ca>
	<5FFFAD06ADE1CA4381B3F0F7C6AF5828989144@ORSMSX109.amr.corp.intel.com>
Message-ID: <20171221203853.GI20015@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Dec 21, 2017 at 08:31:14PM +0000, Shaikh, Azhar wrote:

> Yes I thought about it too. But if some other chip->ops function in
> future, which *might* be in this same case, hence for that
> introduced this flag.

It can't be - the ops struct is constant, can't be modified, and
tpm_tis_core controls what is set. If someone future person meddles in
this then they can fix here to.

Recommend a short comment in the ops clk_enale initializer and call direct?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
