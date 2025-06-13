Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E2132111
	for <linux-security-module@vger.kernel.org>; Fri, 13 Jun 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836040; cv=none; b=KNsc0zv/HVQh9a6mQ4HFEuetElDpxmkTYfLc2OlLzQeRmF8HpL+2oxtihp9vjn1yuaNRBsShaPawf5oR7GbVyhERle6SyfO7ATD4TjSuFW8FOGyngNjqCP/6o252Q5ox5FO9zi9M3BJqlYabX/8WhQ3p3b62Bs/IYzEBjZzR2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836040; c=relaxed/simple;
	bh=Fsmd/OynqYi+2X+eZIkhZcMjAjmYuRs7XyREgNHQA98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwREc2ZMfdbWEFrccJ4B8d6B62FlpFGHEVM7+1o4Otm2svVrbDZJHkmOG4Kp9r8pMu1XLxCp+ObxTTmrtnJed5TsVa9FeiygdVtOqDZtlihhzf8g9PsVkQiBtqPGZD9XfbuIRzohSD5hFrF8AHK/fMeXy/OX3Two2bQzSAg9ZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVNEF8BG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVNEF8BG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749836037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVmS4EGgEnkwhO7NDVdPntY5DfSrUnrO5NX0r8I9Gzg=;
	b=cVNEF8BGNP4NJ88BAzJdvlnUzgnxF66QiJE1MgraoBD4M6JZp556Tlp9aEX4tqhwnjdlz4
	fVp6NuqvXm7ChTPraKeMjFl+4C9xiakNl5TNpAi7EiL1bVuO6xatg0hasdIAw+rJTold3c
	hNYmgpi+2i6zSz+Q7ZhqoWLJ3F4ZiyA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-w_ysVp2bMv6X8ifltDoqhg-1; Fri, 13 Jun 2025 13:33:56 -0400
X-MC-Unique: w_ysVp2bMv6X8ifltDoqhg-1
X-Mimecast-MFC-AGG-ID: w_ysVp2bMv6X8ifltDoqhg_1749836036
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d399070cecso496428885a.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jun 2025 10:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749836036; x=1750440836;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVmS4EGgEnkwhO7NDVdPntY5DfSrUnrO5NX0r8I9Gzg=;
        b=rmKPNvCeFBtmTecCWlz3bUO6xayUsYFrQQOY+29zofiHDE3zGadecUyhwDOHh1wqnm
         Y1czvml+U4ZvceXC6DngDpvCR+P5XEvmvhSm0iWsjYo7K1tbP/CCGme3ggYLxB2sz/Jv
         Dblus5PiHmFhIRmDsF7Fp+1n8dfaZVfOVGymUBNdLRlgJlmBYy5pLHLxkygcx9q+pwqW
         8m/CODOk/IlvdhecTY0HZY3va6QEvh4NyXfEfXNl6XSBpTKtn1GHM47aQh5JO2V+tVy5
         1QvoNeLSblgrotUqr9G/tEIKNzuvLI65hxZ1wcqA0Tr1TCrDpoTBa/hzPj2RFElPJbH3
         CWrg==
X-Forwarded-Encrypted: i=1; AJvYcCVBnAn8t9/CuBzvS3cg7Cjbzc6sVX4fzQOSndgtwTeR4kszgODXpDPe7MpsnkiTtEV/hhZaVFFhwIdhJX/CgBB3DWOXB+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oevTZWlmx1kygh4JqGlhP3qurOwqhUqMBVyFfnxLSCxVtHVC
	elb2oB9lOTUSsJzqWWqS4r7V1XTFqxbmZLVWKxzOBjqAnZokJ3oerpBHDWvbNtT2ZULkS22Y9+M
	6OwAit9vGEDfwuoBJZPdEbgl0mCYfJYpQogotB0J+6pK6qmvLiOzeEwdZX1IAXtMk55W4P73ZfO
	5xuA==
X-Gm-Gg: ASbGncuzRBeWu0ol2liX/WYzjpuCoRo3Z81VYAIx/PdRjtglNuWWUb9uJ00MvvZft9i
	dKcdShHvysTVDAFsz7SWkmzDvPnEpoiIGxRjnPDP3wtRRYEa0zoBAUyzQ3gYZEZSAbwcgTiESJf
	+E9Yx537U2GD4EZjSLLylVf6kAywCF8Ui5GmK4/PAVjEAtSQqRnYmNftt8dvnBn0ly2bLsj7Qu4
	KOMC73kC+SEzngfvC6Gywqc7Q5YAibC1vVHP5WX0rkwz2W354+yV0abtWXRM3/7e3hrUk87/XSB
	qEPWA5oH4KWcsnee
X-Received: by 2002:a05:620a:2448:b0:7d3:9da3:4840 with SMTP id af79cd13be357-7d3c6cebbfcmr42870485a.38.1749836036235;
        Fri, 13 Jun 2025 10:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjAs87IdqSCJ1lmVEc2pJUic+CnTFOXiehkUdG1cJmxJpjMU8c5tMJHN8cq1l3mKPRRfNkzA==
