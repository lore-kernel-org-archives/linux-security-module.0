From: jmorris@namei.org (James Morris)
Date: Wed, 4 Oct 2017 17:17:39 +1100 (AEDT)
Subject: [PATCH] fix security_release_secctx seems broken
In-Reply-To: <ec271e46-07d3-78ba-e58d-3606b0889cbf@schaufler-ca.com>
References: <d09e29aa-f34c-3260-677a-3017cd1cd347@yandex-team.ru>
	<c007fac4-4e2a-6076-513d-6f52f7133a2d@schaufler-ca.com>
	<ec271e46-07d3-78ba-e58d-3606b0889cbf@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1710041713160.19339@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 19 Sep 2017, Casey Schaufler wrote:

> Subject: [PATCH] fix security_release_secctx seems broken
> 
> security_inode_getsecurity() provides the text string value
> of a security attribute. It does not provide a "secctx".
> The code in xattr_getsecurity() that calls security_inode_getsecurity()
> and then calls security_release_secctx() happened to work because
> SElinux and Smack treat the attribute and the secctx the same way.
> It fails for cap_inode_getsecurity(), because that module has no
> secctx that ever needs releasing. It turns out that Smack is the
> one that's doing things wrong by not allocating memory when instructed
> to do so by the "alloc" parameter.
> 
> The fix is simple enough. Change the security_release_secctx() to
> kfree() because it isn't a secctx being returned by
> security_inode_getsecurity(). Change Smack to allocate the string when
> told to do so.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Looks good to me.  I wonder why security_release_secctx was used in the 
first place? (it arrived via commit 42492594)

Konstantin: how did you trigger this?

I plan to send this to Linus for -rc4 unless anyone has objections.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
