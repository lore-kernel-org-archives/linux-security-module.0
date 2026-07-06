Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD1338939
	for <linux-security-module@vger.kernel.org>; Mon,  6 Jul 2026 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357995; cv=pass; b=iSxcLPALO0gHpkFj3MjmX//XIS9sd1jdXRPOceFXSe5NI9siPY/x7SxUyazMa6KqdF81OgMvSTof6at5o8RPBJv/CdAntvQpT3NDHOdPMGFl258gpyEbg7jQCml8OJAdEmzwcxX3dudDjv4xwdr9r52cmL86WfjAKXsf1GCSQ30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357995; c=relaxed/simple;
	bh=1ZNEn0E8kMjTljW5xMZlKQLRFTDyE82gh+WwjDpJB3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPqTquER29GnqwQ2ExlPZduthT4OFgUp8nRD1OpHvCz/l9sFrvc8GggDQcRTa2qrZujFG0syk/y+PwMrFUmIIsilhIPSfDWMnuRINRYDaonBpSupMc9xiDzkDAfZivK8qjcmJIORg2/hy54YB49g6ZD0dXn/XzU8q1kV0MQ8a6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gABKBJEZ; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gABKBJEZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3811e59df58so1992164a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jul 2026 10:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783357993; cv=none;
        d=google.com; s=arc-20260327;
        b=Wl9xABwsjxy341s6kf03Ns+PqSObhPh0g7GMfD91NsDStfchvBYBFNT+ytWiy0jyys
         zgIenCUbSZibd62pMbgTm7z9dEzaBMOcJTZYG3bsdWphb1LUuU6+WgxNut9R3gSp/neP
         uNx1vN9lNZmaPXh6nZCJhQPnoGUOS3+d8TxK15Bawrc03Tjvb3qS0oahWMuatSUl3Xns
         xcy6dAjo7arkUls7NXuxEzzblJi+Chs+q5F6bwCgY1KRPigQg53bwNvoZQf7ILooqvk1
         3MIUH9i8VaZdWWnj6JTB7x3tnr5Qkc9iC5pxxfEO6qekW1WUQ8FP5P8UFki7pkz10Qjz
         uSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0xmu+kWC2HiBNzOMZUwexKsbY0N1RGOC8BXOe7wfUo8=;
        fh=l+jE7N0rFftsnG/Lr4SKosg+OzkBwQQkRjBv8A6WHB4=;
        b=q/CzHlVX63c6ziShwVqPvPyXqugm0PJTgJWw3Pok24I+/XUfN10VuqEbGqNedOIR9f
         3VdZqwSPkv4VVyv/p4o6+4QLy14rRcgL0DjjFjKftePgu1MF86ZM0S5U4oUmhwMNxiOo
         Dqq88GoLcTIZ2ud64IcmdHG5n2M/iZh+6aeuDcZIXpyLlL/oXZlbNJb3aCL2N/5Q5QQ5
         ci9i+OTPqgsyNqGps6z1ItSxz1UffC8BRAW2fZvBbONj5McFfaC2ULnn/phsKBtQHFOk
         maFIoDZTzhRrvhVfNqtuSwW/QpH8Jdk11H680smPHshSYZjpHK9xunpIHEJC/PTSVCza
         YJBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783357993; x=1783962793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xmu+kWC2HiBNzOMZUwexKsbY0N1RGOC8BXOe7wfUo8=;
        b=gABKBJEZplBQOeAiY58cDNt5l0T9YcmfC8zY4vMK88ojpnv5vLtz7eivmuXDl2tMJU
         JK9l07DOsc3RjvWRy6M96kAaJjUxsmgOLj5009a8lVsW+Fs7jBbKEtXlfnWllROILO4W
         CkiD9t3Rg9zR3ogGXsoBJPKiDlN2r90zET1lOG32RWRqjS/OAF7Jkq4NmRcmLLS7BS9m
         lBMwB++Prq8P0TPuR43XDT4fOdoJq1jxrywAw/7nbnquEySFtxGFTDQWLDLeeW7//3tO
         ve5jm4rzh7lyZbr1fpLQnVhUjsAenkcw/gyZ27VM4HZcN+i4bYE2D7PyMKPvwsOPLzO6
         S7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357993; x=1783962793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0xmu+kWC2HiBNzOMZUwexKsbY0N1RGOC8BXOe7wfUo8=;
        b=jeR+X7Jf5k751C9JbBKJ1OQ5lHWHnjBG7LaUFvlh5WYb8BAJCZIAXBmdgFgWAoI0jT
         IUQ0yJG8XglcsQOkrzC7RIXe/YTw6o3GE76QtddxOl3MdBEIgB8+6IcPki0gWs8WvCHv
         NdT6eia2/801JKNtTSuE/ZCyWr3lVH0gnYsyFZsOV485vXHvZa0oCpe0EzKFQB08X0Fe
         7sv2c+A+D8o/eqxFsczhEWNPDsznpj2kHIPGXnlFKXxWYMzddY49TUVmFs1mnvTyDVMb
         D/dtfLzrHuw9uZxxRsd9h4LTZTOEjmRhFUMPT++U86mOcWMQt5OMK3+wc76I/LZjRL4h
         bQWQ==
