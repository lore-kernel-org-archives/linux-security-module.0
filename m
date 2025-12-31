Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2618D242D7B
	for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150699; cv=none; b=sYn33Cp2qyDlI0WWW0XO1+PAZ8nkP/bw34ZmuyDAX5EhIV5MftklAKrB2KCt8zKxR2F2g/xuJS0zbKPidfF2icPozYW78wWPH95Vs6JAEvOi2x0uQ6tmiK+/jG/82uip+8ZydcECOJub4inQ3un+mNkj4aIQ1Upi5B7EqhquAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150699; c=relaxed/simple;
	bh=BG9dv84NYBajw5ICK5PjkOcWC+8b71CUfIuY09cJy1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIg0nBrmH97ZwltelCyyO2vuhwoDpl3RJxmYJy8Qut2l8S/JY+KchY6yV5YALoU+nBId/IffunUhSQTIWwTBVlbR3Kpp2Q0zikssQ2pXwOApL/ihCBhTcwfC7nF9V4Hy4MxKdcLIGpUGPWZuV/YuHOFR5jwS8DUyiJWUL7S71jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rsxvl0eN; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsxvl0eN"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0833b5aeeso143044725ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 19:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767150697; x=1767755497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbkz8rQLQifRiOdikV4dQp+VvpsgfjMUwFFULRePkqI=;
        b=Rsxvl0eNzvz15JYeZ/w2QgRo/BOgYhKC5dYjYNxV+imwDKu+SmeoCpZPUd/GzUxvd6
         qZ8cidBBcJamYc5cM2S5pYXMCv6lAQuGjvlTXNg208/3jAbvcSxGyWYm9XKw/ZRWu9Ja
         IMTrGQzhZ7ipdUpgiFhA/2jE5R66OjCHN4Z/nd1/BCBE+trnK8b7py2aekZDzM/WuLEz
         IUjRpCWAIhcdJl0ZERBhdyFILAmJWPiZZ3KePqALpeh5tZMSmZX4S1KOy43CPiu7bBRE
         WHkpAi0AoQ8FG6Ymwm7Ngx1vI4Qq0RyJDiPnY4ESsgo136KZ5j0aZzMrlVq3ymtrg1ZH
         NWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767150697; x=1767755497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hbkz8rQLQifRiOdikV4dQp+VvpsgfjMUwFFULRePkqI=;
        b=QZYlxkvbi4cStJDTfD/3rZ3AtfhBDFFe5jyA0vDMTfj2kasOFFr7AI67FjT4t++rRC
         VBmx2rsYJGYXjK1mt7OrbUvYEbtr1VjyLndM1tLuHuzIvwdZqhfFJBze196bVPmUyo88
         UblNEUW8b/q1F1nVEnwiAQuM9syBJqAgwsYMgoC7lkQbCQfiP2Ack16MHPh674MyvM82
         FHAx1+Gfk7AJKQcf3z69k6Z5fjmrGvA+R+3YF0LU4Iq+f0fKi6nPOyHyn+l9Ma+Q29fI
         O75rDZEEiJonEpgDhX05VUrd3AdahDPFEzWxBmuNiMPn+TJnwdpK5jOb5eL/yhmIhvER
         Z3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVcwovMaVuIyOGVgCIQvp5LXlTSgmfsNEDv5Cub9zXlbDgzFBU32uzvJBRmm3xXdA24DKGHTwXzQlTYAQk6tn1umpL3Rcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjAme6untSsij3U9PAEmNlLTHhmZSYj6o3KVaSslzS9931V/X
	qrDxm9L/nME087fV4K3241i6NbwX0uMWiFK+SV3Q8DsZelRxCurqcRVb20d1p6iJ7fnhbw==
X-Gm-Gg: AY/fxX7roYHU6Fm59CXlwFm+KUIulPkfwhSmXx0btUnK47KpbRliX1onzD6FJoZlQs2
	K5FwYyqy3f0GLrrkzQzs6VQybiFUmHtskl04oug336EdKf62yUY4+xLwgs+pP0bHAMX+JLnoHtT
	2UStkXZ1zzLg1W9CWOK0QsfUlglxFYV3F9OWMlIVM5xsGcgaeVs0+0UOLr+naep7ClD6Tso0doR
	9x07jf6LmBM3YdhyscKakxLtGUTyRfQKvXsFyWg5T7JQhk75V7P8sHe+oNTWE1LsLmqhkNcTS8h
	QkzDP5njX3urTSmgFLnFDCH7qyEyxxyAtNcXSQfrNZKLtLdwxDGTciRmAM3PiW7ujZHieSVQb5a
	yb580kO8L7akKUFJ00M3y/yt/K7SgTY3CQGGpLyrcxh+Dj/vsM3QoUCW5/p2Q3QgHpnvOMoEOEH
	6FiP6pv1RZ/nclAVUyeAcwkkswm8thVIm9uWBVLCBr
