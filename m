Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792618021;
	b=0YJrC+8i9WSBi0qKW9GyZZ80lHBaFbxXKATVQz48bxm4fI/PicOatfPhpIcQvqVH5jgc
	 xN/9nXjRA3Gjuu3VFrgx6AIbdjau4lZv+fqBFw68iROX9osOozYiqfq4DW8aQJEa3GJiz
	 gOdvlBOIWo3i/I1qZynp0l8ICKrxVljNjoA5XnRSOd7HXLVeFUJYh+6NMRTVDj2EvU500
	 y7KSCs9P89e5sURsJfDOhhGnprjBBjVZhSG1BaalcKa5dQMQPbuPzJhZ/uqXKCO9gJisT
	 R0+6IzoG9DmJq23riQK163W9D+R+ry7g5S55h9P0FlkiUiVhWvfJsPjtsScZoBvq8mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
	b=ffcmq5zv6LsgsPa3YivGwwGiZXXxprPUcURL6PB1fa7UgNuDy6uIGLCevfnEDWeUiFFt
	 9hxuuK6HbRY12v4Y9ooG2He4zLn/HuJ1sNZrG95adbNoKvVbNtJxM0QeIy6YOwxX+asw+
	 RDvtAnsIZs7aFujrLR7Bj9albbeQkDqbYlsSTxWtBFQmZG4jLVxTBC9eQybTa8grTXjUO
	 UgNcbpIgOV5eRXn8JPTHjwMstjKL0SijRNYqvRTEih+G6h2K7OheWlTWm7LmEo5gfatnp
	 CWwtBcBLqlXH5dmwMah3KdPBOlQr8GXbc9PGdXQdlV3nZVJqSbq2nEuMJLZOsgEoTxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Olp7wuHM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA5606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAEA5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Olp7wuHM
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so585697b3a.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 14:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792618020; cv=none;
        d=google.com; s=arc-20260327;
        b=geC64MHRG/Ush/qXmWhfnP35sFYH3dHljwrb2K4Vsb6/O59EAS/AazvfNXUGJQOVQD
         l25Nbw7KwiUempfMt7+3UDFlz52u5YrNKp3A6MhP72bpbEksN+N2SrtC7plS6SI2yurU
         DsNv5A1gt/0VK0j7ZEH1mFRftLIIjRg8HkPytKpqn5/Fq/NubiESG8GtZVoqAptocpWC
         klnftNPYWRIUw7pB7u60oWYx+Mis8Pq4+X4iXSNiHqrDheY2Vdcc8rBm48gxppFPnzbF
         UxZpsHniHKzJk3SV9lhb7o5ndZZCt1nkJFK50Y1YFzHYObSmyxQBlkywbL1IwFWj+Gam
         u6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
        fh=SwGsZ6lz8enMWOUWybc+WZaIIJFLXvNLKePH7NcDrCQ=;
        b=gpym16P4/dTiERxGEZ+rUP/PghLmiGPPnJJLibhSIQ+aRpPXVpqEmJoC8OjitEK7Sp
         YAIgf+J7udVzNkNw4mb9XhY0hk06Pqwccs0K7C3yt8RQWZS3nZDPA2CrP5+OryeggsrO
         4o8NyMe+MvKd4ArgemDYXKFiaCrlHhZiEUlwy9dLsn+t0K1rxdDNkGYjWmsMd/6C/Se9
         rBFVCmkNp/LnZAngG6i+OTuEJACjXDCXDIwIWcyHcNYG3EJsieyzZVFsi4qElpfrA8EN
         4DNrEP+1qZrStrl76GLVJj1BwnEFa7dPsQeT16kjUdpL5leJGYvbiLnP9fIf3y2MGvRH
         WjkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792618020; x=1793222820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
        b=Olp7wuHMPD0rgobGBOMxtyo3z7aaxKDbIa5dXP9TbKcGbUygsV5+IyHL8X9MqiHLaK
         SF5Q5F4zcrxukH7gCbcEDiPEW9TpK/LpwdG0Zp/WNkOdtLXKPWtGgrHx/rm/fKd6AhBq
         Sqb50iWdaGSjuPC5yJGvuwszU7ygtTWzQzZzP/Y5LQoxeQ1zpTaf/cP0Y5LTLuxgm5m+
         mMgxFh7Hw03KKtYJx+gFMRQnB+Oh03CAT2q6U0wCJLi+WorHDAxZdarTr6GXiIUZ6YPT
         zDSBAXgbVjqLnbccNnkKOAC5CpooqtBxZ16uSW5SOOCW9/xyD3tKjCWX38scl4p5skSS
         RyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618020; x=1793222820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BrqJG4OjTNvcnuuTV6wbrFx+ZsrsyYDwwPn/2n+09s=;
        b=1++kWJvB1bElQgXqvYoT3jYtNdfg6EGX7E+fSEYDhRihQO48bWQKZwHNuasuXzZDLR
         EwftQJFlw4syQKM7wU9nPWY7UnpyPchxyeA9yVR94Pkj9VrpVOhs1t3y7sFvCQ8tphUq
         Mlhb+1FnyCuUN8lVPyzusNhzK09OVYF+ZDNwmer2yRB5PLXVXS8DEplVaUNGzGAl5AA1
         yMcX7khj59jXT/CdD0VtzMjcVIPXoBhtYF+VSglAiTIh8FCLLxNt2+0VqatTv3tOIwPV
         ZrmhELTz1/Yii8OL045IPJdUY6zZwXmQL1x9FX9xh8TFMKyHBN47HhIN1nM+KOSchKbv
         L/fg==
