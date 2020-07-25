Return-Path: <SRS0=xYcQ=BE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD9C433E0
	for <linux-security-module@archiver.kernel.org>; Sat, 25 Jul 2020 12:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC102206F6
	for <linux-security-module@archiver.kernel.org>; Sat, 25 Jul 2020 12:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="NceLZ+ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYM6H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYM6H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 25 Jul 2020 08:58:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F37C0619D3
        for <linux-security-module@vger.kernel.org>; Sat, 25 Jul 2020 05:58:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so5926395plr.8
        for <linux-security-module@vger.kernel.org>; Sat, 25 Jul 2020 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SwS3zgXQ3VF1ku0vh+GhUZF3XJKChL/epyFRXUYVq+4=;
        b=NceLZ+ua0PPfIRWokKyauHOh7Af4knLiqKQp/3Y9NaqHulcSSqy71sJWfPnLza0sbJ
         wcJXKcKueYYtVMGDkCBg72YInZ7DJyXC/SNxI37zppwO6A1itXhVhf7jz2apvEh23uEw
         0CW9CIZ2vdD3yj+lRkqNbwRT5fVALfDiqTIfXA2nt4EMs6qfvVhnc5MDioppDkiEtHNN
         m+4+nmvIyVGMsqdKHj6+eaWMW2METt43xmwzbP9gj3titAMDxmZs8ztCflkK4Zmg8+T+
         ErnLoviHhmBxJdt9Y6EfZfOhTS7upDmHTGuj7b64pONSsVjeI5TC5d1nrsvQABv+fmBx
         vo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SwS3zgXQ3VF1ku0vh+GhUZF3XJKChL/epyFRXUYVq+4=;
        b=ihMnl9sxHs4ozHW9+WPJfe/cdY9keDEdcY19WMHb4AbGvGO40yywv5ZvJ6sV0gaANJ
         UlAOgLXkYKxChcjJOny7fQ7cE0Oq8sF//N9QBMKwom4bxS5HwHjJUcCsBgKUQddUrN2S
         YZ2aJNI3CscqDV37oLkR4YYGdvbJeFbOVOsp2iK8IVod01fWDoTE9gVHuq02eJiKp/wg
         R0tO+lSLVp73NyuVzs4Kq0wXPJXeCpPnn4T9FfTCt/s+jCISPiBGe0tG4xOW6+X6j0WI
         7xr8zCyX+NTmQZSt3ziegZUNjHiAlT5OpS61MDoWnvew5AqXVrmzcume1mhfhQHEJQ80
         6baQ==
X-Gm-Message-State: AOAM532j3i9RtTNDliUP9tplHxc1DRFhQMcgtUekPPQspYbFzHYE6JVD
        4Au8nlk8z4/6HiImT8kXv9xNpQ==
X-Google-Smtp-Source: ABdhPJw16TRDmlVEQgK4HcUILzDMnSsPkejzs81OA3L3csUA6UNAi0IarBKU6v/mAw1sbsVUzOJchw==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr12476442plq.128.1595681886088;
        Sat, 25 Jul 2020 05:58:06 -0700 (PDT)
Received: from localhost ([2406:7400:73:5836:d1f0:826d:1814:b78e])
        by smtp.gmail.com with ESMTPSA id y10sm9267128pfn.121.2020.07.25.05.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 05:58:04 -0700 (PDT)
Date:   Sat, 25 Jul 2020 18:28:00 +0530
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] smack: fix slab-out-of-bounds by checking for overflow
Message-ID: <20200725125800.vahdiagxilinzoqw@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fkaeosqzhfpzibgi"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--fkaeosqzhfpzibgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

add a barrier to smk_set_cipso() to check for overflow

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3321
Read of size 1 at addr ffff888097d682b8 by task syz-executor980/6804

