Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103222F15E
	for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583969; cv=none; b=mlGJbFTTzKbpo2zCj9o8XEBjS2na04LWb880/34vcE2Axb6Sqw5uMYiA/XJggAZoQQMmR7VgcnbIyNLP3prNfqy97hqusRAWbZU5pLo9jws6FleH07iW+TzQy1vwOLE19z6mhwT8Kue6kcWCXYVsDITBY/+ItJMrI81rloQvpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583969; c=relaxed/simple;
	bh=sPA3YMc7zB5fmsVIwEgENpeTURZ/iV7aheO5rZV+wXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTNbDtIyNRfNrMjRoWi8Z/MKhcOSqyEGoZI/UWALi463FfbHjW0c4EkbVYIe/WXmNR5EQB8dvSbRDaNnrONf1fygZ3AMKRPsE39O2TpP+vkMMKYXBAJ+Gii6xLvovLPSX6iDMcoqKuIAKnVbO0WjzE0zKhAZTW7bqlRUUo+MSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QmLhM+GA; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QmLhM+GA"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e643f0933afso2864770276.1
        for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742583967; x=1743188767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nSFzAgQaMCuwvxmSdJkfWwEiaWngP9LwXhsN0dSMzo=;
        b=QmLhM+GAXlaQMp8mETBR32bjfXPMOv+MZXAdxshkPfuPMbVq6ZabW968bdxRk3lxlW
         /mrHMe+w7ij3JiofLtqy3VsWqJ+gqvaSRBIjizatniNOtCcmtb1u6t/Jvn5tAW+1lj1o
         pZq+w1hH68WhLsdIZr1Qt+VMpQJPyXiQW/naRtMwtyX3vHVDbn3Z3iRQtXyu2cR05ko+
         42LAlA2nC77VxRCooSgPqm8qPpdP0/JLF/CtNipNQHjaiVwOc6PTMR5EO/77K4IH2YRu
         2zdj8/zfaUEMeIHaTFD3LkoV2x81zSzcxXR3ktl+0ef5AXMXfcQHyFN/oN7qWsp9nYrV
         KhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583967; x=1743188767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nSFzAgQaMCuwvxmSdJkfWwEiaWngP9LwXhsN0dSMzo=;
        b=SeoznbdkUA3ivGEbBPxwDyCfIV1/5lbLCXPeVPRkTZsbk+gpndzcQZf+RJ4E9KRVi/
         aMvI3yi1HRx3Vb7j3ESPU2O9cSdn1iup+8sUYZoldXZ828LlX2wztYeCpFjbj8lY9s9x
         9aHMa4e+dHlaNwyi/fGeifgWXiQ3qcQ212IYFf2qDgVLbTxIk3zYQtgMFrnVwm/9uv09
         FRQBroDCh1+xzl2oB1LPw6BCw2a02nMrQIY4uu92Sn9JuvtOwl5c4Yr55FSa+vbIuf42
         ilSoodWnjVRhG7Nj7UfnudQDyHTRJu5W4KI/V1bvMfAEu+FPWpefeh85TipHs2MZpw8t
         KK1A==
X-Forwarded-Encrypted: i=1; AJvYcCWUuu/+mPUwbhMUq0jMkSziW+Vt9py071Ng1Ar5s4h+MgZ2JIx3g4QyrrzLaaIMfF7/fcSm4pqnYsbQft+6WR7gFL/RDUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTdNM7oMfin+VZA5dVs+2C4m+643ugVEZwJ7CiJupdREiAIoe
	48Fpmcw2sAK++652BUeLPODONCvCQgn02Nw649SQv4q7s976CdIMLPsFLzoKyCHye/bbf0cYJbD
	n+5z90v4QSyAgjaycgo3A8cJMbeATbzFGGAKR
X-Gm-Gg: ASbGncuZApW7G2yCprI8Z3uvkQIxJnKm8AfuRElE03CaEji4zyJG6gio+4frXH8sz0y
	arcG3LTYohQ8S9fGVL54jVPBptlmnSsiVxEAntxDno1q21qgwsd9wRwPGN38Vc8ZXVRCRt14P3O
	wSzsbq7AQAdGsBQitAlP02H1rnZQ==
X-Google-Smtp-Source: AGHT+IH/+vybMPgjTy+Q/lR+WQGG9I7BYYRaZ8XGvbeWqhA0zAi7QHXEcXle+vpl3pUGz1AEgz4oOGz9sgmGVmlf3/8=
X-Received: by 2002:a05:6902:4a8d:b0:e66:a274:7fff with SMTP id
 3f1490d57ef6-e66a2748117mr6225899276.21.1742583948895; Fri, 21 Mar 2025
 12:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com> <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com> <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com> <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com> <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
 <Z92gTQj6QkedbH0K@kernel.org>
In-Reply-To: <Z92gTQj6QkedbH0K@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 15:05:38 -0400
X-Gm-Features: AQ5f1JoCVuy6gH5pZ3qt9eL4_YTiGz_EbkGoV-AHORqyWmdnqKeKo0JNC59Hn0c
Message-ID: <CAHC9VhSi06azJ+b5YgLuDM6xff2401ArMM6LoP0vsqsUgz6VNA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:22=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Thu, Mar 20, 2025 at 05:36:41PM -0400, Paul Moore wrote:

...

> > I want to address two things, the first, and most important, is that
> > while I am currently employed by Microsoft, I do not speak for
> > Microsoft and the decisions and actions I take as an upstream Linux
> > kernel maintainer are not vetted by Microsoft in any way.  I think you
> > will find that many upstream kernel maintainers operate in a similar
> > way for a variety of very good reasons.
>
> This is understood. If one takes a kernel maintainer role, one should
> unconditionally disobey any vetting by the employer (even at the cost of
> the job, or alternatively at the cost of giving up the maintainership).
>
> And with you in particular I don't think anyone has any trust issues,
> no matter which group of villains you might be employed by ;-)

Haha :D

> > The second issue is that my main focus is on ensuring we have a
> > secure, safe, and well maintained LSM subsystem within the upstream
> > Linux kernel.  While I do care about downstream efforts, e.g. UEFI
> > Secure Boot, those efforts are largely outside the scope of the
> > upstream Linux kernel and not my first concern.  If the developer
> > groups who are focused on things like UEFI SB want to rely on
> > functionality within the upstream Linux kernel they should be prepared
> > to stand up and contribute/maintain those features or else they may go
> > away at some point in the future.  In very blunt terms, contribute
> > upstream or Lockdown dies.
>
> Could Lockdown functionality be re-implemented with that eBPF LSM? I
> have not really looked into it so far...

I haven't looked at it too closely, but the kernel code is very
simplistic so I would be surprised if it couldn't be implemented in
eBPF, although there might be some issues about *very* early boot
(Lockdown can run as an "early" LSM) and integrity which would need to
be addressed (there is work ongoing in that are, see the recent Hornet
posting as one example of that work).  Beyond that there are
policy/political issues around that would need to be worked out;
nothing that couldn't be done, but it would be something that we would
need to sort out.

However, as I mentioned earlier, with Lockdown already present in the
kernel, deprecation and removal is really only an option of last
resort, and I'm hopeful we won't come to that.  We've seen some proper
Lockdown patches submitted overnight (!!!) and I'm discussing
maintainer roles with a couple of people off-list; with a bit of luck
I'm thinking Lockdown might be properly maintained after this upcoming
merge window.  Fingers crossed :)

--=20
paul-moore.com
