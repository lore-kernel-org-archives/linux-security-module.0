From: khlebnikov@yandex-team.ru (Konstantin Khlebnikov)
Date: Wed, 4 Oct 2017 12:29:37 +0300
Subject: [PATCH] fix security_release_secctx seems broken
In-Reply-To: <alpine.LRH.2.21.1710041713160.19339@namei.org>
References: <d09e29aa-f34c-3260-677a-3017cd1cd347@yandex-team.ru>
	<c007fac4-4e2a-6076-513d-6f52f7133a2d@schaufler-ca.com>
	<ec271e46-07d3-78ba-e58d-3606b0889cbf@schaufler-ca.com>
	<alpine.LRH.2.21.1710041713160.19339@namei.org>
Message-ID: <ff77bdc9-e642-113d-dbde-f4d0770fff00@yandex-team.ru>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 04.10.2017 09:17, James Morris wrote:
> On Tue, 19 Sep 2017, Casey Schaufler wrote:
> 
>> Subject: [PATCH] fix security_release_secctx seems broken
>>
>> security_inode_getsecurity() provides the text string value
>> of a security attribute. It does not provide a "secctx".
>> The code in xattr_getsecurity() that calls security_inode_getsecurity()
>> and then calls security_release_secctx() happened to work because
>> SElinux and Smack treat the attribute and the secctx the same way.
>> It fails for cap_inode_getsecurity(), because that module has no
>> secctx that ever needs releasing. It turns out that Smack is the
>> one that's doing things wrong by not allocating memory when instructed
>> to do so by the "alloc" parameter.
>>
>> The fix is simple enough. Change the security_release_secctx() to
>> kfree() because it isn't a secctx being returned by
>> security_inode_getsecurity(). Change Smack to allocate the string when
>> told to do so.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> Looks good to me.  I wonder why security_release_secctx was used in the
> first place? (it arrived via commit 42492594)
>  > Konstantin: how did you trigger this?

Just "getcap /bin/ping" is enough to tigger leak if file has capabilities.
Selinux shouldn't be loaded because its release_secctx hook call kfree.

But sometimes it takes some time for kmemleak to find leak. Presumably
because stale poiner stays on stack which could be reused nowdays.

> 
> I plan to send this to Linus for -rc4 unless anyone has objections.
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
