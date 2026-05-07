Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1532B9A9
	for <linux-security-module@vger.kernel.org>; Thu,  7 May 2026 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187471; cv=pass; b=nxgbhuddgcm3ixb/0ChfdmKtcpyr4AgabOxVq0hRKjvDP4ERM3jeCa+Cf26m80iUE/SX/J6163D89OLPeHU62LC2YgGZGbohRo/zCPpeivhC3RVGwkgsIi3kkm/Zk2p2KhsHcU/VqiX62c/Mku5SWasVZEEHheuZ1z7FjbXDZWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187471; c=relaxed/simple;
	bh=dzCGE45kN9A7cRwTX4c6YDKiWHm0lvYyixc38KnjSlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wempcq4iQrx5/v84+C7eNpgKRUyBP+p0AmsSSdWicTRfblMq4EJEMZXuczxkamOv29iYAKmlUJmAP0W48GkRc1B2lRrdHfMXgVXl0QoreS04ygvRhmG3/DYhFmVFfjZzE9Aet8a/2AnC+uFE2tXZCWuvuy38B/hrzGhk/fVYaM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ks8qNKOU; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ks8qNKOU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba0714574fso7904205ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2026 13:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778187468; cv=none;
        d=google.com; s=arc-20240605;
        b=hvhn5mTft9c1VXBdmSIhN00vGOi/lyPZ0MFwIuLQ605oVUkPgH4Wb1bJtoSl8MT9lm
         OmhMhQp7w76muOFOKwfyCwQQSX4uEq69yDQWme8uRi568Eum4qqZZqVX1f1gU992OMDq
         udYfhrjFJu3+Er6LlvW1r0QaD1oJ/TbJe6VG5pItnBWLJb/j65EPvbMe+CyXLH5am8Ys
         de3VlnoNrQGO1gwTweVJF7hcDJGU2Boh+5nVw0lwOCRF9Qblt5OnlM2ISemg+XJT+Tcb
         sN5W6A3QafmBB0YWLBLMtd0WYkNq0Frx8FnVqx6/lcURS/xyErWi9oTVIZna5Lcamzfr
         9Mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w9z2GvzEw9i/nhMRa6wlw8IHkov6Pzg/iLQFCyv25S4=;
        fh=HaMd1tivQvHPgRUfrkMiKkYR3YSq3FR25uxMiTlDfYY=;
        b=XYtp+rhoOEDyOVgLIayfAxc3Ks80X7L1kRT5vW4MKDbUTpz4RJsyM17qqrJbyDWwAP
         TnlSHZ+lQ3JyRuC7URJMc63chh7lqJZ80y6tRZP/eQRpYcYbyXGwhRkyJvfx0pftm0KO
         IZ3VECDWb9eBjXWikk/sF7MruZ1cm0BiEjQJCAxxoq7bEQcJ+r2lQs+X68JK0LR8MG1e
         CcC86KLfLC8Hwg3dseOgQwtiy3mfA675dNelDi1XxKqH5Ni0EzP1L/wDMjMlp9XuvUrw
         PIAnSp8FoAJlvjMnr1KM5e1ddB4xFYHLKKorFDJDBKv2bS9JuLRi3mqUUXDmMgv5PNNJ
         fkmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778187468; x=1778792268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9z2GvzEw9i/nhMRa6wlw8IHkov6Pzg/iLQFCyv25S4=;
        b=Ks8qNKOUoHUd6fNtJlBJb8CTyVXA5nLreVszv/M7Pv++AS2yadUNOK5REbi1j1tA1i
         BQnXYPspts7M4WKCkU1YH9ARq57GZOs2Q3UDFqLDzONjP8oT7KMOl20zT7xq0Rvn5hI5
         jeAs7mqMeV1jhYdIBN+8XPBaES5+ZHsLW64SlgeWtcTzJvSu/e3MB5ZgVSJGe3k3BHPK
         QRI1vKwYBC+BTv2CLKmbHeI/xdeIX7uTE+JADu4TUX3hyYjPi5tv8v149FMuGc0NfCQj
         O/gL5b5Bn5j/LxV+DZG9o+U6AHj69Tdx1z1WMaHRVDDDKZ/mGL67kBogMj2jBFMkhPE/
         E9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187468; x=1778792268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9z2GvzEw9i/nhMRa6wlw8IHkov6Pzg/iLQFCyv25S4=;
        b=qw43iiLvsseWY5u9T7/QqabyHtd+N+cWdfrg7tzrCSsRBoAIJ++2QvINGqW2+JWbfR
         OuniY0hxIV7/qvp/pSZhftM7X68X3wsriq/Z12Fb0kdBXJx32e7dL3yTrYB8/HbqSgnK
         njXysX2GCujhb14iL+aj/9sXx7Tf7KiT1CB8w4CbxkvIV5QDpp5GiTtNGEO2K0VsSCwW
         EV3SA1o2p0zEqao+vz/efLmyRhq0dkJ3ed1utJaxONxGXhjoCjrLgtG9BN5komCXv0F4
         v2vkPC1fecQMaYc43BbW720xVK3FqWwLcZurzHfBaxWHBpB9m557AqW/GhYKyw/JBDr6
         41zw==
