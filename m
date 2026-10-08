Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1463C4544
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441014; cv=none; b=IdUryLWHCno3wqr/YQb9x+FSSrnTcjc7FfYjj4Qhn/nIDhRKfGs6yvYIiuvxAajh7biYzjhklMiDJYZC0EewsAD1HTu8/exGEw95dM7wnrIOWfImZBiJU/LK3VqSoUhBUQoilZsIN+WiuR9RcjlRl61Iaz4XtZFYkDognD9X7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441014; c=relaxed/simple;
	bh=W1wO5rTJxj54sFCvDMHGklfSMYuJHSqefCd6FoLVcMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lOUntTTP56d7+02TWdXQis3c6PxdTCjxSe6gDeajGBKuwiWaw6n/Hn13zL33RNaFlzHFVufw6F5lCuq3jQ5HJGsKhGdGHnKtzDX6mHLcCHjuOG41mCRUn3S5K1b/UfmaYgNb35t8lwORnNnLayW/04AGKXNAFwjhiDf7MOwVGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPNId8X8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPNId8X8"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a4c80d3d5aso2941195a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 23:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791441012; x=1792045812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h130+oraKy+B7FdqSQ8kedGGtt19E8E0V/sHxs3Aigo=;
        b=MPNId8X8pXDSPnLE5vjQgXIt9e+D3daLlD+5KYbpzAtET827jMl8PQ7ex6j4fwaCWw
         /Z7LkZYH2QdusrniT9r0lDN91pqluH3BdRUkHfjKUm4Xa6kT2s9DzHNnRGhlo83HWaJI
         pCaVsbDQBFQUW7/re/zv9v+jMXPwNpOfAAZiCy5jla8z9FDPYyPDjMlDEQEBzdDucuBt
         XcgZoL9E49dUBUMMzyyfAp1EbNVIpzLUEFL+Omjf7sRLT841vrZFn+nZTVSQ3m3KWjj9
         T9S6ZKFIpRw8+yyfOxzwk5Q3D3dwCOvpwRDgQupWNaHw17OWjwcypfw3hjtY+RGLYSpi
         EEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791441012; x=1792045812;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h130+oraKy+B7FdqSQ8kedGGtt19E8E0V/sHxs3Aigo=;
        b=l7nZpZSXtzHRffQp5fIY8JAYhSDM44B/v+7bS3+ZxqnPIP660XeNMZFnlTyWzKj9/H
         nIJMACBrWO0jQknUwtp4c9RvOQ9zyQoawHd/zWLE5Z7RVujcXquDHcG5x/MjiBwk1d/f
         1Lw1IObOBQw2OYaliGFlNv1ajwg0qNnTlwzivREjsnWGuG0Ebu3fhd6aZRAGA9iUeysb
         tm3+fWv5wJuRZ8Z+iObtA+nb1VqIx/7X/lzyfnvttN+F8t62j1lwBxaR+Jwi0OuK51XV
         ZB7GR2fAdwmWfV6m5eavwltklBPcj41iGiac+4g6c3a0IJeR2hboA3vYm1ge6/cbIkvY
         j1lw==
X-Forwarded-Encrypted: i=1; AKwUvByAz//mkfGcTldrS0AC2nwMu1r8S9qPOUbXKPJDwTOCpCIgxQKhd8oIn2qPa4kzAqkoX+/3NEVAPAS18a/chOkU19Toq/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOxQSCJ7fK2JA8RvnNu2Qu2NaCAaQ69LGIo55XthxBRHRpY8fo
	ikDCEFmd7D4GnooZ1bBjWc0zkGtn2M4UF1tQzrHeeDtLZY4/OTUp6+rb
X-Gm-Gg: AYBFou0cUh3uQ7iI+VzHY26uoEOlzXJQNSICQ6vLs1AnLRqUihUWnnpbq+FivmjnDm2
	ppqeIm6xIY0lZYWTYzZNFHsr3rLksH2JbqPaLNl1qY6w9rNVVt9VHOrbyARAPWcJn6FFgAstq81
	GXovqYIdCbpqo0LV9rkOsFu5m52020Yx4h44PuZY0QPRat6WBRbCHMxxKDe/MAqFo1IqBuZYcpp
	9OKSo2NrnBW34dqkf9HHfgiNfQVmAXp/AxLRLQfh7iodSfO9gtacXa7EcRnxqA1Mbzqk8Ipv/LD
	kuVvVSN2g3FXJfsF9QLAB4U+wlwnXdEFes0zhWnD8HO5UyVxCItgR1yvkwMhP+X3QwLgxOG5x8/
	1KwZNGl5Po35iLTbleoQsxgVPAKLRo/6WHT0Qk1NbMS9pquzyD3cIvKxfyPp60XIFSIrQOWCant
	kj31OUFpt/R848lQ8hbwzVJZURkUjDlNJi3JBdZ7NEKy68z+D0KfdaCIds5TFl8IjKGA==