X-Forwarded-Encrypted: i=1; AHgh+Roc9g+nn6rKSyc431wwFnyUu5gMlxzt8EwGTw48l6gWSXIlj1HX9e6d/DW4Bnj3fPYjbFn9GIaoFdydQatLEiVr6O5NLyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbE53gIAr1ch2U6//7qs/otI/0anznIUCQ/xdc279wfpFVX7Mq
	exoxbrHI0tfGXfck/aCcsPmocftJwxQVyfk2sIyyktkj+JHQms7lA1GzGPc28jS5kJtc7seDofq
	0vZpcNFORexaYKmvCixAY64fquloxAbNyOkAkkNiZ
X-Gm-Gg: AfdE7ckepRPsW2zIAkWPX4cCvkCEn21LyyQu/vdIrE+AMyG6GP/1wTXrwIEmajG7m2V
	Vle/jbM2JXcT7dHEIj5ETZ4vHXiSD6EZ43PeQfPK3ynzaHhT06L2e/Y0css9Ui6pArbSyPMwitZ
	LfBJqgFwqRrlaFSvRB6HO6pK3RHYB5VjwOKRRMD20QrHL8ca73nDIpzM9eZlPQ7KFIquYHTu7OE
	iO0wv+hOV9Tg1rphINEVha2tBd8N1DcK8yWjeqXO52UmbXBHy5FxgMic5AvwZ7uzqU7U/ut
X-Received: by 2002:a17:90b:3dc5:b0:381:6466:7160 with SMTP id
 98e67ed59e1d1-387575a0b4cmr1310473a91.26.1783357992887; Mon, 06 Jul 2026
 10:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706135644.326006-1-daniel@iogearbox.net>