X-Google-Smtp-Source: AGHT+IF/QsMVVa3OF111PpZFVi5jRtcz6ATtLYS39ey0hZEOKpQi1gBecdF5+bffYJIb3z9Vl+r8qA==
X-Received: by 2002:a17:902:f552:b0:29e:9387:f2b7 with SMTP id d9443c01a7336-2a2f220cecamr359466075ad.11.1767150697228;
        Tue, 30 Dec 2025 19:11:37 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c88d0asm307840295ad.40.2025.12.30.19.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 19:11:36 -0800 (PST)
From: wangqing <wangqing7171@gmail.com>
X-Google-Original-From: wangqing <wq513132@alibaba-inc.com>
To: yangyuhang0619@gmail.com
Cc: jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [BUG REPORT] memory leak in prepare creds triggered by Netlink/fremovexattr (v6.12.62 , found C repro for Invalid bugs)
Date: Wed, 31 Dec 2025 11:11:17 +0800
Message-Id: <20251231031117.37793-1-wq513132@alibaba-inc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACVn-YmCOUQVQd1FYZhcMSQAK5gsvzA7+k5oiocN23nKRMKBMA@mail.gmail.com>
References: <CACVn-YmCOUQVQd1FYZhcMSQAK5gsvzA7+k5oiocN23nKRMKBMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Dec 2025 at 19:12, yuhang hang <yangyuhang0619@gmail.com> wrote:
> BUG: memory leak
> unreferenced object 0xffff888023928000 (size 184):
>   comm "syz-executor", pid 10631, jiffies 4294970296
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 1adddbfd):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
>     slab_post_alloc_hook mm/slub.c:4152 [inline]
>     slab_alloc_node mm/slub.c:4197 [inline]
>     kmem_cache_alloc_noprof+0x29a/0x320 mm/slub.c:4204
>     prepare_creds+0x2e/0x760 kernel/cred.c:212
>     copy_creds+0xa7/0xa50 kernel/cred.c:312
>     copy_process+0xf7d/0x8b20 kernel/fork.c:2262
>     kernel_clone+0xeb/0x900 kernel/fork.c:2810
>     __do_sys_clone+0xcf/0x120 kernel/fork.c:2953
>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>     do_syscall_64+0xcb/0x220 arch/x86/entry/common.c:83
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> BUG: memory leak
> unreferenced object 0xffff88802067d920 (size 16):
>   comm "syz-executor", pid 10631, jiffies 4294970296
>   hex dump (first 16 bytes):
>     00 00 00 00 00 00 00 00 00 3d 08 1b 80 88 ff ff  .........=......
>   backtrace (crc 8e8e0e90):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
>     slab_post_alloc_hook mm/slub.c:4152 [inline]
>     slab_alloc_node mm/slub.c:4197 [inline]
>     __do_kmalloc_node mm/slub.c:4331 [inline]
>     __kmalloc_noprof+0x331/0x460 mm/slub.c:4344
>     kmalloc_noprof include/linux/slab.h:882 [inline]
>     kzalloc_noprof include/linux/slab.h:1014 [inline]
>     lsm_blob_alloc security/security.c:685 [inline]
>     lsm_blob_alloc security/security.c:678 [inline]
>     lsm_cred_alloc security/security.c:702 [inline]
>     security_prepare_creds+0x294/0x320 security/security.c:3240
>     prepare_creds+0x54e/0x760 kernel/cred.c:242
>     copy_creds+0xa7/0xa50 kernel/cred.c:312
>     copy_process+0xf7d/0x8b20 kernel/fork.c:2262
>     kernel_clone+0xeb/0x900 kernel/fork.c:2810
>     __do_sys_clone+0xcf/0x120 kernel/fork.c:2953
>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>     do_syscall_64+0xcb/0x220 arch/x86/entry/common.c:83
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Hi,

I've analyzed the kmemleak output and the copy_process() code path.
The allocation happens in prepare_creds(), but all error paths after
copy_creds() correctly call exit_creds() to release the credential.

This is likely a false positive caused by RCU delayed freeing of
struct cred. The object is queued via call_rcu() and not immediately
freed, so kmemleak may report it as "unreferenced" before the grace
period completes.

To verify, please:
1. Run `echo scan > /sys/kernel/debug/kmemleak`
2. Wait 2-3 seconds
3. Run `echo scan > /sys/kernel/debug/kmemleak` again
4. Check if the report disappears.

If it persists across multiple scans, then it might be a real leak.

-- 
Best regards,
Qing Wang
