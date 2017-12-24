From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 24 Dec 2017 00:56:01 -0500
Subject: [PATCH 11/11] evm: Don't update hmacs in user ns mounts
In-Reply-To: <1514092328.5221.116.camel@linux.vnet.ibm.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
	<1f2233a1a028f1eb1e9bea7d06efa6d34e69e752.1512041070.git.dongsu@kinvolk.io>
	<20171223040348.GK6837@mail.hallyn.com>
	<1514092328.5221.116.camel@linux.vnet.ibm.com>
Message-ID: <1514094961.5221.132.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 2017-12-24 at 00:12 -0500, Mimi Zohar wrote:
> Hi Serge,
> 
> On Fri, 2017-12-22 at 22:03 -0600, Serge E. Hallyn wrote:
> > On Fri, Dec 22, 2017 at 03:32:35PM +0100, Dongsu Park wrote:
> > > From: Seth Forshee <seth.forshee@canonical.com>
> > > 
> > > The kernel should not calculate new hmacs for mounts done by
> > > non-root users. Update evm_calc_hmac_or_hash() to refuse to
> > > calculate new hmacs for mounts for non-init user namespaces.
> > > 
> > > Cc: linux-integrity at vger.kernel.org
> > > Cc: linux-security-module at vger.kernel.org
> > > Cc: linux-kernel at vger.kernel.org
> > > Cc: James Morris <james.l.morris@oracle.com>
> > > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > 
> > Hi Mimi,
> > 
> > does this change seem sufficient to you?
> 
> I think this is the correct behavior in the context of fuse file
> systems. ?This patch, the "ima: define a new policy option named
> force" patch, and an updated IMA policy should be upstreamed together.
> ?The cover letter should provide the motivation for these patches.

Ah, this patch is being upstreamed with the fuse mounts patches. ?I
guess Seth is planning on posting the IMA policy changes for fuse
separately.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
