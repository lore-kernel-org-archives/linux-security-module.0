From: khlebnikov@yandex-team.ru (Konstantin Khlebnikov)
Date: Sat, 16 Sep 2017 21:18:56 +0300
Subject: [BUG] security_release_secctx seems broken
Message-ID: <d09e29aa-f34c-3260-677a-3017cd1cd347@yandex-team.ru>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I've got this kmemleak splat

unreferenced object 0xffff880f687ff6a8 (size 32):
   comm "cp", pid 4279, jiffies 4295784487 (age 2866.296s)
   hex dump (first 32 bytes):
     01 00 00 02 02 00 08 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  .....kkkkkkkkkk.
   backtrace:
     [<ffffffff8192d77a>] kmemleak_alloc+0x4a/0xa0
     [<ffffffff8125b721>] __kmalloc_track_caller+0x171/0x280
     [<ffffffff812125c7>] krealloc+0xa7/0xc0
     [<ffffffff812abb2d>] vfs_getxattr_alloc+0xbd/0x110
     [<ffffffff813ba789>] cap_inode_getsecurity+0x79/0x200
     [<ffffffff813be4d2>] security_inode_getsecurity+0x52/0x80
     [<ffffffff812aad1a>] xattr_getsecurity+0x3a/0xa0
     [<ffffffff812aadf4>] vfs_getxattr+0x74/0xa0
     [<ffffffff812ab27e>] getxattr+0x9e/0x170
     [<ffffffff812abd2a>] SyS_fgetxattr+0x5a/0x90
     [<ffffffff8193a67b>] entry_SYSCALL_64_fastpath+0x1e/0xae
     [<ffffffffffffffff>] 0xffffffffffffffff

allocated in  xattr_getsecurity() security_inode_getsecurity() -> cap_inode_getsecurity()
should be freed by security_release_secctx() but there is no release_secctx hook.

I don't know details about modern security models stack but it
seems security_release_secctx() have to know which layer owns
secdata to free it property: selinux just calls kfree,
capability_hooks should do the same, but other modules returns
non-freeable pointers. Currently security_release_secctx() calls
release_secctx for all models, this is obviously wrong.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
