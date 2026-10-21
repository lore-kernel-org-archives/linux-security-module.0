Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622748;
	b=156BU6vgka6Rgwan3Tn41rSM1z2aQ1kRNL90dLOTr3quxjl+tFGGpXbP3ciGG2+laL9H
	 A9v6sII1l3aMoaf37x1Th6LMDkrzuiYTZyBI1aAet6iwbRR/20TJR9dRzMptCVlBfNuAi
	 Vj3kKeJq544Hb61ueoQQWTdLVXE0Eo3Y9A91y3WOBT5ie5EstEH98uB2GELKoWAtWfMyt
	 AWM4Jn7tYGx816d38F4OnFSsoYuPnl+24zxA1YuZSjgUYTu6muHnPiXoTKpbXwSiLC27c
	 N/5JRYaAElQaAaWTVd7uT2+fnxfJJD+S7Prdeap/U55/+YbAorisPjQCE+sryzzM4FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=4llyIL00u+37KgFZuL7wHKAnvyFDGQSYrc7zfpO6OMA=;
	b=5nt5TKTOXi3IdDhKb2OKMwF0PRmBo0nW3l6gyBFsh74xxyJbznr9ef+W1nzgF+Cw10lw
	 BcCUhsat+mcOL+Y/9JVdqXPOHclCACncoU0dapDmXPkWiwFsEX7yyUrmneWsih0mozKNr
	 Rkky0WXMWeBmduyzVhsYwuhafESHUwLe4/o34wl3sxkm4Uhw9YM99+ZsAql1kh7AzJSqM
	 Z4LIA80l3V8CEdOfXVO36D2IIGUUjQ0WM+eJwCFKwIYnFsD9jFV2Xwv5FVcFBC/KDpMWK
	 71vpkkiJQaZmduRfgLpgh66DkA6tU0swweCd+nVc2eEs7LZeT93wXrWIhXaH8yKym1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OhBKRuxM;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39071606A320
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 22:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39071606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OhBKRuxM
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso4142a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792622748; x=1793227548; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4llyIL00u+37KgFZuL7wHKAnvyFDGQSYrc7zfpO6OMA=;
        b=OhBKRuxMGHwUmmfTFM7fh88Q717Sm8fLuKCUC7E2Ni0wE7BGYNuQiKEyFm3I/d4qoV
         /p7E9SGOrPgKQlLfaKyitIPI0vtmGSbgNiPBfzuqol2QkDYxfpgl2FihMMSktk48pOzl
         dA++Vo7mrC9bOO7mIfwBo7Z41XtKQ3p7hdr5UxOiO0Y/VBZVSKn320qV8eCMxFabSgm8
         7lQeChYyLislsSyVv33w08Dimat5+907g27KR4Uj5bWfkuMEf/DhRIBi9L4TVoEJhlze
         NEzHYS2yJizUQKBZoJpfOKJt21xvcypQWJCa2olkRMYAozzJAMSO/GYE4LMpJ7Zum3eo
         /hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622748; x=1793227548;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4llyIL00u+37KgFZuL7wHKAnvyFDGQSYrc7zfpO6OMA=;
        b=FPRDE7eMEktIP1F73I/W8uusUulX4IUWPQ+GMdqp8XXSRgL/fo+fxZxbeWwFjB1uaW
         Ralci4JhxlnW+alIkVhKXkuvs6efuc4qkWoR6+N6bRVjKnUgzUP4hsqRQsxJAJQ2S6Mt
         sew1G3oKDs7N/7wU+F913eyQ8f14kdG1Te1auDXv98JJrkJUbQbF41P3wTKR85vCe2Um
         bMwq7cviMnUPitlYVd9vnwf8JYlza1S4junDUrpbSY+bmjzsz/CnC8dAQC+TcbE7yyis
         Q8aVawWIjIG8r4kfpF6chR0mAnPMlfWMtBPG6XRf71YqNpY0daj7hrFmjoN81WEsxJBC
         oyrg==
X-Forwarded-Encrypted: i=1; AKwUvBw1dfqIKU9T1yhdEgzGM1i7YkVjOi8cezwyOyRKB+ZcqMeAm/xeiwlosAEYkscopKLcvj47n9E3uJng4F2bSGqI/mJBrD8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZaI3OvjHQZjjugurU6oMI5dGDclIjW2BTdqZ+hMf7B2PzhuL5
	POrZWFE/4sbnr+Klyc5qlS96GreiKXV4g5Q5HcCwQcKXoNbBVSnpY7yPhTMuQQ==
