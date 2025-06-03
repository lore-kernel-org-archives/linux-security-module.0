Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328A1917ED
	for <linux-security-module@vger.kernel.org>; Tue,  3 Jun 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940780; cv=none; b=Otxay+cJaU8BqpxnkLXoSxn0SJyP1TzCe2VEwznb6UXs4i2JpGJnLKLXhQ9Esd4ljIwJSleJA8E2ehUbxcrkLPP2qOPgD81v+3vfI/80ZCnUufeE0Ec6PuYM1JAX8lntb/ETx21oUjvOue03PxSOOoGTqG62JC+bkZjdMVBrcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940780; c=relaxed/simple;
	bh=bykTWvbWw8qTEyfrEVK4yCpmPA2NXTZ774cLYmsrnVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Klj97mqGciu49Ro7SE2mRrAiQ5iRlk0Et9eyVObXpSVriAuH1Du8DRzYe12Qot2xu7cUDPA8ssJwqKhiPwg5VtQePa/DQNZKXGDESKvVTRziUnyQpSW7SqE5oqKEWWqPegxEjieHeq/6IYoeqF/Qn/RgndGviuKkQdrvXMxL0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y85iQR0I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y85iQR0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748940777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Jb42iny1TsT8wfDOY7u3cam0NzD7GcI+3SZQa6vB0U=;
	b=Y85iQR0I3jZ9RXdr02kPqzZLFcyuP+Rj+8Kz7fyvIaJZTB385pGpwMsWZpYtjtow0elbJ9
	F5K4fcvp5ZN4S1ygUXGKKs8i8tSUYdtOnUa5EUXP26Ko4WVj7BXRqGECnIxUW1sW7vCpW6
	LMfzuK13S+qWIal2zyDi02YnyxwwoFY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-wEXhg_TBNM-gXuhnyzCKmg-1; Tue, 03 Jun 2025 04:52:56 -0400
X-MC-Unique: wEXhg_TBNM-gXuhnyzCKmg-1
X-Mimecast-MFC-AGG-ID: wEXhg_TBNM-gXuhnyzCKmg_1748940775
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451e24dfe1dso8088105e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Jun 2025 01:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748940775; x=1749545575;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fokWVoE1/UZZzyISn1y7Db8mSF3EnEdFgZvjp1rn9Hg=;
        b=wVwUmbZFKEq8WbxSxNjtpdKI702ZygxvB6vzvamUqMLWhsC5HKFwuhkXLDI2JYV2EQ
         WfP25kAH8pfMelbmbhJG5Y6U8gCvGOUlIiynDXyiiMOBtT2wL5Rh0qsEtc8bFLC4G7Jf
         bKsCHA7c2gxllF+ETPgjF7uSrXxWt17kN6L00PtU51DR5UJTkK8MBMhH+FMdnhniqGBw
         tuTM9q2ZxRgxlmyUpWfkQMJ61ATtl7f4XufleH2bj0RSi2NmCcotdwgCONC4MeAn/L2O
         R260TfbsSApJVCiZdltf8UEQ29vNlVwfRn2Q5HBPSNSEGS7QupXFDCQLUoCzqnLOGch8
         QAGA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqr9EgaaXEBXJy3sOHBAzTX1+QrF8QXKHNSablqlDSrIedI5dff5UYHfJkbF6yWX+0QeDjNS00BWvgKoYAmTiqB9axGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/Q+vUS2eVNhq86QnH8U4r93DWYvNRZwatiHMcUS+sbepapMX
	q0TYhNvnArfac3x70H2DeFJMF0frqnDuCi7co7eIPbY6gDaNMWuTJAiEA7dt9FImkWWe6AaDZ2M
	obuwd3DtU2roZlYEcfggMpEpV2sYtPAdt+jvxbKHdq2LlwgsvdoKCuKtvj9av/rgQdtOUoNimAs
	yz8Q==