X-Forwarded-Encrypted: i=1; AKwUvBxPTAzkLH8CFtwwUkQnijzeoSpap3Jj4ys70Y7k0MGBnnqi0uD2JJxWNr89Wa6ImEJp3fHDjZDVDAT8HUJVPI8DGHIXBzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbLiYOKU6E32L+mVKeg9xCSKSsZfmm0erOq5uudru+ocR2QUZl
	alFDjuMyf5tGYQCzqOGyauxy87iR57cPP32iXzqMirr5RFD17YQY1IJJoQHP28dwad2COlbPKt1
	yEJ9UFZggrZHfLZWxThcxIdJXSZ/3pKg6mRbhnojb
X-Gm-Gg: AYBFou0NciJ6ByjF9+5QV7Od7/zBYwr+xlrIRtRjs/7cFYkJxeYI22ycNo/qP92RRQU
	Ma4g7it/5JDzHrUcpiiVQ+F+Fn5FWNsDmE/kKxWfephM1nCnEjc0kmVkAfCIwDikboBA1DjVj2T
	ZVEW1pXqLMJZZPCoav8ZWPlqcE8bkkGSc5GiD9K+Gu4OvPOWa5LwAvckPMtcIGo4in8xotKRdY7
	VNwpC8L0TB/x55+oG+gEQPtnrAL9o4NkvINWp8jZi1kBxhYLI+x7YMA48McTcu7DMijqidps3Oc
	RNGziVcVxqPkxe5zpQeh8HPWjcHjogT+AVWMUb6JoH7HB6r/xo6SPVMTibNhqjT0QaeduKiYRhO
	iodozZNWuv5jVIVw0TPmBquTLuaAT36x2X+JG+EjJr0HInRm5qyzsOqi3g0Q8k6lLyidYD/S/tR
	pO+ksdlXIB4xHD0A==
X-Received: by 2002:a05:6a00:448c:b0:891:6721:370a with SMTP id
 d2e1a72fcca58-8a089d16bd2mr2288044b3a.29.1792618020160; Wed, 21 Oct 2026
 14:27:00 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Oct 2026 17:26:48 -0400
X-Gm-Features: AclHuK_WG0WtmvYrPQFuNXHrb2rzzSH_2jeZmbcgt1YGcpXNkJbu_aqEAAZfEdc
Message-ID: <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 7.4
To: torvalds@linux-foundation.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	Alexei Starovoitov <ast@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 5:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi Linus,
>
> The following changes since commit ff47652a4b66c067c765a7ad464d930b5a9367=
cc:
>
>   Merge tag 'cifs-fixes-7.3-rc6' of https://git.manguebit.org/linux (2026=
-10-02 14:04:11 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/b=
pf-next-7.4
>
> for you to fetch changes up to b116ac6087541d3d98031e786adbe9c733cd6df3:
>
>   selftests/bpf: Time tc_edt from its first packet with data (2026-10-21 =
17:50:51 +0000)

...

> Other features and fixes:
>
> - Let BPF LSM set xattrs at inode creation with bpf_inode_init_xattr()
>   (David Windsor, Daniel Borkmann)

I need to object to the BPF LSM kfunc added in commit ff0d1c0915d1
("bpf, lsm: Let BPF LSM provide xattrs at inode creation") for reasons
already mentioned in the thread below:

https://lore.kernel.org/all/20260915150739.284189-5-daniel@iogearbox.net

The primary reason for my objection is that the bpf_inode_init_xattr()
kfunc, despite its name, is a LSM kfunc and should be located in
security/bpf_lsm_kfuncs.c.  The bpf_inode_init_xattr() kfunc is called
from a BPF LSM program where it allocates a buffer for an xattr
name/value pairing, updates the LSM framework managed list with the
name/value pair, and then returns to the BPF LSM program which in turn
returns to the LSM framework where security_inode_init_security()
writes the inode's xattrs collected from all of the enabled LSMs.  The
bpf_inode_init_xattr() kfunc does not call into any VFS APIs, but it
does call into an LSM internal API.  There is no good technical reason
why this kfunc is located outside the security/ directory, and given
that there is plenty of precdence for BPF kfuncs located outside of
bpf/ (e.g. drivers, VFS, io_uring, cgroups, scheduler, mm, networking,
etc.) it weould appear the decision to locate bpf_inode_init_xattr()
in fs/bpf_fs_kfuncs.c is due largely (solely?) to a petulant policy to
never allow a kfunc in the security/ space:

https://lore.kernel.org/linux-security-module/DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gm=
ail.com

I'm supportive of the work that David Windsor did to enable BPF LSMs
to leverage the security_inode_init_security() LSM hook, and generally
speaking I'm supportive of changes to make it easier for BPF LSM
developers to use existing LSM hooks (there were multiple changes in
the Linux v7.4 LSM framework pull request to do just that), but I
can't support the BPF maintainers actively circumventing
review/oversight from LSM developers.  I'm happy to support David's
work, but the bpf_inode_init_xattr() kfunc, and associacted code,
needs to be moved into security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
