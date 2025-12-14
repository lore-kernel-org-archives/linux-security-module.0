Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B13597B
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765676358; cv=none; b=iFfrdnR+cbifWL0GSswt6gGJD/VJkEd5XxC6Eo7Aw9nn1G+FCguT7PapkcPVK8AI6x2cm49gdu4yDKGPxSVXVngZOjMxs/7y2VdICOK9sR9mJ12bRXyBaMN42VpOrIu8cAz9xy1CciertuiAhWHmkAifJViQKKST/EPye7hWTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765676358; c=relaxed/simple;
	bh=jGOE+IFMdmfa/5DA5Ptrqap/5EoUnr6WZZO2GI1lO1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZnMtZDoHvRreQMIiZCmXPgDT8cbyefxVlYRrNtDpYAGINsUziZhbfBzpgxTeO9TlIZkpoPlgwTx9MaDpgS2PUP6DDI6ccaZu33O56M6gTd2Ma3h7gMvqqtsgQmFIiSYGnEL8MsL3ylmPtlc3AeFI3XYMIppW0PtmcfNC4KMgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=Eh8S5WVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xl0sG/xF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="Eh8S5WVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xl0sG/xF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18EA6140016D;
	Sat, 13 Dec 2025 20:39:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 13 Dec 2025 20:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765676354; x=1765762754; bh=g6apQ7pWRB
	Mb6t9l0bnK4fjB4mp8nOnknXJK5EBBqN4=; b=Eh8S5WVIV0x/sWbvXaASqNgqGB
	Pu4D613O+F0eXs8r+C0XfG0qtj+rmaisVs5jX8mTpKNYb1LarLM1xrIQzoh032bt
	qGmIvxE+TgBvp53oKISyr8OU3hueYovrK/EHGNeb3Y00BZRZF3F3KF41diDrS4Yo
	vdEMIlumsRF0wkT2Skp3ZEFwymjrHgIHbvo3OGTBjvXlSKB7YrIa7u0xDdRi9J11
	fZbx41Yz0uC+5eJcleDgs8/snB00gni6beKFmJ6ufi5T7LZEQrD/6mUHijLM6NVb
	zGHNglQ5+2yREp4hWDLt4F30B5DzTrt1cINjVVWY6RHAU68Y5q5TYpW9cXaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765676354; x=1765762754; bh=g6apQ7pWRBMb6t9l0bnK4fjB4mp8nOnknXJ
	K5EBBqN4=; b=xl0sG/xFgz0UMY+xYo4zH/Ym6hVo83oYE63v0g2pBDGWuQG5oD4
	x7U6f0+tapOOu8u78ZibTbbbeVErFv6zjWTY+c8QF5sie8LVLdYb3aQ7oX1K0Hu5
	HLObhcdZ5Ro+6kL724whLWvsDM4hC1AkXJffLZXSKnflSvvtyRNaFc81t2EJOokK
	dOr8dEtePQZo2/gdZRNNJuKGWa1qzLmNdxAIdqYqs1W6EzUMsGEs2JRsuQniIWLg
	ho4+PXxo3JFlHwqAsRnRIQbXg5rnJ7ozEGYBAF5TC7Q6mdHzJ1tfDpGmBHnMzMuf
	94O387bmqjM9zSR9obWkB7NVPH5jZX2NL6Q==
X-ME-Sender: <xms:QRU-aTlEu0uae0n7P5RhihngBKC5AG-fbUn7gIQlY5WD-bjCKlfMeA>
    <xme:QRU-aUpQs6mlDUCTcf805VXXE9c8yMwToOfCZI2z6Pk4-B9_mRbMrvXEciXmqbdDO
    ct09frnbAmVm8jMjllpyQAi-hOP6CioecwktXXGM8MQdbBRpy_zCw>
X-ME-Received: <xmr:QRU-aUHh9DgdTDGlAAP191Asjm0NsvKFdeGqjspkpA1Iw7XkpCtOIZ6wXu8Q9DHkyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepteehvedugf
    ejgfehhfeijeduleekleejgedvkeeuuefhhfegvdevfeetveegteeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrih
    hspdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
    vghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgrnhgulhhotg
    hksehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepuggvvhgvlhesshhpvggt
    thhruhhmqdhoshdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QRU-aYycJpe3aR7jJHX270qSiCaf0QSubgMeE6eKuvT8i2U_i72mJA>
    <xmx:QRU-aRqDEU236SsrMrSS5HFpjUt1UbditAu0UJPVztf25RfhXCK02g>
    <xmx:QRU-aagUYw8Jjw6fXcALfjDgIoXovCL1EjC5CRa6xwYse_TaHTpkNA>
    <xmx:QRU-aWhOse_RTTv7YUEgKyZpnLF4YOT15Pk-90aPaeVOcGjtnoORiA>
    <xmx:QhU-acK6j_IPvuM9qqaQu1gx7rZHxXtsh851_Fo5EReDywZaBclBEhcm>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Dec 2025 20:39:13 -0500 (EST)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id A18257BF7028; Sun, 14 Dec 2025 02:39:01 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Spectrum OS Development <devel@spectrum-os.org>,
 linux-security-module@vger.kernel.org, landlock@lists.linux.dev
