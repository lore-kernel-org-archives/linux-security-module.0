Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683473B443F
	for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999425; cv=none; b=L8M5dDxmagRy9gAzOOd1523OVyDjMeLYe+MLpeIgZaCgmZFzXR8wF9JsFJXfatCd7ZM78Nj0Mqi3o0HimAo0M78KVdvtUTQ67LRRO2glwBprVZF1Xpex/cLGtDDvulrTYElX+q7dyjpCRx3GdkpQzW0MoQrfa6iqwEUrfo+3vQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999425; c=relaxed/simple;
	bh=9aWsYjxU1yrw8viF0+Sf5scIs3DMWcLcR3xM0bHXtys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyqG48biAyWmEeaAhE+8lteVVUbfn4Epyg0Gvtl2oFrMMNS6WAOadV1FxabgzTiMUCRIdDCqzvcMEHygBhxRsXBvMqiEEtnoTBF6e5zS5f3IyXf9PryTg590hqbMsDPSin0Sa7/uJF6OPKhRBcoQOwJ3qx9ZkrzQvAwOWehoRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MF7zWiyA; arc=none smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MF7zWiyA"
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-6aaf6076546so1360711eaf.1
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2026 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786999422; x=1787604222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8hQvq3XnTlInZZFipkXBqM/QS0vM+oWvL7vzyru0XOw=;
        b=MF7zWiyALDAvigHeNFELoUu2pQ5DBnl6SkGtCRuXow8DyfAKKd0xBj22pEOvs1GFtD
         78vJioJg2isUwh0glZ9ttCkNs1PDYZRWE4H8CeZSmwkNArsI9Nhi2XJdrrhehILix5oO
         iHwDf1pCLq34a2bxKPaxGxYM+efqroBM3biA7nk/1AogTmmccasyet6jJo8ek6hTpZ/s
         MscGx4FEddY6AFeyi7rolQGma0hJwPm+iVPDbZS8qkHmakwKyzY+5vlckRCHQ29shZVf
         LrkogMio/k5WnqwGUwIkBdmHNrcF9CXxo9i/toG/azGhbqWCEApewyCHewW0R2jGQuEO
         7jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786999422; x=1787604222;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hQvq3XnTlInZZFipkXBqM/QS0vM+oWvL7vzyru0XOw=;
        b=SsSrtasjeUPN8FStyqiNkGzv3OYFLY1gqaBzVt35GGMJ2N/Nf8hEKKJd6B2F4rfM2H
         D7M8aG2csiP1+gBplOVUQe9MUjC48NpdLIzdXDS+0ViL7L6IWGBK6644cVw2qKKgu02q
         Om8MF8j07/RNZtMXHUXxHoXI12IqGDiUIlRSKaaZijnMxsXl1vHMeX6NhxinlWsScgYQ
         zUezB2uedrAhy2OgyMtX0NEeEpTkBiHsU3nplxK9Rk6DQ1LQd9crMq7TMY3DfcG3zgxR
         fYu9UYWkwKHp7kFtt3LVg+GKTqRb1iigksScfrLSEUvQmaOn+pXukZ7LwLQrpIkTC+LC
         oxMg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7oHleT4V+lOFfAwKF2If7J5+vq95WnL0n25dru55SiNzjvzN+Esmnaz9T/hOboduzioZVvv+4AhTJTxvULojbfDe4vrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnddVTCufMfzkzOspZsv/v+hipxf7zx6Omflua94Qi5XF34iB
	i8fZrKYdfxhZU2vH6DsJrPsknXto1S7dYQGTLZ6jbIOd/OVm6b7nD6j/9lPa03kbqMs=
X-Gm-Gg: AR+sD13nVwQ8WBtW/3o+YkyCJlV2AX5RZLXbhiNVKMcXdAAy+UdMCZjYBSLXjUB3TIP
	MxzG4feHPgM802zicgQfajoLDJbue4l8HXtu/hBH85Wdz8zcn0lBx24+2bZkwrHpKsPYh3pUtyx
	0K90fWsBS2fdyteA+cvGLp5JKbawWBTEoOcUgPFNFSyLJdAZtj0P7uZQV5WGbw1c1hq9DhNdwjA
	PbiRbahfl+IJexvfc75VyBxgfpJN4sutW9GlLtHpeCAfiMo+zJzKompqavUY1jy54tj3fqAQJph
	MWwaMPsVEq4FNeSyMaNU5DkXuBcccfEFlieZNBsQRvU16n6sdeg6bjPCKv0C17CMUWTEUwsHE09
	r1HD3g652WtbNeEQN4CRivWrhoov6NcEyLq/h7d7CyUTZkQ1tcXX888CEs2bZW0SqH9fzpJ8wVV
	1n9BCNfdX6JO5SX+BO3+0QXfhxya8atgaghTS2qOs=
