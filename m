From: james.l.morris@oracle.com (James Morris)
Date: Thu, 2 Nov 2017 11:18:32 +1100 (AEDT)
Subject: [PULL] Smack: Changes for 4.15
In-Reply-To: <e8daf4e9-aedd-9bef-263e-48d2501268ea@schaufler-ca.com>
References: <e8daf4e9-aedd-9bef-263e-48d2501268ea@schaufler-ca.com>
Message-ID: <alpine.LFD.2.20.1711021117140.16891@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 1 Nov 2017, Casey Schaufler wrote:

> Only one change for Smack for 4.15. A fix for overlayfs handling.
> 
> The following changes since commit eb95b40b45a1ee4218cab0e6c72dd014d8f09bee:
> 
>   Merge branch 'next-general' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security into next (2017-09-25 11:03:43 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/cschaufler/smack-next smack-for-4.15
> 
> for you to fetch changes up to c31a5d0182e7b76392295b9a9a5637ca1022c450:
> 
>   Smack: Base support for overlayfs (2017-10-16 12:13:12 -0700)
> 
> ----------------------------------------------------------------
> Casey Schaufler (1):
>       Smack: Base support for overlayfs
> 
>  security/smack/smack_lsm.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)

I'll cherry pick this but it looks like you're pulling stuff into your 
tree from Linus (including the IMA & Tomoyo changes which Paul 
acccidentally sent).

Please base your tree off next-general, not Linus.


- James
-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
