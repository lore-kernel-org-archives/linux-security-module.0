Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572522A1DC
	for <linux-security-module@vger.kernel.org>; Sun, 25 Aug 2024 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724563409; cv=none; b=ar/HuGzEN67W/tIskMC5FLkbkr9MeCtlT1iPUoyab0HHsV69V//qXIk5ion2sskSPD5e91+nXB33Np7738LqY/v37Nc2OkmD6RtPySp+RyhzOKiyCAvGnzRGPtUdxM6z4yMvPdhW62+NC+l96YNJpWmV9je/zWHf3h0HjhQSEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724563409; c=relaxed/simple;
	bh=5bRKrr+T/+bhtWSuhnwGY6n4BSJoLjmfHeNbXUOCK9A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=URiArnijlAETwOAw6wxzIfFw87OFpobpywT8e6NEcUi4b3iPmHUttU3EM7b+aC3f91nbWDEerACENpb29xUcus7ZR3Um5YjqWz1snb2sTKbnyHsQ2+ZL/2Lk0zzXpAWwpBeVgc06bwJoP+pdV7aUd7cFcxszGuhy/kQB4zKodqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=pBJ0Ylue; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=QKxExIX2; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pBJ0Ylue";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QKxExIX2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724563408; x=1756099408;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=5bRKrr+T/+bhtWSuhnwGY6n4BSJoLjmfHeNbXUOCK9A=;
  b=pBJ0YlueG4OwGl55DBkaRPBHetYWjQEwe6RqIMyi3+kF1m8jDk+8NUsg
   NBhhz3tqJtpnRC7DdktCUX26evHEahyFBqmKtZwK4/+5UUCvMswmjbhFI
   xd1g7WibaHuX473m4RjB2hQpaTlbq/loL0i19/bdHh19ZRyKPWaCvOA9z
   pYB9WTBa9xf0dDYDCVWxE5KXUSUs/tCvYR/KiAdFZ/cODm+K93Ly7zj6S
   bk1os1PcwTJ3D8kdDmPByypLL8EiEjntWMgFXqPaZ8iK/A7kmKnSMyMQR
   aoNri5vUzYhi0AfN5VuwC2qP3B8kdOi2HZMBLM24mPQAPEpThpubOer2K
   Q==;
X-CSE-ConnectionGUID: ZFytQbAdQSi64k60EXshxQ==
X-CSE-MsgGUID: 3hMMr8WnTA+TQbc8Fch0UQ==
Received: from mail-ot1-f69.google.com ([209.85.210.69])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:23:27 -0700
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7094db8ec7dso5091452a34.0
        for <linux-security-module@vger.kernel.org>; Sat, 24 Aug 2024 22:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724563407; x=1725168207; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx/YNFW2qlZwtm15Rp0Dif01ECRBK53Yl/ExQSV8X9c=;
        b=QKxExIX2yweeZk9skpXHW8ez3QUcaMGaSXNSd/To60byA86Gjci3fYEJM9boK1uX57
         wDkJVUqiEx9FoNC+XB7vFs2pCVtiXWX8Wf/H+LbSdZXsB4S2Y47QKqlWiG7ybsfJYA6n
         BNrXwg6jPZGC3wEDVQY82ZkMPT+MW9FdYJp0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724563407; x=1725168207;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx/YNFW2qlZwtm15Rp0Dif01ECRBK53Yl/ExQSV8X9c=;
        b=ZB336UmUNh2RH4iab+BiRwomAmxCbPxwvIudGSHsnGZoxGlhSOH9CPwfr4mRl1c7Nw
         9YvAlNlVzQFrdMy2ZKQGc4ypp3g7w23CCwyqrc1782EKAsUSA1XjrnTIioclrZsBMoBI
         fNmxsAvHZVNtVprUaGZyy7w2nvXawed8Wbuc+Fa7a5yecuU+0Jegb1rnMH6LLVi+yK/w
         QpncWnn9DnnSptqBkGck55cHgrtReRK3Ity5d2EXphShyniPhq5qq9IzdClMnrYSTdaB
         evk9jB99WB/O9hj+FL27BZlbixvmbOkRodGZWoeIxh4h36WIcUE+mGwSdKDAEVR4+qFk
         Q6aw==
X-Forwarded-Encrypted: i=1; AJvYcCUOsd+pOMyOzLCl7b+dJ+n9QB+DdZyYca5wFOpcZ6Yg0IjdPUGNcGiN29OngnkUVCvUVe+T2noXehMCo9VNuBjOcg8be8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDA0kzrF8ny9tuQqW7qfqmq2Ei2J7VQHyrpzoiwtzWmCUnl2ec
	Ia/YIH+vD41r9EkEKbltOtxMnnNWNRGMc8fKVsuojI89Pwogg7YnYlp94TxDm5mg4Ahiwbe1eV7
	4l44lZKt83NNc+S8ftBi8556hb41ZNJcXs0WcToRA6x6czF3+ICwA10gIkrZHkHr5IScvResU4U
	NHkGH2QiDpSTWI0Pv7WcOeimgvQxjNb1KuBJ6+4GlgRGa6Np3yfQ==