X-Received: by 2002:a05:6820:1795:b0:6a3:bdc5:591a with SMTP id 006d021491bc7-6b0d6919fd2mr25263755eaf.32.1786999422065;
        Mon, 17 Aug 2026 13:43:42 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:62])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1165cd62fsm2616325eaf.5.2026.08.17.13.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 13:43:41 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:43:38 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: syzbot <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>
Cc: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Subject: Re: [syzbot] [lsm?] [integrity?] possible deadlock in
 ima_file_truncate
Message-ID: <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
References: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>

On Sat, Aug 08, 2026 at 05:20:29PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=113c53b9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> dashboard link: https://syzkaller.appspot.com/bug?extid=448c2e24b1ceff13ed2a
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.3.857/8643 is trying to acquire lock:
> ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
> ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
> ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
> 
> but task is already holding lock:
> ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:4693 [inline]
> ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4280 fs/namei.c:4863
> 

I had AI whip up a reproducer for this, but it's not mutually exclusive to the
added patch. Tested by running reproducer, then unapplied patch, still
reproduced on v7.2-rc4.

I'll need to simplify it before I post it.

#syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in process_measurement (6)

See below for un-applied repro result.

Best,
Fred

[   23.443936] ======================================================
[   23.443988] WARNING: possible circular locking dependency detected
[   23.444028] 7.2.0-rc4 #11 Not tainted
[   23.444062] ------------------------------------------------------
[   23.444095] repro-deadlock./159 is trying to acquire lock:
[   23.444121] ffff8881033da7b0 (&ima_iint_mutex_key[depth]#2){+.+.}-{4:4}, at: process_measurement+0x298/0xc10
[   23.444184]
[   23.444184] but task is already holding lock:
[   23.444217] ffff88810210ac68 (&subsys->lock){+.+.}-{4:4}, at: nvmet_ns_enable+0x26/0x1e0
[   23.444265]
[   23.444265] which lock already depends on the new lock.
[   23.444265]
[   23.444302]
[   23.444302] the existing dependency chain (in reverse order) is:
[   23.444340]
[   23.444340] -> #2 (&subsys->lock){+.+.}-{4:4}:
[   23.444378]        lock_acquire+0xc7/0x2e0
[   23.444401]        __mutex_lock+0xc7/0x1120
[   23.444425]        nvmet_ns_device_path_store+0x31/0xd0
[   23.444454]        configfs_write_iter+0xc8/0x140
[   23.444484]        vfs_write+0x2af/0x530
[   23.444508]        ksys_write+0x73/0xf0
[   23.444531]        do_syscall_64+0x121/0x630
[   23.444568]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   23.444598]
[   23.444598] -> #1 (&p->frag_sem){.+.+}-{4:4}:
[   23.444634]        lock_acquire+0xc7/0x2e0
[   23.444653]        down_read+0x31/0x150
[   23.444678]        __configfs_open_file+0x5d/0x1f0
[   23.444708]        do_dentry_open+0x136/0x4a0
[   23.444740]        vfs_open+0x34/0xf0
[   23.444763]        dentry_open+0x34/0x60
[   23.444786]        ima_calc_file_hash+0x8a/0xe0
[   23.444816]        ima_collect_measurement+0x2eb/0x3a0
[   23.444845]        process_measurement+0x4e4/0xc10
[   23.444874]        ima_file_check+0x60/0x90
[   23.444899]        security_file_post_open+0x2e/0x40
[   23.444928]        path_openat+0x51f/0x1140
[   23.444950]        do_file_open+0xe4/0x1a0
[   23.444976]        do_sys_openat2+0x7f/0xe0
[   23.445003]        __x64_sys_openat+0x56/0xa0
[   23.445040]        do_syscall_64+0x121/0x630
[   23.445075]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   23.445112]
[   23.445112] -> #0 (&ima_iint_mutex_key[depth]#2){+.+.}-{4:4}:
[   23.445163]        check_prev_add+0xeb/0xe80
[   23.445199]        __lock_acquire+0x149d/0x1d10
[   23.445233]        lock_acquire+0xc7/0x2e0
[   23.445257]        __mutex_lock+0xc7/0x1120
[   23.445288]        process_measurement+0x298/0xc10
[   23.445323]        ima_file_check+0x60/0x90
[   23.445354]        security_file_post_open+0x2e/0x40
[   23.445396]        path_openat+0x51f/0x1140
[   23.445424]        do_file_open+0xe4/0x1a0
[   23.445452]        file_open_name+0xd1/0x1a0
[   23.445488]        filp_open+0x28/0x40
[   23.445516]        nvmet_file_ns_enable+0x2b/0xf0
[   23.445553]        nvmet_ns_enable+0x13c/0x1e0
[   23.445590]        nvmet_ns_enable_store+0x8a/0xb0
[   23.445626]        configfs_write_iter+0xc8/0x140
[   23.445662]        vfs_write+0x2af/0x530
[   23.445691]        ksys_write+0x73/0xf0
[   23.445719]        do_syscall_64+0x121/0x630
[   23.445755]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   23.445790]
[   23.445790] other info that might help us debug this:
[   23.445790]
[   23.445839] Chain exists of:
[   23.445839]   &ima_iint_mutex_key[depth]#2 --> &p->frag_sem --> &subsys->lock
[   23.445839]
[   23.445918]  Possible unsafe locking scenario:
[   23.445918]
[   23.445958]        CPU0                    CPU1
[   23.446004]        ----                    ----
[   23.446035]   lock(&subsys->lock);
[   23.446066]                                lock(&p->frag_sem);
[   23.446109]                                lock(&subsys->lock);
[   23.446153]   lock(&ima_iint_mutex_key[depth]#2);
[   23.446190]
[   23.446190]  *** DEADLOCK ***
[   23.446190]
[   23.446230] 5 locks held by repro-deadlock./159:
[   23.446268]  #0: ffff888101ce6428 (sb_writers#10){.+.+}-{0:0}, at: ksys_write+0x73/0xf0
[   23.446325]  #1: ffff888101f19080 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x2e/0x140
[   23.446382]  #2: ffff88810221faf0 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0xa0/0x140
[   23.446439]  #3: ffffffff82e80be8 (nvmet_config_sem){+.+.}-{4:4}, at: nvmet_ns_enable_store+0x4d/0xb0
[   23.446496]  #4: ffff88810210ac68 (&subsys->lock){+.+.}-{4:4}, at: nvmet_ns_enable+0x26/0x1e0
[   23.446553]
[   23.446553] stack backtrace:
[   23.446583] CPU: 0 UID: 0 PID: 159 Comm: repro-deadlock. Not tainted 7.2.0-rc4 #11 PREEMPT(lazy)
[   23.446585] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   23.446586] Call Trace:
[   23.446587]  <TASK>
[   23.446588]  dump_stack_lvl+0x78/0xe0
[   23.446591]  print_circular_bug+0x2ca/0x400
[   23.446593]  check_noncircular+0x161/0x180
[   23.446597]  check_prev_add+0xeb/0xe80
[   23.446600]  __lock_acquire+0x149d/0x1d10
[   23.446602]  lock_acquire+0xc7/0x2e0
[   23.446603]  ? process_measurement+0x298/0xc10
[   23.446605]  ? lock_acquire+0xc7/0x2e0
[   23.446607]  __mutex_lock+0xc7/0x1120
[   23.446608]  ? process_measurement+0x298/0xc10
[   23.446610]  ? fs_reclaim_acquire+0x4c/0xd0
[   23.446612]  ? process_measurement+0x298/0xc10
[   23.446614]  ? find_held_lock+0x2b/0x80
[   23.446617]  ? process_measurement+0x298/0xc10
[   23.446618]  process_measurement+0x298/0xc10
[   23.446625]  ima_file_check+0x60/0x90
[   23.446627]  security_file_post_open+0x2e/0x40
[   23.446629]  path_openat+0x51f/0x1140
[   23.446632]  ? __lock_acquire+0x5df/0x1d10
[   23.446633]  do_file_open+0xe4/0x1a0
[   23.446639]  file_open_name+0xd1/0x1a0
[   23.446640]  filp_open+0x28/0x40
[   23.446642]  nvmet_file_ns_enable+0x2b/0xf0
[   23.446644]  nvmet_ns_enable+0x13c/0x1e0
[   23.446646]  nvmet_ns_enable_store+0x8a/0xb0
[   23.446647]  configfs_write_iter+0xc8/0x140
[   23.446650]  vfs_write+0x2af/0x530
[   23.446653]  ksys_write+0x73/0xf0
[   23.446655]  do_syscall_64+0x121/0x630
[   23.446657]  ? clear_bhb_loop+0x40/0x90
[   23.446659]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   23.446660] RIP: 0033:0x7f6d63b105a4
[   23.446662] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d a5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   23.446663] RSP: 002b:00007ffdbeb92468 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   23.446665] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6d63b105a4
[   23.446666] RDX: 0000000000000002 RSI: 000055be1939cba0 RDI: 0000000000000001
[   23.446666] RBP: 00007ffdbeb92490 R08: 0000000000000073 R09: 0000000000000000
[   23.446667] R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000002
[   23.446667] R13: 000055be1939cba0 R14: 00007f6d63bf85c0 R15: 00007f6d63bf5ee0
[   23.446670]  </TASK>