X-Forwarded-Encrypted: i=1; AFNElJ+0MMcHerGMmR2+2+4CLDCEJZacRdCCWKYMYOyhr55gtMCmij96sujgO0HR+2DF5plO/StW3jALMH9FsLtoUHbmlT8wbWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4n47DLdrR46CHr0BOMQ/Qf0Jr6evgLMPExcEdgSKJ6GSVGUu
	DbH2yb7v7ATGnJQOf4RL91KpzN7ju0XfUNTr7yGOEyWYZYmoxKjg9afjiEcsJlYcSdLOvXSjY/G
	KXFqia1RGxGm+T9hFh++xXhjfSOuyw6zRpdGl9afZ
X-Gm-Gg: Acq92OHKUk6ejM+7jV+TxtVJRne1Vt5nX5mxFJHFt2RDCyaBo5vqv/b463PcKPiotpA
	AFXNBr9LIRP0Lt3xXxcq9gGYAsIQQkhjsRyWXQK770xAnVKubdiLfqkisQ35nHCXxocbenj6jxn
	/rYCU3eKgHK4qHY9wUtS8qh+8Gk+f06Ek8mgW3TUyjtCXD/NHF+lL8eHbxcGRQ1vN4UNldZ5uBR
	YNhLuH9kh/J8plM76phdnthAPkGAvAqwp+3YsrTpNKuRDNsI9BNzrg+2I1wCXWYMn0UvcjIzx6+
	CwUSiL7d3fc4DV+u6A==
X-Received: by 2002:a17:902:cf4c:b0:2b7:88d8:efde with SMTP id
 d9443c01a7336-2ba78f4e986mr89794045ad.7.1778187467778; Thu, 07 May 2026
 13:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507191416.2984054-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-1-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 May 2026 16:57:35 -0400
X-Gm-Features: AVHnY4JwRLAedFRfQ7q22oAcPpo0Tq1zBBEQ_RXTzWDidOJW2m8V1gD0lHHMSSw
Message-ID: <CAHC9VhR0Abikk+2=DWtVu1cEkcwkudKFRJH51BFOh0Qt01wLJw@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] Reintroduce Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, linux-crypto@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 3:14=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This patch series introduces the next iteration of the Hornet LSM.
> Hornet=E2=80=99s goal is to provide a secure and extensible in-kernel
> signature verification mechanism for eBPF programs.
>
> Hornet addresses concerns from users who require strict audit trails and
> verification guarantees for eBPF programs, especially in
> security-sensitive environments. Many production systems need assurance
> that only authorized, unmodified eBPF programs are loaded into the
> kernel. Hornet provides this assurance through cryptographic signature
> verification.
>
> The currently accepted loader-plus-map signature verification scheme,
> mandated by Alexei and KP, is simple to implement and generally
> acceptable if users and administrators are satisfied with it. However,
> verifying both the loader and the maps offers additional benefits
> beyond verifying the loader alone:
>
> 1. Security and Audit Integrity
>
> A key advantage is that the LSM hook for authorizing BPF program loads
> can operate after signature verification. This ensures:
>
> * Access control decisions are based on verified signature status.
> * Accurate system state measurement and logging.
> * Log entries claiming a verified signature are truthful, avoiding
>   misleading records where only the loader was verified while the actual
>   BPF program verification occurs later without logging.
>
> 2. TOCTOU Attack Prevention
>
> The current map hash implementation may be vulnerable to a TOCTOU
> attack because it allows unfrozen maps to cache a previously
> calculated hash. The accepted =E2=80=9Ctrusted loader=E2=80=9D scheme can=
not detect
> this and may permit loading altered maps.
>
> 3. Supply Chain Integrity
>
> Verify that eBPF programs and their associated map data have not been
> modified since they were built and signed, in the kernel proper, may
> aid in protecting against supply chain attacks.
>
> This approach addresses concerns from users who require strict audit
> trails and verification guarantees, especially in security-sensitive
> environments. Map hashes for extended verification are passed via the
> existing PKCS#7 UAPI and verified by the crypto subsystem. Hornet then
> calculates the program=E2=80=99s verification state.  Hornet itself does =
not
> enforce a policy on whether unsigned or partially signed programs
> should be rejected. It delegates that decision to downstream LSMs
> hook, making it a composable building block in a larger security
> architecture.

[NOTE: trimmed changelog for brevity]