X-Received: by 2002:a05:620a:2448:b0:7d3:9da3:4840 with SMTP id af79cd13be357-7d3c6cebbfcmr42866685a.38.1749836035856;
        Fri, 13 Jun 2025 10:33:55 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::baf])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eaca83sm197229685a.60.2025.06.13.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:33:55 -0700 (PDT)
Message-ID: <de070353cc7ef2cd6ad68f899f3244917030c39b.camel@redhat.com>
Subject: Re: Module signing and post-quantum crypto public key algorithms
From: Simo Sorce <simo@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>, David Howells
 <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Stephan Mueller
	 <smueller@chronox.de>, torvalds@linux-foundation.org, Paul Moore
	 <paul@paul-moore.com>, Lukas Wunner <lukas@wunner.de>, Clemens Lang
	 <cllang@redhat.com>, David Bohannon <dbohanno@redhat.com>, Roberto Sassu
	 <roberto.sassu@huawei.com>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 13 Jun 2025 13:33:54 -0400
In-Reply-To: <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com>
References: <501216.1749826470@warthog.procyon.org.uk>
	 <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LjKxhQ0_9M_IuM5FU2sJe2zPwAk87Mi1hu3-MGn82yY_1749836036
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Premise: this problem can't be ignored, even if you think Quantum
Computers are BS, various government regulations are pushing all
commercial entities to require PQ signatures, so we have to deal with
this problem.

On Fri, 2025-06-13 at 16:21 +0100, Ignat Korchagin wrote:
> Hi David,
>=20
> On Fri, Jun 13, 2025 at 3:54=E2=80=AFPM David Howells <dhowells@redhat.co=
m> wrote:
> >=20
> > Hi,
> >=20
> > So we need to do something about the impending quantum-related obsolesc=
ence of
> > the RSA signatures that we use for module signing, kexec, BPF signing, =
IMA and
> > a bunch of other things.
>=20
> Is it that impending? At least for now it seems people are more
> concerned about quantum-safe TLS, so their communications cannot be
> decrypted later. But breaking signatures of open source modules
> probably only makes sense when there is an actual capability to break
> RSA (or ECDSA)

We do not know when Q-day (or Y2Q if you prefer) will strike, "never"
is still a possibility.

But, as a data point, IBM just announced a roadmap for a contraption
with 200 error corrected logic qubits.
That is substantial progress, so we cannot assume it will never happen,
the risk is too high (it is not me saying this, it is the cryptography
community consensus).

In terms of impending, what is pressing businesses at this time is the
CNSA 2.0 requirements, which wants software and firmware signatures to
transition to PQ algorithm in 2025 (yes this year) with complete phase
off of classic signatures by 2030 (it is an aggressive timeline, yes).

This is because a lot of the keys are embedded in HW (think Secure
Boot), so you can't wait until *after* you have a machine that can
generate forged signatures to protect your software update process.

A Quantum computer capable of breaking RSA =3D=3D you can load any code in
a kernel that uses RSA/ECC signed modules.



> We need to consider cases, for example, when a python script calls
> some binaries via system(3) or similar in a tight loop. Yes, with IMA
> we would verify only once, but still there are cases, when software
> updates happen frequently or config management "templates" the
> binaries, so they change all the time.

In general, if you care about performance what you want to do is to
limit the amount of signatures you have to check to the bare minimum,
that is why I proposed to David the use of hashes, where you can have a
whole bundle of them and a single signature covering them all. This is
paramount for something like IMA if you want to make it usable wrt
performance.

> > I don't think we can dispense with signature checking entirely, though:=
 we
> > need it for third party module loading, quick single-module driver upda=
tes and
> > all the non-module checking stuff.  If it were to be done in userspace,=
 this
> > might entail an upcall for each signature we want to check - either tha=
t, or
> > the kernel has to run a server process that it can delegate checking to=
.
>=20
> Agreed - we should have an in-kernel option
>=20
> > It's also been suggested that PQ algorithms are really slow.  For kerne=
l
> > modules that might not matter too much as we may well not load more tha=
n 200
> > or so during boot - but there are other users that may get used more
> > frequently (IMA, for example).
>=20
> Yep, mentioned above.

Note that PQ algorithms are not all slow, but mostly signatures are
large, much larger than hashes, which is another reason to move to
storing hashes in the kernel, rather than signatures.

Where the smaller classic signatures (ECC) are 32 bytes, the smallest
produced by ML-DSA are 2420 bytes (with a public key of 1312).
For SLH-DSA the smaller signature is 7856 bytes (but hey! 32 bytes
pubic key).

The proposed FN-DSA standard has smaller signature sizes (the smallest
in the drafts is ~666B with a 897B public key, numbers are still
subject to change), yet it requires a IEEE-754 FPU to implement and is
a bit crazy, and it is generally not recommended for software
signatures.

Some algorithm is also slow (eg SLH-DSA with strong parameters), but
ML-DSA is comparable to ECC in performance.


In any case reducing the number of verification operations is a net
positive for kernel boot/operations performance so moving to hash-based
checks instead of full signature verification wherever possible just
makes general engineering sense, even if it can make loading of hash
lists slightly more complicated.

HTH,
Simo.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc

