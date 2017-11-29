From: tytso@mit.edu (Theodore Ts'o)
Date: Wed, 29 Nov 2017 10:54:06 -0500
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171129.095014.1909386937628805919.davem@davemloft.net>
References: <20171128211659.GP729@wotan.suse.de>
	<CAGXu5j+JaFCo+pZKvet==Kh7GQgNXi30P50SMF4cpOGoUw-8ug@mail.gmail.com>
	<20171129134612.72ccb53d@alans-desktop>
	<20171129.095014.1909386937628805919.davem@davemloft.net>
Message-ID: <20171129155406.i2lyclquj75lvtn4@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 29, 2017 at 09:50:14AM -0500, David Miller wrote:
> From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Date: Wed, 29 Nov 2017 13:46:12 +0000
> 
> > I really don't care what the module loading rules end up with and
> > whether we add CAP_SYS_YET_ANOTHER_MEANINGLESS_FLAG but what is
> > actually needed is to properly incorporate it into securiy ruiles
> > for whatever LSM you are using.
> 
> I'm surprised we're not using the SHA1 hashes or whatever we compute
> for the modules to make sure we are loading the foo.ko that we expect
> to be.

We do have signed modules.  But this won't help us if the user is
using a distro kernel which has compiled some module which is known to
be unmaintained which everyone in the know *expects* to have 0-day
bugs, such as DCCP.  That's because the DCCP module is signed.

We could fix this by adding to the signature used for module signing
to include the module name, so that the bad guy can't rename dccp.ko
to be ppp.ko, I suppose....

> All of this capability stuff seems to dance a circle around the
> problem rather than fix it.

Half the problem here is that with containers, people are changing the
security model, because they want to let untrusted users have "root",
without really having "root".  Part of the fundamental problem is that
there are some well-meaning, but fundamentally misguided people, who
have been asserting: "Containers are just as secure as VM's".

Well, they are not.  And the sooner people get past this, the better
off they'll be....

						- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
