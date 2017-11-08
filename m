From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 08 Nov 2017 18:33:32 -0500
Subject: [GIT PULL] linux-integrity patches for 4.15-security-next-testing
In-Reply-To: <alpine.LFD.2.20.1711091018260.19483@localhost>
References: <1510178057.4484.64.camel@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1711091018260.19483@localhost>
Message-ID: <1510184012.4484.69.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-11-09 at 10:18 +1100, James Morris wrote:
> On Wed, 8 Nov 2017, Mimi Zohar wrote:
> 
> > Hi James,
> > 
> > These are the rebased EVM & IMA patches for the security/next-testing
> > branch. ?There is a mixture of bug fixes, code cleanup, preparatory
> > code for new functionality and new functionality.
> > 
> > Commit?26ddabfe96bb "evm: enable EVM when X509 certificate is loaded"
> > enabled EVM without loading a symmetric key, but was limited to
> > defining the x509 certificate pathname at build. ?Included in this set
> > of patches is the ability of enabling EVM, without loading the EVM
> > symmetric key, from userspace. ?New is the ability to prevent the
> > loading of an EVM symmetric key.
> > 
> > [A version of commit 917086ff231f "vfs: fix mounting a filesystem with
> > i_version" is included here, as it was upstreamed in -rc6.]
> > 
> 
> Merged to next-testing and next-integrity in
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git

Hm, does this mean that these patches will be included in your pull
request? ?Based on Linus "comments" last time, is this such a good
idea?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
