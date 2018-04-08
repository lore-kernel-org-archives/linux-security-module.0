From: paul@paul-moore.com (Paul Moore)
Date: Sun, 08 Apr 2018 08:45:45 -0400
Subject: [GIT PULL] SELinux patches for v4.17
In-Reply-To: <CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
	<CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
	<CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
Message-ID: <162a54a7ca8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On April 8, 2018 2:13:51 AM Xin Long <lucien.xin@gmail.com> wrote:
On Sat, Apr 7, 2018 at 7:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com> wrote:

Everything passes the selinux-testsuite, but there are a few known
merge conflicts.  The first is with the netdev tree and is in
net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
Rothwell has already done the heavy lifting in resolving the merge for
you, and the SCTP folks have given his merge patch a thumbs-up.

I ended up re-doing the merge, and it looks like some more sctp
changes happened after Stephen's merge anyway, so mine didn't end up
quite like his.
You're right, a sctp fix went into net-next after Stephen's that merge.
https://patchwork.ozlabs.org/patch/884469/ (v1)
https://patchwork.ozlabs.org/patch/884971/ (v2)

Which caused the resolution to have changed again.

I've checked the new resolution on your tree, the SCTP part is all good.

Thanks for double checking that Xin.

--
paul moore
www.paul-moore.com




--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
