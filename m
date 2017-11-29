From: davem@davemloft.net (David Miller)
Date: Wed, 29 Nov 2017 10:58:16 -0500 (EST)
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171129155406.i2lyclquj75lvtn4@thunk.org>
References: <20171129134612.72ccb53d@alans-desktop>
	<20171129.095014.1909386937628805919.davem@davemloft.net>
	<20171129155406.i2lyclquj75lvtn4@thunk.org>
Message-ID: <20171129.105816.1108278026315471171.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 29 Nov 2017 10:54:06 -0500

> On Wed, Nov 29, 2017 at 09:50:14AM -0500, David Miller wrote:
>> From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
>> Date: Wed, 29 Nov 2017 13:46:12 +0000
>> 
>> > I really don't care what the module loading rules end up with and
>> > whether we add CAP_SYS_YET_ANOTHER_MEANINGLESS_FLAG but what is
>> > actually needed is to properly incorporate it into securiy ruiles
>> > for whatever LSM you are using.
>> 
>> I'm surprised we're not using the SHA1 hashes or whatever we compute
>> for the modules to make sure we are loading the foo.ko that we expect
>> to be.
> 
> We do have signed modules.  But this won't help us if the user is
> using a distro kernel which has compiled some module which is known to
> be unmaintained which everyone in the know *expects* to have 0-day
> bugs, such as DCCP.  That's because the DCCP module is signed.

That's not what we're talking about.

We're talking about making sure that loading "ppp.ko" really gets
ppp.ko rather than some_other_module.ko renamed to ppp.ko via some
other mechanism.

Both modules have legitimate signatures so the kernel will happily
load both.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