Subject: Re: [PATCH] host/roots: Sandbox xdg-desktop-portal-spectrum-host
In-Reply-To: <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
References: <20251212-sandbox-dbus-portal-v1-1-522705202482@gmail.com>
 <87o6o25h6y.fsf@alyssa.is>
 <cfab1f24-65ad-40ed-b4a6-17f0aad8dc60@gmail.com>
 <87ikea5a8x.fsf@alyssa.is>
 <00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com>
Date: Sun, 14 Dec 2025 02:39:00 +0100
Message-ID: <87bjk16dvv.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Demi Marie Obenour <demiobenour@gmail.com> writes:

> On 12/13/25 16:42, Alyssa Ross wrote:
>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>=20
>>> On 12/13/25 14:12, Alyssa Ross wrote:
>>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>>
>>>>> It is quite possible that these Landlock rules are unnecessarily
>>>>> permissive, but all of the paths to which read and execute access is
>>>>> granted are part of the root filesystem and therefore assumed to be
>>>>> public knowledge.  Removing access from any of them would only increa=
se
>>>>> the risk of accidental breakage in the future, and would not provide =
any
>>>>> security improvements.  seccomp *could* provide some improvements, but
>>>>> the effort needed is too high for now.
>>>>>
>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
>>>>> ---
>>>>>  .../template/data/service/xdg-desktop-portal-spectrum-host/run    | =
8 ++++++++
>>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> Are you sure this is working as intended?  There's no rule allowing
>>>> access to Cloud Hypervisor's VSOCK socket, and yet it still seems to be
>>>> able to access that.  Don't you need to set a rule that *restricts*
>>>> filesystem access and then add holes?  Did you ever see this deny
>>>> anything?
>>>
>>> 'man 1 setpriv' states that '--landlock-access fs' blocks all
>>> filesystem access unless a subsequent --landlock-rule permits it.
>>> I tried running with no --landlock-rule flags and the execve of
>>> xdg-desktop-portal-spectrum-host failed as expected.
>>>
>>> The socket is passed over stdin, and I'm pretty sure Landlock
>>> doesn't restrict using an already-open file descriptor.
>>> xdg-desktop-portal-spectrum-host does need to find the path to the
>>> socket, but I don't think it ever accesses that path.
>>=20
>> I've been looking into this a bit myself, and from what I can tell
>> Landlock just doesn't restrict connecting to sockets at all, even if
>> they're inside directories that would otherwise be inaccessible.  It's
>> able to connect to both Cloud Hypervisor's VSOCK socket and the D-Bus
>> socket even with a maximally restrictive landlock rule.  So you were
>> right after all, sorry!
>
> That's not good at all!  It's a trivial sandbox escape in so many cases.
> For instance, with access to D-Bus I can just call `systemd-run`.
>
> I'm CCing the Landlock and LSM mailing lists because if you are
> correct, then this is a bad security hole.

I don't find it that surprising given the way landlock works.  "connect"
(to a non-abstract AF_UNIX socket) is not an operation there's a
landlock action for, and it's not like the other actions care about
access to parent directories and the like =E2=80=94 I was able to execute a
program via a symlink after only giving access to the symlink's target,
without any access to the directory containing the symlink or the
symlink itself, for example.  Landlock, as I understand it, is intended
to block a specified set of operations (on particular file hierarchies),
rather than to completely prevent access to those hierarchies like
permissions or mount namespaces could, so the lack of a way to block
connecting to a socket is more of a missing feature than a security
hole.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCaT4VNAAKCRCZddwkt31p
Ffm0AQD2qoNzppzGETkXMLFjf/33Wi7iKAztg9FdW8bZmIo35gEA1HCAAUP/jLqJ
C6GXrQcFpqGOt1+FV8hIy5TT4WPclA8=
=QGE6
-----END PGP SIGNATURE-----
--=-=-=--
