Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1F243954
	for <linux-security-module@vger.kernel.org>; Tue, 23 Sep 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590826; cv=none; b=WemnTJPpg9nhwFtKADC0Ly+KA6EUDCKNMLoLDXfdjOA3+G8vTTNFuPiJ/maWOO7pRpHsjwgxjQTm8tWwHCU0X/JAqmw4A77fNKT2wIN/6UXkLvzlbkIbg8zxzCrnkNvaexiRPnsSceK0ROWNlmhvamQcAALU+GoTd5yaLpU8/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590826; c=relaxed/simple;
	bh=/yTK6Wyn7S+cC9ZuMCyCbCLvMuzpeiKg15N/mIeh2Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwuAq3pUu9ROdkdOr33USho/dVSzdIf12VYhrGI9EQkrQnap2b8UNU4ocJnurLYq3agdhx4rqS3gDGiZhP2+9ZmTC8VwhuHDhcDq/zKbxQSQeLxyx7lPM9ywhbMSSnurz2hViryd4UYCjOsOxymIdJ50EOuOANdDCnBCOz6/Gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CXP16esa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CXP16esa"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b555ed30c1cso447063a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 22 Sep 2025 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758590823; x=1759195623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqjdOORSGFD7FvIcZ0JXH7SgphifcM2Ag/xxYoTRY5A=;
        b=CXP16esapDC7TdI8kWZFZ2uWezmbiNRclVtPGBK5sJ4dLhZwklPmvml47X3iRKMWlK
         8/HXYnbvt0X00N9l5MbYFZIZSDQklNZ3d+p4pWStHoVaKfgiwi/HkQe+B+CzjXTt+HkI
         ePcedy5G4KW4i8hT8yWKiNW3X005JPvVKK1L7WEYPfJJBIjplZZAQnCcaB7W2mb/wfzD
         iJwzDPy38QrcGlpqjS/6C8sBt/YrLQTbGlPSDQTMYHbspOaPSWrMnhtzjWlJ0PzmNUC+
         k1m3WaXQ0G0efOtTywNL0GOtx8Rb40ix0sfiITgWRvga9ZKlzibeNTdJxOK70FijLpVv
         fmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590823; x=1759195623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqjdOORSGFD7FvIcZ0JXH7SgphifcM2Ag/xxYoTRY5A=;
        b=Xw2EiplgpiTa8QgfeMiHkKNTIG68/u1hkHv+qllPdOC5HzviGpJUz35kBs5lBG/s2O
         FnNS3Fb1hFQuf6jiJxHWusPNeWmMHHLob2d8/NjYtf3x57QUtZijSsNB07ASR8hT4Pk1
         jl7hn1oWEUCwHO8WcAtF5hWDLhS+dL/zEy1ufmYo4QQKKmhOl4KQSOXAj2P2S/dhkp6D
         hQhkY9iD8q+IA/Z5Hr8iU8t9xGtQ/0k6o7rvkcTku4tt7KMXoLjaagOe0LGANpuYEdx4
         Ab/YjyvZjpu95wp/Ms4FSpzKTDhsyTTmrFBuxwRMIxUEBGNQDvZT9JwhW7KR/0ntsOw0
         ZqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMEcF4PVMaGK6uFLyV8kaYzJZbb881L7Nxmuxapm/kY/+jLLrnLNtHvmAi845DNGoeowqpG9ZVSnmMkEVj1xUCevqHb/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqeqcaG4nISrXU9IzJwFfjQtfoWR6rBvXnm+plt9OOb5IfHxj
	5N3PH7vD4E2Pcd0I/ecE31asQU5LkBZIk7rYTV8vspRb9di6V+a6QGsjW/ggLOAdknoEE2A3CBk
	UE7CJy24FIbNi47vlzmmq6ILT3TrS5olAJi1fEG08
X-Gm-Gg: ASbGncvb8Fw1F8OQvNYTaIdQ2Q4hhsjhK0r2RtTIzYdZcwyJgTpY9S2QC+IdlYZabD4
	am0vwy+88nOquY0gBgH2xp7NMoCdWpmVicSMiEOl11eQNay6PlQSJNeT4e4i8ey3VEGMCXYO3YS
	zqPhKQpotyC+Yj0WfJe+fnn+YibsQXyptWlF0OzBJI5/2b1MzDgyRiMVgDWiJJ+4dqKkNPBo/rW
	cm0A/g=