CPU: 0 PID: 6804 Comm: syz-executor980 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3321
 sscanf+0x6c/0x90 lib/vsprintf.c:3527
 smk_set_cipso+0x374/0x6c0 security/smack/smackfs.c:908
 vfs_write+0x2dd/0xc70 fs/read_write.c:576
 ksys_write+0x11b/0x220 fs/read_write.c:631
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402d9
Code: Bad RIP value.
RSP: 002b:00007ffe89010db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402d9
RDX: 0000000000000037 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000014 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ae0
R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6804:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc_track_caller+0x249/0x320 mm/slab.c:3671
 memdup_user_nul+0x26/0xf0 mm/util.c:259
 smk_set_cipso+0xff/0x6c0 security/smack/smackfs.c:859
 vfs_write+0x2dd/0xc70 fs/read_write.c:576
 ksys_write+0x11b/0x220 fs/read_write.c:631
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 4906:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 tomoyo_path_number_perm+0x525/0x690 security/tomoyo/file.c:736
 tomoyo_path_mknod+0x128/0x150 security/tomoyo/tomoyo.c:240
 security_path_mknod+0xdc/0x160 security/security.c:1077
 may_o_create fs/namei.c:2919 [inline]
 lookup_open fs/namei.c:3060 [inline]
 open_last_lookups fs/namei.c:3169 [inline]
 path_openat+0xbe8/0x37f0 fs/namei.c:3357
 do_filp_open+0x191/0x3a0 fs/namei.c:3387
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1388 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1199
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888097d68280
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 56 bytes inside of
 64-byte region [ffff888097d68280, ffff888097d682c0)
The buggy address belongs to the page:
page:ffffea00025f5a00 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0xffff888097d68c80
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000288fe08 ffffea00026f38c8 ffff8880aa400380
raw: ffff888097d68c80 ffff888097d68000 000000010000001e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097d68180: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
 ffff888097d68200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888097d68280: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                        ^
 ffff888097d68300: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
 ffff888097d68380: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Reported-and-testedby: syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com
Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
---
 security/smack/smackfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 58d3f43cc8bb..17809310d046 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -905,6 +905,11 @@ static ssize_t smk_set_cipso(struct file *file, const =
char __user *buf,
=20
 	for (i =3D 0; i < catlen; i++) {
 		rule +=3D SMK_DIGITLEN;
+		if (rule > data + count) {
+			rc =3D -EOVERFLOW;
+			goto out;
+		}
+
 		ret =3D sscanf(rule, "%u", &cat);
 		if (ret !=3D 1 || cat > SMACK_CIPSO_MAXCATNUM)
 			goto out;
--=20
2.20.1


--fkaeosqzhfpzibgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIF+jd5Z5uS7xKTfpQZdt+T1HgiEFAl8cLFcACgkQQZdt+T1H
giEhDgv9EbHm+1veIws3uVSi24CoK33afWoI2l2KVRmc+HeKPhuQSWe0hb0Xvo4p
ehdOp9zxZHrCxlPt4uTYrRJV4V3NqoJ0v1en+LV7uNFnnXqJexsYanOJI/wotoig
0WPR9yOflyptic2u3142qTUJeo3fcp6/WCGIzcODZIFeg2QbCuhuwa0O0lIVPsvl
JpFxPdPvlWgj2zb38Tdlrw9OtEFr1/n2l27ipp0lzD+G/NuNgZZG0bniuQaMQ446
B1gQLjww437jcBA9lnZanoJcc13qxkSUK6/QcrroNM577pdw+7oLzVoTwGo1qt9x
RKEB+6QrZI6pRqoOmSKa9PcdbR1rmVvOLve2EWNcBjTQjBFJNGHzGcWFkmOO1IZ6
E7dGkDMRkCHi5i0DcEnSTvojrRMp1DAnofxWz0fQMBKaY2RmW6d0qiNUL5Mh2BvZ
fBFUNLPrtCU9HCsrkJChOLAZH8WYxL0dzrOl6Hn8Ui50zKpxMZlu58FfgBbI6TWB
FtoJrCu9
=2wOc
-----END PGP SIGNATURE-----

--fkaeosqzhfpzibgi--
