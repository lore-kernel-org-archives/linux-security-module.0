From: ebiggers3@gmail.com (Eric Biggers)
Date: Thu, 4 Jan 2018 20:54:28 -0800
Subject: KASAN: slab-out-of-bounds Read in cap_inode_getsecurity
In-Reply-To: <001a1140bece222e180561f63cb7@google.com>
References: <001a1140bece222e180561f63cb7@google.com>
Message-ID: <20180105045428.GB614@zzz.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jan 04, 2018 at 08:58:02AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 71ee203389f7cb1c1927eab22b95baa01405791c
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+37db7b2a61b64a9abb81 at syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1514753657.623:7): avc:  denied  { map } for
> pid=3504 comm="syzkaller926656" path="/root/syzkaller926656864" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in cap_inode_getsecurity+0x621/0x7d0
> security/commoncap.c:408
> Read of size 4 at addr ffff8801bea30b00 by task syzkaller926656/3504
> 
> CPU: 1 PID: 3504 Comm: syzkaller926656 Not tainted 4.15.0-rc5+ #244
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:429
>  cap_inode_getsecurity+0x621/0x7d0 security/commoncap.c:408
>  security_inode_getsecurity+0xcd/0x110 security/security.c:809
>  xattr_getsecurity+0xd3/0x1f0 fs/xattr.c:244
>  vfs_getxattr+0xc8/0x110 fs/xattr.c:333
>  getxattr+0x116/0x2a0 fs/xattr.c:540
>  path_getxattr+0xed/0x170 fs/xattr.c:568
>  SYSC_getxattr fs/xattr.c:580 [inline]
>  SyS_getxattr+0x33/0x40 fs/xattr.c:577
>  entry_SYSCALL_64_fastpath+0x23/0x9a

Already fixed in Linus's tree.

#syz fix: capabilities: fix buffer overread on very short xattr
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
