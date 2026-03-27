Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E43909AF
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612746; cv=none; b=bxy2stsSDCgJN633SLSTd5CoAEdzZRZcYYkMqzsL/r1hQBU8C0+wIG+GsqtonpNVADfz+jmijKkI1dI6pn11+FBJ/cLjmP/Uwx3qTRiNNQHHPQtQz20iontY51idMRP0Zr483YOsEJgFjPcjKeLgBQapesxD9f6OuPZ4fD5DSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612746; c=relaxed/simple;
	bh=7ORQZ8ncEf+eZNmfiPVZiLL+FJbeMarPTKIePIuP2V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2JXNvRNXETIAIYJMSTku5Zddx4TNxk5ETE8HW6zgJrcfStbreE0sTvEo7TeKKUv6PaU5C+D8BTKctKJ4gNptKXAfOsd+zvfT8Z9SAXnJ4izflrZwzDG05nf8wXzthEWAhePj+kkAqsDMSUEMzHXdUQK8q2XJ8YLAM3Iie5VwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=RVAEv899; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="RVAEv899"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad617d5b80so13816935ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1774612744; x=1775217544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hug4SpL7ksBzJoom/vOpWbZH8sETbbkswMlMAN0QIos=;
        b=RVAEv899IOSLyFQF+BWm/TRgbmi8aROhNJGgutBZm0gZssMKhdEmafBbRRg/xTFY8B
         lkLvyveGJsAXFcSwBt0pmMeWehZWclVkDXY7y3gyZf1XdPrQttgcEnN0LmR+aq3e8jBK
         nbQot3gb0o51TMOjvjDaIR0kZsMwUOmzpHVTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612744; x=1775217544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hug4SpL7ksBzJoom/vOpWbZH8sETbbkswMlMAN0QIos=;
        b=m/7nx/h6ekQiGf5DHBA2+bKiJ//P/Hl/H9ooXTCwStNJRDCPHULFMNtdOwWOb4Q4MW
         A6kM7JdjbJ4nCHPpeVWmNXHkUwUey5sTSJKhzqydbwj+cPZO9rtjFXoAifk6kT261SS9
         xxSwT7SLEYFnWP/3QBQ4a9bUw2whhZPdTb2jGcbdCGrbCsWQfzWI8Sasp+W80Nz9fuPS
         z8V43t3iZo1Th1tdctyHLgLmh7oxdz8Qahe5vSgH8Oi+AN/fMqKPvkpTG4D00mJKsb2P
         qkDsrQ2i4EWN1ngYP11zNTzZ6CEo+yoJzYwCuhd5PcUOJ8hxgKMnMJOVPfk103sAgyOC
         4BsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWLqzHKwmLU7dCYji8l0+Yb7R3pwhXt9ft2NeiAPJ3cNJw/uF2BSorwCJ2AzT8e2n0mGXyBgf1jPM9TZSm7kZ8Rx5hx3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNYra95BIbGJflnvderczGaKuBPa8CzLs/4umJp48cwOkRJVE
	6mpAhpc5izXpfci6ZQVaZSR0vmk/YJ3r6aVlIfaCWlB3Gmc7D5ysXNrEmBPyH6c1TuQ=
X-Gm-Gg: ATEYQzyGc1ulLWlE1gjtMhlXAHju2Spp+ZerLx42ckEULhWV8kqWWCTygoR1WKd2F6N
	GwyqA1oUt/qMn/93EldYvgSDjgQjY+vRnbEFJHYXFneLdNTD/VEpk4iWA0QR9i0NzMb9oCW9evi
	k7NEyTYLqXFtwp0SBnDJ5UwYEYDN9nIlpvVKABYZHvB0hoNqqsGVeqvHBI90Cb+mLEBvYkDwhfm
	y+L/JjhtJwqmuDVYiT5ZLlF3gvaDQok3Y4NnVbaq1uMnskXdvBu4Nu7MugK88/qVf5plu1sufJg
	ua49Mh1XUY7Qb/3OPAxZ2/DQxy5/yG6q9nsaeSjvFa3UU89IOwIl4n7oxwZheoIvbmu5Yk6soqC
	sdNJOWHWzc2tJar0p630zxexNe7LXal5HyHwLCsvhXM1s+J6Lb2Xq5M/tX4CqZM8xs1r1HmW7Je
	v69ZEFXML2k5nVk+rxkCxhcchNda0OsHB7Uz76lNpo1caNqLh6dSBCkZSPkN0hbz66Zrt3WrZft
	QrgesvR7FuTe6pwJKPvih60AHA6HJuo0B8mKgUYBgHPEu6/DcEqFkv/2FFyVD9OmeLUZHq67Tfd
	L/OpylZNVSLXPxOLFq5+QqDE3W509GqR4fH3ZNpiwb8UOVA8Z0bFb2fZ/r6nQSrR