X-Gm-Gg: AYBFou3hqx3dc5TI1Hzu3YY0emxlztzj4Oszwkq9S5EK3YgMfiVmoG1vz9B5w+JJ2r9
	//y5uoTlMolzwsNiBYMzBemYPK97O0fF2T/znat+l7f9gZKvyafhswCag/1rBNWNM4mBxcnN1/G
	1FVbS6KmohCJX6U5FfX060JAVxwyarqgKEJ5nd6KXiRqXS1W+Fk5D/gTXTpmunggCpE/y1bh3ea
	GqUlQkkTONlE3i3WUUw1vbHYjsH3fYDKIw3fWJRp12hmagXY9u8KDdIswuejKfLHhUzCiJFrr80
	G6fAz/gPF2W7gCxfKDdwm1lB9i2e41IKiaKim7pxHaM93u6CGIVlQBMSiEngvLtgc6vLczdl/zu
	12Ut6JW2j/iButbUf9GDbjF7KPHV7bnthlq2XP4GH+HCIq+BjuxSDDFGU2aQ8UiKDLaj4lkoZfJ
	pwD5tB/pEwslr2YZ7lAKoDDWDohgM2dfoIcxahtbuTaTHFCwdHjKT2Skx/oSkHMMU4yU/g2hs58
	HmUDcINcZQY/y2RQSG3ex3GpyTUqjV4EBlhEpBWP3BJy0qul6A5k9Efzfcn81Cx3oAS/UJbLHay
	P6th1CoGxUnqczurOy6Aolgn3tU/jNQSnPU8qk+AEuB/mI+/rn04oLd4zSJ5jg==
X-Received: by 2002:a17:90b:3f8f:b0:3ac:7c4d:8be1 with SMTP id 98e67ed59e1d1-3ad8708f735mr2855455a91.62.1792622747523;
        Wed, 21 Oct 2026 15:45:47 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48bcf45sm1215949a91.15.2026.10.21.15.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:45:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:45:46 +0000
Message-Id: <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>,
 <linux-security-module@vger.kernel.org>, <brauner@kernel.org>,
 <dwindsor@gmail.com>, <kpsingh@kernel.org>, <matt@bobrowski.net>
Subject: Re: [GIT PULL] BPF changes for 7.4
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, <torvalds@linux-foundation.org>
In-Reply-To: <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com>
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com> <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 02:26 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The primary reason for my objection is that the bpf_inode_init_xattr()
> kfunc, despite its name, is a LSM kfunc and should be located in
> security/bpf_lsm_kfuncs.c.

Linus,

there is no such file. The ask is to create it and to give it to LSM tree:
"We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
the LSM framework"
https://lore.kernel.org/all/CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com/

fs/bpf_fs_kfuncs.c has six xattr kfuncs already:
bpf_{get,set,remove}_dentry_xattr(), bpf_get_file_xattr(),
bpf_cgroup_read_xattr(), bpf_sock_read_xattr().
bpf_inode_init_xattr() is the 7th. Same "security.bpf." names,
same check of the name.
Christian's answer to the same ask in June:
"For xattrs we have it all centralized in the VFS and in general all VFS
related bpf kfuncs should continue living there and be registered there."
https://lore.kernel.org/bpf/20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner/

> The bpf_inode_init_xattr() kfunc does not call into any VFS APIs, but it
> does call into an LSM internal API.

That API is lsm_get_xattr_slot(), a static inline in
include/linux/lsm_hooks.h:

	if (unlikely(!xattrs))
		return NULL;
	return &xattrs[(*xattr_count)++];

The kdoc of security_inode_init_security() tells LSMs to call it.
selinux, smack and evm do. BPF LSM is one more LSM.
The series doesn't touch LSM framework. All it has under security/ is:
 security/bpf/hooks.c |  1 +

The kfunc fills struct xattr for initxattrs() callback of the filesystem.
It runs inside the transaction that creates the inode.

> it weould appear the decision to locate bpf_inode_init_xattr()
> in fs/bpf_fs_kfuncs.c is due largely (solely?) to a petulant policy to
> never allow a kfunc in the security/ space:

The kfunc is in fs/bpf_fs_kfuncs.c since David's v1 in April.
That email is from September.

On Jul 1 Paul was ok with the kfunc there as long as LSM bits move into
security_lsmxattr_add():
https://lore.kernel.org/all/CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com/
David did that in v5 and v6. On Jul 31:
"I saw the v5 patchset and the nature of the kfunc became painfully
obvious to me so I changed my opinion."
https://lore.kernel.org/all/CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com/
"this puts us at a stalemate and David will need to find another
approach for his work."
https://lore.kernel.org/all/CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com/
Six versions in three months, stuck on the name of the file.
That's why I don't want bpf kfuncs under security/.

> I can't support the BPF maintainers actively circumventing
> review/oversight from LSM developers.

v3-v6 were on LSM list.
The last series is that other approach. Christian, KP and Matt were in cc.
LSM list was not. It should have been. Fair point. Will cc next time.

It's in linux-next since September. On Sep 23 Daniel asked for technical
comments or bugs:
https://lore.kernel.org/bpf/04fe4568-90cb-4aac-a21d-c0443e418b46@iogearbox.net/
None so far.
