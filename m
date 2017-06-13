From: paul@paul-moore.com (Paul Moore)
Date: Tue, 13 Jun 2017 11:37:15 -0400
Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
In-Reply-To: <3e8e03a4-ec19-71c5-2eae-46201507b962@schaufler-ca.com>
References: <3e8e03a4-ec19-71c5-2eae-46201507b962@schaufler-ca.com>
Message-ID: <CAHC9VhS=XF-_stYvFTw37DrJQaHh9G=vmZAbeDObP9DXH7Bi6g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 8, 2017 at 10:41 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Subject: [PATCH RFC] Smack: More sanity in the use of Netlabel
>
> I want to make some changes to Smack's way of looking at
> networks and network labeling. The existing default is that
> Smack thinks everyone is a CIPSO host and that any packet
> without a label should get the ambient label. This was the
> right choice in 1997 when MLS hosts only talked to each other,
> and might have made some sense in 2007 when Smack got started,
> but is clearly not going to work well in 2017. I also have
> found that the way Smack uses Netlabel is painfully at odds
> with the way SELinux does, and that could prevent my long
> term goal of complete module stacking from coming about.
>
> The proposed New World Order shouldn't break anybody who
> isn't using a network that is dedicated to nothing but
> CIPSO hosts, and that's easy to configure, too. It should
> make working side-by-side with SELinux reasonably simple.
>
> Today, the ambient label (floor by default) is defined as
> an unlabeled Netlabel domain, and the default domain is a
> cipsov4, doi:3. When a network address is configured to be
> single-label the Netlabel configuration does not look right
> to me, I'm not sure it did anything useful.
>
> The change simplifies (put the 'S' in "Smack") the Netlabel
> configuration and makes everything clearer. To maintain
> compatibility, 0.0.0.0/0 is given cipsov4,doi:3 and looks
> on the net as it does today. The loopback address 127.0.0.1/32
> gets cipsov4,doi:2 and doi:2 is defined to use tag:6, which
> is the local-only but always correct tag.
>
> Because the new configuration uses addresses, it's easy
> to map it to something reasonable for SELinux. Change
> 0.0.0.0/0 to an unlabeled domain are you should be happy.
>
> # echo 0.0.0.0/0 System > /sys/fs/smackfs/netlabel
>
> I'm not 100% done with this patch, but I have to leave it
> alone for a few days, so it seemed like a good point to
> get other eyes on it.

I'll refrain from commenting on any details in the Smack code, but I
thought it might be worth mentioning/asking two things:

* I know I've brought this up before and you punted, but since you are
reworking the code I figured it is worth mentioning again: I would
really recommend leveraging the NetLabel caching mechanism.  All of my
measurements are old, but the performance improvement for SELinux was
significant; not only do you get to bypass the CIPSO/CALIPSO option
parsing, but you get to bypass any of the secattr-to-LSM conversions
necessary.

* It sounds like the main motivation for this change is to help enable
LSM stacking for the per-packet access controls.  With that in mind
would you care to share your current thinking/plans for that?  The
proper context (SELinux joke, hardy har har) should help us comment on
the ideas/designs in this patch.

> Oh, and I cleaned up those IPv6 ifdefs that made everyone
> cringe so.

Regardless of everything else, this makes me happy.  I have to think
this should make your life a bit easier too. :)

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/Kconfig           |  10 +-
>  security/smack/Makefile          |   3 +-
>  security/smack/smack.h           |  24 ++--
>  security/smack/smack_access.c    |   6 +-
>  security/smack/smack_lsm.c       | 265 ++++++++++++++++++++++-----------------
>  security/smack/smack_netfilter.c |   4 +-
>  security/smack/smackfs.c         | 208 +++++++++++++++++++-----------
>  7 files changed, 308 insertions(+), 212 deletions(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
