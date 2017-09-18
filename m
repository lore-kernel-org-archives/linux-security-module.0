From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 18 Sep 2017 13:25:50 -0700
Subject: [BUG] security_release_secctx seems broken
In-Reply-To: <d09e29aa-f34c-3260-677a-3017cd1cd347@yandex-team.ru>
References: <d09e29aa-f34c-3260-677a-3017cd1cd347@yandex-team.ru>
Message-ID: <c007fac4-4e2a-6076-513d-6f52f7133a2d@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/16/2017 11:18 AM, Konstantin Khlebnikov wrote:
> I've got this kmemleak splat
>
> unreferenced object 0xffff880f687ff6a8 (size 32):
> ? comm "cp", pid 4279, jiffies 4295784487 (age 2866.296s)
> ? hex dump (first 32 bytes):
> ??? 01 00 00 02 02 00 08 00 00 00 00 00 00 00 00 00? ................
> ??? 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5? .....kkkkkkkkkk.
> ? backtrace:
> ??? [<ffffffff8192d77a>] kmemleak_alloc+0x4a/0xa0
> ??? [<ffffffff8125b721>] __kmalloc_track_caller+0x171/0x280
> ??? [<ffffffff812125c7>] krealloc+0xa7/0xc0
> ??? [<ffffffff812abb2d>] vfs_getxattr_alloc+0xbd/0x110
> ??? [<ffffffff813ba789>] cap_inode_getsecurity+0x79/0x200
> ??? [<ffffffff813be4d2>] security_inode_getsecurity+0x52/0x80
> ??? [<ffffffff812aad1a>] xattr_getsecurity+0x3a/0xa0
> ??? [<ffffffff812aadf4>] vfs_getxattr+0x74/0xa0
> ??? [<ffffffff812ab27e>] getxattr+0x9e/0x170
> ??? [<ffffffff812abd2a>] SyS_fgetxattr+0x5a/0x90
> ??? [<ffffffff8193a67b>] entry_SYSCALL_64_fastpath+0x1e/0xae
> ??? [<ffffffffffffffff>] 0xffffffffffffffff
>
> allocated in? xattr_getsecurity() security_inode_getsecurity() -> cap_inode_getsecurity()
> should be freed by security_release_secctx() but there is no release_secctx hook.

There is a bug here, but the fix suggested is not correct.
security_inode_getsecurity() provides the security attribute
with a specified name. In the past there would be exactly one
use for this call, which was to return the value of the
attribute that happened to match the security "context" of
the inode. Freeing the value with security_release_secctx()
works coincidentally. Because security_inode_getsecurity() is
called with the "true" value for the alloc parameter the correct
fix is:

	- fix smack_inode_getsecurity() to honor the alloc flag
	- change the security_release_secctx() to kfree here.

I can provide a patch in a day or so.

>
> I don't know details about modern security models stack but it
> seems security_release_secctx() have to know which layer owns
> secdata to free it property: selinux just calls kfree,
> capability_hooks should do the same, but other modules returns
> non-freeable pointers. Currently security_release_secctx() calls
> release_secctx for all models, this is obviously wrong.
>


.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
