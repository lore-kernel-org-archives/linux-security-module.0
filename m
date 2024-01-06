Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3D10787
	for <linux-security-module@vger.kernel.org>; Sat,  6 Jan 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RxgVRAMi"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78158569dc6so99410385a.3
        for <linux-security-module@vger.kernel.org>; Sat, 06 Jan 2024 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704584697; x=1705189497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDbVoT7OoEiFM460KfCQ5FF8c6kjcJrMKDjqfMX1Qnc=;
        b=RxgVRAMiMMFDkQ2XuwKrvLAhelF7lwqeHQ/XoKdorrsAoC4HHL9yJVmAeSJRqdO/mZ
         qaRnE3ua9GVKeVQOEHXkgVuGGy/Ymcx4dQEM+2BIe2N+l9bRXGx947xI/2IRNC9+GhQt
         J0PbRxPacnAIYzQsbSqHetX+rHVTB5SInOnVjNb351Em4MV2M3wHnvWG+ehudn9Q5CTR
         Qf9xzAbdFM4Ps0vsqLgQ6QUgVz8s+wVKkVz4LJhDFuW3x5wDvSLrhV+TI8Gt7GDzDGoB
         AkKI/THKErAJuK3jI2djv1znkBWovKP3Y6V3xz9Rwte/6bf1GR2RIluftzReCBuNlP+l
         Lm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704584697; x=1705189497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDbVoT7OoEiFM460KfCQ5FF8c6kjcJrMKDjqfMX1Qnc=;
        b=dncBMsWaSLTBafSP4vk3e7MHuPg35nF3IFwxfNSsw54mT0D0RYrQbne6szxqzB8pfH
         o1rtqDEAE00GyX4kVJ8ftb8pxLe0iywWax7XuhhOaHLoMaFGj4RJKafekB5B7efl2nLa
         wUcEqrcpMBHUoPcXQBq/FPPeHerF3wVSrPFCo42jRQyzYE3YENyZd5mvWYAlkiy/3bW/
         DiiE8PC4ykXu1XMuBMzfVU+xvmtdRpcZl/VBouOPMF30MyS4ZtuVz1KZuFYAT8i9aPam
         p+JdlVZiJjOREjeQ7tQM8agatRNbaHJHy79iGkvxlBySzN4xY9JOvPgTYA5lX1w40D+R
         /iKg==
X-Gm-Message-State: AOJu0Yw9b5CEGMdu6W3MC0Z1K8szl68ICPEWKsFWDDXdnJAHzeaokraX
	uB2dDYYWt0yi9unY/5GdsDKC5izySTixgnwodzoRsIxQZEXZ
X-Google-Smtp-Source: AGHT+IEcPlkIt3uM5ECdHrGpN4ABuoY7X6eqs/p1NmkUnHpr3j0qgfOOV86sMtzHdJDQci/0ojkKljVBVspmg+nGsUo=
X-Received: by 2002:a05:620a:2a11:b0:783:148d:33ca with SMTP id
 o17-20020a05620a2a1100b00783148d33camr1931706qkp.128.1704584697399; Sat, 06
 Jan 2024 15:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com> <1c370ecf-272a-4052-8f06-4fcfd9bf08b5@linux.ibm.com>
In-Reply-To: <1c370ecf-272a-4052-8f06-4fcfd9bf08b5@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 6 Jan 2024 18:44:45 -0500
Message-ID: <CAHC9VhR9kjn6=MxgcEFx1M0Hz=4pGXWLrUcPx++TLvngih4KPw@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Ken Goldman <kgold@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, 
	linux-integrity@vger.kernel.org, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:14=E2=80=AFPM Ken Goldman <kgold@linux.ibm.com> w=
rote:
>
> I'm still struggling with the "new root of trust" concept.
>
> Something - a user space agent, a third party, etc. - has to
> retain the entire log from event 0, because a new verifier
> needs all measurements.

[NOTE: a gentle reminder to please refrain from top-posting on Linux
kernel mailing lists, it is generally frowned upon and makes it
difficult to manage long running threads]

This is one of the reasons I have pushed to manage the snapshot, both
the trigger and the handling of the trimmed data, outside of the
kernel.  Setting aside the obvious limitations of kernel I/O, handling
the snapshot in userspace provides for a much richer set of options
when it comes to managing the snapshot and the
verification/attestation of the system.

> Therefore, the snapshot aggregate seems redundant.  It has to
> be verified to match the snapshotted events.

I can see a perspective where the snapshot_aggregate is theoretically
redundant, but I can also see at least one practical perspective where
a snapshot_aggregate could be used to simplify a remote attestation
with a sufficiently stateful attestation service.

> A redundancy is an attack surface.

Now that is an overly broad generalization, if we are going that
route, *everything* is an attack surface (and this arguably true
regardless, although a bit of an extreme statement).

> A badly written verifier
> might not do that verification, and this permits snapshotted
> events to be forged. No aggregate means the verifier can't
> make a mistake.

I would ask that you read your own comment again.  A poorly written
verifier is subject to any number of pitfalls and vulnerabilities,
regardless of a snapshot aggregate.  As a reminder, the snapshotting
mechanism has always been proposed as an opt-in mechanism, if one has
not implemented a proper snapshot-aware attestation mechanism then
they can simply refrain from taking a snapshot and reject all
attestation attempts using a snapshot.

> On 11/22/2023 9:22 AM, Paul Moore wrote:
> > I believe the intent is to only pause the measurements while the
> > snapshot_aggregate is generated, not for the duration of the entire
> > snapshot process.  The purpose of the snapshot_aggregate is to
> > establish a new root of trust, similar to the boot_aggregate, to help
> > improve attestation performance.

--=20
paul-moore.com