X-Received: by 2002:a17:90b:3b4a:b0:39e:d36c:ee54 with SMTP id 98e67ed59e1d1-3a89f649556mr4353286a91.5.1791441011811;
        Wed, 07 Oct 2026 23:30:11 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff8d5896sm2787569a91.12.2026.10.07.23.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:30:11 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] keys: Protect the type name while describing a key
Date: Thu,  8 Oct 2026 14:30:06 +0800
Message-Id: <pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

keyctl_describe_key() must keep the key type's name alive until
kasprintf() has consumed it. The retained key reference keeps the key
and its description alive, but does not pin the module providing its
type. The name is passed to kasprintf() without holding key->sem.

kvasprintf() uses the saved name pointer in two formatting passes, with
a GFP_KERNEL allocation between them. With AF_RXRPC=m, a task that
passes View permission before type retirement can overlap a privileged
module unload in this order:

1. KEYCTL_DESCRIBE looks up the key, saves key->type->name in the
   kasprintf() arguments and completes the first formatting pass.
2. While the formatter is delayed before its second pass,
   af_rxrpc_exit() calls unregister_key_type(), which removes the type
   from the registry and waits for key_gc_keytype().
3. The collector takes key->sem for writing, retypes the retained key
   to key_type_dead and completes retirement. Unregistration and module
   exit return, allowing free_module() to release the type and name.
4. The formatter resumes its second pass and reads the saved name from
   released module storage, which can fault in string().

Hold key->sem for reading across kasprintf(). The collector then cannot
retype the key or complete retirement until both formatting passes have
finished. If retirement wins the lock first, formatting uses the core
key_type_dead name instead. Release the semaphore immediately after
kasprintf(), including on allocation failure, before copying to
userspace.

Oops report as below:

    BUG: unable to handle page fault for address: fffffbfff8054794
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 1a7ff6067 P4D 1a7ff6067 PUD 1a7ff2067 PMD 100b0b067 PTE 0
    Oops: Oops: 0000 [#1] SMP KASAN NOPTI
    CPU: 0 UID: 0 PID: 500 Comm: key-fixture Tainted: G           O        7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
    Tainted: [O]=OOT_MODULE
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    RIP: 0010:string+0x23f/0x470
    Code: 48 8b 04 24 48 83 c3 01 41 83 c6 01 48 39 c5 74 34 e8 f5 2e 5e fb 48 89 ef 48 83 c5 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38 38 d0 7f 08 84 c0 0f 85 d6 01 00 00 44 0f b6 65 ff
    RSP: 0018:ffff888116307b80 EFLAGS: 00010246
    RAX: 1ffffffff8054794 RBX: ffff88810a4a52c0 RCX: ffffffff8626be7b
    RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffc02a3ca0
    RBP: ffffffffc02a3ca1 R08: 0000000000000001 R09: 0000000000000001
    R10: ffffffff893cfe57 R11: ffff88811404d700 R12: 00000000ffffffff
    R13: ffff88810a4a52d4 R14: 0000000000000000 R15: dffffc0000000000
    FS:  00007fad30f2a780(0000) GS:ffff8881fd7d6000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: fffffbfff8054794 CR3: 0000000104fb7004 CR4: 0000000000770ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? __pfx_string+0x10/0x10
     vsnprintf+0x330/0x1110
     ? pmbd_probe_hit_cookie+0xee/0x1c0
     ? __pfx_vsnprintf+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? kasprintf+0xc7/0x100
     kvasprintf+0xe4/0x1a0
     ? __pfx_kvasprintf+0x10/0x10
     ? pmbd_gate_site_armed+0x14e/0x1c0
     ? pmbd_site_is_armed+0xa1/0xd0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? map_id_range_up+0x286/0x370
     kasprintf+0xc7/0x100
     ? __pfx_kasprintf+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? from_kuid_munged+0xa3/0x130
     ? __pfx_from_kuid_munged+0x10/0x10
     keyctl_describe_key+0x26d/0x600
     __do_sys_keyctl+0x2ed/0x4f0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7fad3103b7b9
    Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 66 0d 00 f7 d8 64 89 01 48
    RSP: 002b:00007ffeda509798 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
    RAX: ffffffffffffffda RBX: 000000000b61be23 RCX: 00007fad3103b7b9
    RDX: 00007ffeda5097a0 RSI: 000000000b61be23 RDI: 0000000000000006
    RBP: 00007ffeda5097a0 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000200 R11: 0000000000000246 R12: 0000000000000000
    R13: 00007ffeda509b90 R14: 00007fad31168000 R15: 000055ba831cdd08
     </TASK>
    Modules linked in: [last unloaded: rxrpc(O)]
    CR2: fffffbfff8054794
    ---[ end trace 0000000000000000 ]---

Fixes: aa9d4437893f ("KEYS: Fix the size of the key description passed to/from userspace")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529cb77de5386f1f3a99905d4b7688c..5a5efa26ed0ece3a5ab22e37ad7bda7a5a744b83 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
 
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
+	down_read(&key->sem);
 	infobuf = kasprintf(GFP_KERNEL,
 			    "%s;%d;%d;%08x;",
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
 			    key->perm);
+	up_read(&key->sem);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