X-Google-Smtp-Source: AGHT+IEeSW9eXhOzqwgIxKu1Sg8gHX7O7Kl89y/+j8/ODZNSQZvRiiteecPHa8MK2WLwmvUISfs/IRuIn1g7SLY2SQw=
X-Received: by 2002:a17:90b:1fd0:b0:32e:f1c:e778 with SMTP id
 98e67ed59e1d1-332a95445d8mr1090948a91.3.1758590822705; Mon, 22 Sep 2025
 18:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921160120.9711-1-kpsingh@kernel.org>
In-Reply-To: <20250921160120.9711-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 21:26:49 -0400
X-Gm-Features: AS18NWCpAdZ5ZGSx3Cngxh2izSuRjhhwIO5s13DS6QhO8MBfyMUCK-TS5SSShFM
Message-ID: <CAHC9VhRSs=6rd7fwMGQ1Zyj5PX1aSGtxEMgoS4T4gzD3e7nv9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 0/5] Signed BPF programs
To: KP Singh <kpsingh@kernel.org>, bboscaccy@linux.microsoft.com, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kys@microsoft.com, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 12:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> BPF Signing has gone over multiple discussions in various conferences wit=
h the
> kernel and BPF community ...

In addition to the signature scheme KP has proposed, if we want to
increase adoption of BPF to those who currently disable it due to
strict code provenance and integrity concerns, we need to merge
Blaise's optional signature scheme as described most recently in the
patch posting linked below:

https://lore.kernel.org/linux-security-module/20250909162345.569889-1-bbosc=
accy@linux.microsoft.com/

It is important to note that Blaise's patch allows both signature
schemes to coexist together in the same kernel, allowing users to
select which scheme to use on each program load, and enables the
kernel to support policy to selectively enforce rules around which
signature scheme is permitted for each load.

While we've discussed this in the past, Blaise's signature scheme is
important as it satisfies requirements that aren't otherwise met:

* Both the lskel and original BPF program are verified for provenance
and integrity prior to the security_bpf_prog_load() hook.  This allows
LSMs, including BPF LSMs, to make access control decisions on the
entirety of the verification, not just the verification of the lskel.
For those users who have very strict security requirements which
require analysis of the system's security policy as part of their
vetting, this limits the scope of the BPF signature verification
policy analysis to just the LSM's policy.  This approach is in keeping
with most every other security significant operation in the kernel,
and is also seen as a best practice, since it significantly simplifies
the analysis of the system's security properties.  KP's signature
scheme, while it does verify the original program, it offloads the
digest verification of the original BPF program to the lskel.  Aside
from breaking with most other kernel-based access control approaches,
this means that analysis of only the LSM's policy is no longer
sufficient, security officers must vet both the LSM's policy as well
as the digest verification code in every lskel used on the system.

* Verification of both the lskel and the original BPF program prior to
the security_bpf_prog_load() hook also makes it possible for
observability, measurement, and attestation focused LSMs to more
easily audit, measure, and attest the verified lskel and original BPF,
as all of the components have passed provenance and integrity
verification while the measurements/digests still remain stable as
none of the lskel based transforms have yet to take place.  Using KP's
signature scheme this isn't quite possible as the original BPF program
is verified during the execution of the lskel which potentially
mutates the original BPF program.

As an aside, Blaise's signature scheme also has the nice property that
BPF ELF objects using Blaise's signature scheme are backwards
compatible with existing kernels, allowing the signed BPF to be loaded
on older kernels, albeit without signature verification for obvious
reasons.  While this may not be important to some users, BPF ELF
objects using KP's signature scheme will likely fail when loaded on
older kernels.

Taken individually, KP's and Blaise's signature schemes may not
satisfy all of the use cases and requirements for BPF signing that
have been discussed over the years, but I believe that the two schemes
together can satisfy everyone's needs.

--=20
paul-moore.com