In-Reply-To: <20260706135644.326006-1-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 6 Jul 2026 13:13:00 -0400
X-Gm-Features: AVVi8CeCuWrUiOENGEA-IpthH0EltUGg_gz23gBLobgWKHgUrDsTpSX5qNBeOt0
Message-ID: <CAHC9VhQbqxJFBX+3-JiHR7+QqgWsiAAak7J4-q3QykdGqB7g+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] Verify BPF signed loader at load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 9:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> The BPF signing scheme signs a light skeleton's loader program and lets
> the loader vouch for everything else: bpftool bakes the SHA256 of the
> metadata map into the loader's instructions, signs the instructions, and
> the loader compares the (frozen, exclusive) map against that hash from
> within BPF once it runs. The construction is sound as a trusted hash
> chain, but the kernel itself never attests the metadata, and that split
> has been the recurring objection from the LSM / integrity side since the
> scheme was proposed.
>
> This proposal closes both gaps by having the kernel verify the metadata
> at BPF_PROG_LOAD time, before the LSM admission hook and before the
> verifier, /without/ growing the UAPI. A signed loader binds its metadata
> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
> are already bound to the loader's digest via excl_prog_hash. When a
> signature is present, the kernel collects the exclusive maps from the
> fd_array and appends their frozen contents to the instructions before
> PKCS#7 verification, so the signature covers ...
>
>     insns || metadata_0 || metadata_1 || [...]
>
> ... in fd_array order. The in-loader hash check is dropped from the
> gen_loader entirely: generated loaders carry no verification logic
> anymore, and signing or verifying a skeleton becomes an ordinary CMS
> operation over bytes that sit verbatim in the skeleton, reproducible
> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED
> with nothing in between.
>
> There is no new UAPI, we now have a single signature scheme, no LSM
> code reaching into BPF internals, no new LSM hook, and unsigned loads
> are completely unaffected. It is also less complex since the loader
> does not need to deal with BTF, an extra kfunc, etc, as proposed in
> an earlier series [0]. Tested against full BPF CI which came back
> green. For more details and examples, see the documentation patch in
> this series.
>
>   [0] https://lore.kernel.org/bpf/20260522023234.3778588-1-kpsingh@kernel=
.org/
>
> v3 -> v4:
>   - Fix upper limit in MAX_FD_ARRAY_CNT (Anton)
>   - Reject !fd_array && attr->fd_array_cnt (Anton)
>   - Add bpftool patch wrt ignored return value of EVP_Digest() (sashiko)
>   - Fix setting of gen_loader_fixture_init (sashiko)
>   - Fix unused map_fd cleanup branch in selftest (bot+bpf-ci)
>   - Remove now unused map->excl member and adjust selftests
>   - Added more BPF signed_loader corner case selftest coverage
>   - Added Paul's Nack wrt bpf_prog_load LSM hook dispute
>   - Added patch 2 to move bigger allocations below fd_array
>     resolution (Paul)

If you want to squash patch 2/9 and 3/9 together so that one can't
easily merge 3/9 without the vzalloc(program) relocation I'll gladly
drop my NACK on patch 3/9.

> v2 -> v3:
>   - Added first commit to cache and work on objects in fd_array
>     which was the most recent issue sashiko rightfully complained
>   - Added more BPF signed_loader selftest coverage to cover that
>     usage of sparse fd_array or map fds gets rejected
>   - I left the security_bpf_prog_load as in v2 given preference
>     from BPF side over adding new hook
> v1 -> v2:
>   - Addressed both sashiko complaints, the TOCTOU bug regarding
>     fd_array processing, as well as exclusive map checking to
>     only allow array maps. The validation is now moved into the
>     verifier before the main verification work happens. This also
>     gives the opportunity to utilize the verifier log.
>
> Daniel Borkmann (9):
>   bpf: Resolve and cache fd_array objects at load time
>   bpf: Move bigger allocations below fd_array resolution
>   bpf: Verify signed loader metadata at load time
>   libbpf: Drop in-loader metadata check for load-time verification
>   bpftool: Check EVP_Digest when computing excl_prog_hash
>   bpftool: Cover loader metadata with the program signature
>   selftests/bpf: Adjust bpf_map layout in verifier_map_ptr
>   selftests/bpf: Verify load-time signed loader metadata
>   Documentation/bpf: Add BPF signing and enforcement doc
>
>  Documentation/bpf/index.rst                   |    1 +
>  Documentation/bpf/signing.rst                 |  496 ++++++++
>  include/linux/bpf.h                           |    1 -
>  include/linux/bpf_verifier.h                  |   23 +-
>  kernel/bpf/syscall.c                          |   83 +-
>  kernel/bpf/verifier.c                         |  450 ++++++--
>  tools/bpf/bpftool/gen.c                       |    2 +
>  tools/bpf/bpftool/sign.c                      |   24 +-
>  tools/lib/bpf/bpf_gen_internal.h              |    1 -
>  tools/lib/bpf/gen_loader.c                    |   76 +-
>  tools/lib/bpf/libbpf_internal.h               |    1 -
>  tools/lib/bpf/skel_internal.h                 |   31 +-
>  .../selftests/bpf/prog_tests/signed_loader.c  | 1004 ++++++++++++++---
>  .../selftests/bpf/progs/test_signed_loader.c  |    9 +-
>  .../selftests/bpf/progs/verifier_map_ptr.c    |   23 +-
>  15 files changed, 1786 insertions(+), 439 deletions(-)
>  create mode 100644 Documentation/bpf/signing.rst

--=20
paul-moore.com