X-Received: by 2002:a05:6830:d8b:b0:709:3fb0:3bee with SMTP id 46e09a7af769-70e0ec110e4mr9872722a34.27.1724563406748;
        Sat, 24 Aug 2024 22:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBiMSgpHxK06kD9SbKkHv+QsYVEql8gZ8Qo1CNJ+QEw5jIlBgYUTA/WOvCzDBatR/JWP2fjNfem28jbFF+WCg=
X-Received: by 2002:a05:6830:d8b:b0:709:3fb0:3bee with SMTP id
 46e09a7af769-70e0ec110e4mr9872711a34.27.1724563406431; Sat, 24 Aug 2024
 22:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:23:16 -0700
Message-ID: <CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
Subject: WARNING in process_measurement
To: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We found a bug in Linux 6.10. This is likely a mutex corruption bug,
where the mutex's internal state has been compromised, leading to an
integrity check failure. The bug occurs in
https://elixir.bootlin.com/linux/v6.10/source/security/integrity/ima/ima_ma=
in.c#L269.

The bug report and syzkaller reproducer are as follows:

Bug report:

DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
__mutex_lock_common kernel/locking/mutex.c:587 [inline]
WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
Modules linked in:
CPU: 0 PID: 8057 Comm: cron Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
RIP: 0010:__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
Code: 04 20 84 c0 0f 85 13 01 00 00 83 3d fc e5 23 04 00 0f 85 e9 f4
ff ff 48 c7 c7 60 70 4c 8b 48 c7 c6 e0 70 4c 8b e8 83 f4 54 f6 <0f> 0b
e9 cf f4 ff ff 0f 0b e9 dc f8 ff ff 0f 0b e9 5b f5 ff ff 48
RSP: 0018:ffffc9000aa77380 EFLAGS: 00010246
RAX: 26a6b2d2d0cdac00 RBX: 0000000000000000 RCX: ffff8880241e5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000aa774d0 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: dffffc0000000000
R13: ffff888020efc330 R14: 0000000000000000 R15: 1ffff9200154eeb8
FS:  00007f902ffb1840(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f902fb7e06a CR3: 0000000018c3c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_measurement+0x536/0x1ff0 security/integrity/ima/ima_main.c:269
 ima_file_check+0xec/0x170 security/integrity/ima/ima_main.c:572
 security_file_post_open+0x51/0xb0 security/security.c:2982
 do_open fs/namei.c:3656 [inline]
 path_openat+0x2c0b/0x3580 fs/namei.c:3813
 do_filp_open+0x22d/0x480 fs/namei.c:3840
 do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f903019a167
Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85
c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
RSP: 002b:00007fff194600a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000564dd2fb9cf0 RCX: 00007f903019a167
RDX: 0000000000000000 RSI: 00007f902fb7e103 RDI: 00000000ffffff9c
RBP: 00007f902fb7e103 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000564dd2fb9cf0 R14: 0000000000000001 R15: 0000000000000000
 </TASK>


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
Wifi:false IEEE802154:true Sysctl:true Swap:false UseTmpDir:true
HandleSegv:true Trace:false LegacyOptions:{Collide:false Fault:false
FaultCall:0 FaultNth:0}}
r0 =3D openat$ptmx(0xffffffffffffff9c, 0x0, 0x141040, 0x0)
ioctl$TIOCSETD(r0, 0x5423, 0x0)
mmap$IORING_OFF_CQ_RING(&(0x7f0000ffc000/0x4000)=3Dnil, 0x4000, 0x2,
0x20031, 0xffffffffffffffff, 0x8000000)
mmap$IORING_OFF_SQ_RING(&(0x7f0000ff4000/0xc000)=3Dnil, 0xc000, 0xe,
0x12, 0xffffffffffffffff, 0x0)
openat$sndseq(0xffffffffffffff9c, 0x0, 0x902)
write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
&(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf26=
4340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12=
ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a3=
00916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc4=
14539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
0xb4)
r1 =3D syz_open_dev$sg(&(0x7f00000003c0), 0x0, 0x8000)
ioctl$syz_spec_1724254976_2866(r1, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})
ioctl$KDGKBDIACR(0xffffffffffffffff, 0x4bfa, 0x0)


--=20
Yours sincerely,
Xingyu
