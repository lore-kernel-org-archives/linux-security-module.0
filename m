Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81B37DEB5;
	Fri,  5 Jun 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684156; cv=none; b=XugMuQFceTIiecJFAissiKkHZoMx6gYUG9iNt/lEcceDPP/OlAhiR4un/B91CEYuxrgbJgg/hUl09kz06C6QzW1N1b9zTO9iqR1rJVVb8yZ1RmrR5Qpyd6kCBkopaAV+dICWUSfX7XQPd1N1ST4hwEmJVib3zWcJHm2d6VVPhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684156; c=relaxed/simple;
	bh=pxXyFkSQfVEU4LrpYBw4Ws5o0ixDm2veIsC0NFL41xM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKkX3lq5zAzj/TkLEbhwQptBO6x9ObGCTpmIqA9fGjZZlg3sU8tc/AzbwcQ2uqzKkJUlEw6z4FSdz4xfwVKuZmN141bjJmctfDyEpDsLxHoR6ieenJbq9BN9fWQnHLYiQW6nxv07YqS7xQ7B1aAYjccl01eO9nUV5lnp+Qcf+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=vsbUWacv; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vsbUWacv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1780684153;
	bh=pxXyFkSQfVEU4LrpYBw4Ws5o0ixDm2veIsC0NFL41xM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=vsbUWacvMUDvItE1V8UkTCKLvEcTavyW7UMKZgDQc34vThJDYWfgk0xodAZ5NuNxZ
	 FeUuE3DJ41bMY9p+wPVkCrzEZAMAuzQYP+t9AEViCpwSnrenevhSxjF61wlvGgUKAB
	 ow74SSxIjj0bksu3ESP3s3TK3GPT96UhW9Y9UJZU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8c71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 2B4951C0400;
	Fri, 05 Jun 2026 14:29:13 -0400 (EDT)
Message-ID: <ecf0521ed302db672672ebfbc670ecfba36a6e00.camel@HansenPartnership.com>
Subject: Re: -next status as at v7.1-rc6
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
  Mark Brown <broonie@kernel.org>, Blaise Boscaccy
 <bboscaccy@linux.microsoft.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-next@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 14:29:12 -0400
In-Reply-To: <aiLS4wOtpqrpw4pA@mail.hallyn.com>
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk>
	 <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
	 <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com>
	 <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
	 <CAHC9VhRXW_kyWXgYBqW3K-jSr5yN9wp1EPos1c=BFmiebxLiUQ@mail.gmail.com>
	 <CAHk-=wij4nkMRcshzEGsxvjwP2RBQyaiQ4-vQrYTOqvQusxu9g@mail.gmail.com>
	 <aiLS4wOtpqrpw4pA@mail.hallyn.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 08:45 -0500, Serge E. Hallyn wrote:
> On Thu, Jun 04, 2026 at 04:18:46PM -0700, Linus Torvalds wrote:
> > On Thu, 4 Jun 2026 at 15:23, Paul Moore <paul@paul-moore.com>
> > wrote:
> > >=20
> > > While you didn't reply to any of my comments explaining how
> > > Hornet works, specifically how it ties into the kernel, I'm
> > > assuming you've read the overview.=C2=A0 Can you help those of us in
> > > the LSM space understand why a BPF dev's NACK on code that lives
> > > strictly under security/ is sufficient grounds to reject an LSM
> > > patch?
> >=20
> > Honestly, I'm not competent to make a judgment call between two
> > different models for hash chain verification, so I basically *have*
> > to go by maintainer opinions.
> >=20
> > And the discussions I have been cc'd on have not been what I'd call
> > enlightening.
> >=20
> > But people have pointed out that the LSM code mucks around with bpf
> > internals, and those NAK's have had reasons for them.
> >=20
> > And honestly, I don't understand *why* Hornet does what it does -
> > and does it in ways that obviously annoy the bpf people. There is
> > no *reason* to look at the bpf maps that I can see, and from my
> > understanding of Alexei's arguments (which may be lacking), the
> > fact that Hornet does that is the main reason for the NAK.
>=20
> The two most useful threads I believe were from a year ago,
> 20250502184421.1424368-1-bboscaccy@linux.microsoft.com
> and
> 20250528215037.2081066-1-bboscaccy@linux.microsoft.com
> which includes the proposal by the BPF side:
> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-FmXz46=
GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/
>=20
> There were 2 or three objections from each side iiuc, but the main
> ones that stuck in my mind were
>=20
> 1. whether it is ok to rely on a signed userspace bpf verifier
> program to
> =C2=A0=C2=A0 verify the signature.
> 2. objection by James Bottomley=20
> =C2=A0=C2=A0
> (2f71d6c03698eb17d51f7247efde777627ee578a.camel@HansenPartnership.com
> )
> =C2=A0=C2=A0 about the verifiability of the hash chain link.

My objection to the upstream signature scheme in that email was that if
you hand me a lskel consisting of a loader and a map and ask me to sign
it, how do I know the loader actually verifies the hash of the map
without having to disassemble and analyze it.

I think the second patch set (not yet upstream) makes that task easier
because it now calls out to the bpf_loader_verify_metadata() kfunc to
verify the map.  That means I can run the loader in a sandbox and see
if it makes the call, which is way easier than having to disassemble
and analyse its byte code.  Note: it's still not as easy as the hornet
method of simply having the map hash as a signed attribute I can
extract and verify, though.  However, the required task has gone from
pretty impossible to doable.

Regards,

James