X-Gm-Gg: ASbGncvBkPSF7r3Ni4NEN5SO6cWNEAF6Bk9jOpW8w7ck9QvP2mf9ZFes1La0wbdCqrE
	o48GK6v88Ay3jRyvH+1qbDvdlp4mMKSDcpaBB4vyOea9kq6e8B/q61keo06iH6C6+N7pX95EXNs
	0dAMBm0lacn1GY1BNoQ2nKKOet29aqG3Jzhrhj+my9+Ij1lOo+kHcO9hh5A7l8c16SJWfvLR4gS
	iykFp0FCZb8bkcv2S0EOp4YCUsvMC2H1IVZ9KI4RUe05BYPUcN6tL9u+NjDIi1jvd7c5jdThfVI
	G08xo4w=
X-Received: by 2002:a5d:5f50:0:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a4f89a47a7mr12821658f8f.1.1748940774711;
        Tue, 03 Jun 2025 01:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGEHrNubrNeaL99rs9CvcijC7m6ROFlnCc2yKxqiTtySjgF89euRWCZceONTzwb++Fm8VsBg==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d994:be4b with SMTP id ffacd0b85a97d-3a4f89a47a7mr12821635f8f.1.1748940774311;
        Tue, 03 Jun 2025 01:52:54 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c842sm17289467f8f.29.2025.06.03.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 01:52:53 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Jones <pjones@redhat.com>, Robert Holmes
 <robeholmes@gmail.com>, Jeremy Cline <jcline@redhat.com>, Coiby Xu
 <coxu@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 1/1] module: Make use of platform keyring for module
 signature verify
In-Reply-To: <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <20250602132535.897944-2-vkuznets@redhat.com>
 <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