> Blaise Boscaccy (6):
>   lsm: security: Add additional enum values for bpf integrity checks
>   security: Hornet LSM
>   hornet: Introduce gen_sig
>   hornet: Add a light skeleton data extractor scripts
>   selftests/hornet: Add a selftest for the Hornet LSM
>   ipe: Add BPF program load policy enforcement via Hornet integration
>
> James Bottomley (3):
>   crypto: pkcs7: add flag for validated trust on a signed info block
>   crypto: pkcs7: add ability to extract signed attributes by OID
>   crypto: pkcs7: add tests for pkcs7_get_authattr
>
> Paul Moore (1):
>   lsm: framework for BPF integrity verification
>
>  Documentation/admin-guide/LSM/Hornet.rst     | 323 +++++++++++++++
>  Documentation/admin-guide/LSM/index.rst      |   1 +
>  Documentation/admin-guide/LSM/ipe.rst        | 162 +++++++-
>  Documentation/security/ipe.rst               |  68 ++++
>  MAINTAINERS                                  |   9 +
>  certs/system_keyring.c                       |   1 +
>  crypto/asymmetric_keys/Makefile              |   4 +-
>  crypto/asymmetric_keys/pkcs7_aa.asn1         |  18 +
>  crypto/asymmetric_keys/pkcs7_key_type.c      |  44 +-
>  crypto/asymmetric_keys/pkcs7_parser.c        |  81 ++++
>  crypto/asymmetric_keys/pkcs7_parser.h        |   1 +
>  crypto/asymmetric_keys/pkcs7_trust.c         |   1 +
>  include/crypto/pkcs7.h                       |   4 +
>  include/linux/lsm_hook_defs.h                |   5 +
>  include/linux/oid_registry.h                 |   3 +
>  include/linux/security.h                     |  28 ++
>  include/uapi/linux/lsm.h                     |   1 +
>  scripts/Makefile                             |   1 +
>  scripts/hornet/Makefile                      |   5 +
>  scripts/hornet/extract-insn.sh               |  27 ++
>  scripts/hornet/extract-map.sh                |  27 ++
>  scripts/hornet/extract-skel.sh               |  27 ++
>  scripts/hornet/gen_sig.c                     | 401 +++++++++++++++++++
>  scripts/hornet/write-sig.sh                  |  27 ++
>  security/Kconfig                             |   3 +-
>  security/Makefile                            |   1 +
>  security/hornet/Kconfig                      |  13 +
>  security/hornet/Makefile                     |   7 +
>  security/hornet/hornet.asn1                  |  12 +
>  security/hornet/hornet_lsm.c                 | 352 ++++++++++++++++
>  security/ipe/Kconfig                         |  15 +
>  security/ipe/audit.c                         |  15 +
>  security/ipe/eval.c                          |  93 ++++-
>  security/ipe/eval.h                          |  11 +
>  security/ipe/hooks.c                         |  63 +++
>  security/ipe/hooks.h                         |  15 +
>  security/ipe/ipe.c                           |  14 +
>  security/ipe/ipe.h                           |   3 +
>  security/ipe/policy.h                        |  14 +
>  security/ipe/policy_parser.c                 |  27 ++
>  security/security.c                          |  75 +++-
>  tools/testing/selftests/Makefile             |   1 +
>  tools/testing/selftests/hornet/Makefile      |  63 +++
>  tools/testing/selftests/hornet/loader.c      |  21 +
>  tools/testing/selftests/hornet/trivial.bpf.c |  33 ++
>  45 files changed, 2112 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1
>  create mode 100644 scripts/hornet/Makefile
>  create mode 100755 scripts/hornet/extract-insn.sh
>  create mode 100755 scripts/hornet/extract-map.sh
>  create mode 100755 scripts/hornet/extract-skel.sh
>  create mode 100644 scripts/hornet/gen_sig.c
>  create mode 100755 scripts/hornet/write-sig.sh
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet.asn1
>  create mode 100644 security/hornet/hornet_lsm.c
>  create mode 100644 tools/testing/selftests/hornet/Makefile
>  create mode 100644 tools/testing/selftests/hornet/loader.c
>  create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

[NOTE: added the linux-crypto list to the To/CC lines]

Hi crypto folks,

You'll notice there are three patches from James Bottomley in this
patchset that touch crypto code and I'd appreciate it if you could
take a look and either ACK the patches or let James and Blaise know
what you would like changed.  James did send these patches to you for
review some time ago, so they aren't necessarily new, but I wanted to
make sure you saw them again.

Unfortunately, it doesn't look like the crypto list was CC'd on this
patchset, so here is a lore link to the patchset as a whole:

https://lore.kernel.org/linux-security-module/20260507191416.2984054-1-bbos=
caccy@linux.microsoft.com

... and here are lore links to the three crypto patches:

https://lore.kernel.org/linux-security-module/20260507191416.2984054-2-bbos=
caccy@linux.microsoft.com

https://lore.kernel.org/linux-security-module/20260507191416.2984054-3-bbos=
caccy@linux.microsoft.com

https://lore.kernel.org/linux-security-module/20260507191416.2984054-4-bbos=
caccy@linux.microsoft.com

Thanks.

--=20
paul-moore.com
