From: ebiggers3@gmail.com (Eric Biggers)
Date: Tue, 2 Jan 2018 11:00:43 -0600
Subject: KASAN: slab-out-of-bounds Read in cap_convert_nscap
In-Reply-To: <089e082658c46152990561c82268@google.com>
References: <089e082658c46152990561c82268@google.com>
Message-ID: <20180102170043.GA924@zzz.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 02, 2018 at 01:58:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 5aa90a84589282b87666f92b6c3c917c8080a9bf
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
> Reported-by: syzbot+7bf52949a1cf3a36b620 at syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1514639069.283:7): avc:  denied  { map } for
> pid=3182 comm="syzkaller986771" path="/root/syzkaller986771207" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in cap_convert_nscap+0x501/0x610
> security/commoncap.c:498
> Read of size 4 at addr ffff8801c96ae080 by task syzkaller986771/3182
> 
> CPU: 1 PID: 3182 Comm: syzkaller986771 Not tainted 4.15.0-rc5+ #152
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:429
>  cap_convert_nscap+0x501/0x610 security/commoncap.c:498
>  setxattr+0x365/0x400 fs/xattr.c:446
>  SYSC_fsetxattr fs/xattr.c:508 [inline]
>  SyS_fsetxattr+0x130/0x190 fs/xattr.c:497
>  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
>  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
>  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129

Looks like the same bug I sent out a fix for yesterday.

#syz fix: capabilities: fix buffer overread on very short xattr

https://marc.info/?l=linux-kernel&m=151488700301705
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