Date: Tue, 03 Jun 2025 10:52:52 +0200
Message-ID: <87r001yzob.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2rPuAtWUxYjQIiLZhEcvC4JFIahhc3P79tWJKbtCAb8_1748940775
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Mon, 2025-06-02 at 15:25 +0200, Vitaly Kuznetsov wrote:
>> This patch complements commit 278311e417be ("kexec, KEYS: Make use of
>> platform keyring for signature verify") and commit 6fce1f40e951
>> ("dm verity: add support for signature verification with platform
>> keyring")
>> and allows for signing modules using keys from SecureBoot 'db'. This
>> may
>> come handy when the user has control over it, e.g. in a virtualized
>> or a
>> cloud environment.
>>=20
>> Suggested-by: Robert Holmes <robeholmes@gmail.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> =C2=A0Documentation/admin-guide/module-signing.rst |=C2=A0 6 ++++++
>> =C2=A0kernel/module/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 11 +++++++++++
>> =C2=A0kernel/module/signing.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 9 ++++++++-
>> =C2=A0security/integrity/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
>> =C2=A04 files changed, 26 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/admin-guide/module-signing.rst
>> b/Documentation/admin-guide/module-signing.rst
>> index a8667a777490..44ed93e586b9 100644
>> --- a/Documentation/admin-guide/module-signing.rst
>> +++ b/Documentation/admin-guide/module-signing.rst
>> @@ -118,6 +118,12 @@ This has a number of options available:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 additional certificates which will be inc=
luded in the system
>> keyring by
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default.
>> =C2=A0
>> + (5) :menuselection:`Use .platform keyring for verifying kernel
>> modules signatures`
>> +=C2=A0=C2=A0=C2=A0=C2=A0 (``CONFIG_MODULE_SIG_PLATFORM``)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 This option additionally allows modules to be =
signed with a key
>> present
>> +=C2=A0=C2=A0=C2=A0=C2=A0 in ``.platform`` keyring, e.g. a SecureBoot 'd=
b' key.
>> +
>> =C2=A0Note that enabling module signing adds a dependency on the OpenSSL
>> devel
>> =C2=A0packages to the kernel build processes for the tool that does the
>> signing.
>> =C2=A0
>> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
>> index 39278737bb68..f1b85c14548a 100644
>> --- a/kernel/module/Kconfig
>> +++ b/kernel/module/Kconfig
>> @@ -340,6 +340,17 @@ config MODULE_SIG_HASH
>> =C2=A0=09default "sha3-384" if MODULE_SIG_SHA3_384
>> =C2=A0=09default "sha3-512" if MODULE_SIG_SHA3_512
>> =C2=A0
>> +config MODULE_SIG_PLATFORM
>> +=09bool "Use .platform keyring for verifying kernel modules
>> signatures"
>> +=09depends on INTEGRITY_PLATFORM_KEYRING
>> +=09depends on MODULE_SIG
>> +=09help
>> +=09=C2=A0 When selected, keys from .platform keyring can be used for
>> verifying
>> +=09=C2=A0 modules signatures. In particular, this allows to use UEFI
>> SecureBoot
>> +=09=C2=A0 'db' for verification.
>> +
>> +=09=C2=A0 If unsure, say N.
>> +
>> =C2=A0config MODULE_COMPRESS
>> =C2=A0=09bool "Module compression"
>> =C2=A0=09help
>> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
>> index a2ff4242e623..3327e7243211 100644
>> --- a/kernel/module/signing.c
>> +++ b/kernel/module/signing.c
>> @@ -61,10 +61,17 @@ int mod_verify_sig(const void *mod, struct
>> load_info *info)
>> =C2=A0=09modlen -=3D sig_len + sizeof(ms);
>> =C2=A0=09info->len =3D modlen;
>> =C2=A0
>> -=09return verify_pkcs7_signature(mod, modlen, mod + modlen,
>> sig_len,
>> +=09ret =3D verify_pkcs7_signature(mod, modlen, mod + modlen,
>> sig_len,
>> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERIFY_USE_SECONDARY_KE=
YRING,
>> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERIFYING_MODULE_SIGNAT=
URE,
>> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL);
>> +=09if (ret =3D=3D -ENOKEY &&
>> IS_ENABLED(CONFIG_MODULE_SIG_PLATFORM)) {
>> +=09=09ret =3D verify_pkcs7_signature(mod, modlen, mod +
>> modlen, sig_len,
>> +=09=09=09=09VERIFY_USE_PLATFORM_KEYRING,
>> +=09=09=09=09VERIFYING_MODULE_SIGNATURE,
>> +=09=09=09=09NULL, NULL);
>> +=09}
>> +=09return ret;
>> =C2=A0}
>
> I don't think this is the correct way to do it.  If, as you say, db is
> controlled by the end user and therefore has trusted contents, then I
> think you want to update certs/system_keyring.c to link the platform
> keyring into the secondary trusted one (like it does today for the
> machine keyring), so it can be used by *every* application that checks
> keyrings rather than just modules.

Yea, that would be the solution I allude to at the end of my cover
letter: make .platform globally trusted so we don't need the 'trusted
for kexec', 'trusted for dm-verity' zoo we already have.

>
> Also, are you sure a config option is the right thing?  Presumably Red
> Hat wants to limit its number of kernels and the design of just linking
> the machine keyring (i.e. MoK) was for the use case where trust is
> being pivoted away from db by shim, so users don't want to trust the db
> keys they don't control.  If the same kernel gets used for both
> situations (trusted and untrusted db) you might want a runtime means to
> distinguish them.

I was not personally involved when RH put the patch downstream (and
wasn't very successful in getting the background story) but it doesn't
even have an additional Kconfig, e.g.:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/commi=
t/03d4694fa6511132989bac0da11fa677ea5d29f6
so apparently there's no desire to limit anything, basically, .platform
is always trusted on Fedora/RHEL systems (for a long time already).

As part of the RFC, I'd like to try to understand under which conditions
people may not want to trust 'db'. In the most common use case, 'db' is
used to authorize shim and the kernel is signed by a cert from shim's
vendor_db, not trusting 'db' for modules after that seems somawhat
silly. Maybe we can detect the fact that the user took control over the
system with MOK and untrust .platform only then (while trusting it by
default)?

A runtime toggle is not something I thought much about: the sole purpose
of this part of 'lockdown' (limitimg unsigned modules load) seems to be
to prevent someone who already has 'root' on the system to gain kernel
level access to e.g. hide its activities. In case root can decide which
keys are trusted, isn't it all in vain? Or maybe if the toggle is to
just trust/not trust .platform (and not e.g. disable signatures
verification completely, inject a new key,...) this is acceptable?
Another option is to have a kernel command line parameter but this is
complicated for users.

--=20
Vitaly

