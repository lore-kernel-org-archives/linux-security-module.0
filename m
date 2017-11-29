From: tytso@mit.edu (Theodore Ts'o)
Date: Wed, 29 Nov 2017 11:29:45 -0500
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171129.105816.1108278026315471171.davem@davemloft.net>
References: <20171129134612.72ccb53d@alans-desktop>
	<20171129.095014.1909386937628805919.davem@davemloft.net>
	<20171129155406.i2lyclquj75lvtn4@thunk.org>
	<20171129.105816.1108278026315471171.davem@davemloft.net>
Message-ID: <20171129162945.u2zjcoe4gsanhmkc@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 29, 2017 at 10:58:16AM -0500, David Miller wrote:
> That's not what we're talking about.
> 
> We're talking about making sure that loading "ppp.ko" really gets
> ppp.ko rather than some_other_module.ko renamed to ppp.ko via some
> other mechanism.

Right, and the best solution to this problem is to include in the
signature the name of the module.  (One way of doing this is adding
the module name into the cryptographic checksum which is then
digitally signed by the kernel module key; we would have to bump the
version number of the signature format, obviously.)  This binds the
name of the module into the digital signature so that it can't be
renamed.

						- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
