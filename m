Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D078C11
	for <linux-security-module@vger.kernel.org>; Wed,  4 Jun 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023278; cv=none; b=dh+cUrmbil+BYOiR4EJWU95p6kRLKutIp2nq5eEbTzA96DtD8uMHYNr4+QmKME1bX/QHSLMx+qrnIM/3r7TZTrHOjttitr8Vuo5sBGv9tkNw+ukCkWYjejKcc3RDLCLHmpK16Q8GYrqfEG6JCj+lYBsUvnCY71ZlBDFIgdX0qNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023278; c=relaxed/simple;
	bh=whTGbpBhBW/OOhveb/cO0KpcvU/mc2vIZTt6J7B3EAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G++xwNYOr5Uun4BnJZNck4xKP9hE/HvKJ87H6IeEVNnb7FNLmVXcfAthV6xRA2CZCqQKgzrQvMm+ngKLe3AzItKyzSjAweMbGVRIUAFDsXCy93NVovrAIQq99Tym3E6zKBuDeouUqJOqkk5mT0ocaeIxMyNkYPgmaB8hq411MoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-yTeT7kvxO0C6pPsgHtShAg-1; Wed, 04 Jun 2025 03:47:52 -0400
X-MC-Unique: yTeT7kvxO0C6pPsgHtShAg-1
X-Mimecast-MFC-AGG-ID: yTeT7kvxO0C6pPsgHtShAg_1749023272
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451deff247cso2942695e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Jun 2025 00:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749023271; x=1749628071;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ygmWQWXbYd84BZ22kC3DM6odLW06NCGE4pAVf3jq5k=;
        b=rpUAXU4Ok0fllXh1oTHt/rGMtqSWaTM0TgpfflBm0C88xPRFb6KLjd+NLyTUWSuxgu
         6UkOXjod+7jWEYyb9z00nfDYslj9J2lQgOMOgPRCxilxPPOtiRCOE6OB+1BT15ax4qBR
         KDK0aEl8k5ghkJI6DKSJnkkd0wBe86m/v60k1+OIZPfjIUJcRCjfvBk/Hc1G9M4tpz9C
         gno/EHxZMGvDtiJRLZEVWgz+qlSUbZWmoiGQ3pbFnImf/Ajmed3jnm8P+b4FpHAQTBP9
         22bKw95oipeo86AZ++oj27W0Qshf2dQYK/q8XpIG0/ipHyMNDD5L0gSg35wSbcEXLYu+
         9iog==
X-Forwarded-Encrypted: i=1; AJvYcCX8+XNVMlSiAhLt1WozerYYy19bLMLM2nEInjhwkQYr3/6R8lvu9sHw5m641JjTPzqxwRxgxM+AABqAYSmkouec1bLCnCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JIf34E9trB8NEpUYA9Q/k3Vm5y+icFLFr47gej3OQzXhMORP
	yFdg8NT4pRhQlm6G9fxh3DkWqDopUZh4n9qsfbcP2xL5Gdi3sVsB/tE/BAGQ3DEU9FqJlVzj2SZ
	MbYwb765i4edUQWkVXxTGemY7Yotolv4gq3TJa3JcJGLS1XhewkMz+fS5wUsPSL9q1IuMByEElW
	Gr2w==
X-Gm-Gg: ASbGnctU7BlNYSQOdtu4KaLOkYcqzk6cVxtxD43ozf1HpoUV5XR03kkIpnCkHGgieut
	nwx1ziATxIjZ9wmFFaTNLf4dbKA53n4rm367km/tYp0QdIojmISL11n75t0TSs8a09AgJPVMrNE
	P5cHo0KsJN4PbpfvHD+cactcV/pxJwdL6A4pE/UfT2Tb4tz6N48WfC3dQArvSmgVanDHZpe0h1j
	mEnoFiKBN4qBVQHqPqZgdkU8H9050Xv3um30W++iLG5mph4goiKfcB65DTj90KuyvbBUGnxns7e
	+fCd6nc=
X-Received: by 2002:a05:600c:4f46:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-451efeb62edmr16204915e9.13.1749023271476;
        Wed, 04 Jun 2025 00:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJk55eb8TjJoA47+XoMh9gAce9YiEwRtdQfUP3XiuiMssBNBDp3zfR4HUA5bIORLwXMaPKeQ==
X-Received: by 2002:a05:600c:4f46:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-451efeb62edmr16204515e9.13.1749023270973;
        Wed, 04 Jun 2025 00:47:50 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d8csm188712405e9.24.2025.06.04.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 00:47:50 -0700 (PDT)
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
In-Reply-To: <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <20250602132535.897944-2-vkuznets@redhat.com>
 <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
 <87r001yzob.fsf@redhat.com>
 <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>