X-Received: by 2002:a17:903:8c8:b0:2b0:6945:7dab with SMTP id d9443c01a7336-2b0cdd224a1mr25925275ad.46.1774612743743;
        Fri, 27 Mar 2026 04:59:03 -0700 (PDT)
Received: from aegis ([2001:fd8:4d01:cc02:98a4:1c09:c7c4:e19a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e820sm58443435ad.50.2026.03.27.04.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:59:03 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Fix string overrun due to missing termination
Date: Fri, 27 Mar 2026 19:58:32 +0800
Message-ID: <20260327115833.7572-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When booting Ubuntu 26.04 with Linux 7.0-rc4 on an ARM64 Qualcomm
Snapdragon X1 we see a string buffer overrun:

BUG: KASAN: slab-out-of-bounds in aa_dfa_match (security/apparmor/match.c:535)
Read of size 1 at addr ffff0008901cc000 by task snap-update-ns/2120

CPU: 5 UID: 60578 PID: 2120 Comm: snap-update-ns Not tainted 7.0.0-rc4+ #22 PREEMPTLAZY
Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
Call trace:
show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
dump_stack_lvl (lib/dump_stack.c:122)
print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:597)
__asan_report_load1_noabort (mm/kasan/report_generic.c:378)
aa_dfa_match (security/apparmor/match.c:535)
match_mnt_path_str (security/apparmor/mount.c:244 security/apparmor/mount.c:336)
match_mnt (security/apparmor/mount.c:371)
aa_bind_mount (security/apparmor/mount.c:447 (discriminator 4))
apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
security_sb_mount (security/security.c:1062 (discriminator 31))
path_mount (fs/namespace.c:4101)
__arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
do_el0_svc (arch/arm64/kernel/syscall.c:152)
el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
el0t_64_sync (arch/arm64/kernel/entry.S:596)

Allocated by task 2120:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (./arch/arm64/include/asm/current.h:19 mm/kasan/common.c:70 mm/kasan/common.c:79)
kasan_save_alloc_info (mm/kasan/generic.c:571)
__kasan_kmalloc (mm/kasan/common.c:419)
__kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5260 mm/slub.c:5272)
aa_get_buffer (security/apparmor/lsm.c:2201)
aa_bind_mount (security/apparmor/mount.c:442)
apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
security_sb_mount (security/security.c:1062 (discriminator 31))
path_mount (fs/namespace.c:4101)
__arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
do_el0_svc (arch/arm64/kernel/syscall.c:152)
el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
el0t_64_sync (arch/arm64/kernel/entry.S:596)

The buggy address belongs to the object at ffff0008901ca000
which belongs to the cache kmalloc-rnd-06-8k of size 8192
The buggy address is located 0 bytes to the right of
allocated 8192-byte region [ffff0008901ca000, ffff0008901cc000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9101c8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:-1 pincount:0
flags: 0x8000000000000040(head|zone=2)
page_type: f5(slab)
raw: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
raw: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
head: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
head: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
head: 8000000000000003 fffffdffe2407201 fffffdffffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff0008901cbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff0008901cbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0008901cc000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff0008901cc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff0008901cc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

This was introduced by previous incorrect conversion from strcpy(). Fix it
by adding the missing terminator.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Fixes: 93d4dbdc8da0 ("apparmor: Replace deprecated strcpy in d_namespace_path")
---
 security/apparmor/path.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index 65a0ca5cc1bd..2494e8101538 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -164,14 +164,16 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 	}
 
 out:
-	/* Append "/" to directory paths, except for root "/" which
-	 * already ends in a slash.
+	/* Append "/" to directory paths and reterminate string, except for
+	 * root "/" which already ends in a slash.
 	 */
 	if (!error && isdir) {
 		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
 
-		if (!is_root)
+		if (!is_root) {
 			buf[aa_g_path_max - 2] = '/';
+			buf[aa_g_path_max - 1] = '\0';
+		}
 	}
 
 	return error;
-- 
2.53.0