Date: Wed, 04 Jun 2025 09:47:48 +0200
Message-ID: <8734cgosm3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RCn9pwYaOi-9PjYGU4ytBObG9qPWNVFUPyBytpnDw-Y_1749023272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Tue, 2025-06-03 at 10:52 +0200, Vitaly Kuznetsov wrote:
>> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> [...]
>> > Also, are you sure a config option is the right thing?=C2=A0 Presumabl=
y
>> > Red Hat wants to limit its number of kernels and the design of just
>> > linking the machine keyring (i.e. MoK) was for the use case where
>> > trust is being pivoted away from db by shim, so users don't want to
>> > trust the db keys they don't control.=C2=A0 If the same kernel gets us=
ed
>> > for both situations (trusted and untrusted db) you might want a
>> > runtime means to distinguish them.
>>=20
>> I was not personally involved when RH put the patch downstream (and
>> wasn't very successful in getting the background story) but it
>> doesn't even have an additional Kconfig, e.g.:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/co=
mmit/03d4694fa6511132989bac0da11fa677ea5d29f6
>> so apparently there's no desire to limit anything, basically,
>> .platform is always trusted on Fedora/RHEL systems (for a long time
>> already).
>
> It sounds like that's just distro politics:  RH wants to enable binary
> modules (by allowing them to be signed) but doesn't want to be seen to
> be signing them (so they can't be signed with the embedded RH key) so
> that gamers can have performant graphics drivers and the like.  Thus it
> mixes in the db keyring, which usually contains several Microsoft
> certificates and also one from the ODM manufacturer, so now it can send
> would be shippers of binary modules to those groups to get them signed.
> If you only have the built in and MoK keyrings, the only possible
> signers are either RH or the machine owner ... who isn't a single
> entity to deal with.  Personally I think this is a bit daft: Debian
> manages an out of tree module infrastructure using DKMS and MoK
> signing, so I can't see why RH can't get it to work in the same way.
>

I guess such approach can be used with some limitations: the out-of-tree
module must be open source, the vendor of the module must commit to
fixing (inevitable) module build issues when the distro updates its
kernel and so on. It, however, doesn't help the users which want to
build and sign their own modules themselves.

>> As part of the RFC, I'd like to try to understand under which
>> conditions people may not want to trust 'db'. In the most common use
>> case, 'db' is used to authorize shim and the kernel is signed by a
>> cert from shim's vendor_db, not trusting 'db' for modules after that
>> seems somawhat silly. Maybe we can detect the fact that the user took
>> control over the system with MOK and untrust .platform only then
>> (while trusting it by default)?
>
> Well, I think it's pretty obvious that in a standard secure boot system
> most people wouldn't want either Microsoft or the ODM manufacturer
> being in a position to sign module code for their systems.  Indeed,
> when this was first mooted by Red Hat years ago, I thought Microsoft
> refused to be the CA for our modules anyway.  From a security point of
> view, it's separation of concerns: the standard secure boot database
> guards access to the UEFI boot time before ExitBootServices.  The
> kernel is a completely separate security domain and should be guarded
> by different keys.
>
>> A runtime toggle is not something I thought much about: the sole
>> purpose of this part of 'lockdown' (limitimg unsigned modules load)
>> seems to be to prevent someone who already has 'root' on the system
>> to gain kernel level access to e.g. hide its activities. In case root
>> can decide which keys are trusted, isn't it all in vain?
>
> Not exactly, the purpose of lockdown is to make root less privileged
> than ring 0 (the kernel), so that a user space privilege escalation
> does less damage.  The gold standard for all of this is supposed to be
> to foil an Evil Maid attack (physical access) but I don't think we're
> quite there yet.  From the point of view of the keyrings a lot of
> others (like .ima) have trusted signing requirements meaning root can't
> simply add keys, they have to be signed by keys in the existing trusted
> keyring as well.
>
>>  Or maybe if the toggle is to just trust/not trust .platform (and not
>> e.g. disable signatures verification completely, inject a new
>> key,...) this is acceptable? Another option is to have a kernel
>> command line parameter but this is complicated for users.
>
> I was thinking that if the goal is simply to enable cloud db then the
> toggle could be detecting the presence of the MoK variables.  However,
> if the distro politics thought above is correct, that won't work for
> the RH use case of enabling additional binary modules by getting others
> to sign them.  Until we have UKI signing of the kernel command line,
> it's not such a safe vector to use for switches like this because it
> makes the Evil Maid problem worse (and they're hard for users to manage
> anyway as you say).

(FWIW, RH-signed UKI is already present in RHEL/Fedora/derivatives along
with a set of good known UKI cmdline extentions ('fips=3D1',
'crashkernel=3D...',...) so adding e.g. 'platform_is_trusted=3D1' extension
*is* possible).

So if we consider trusting/not trusing platform to be a distro choice
("politics"), then I guess the suggested Kconfig approach may make
sense? I, however, quite like the idea to complement it with an
automatic toggle based on the MOK status: we can make the Kconfig a
tristate:
- Platform is never trusted (current approach)
- Platform is always trusted
- Platform is trused when MOK is not used
To me, this third option makes sense: if a user wants to take ownership
over the system, they can use MOK and sign the kernel itself and/or
out-of-tree modules with it. If the user doesn't care, then there's no
reason to not trust 'db'.

--=20
Vitaly

