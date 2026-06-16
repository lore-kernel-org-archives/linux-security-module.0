Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E23B2FF9
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781651175; cv=none; b=kqRRzhxHR2/YfJujVA+U0KS6T6vic57H9U26xW4l0qnj54eo+Gbrcr6nv/SI5li8nPBFsMor+HRPH/DnIJg+S3dHsxB61VMDDLj4hP6pqd19G+4Ip2uyNJB0hQ+9Oo3vdICrNhKlg6pENIVnkgo7JzX5shLl4ltJEY4dztFLSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781651175; c=relaxed/simple;
	bh=7BoAeYvyM/ShmVhwe1Bya42w86ZTb2iV4bXaLbdDHaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iItF2RgGEJcH3oxRHddrVxUdh8Zk+FNm7hYPPRHgiDb38YUzn/uizgKjWgjUX2N5vQOQdRh6IhFoGHtdpLGqdcYknntOL2564h5Qiz22hU3jVywI2pNDdE6UqMCKyAjD13qkJowFRm5S1TEZqk4zANwVCVw930JP36zpdpUtEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DWAuO+2l; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DWAuO+2l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781651160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f10e25rh2kh/32mqIoWdgyM3DhEAHTmgbvyfq30e+iw=;
	b=DWAuO+2lcSdAS9nlYs/y13xDgnlv8PiB6qDurLWvIDvhvvZlDDeR6PTGgQNvegkzMZfg1H
	Q+pPY1p9WKvMk6G6ks4/GO4WkOM2sS8RELhpPRWtrN/hUlkdADuvDx3Z/7Sn3yBGSfneSB
	dRT34aMYAftyHdbV6FmylhU0avSvWso=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>,
  linux-security-module@vger.kernel.org,  sashiko@lists.linux.dev,
  =?utf-8?Q?G=C3=BCnther?=
 Noack <gnoack3000@gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
In-Reply-To: <20260616.aiGaim8xie8z@digikod.net> (=?utf-8?Q?=22Micka=C3=AB?=
 =?utf-8?Q?l_Sala=C3=BCn=22's?= message
	of "Tue, 16 Jun 2026 16:59:03 +0200")
References: <20260615.zeinurej8oZ9@digikod.net>
	<CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
	<20260616.EPh8ked0niko@digikod.net>
	<CAHC9VhRa8DQ-ekrmPQSg2pO9pBFj6GA9DO=x5kguGFTbKKyv7Q@mail.gmail.com>
	<20260616.aiGaim8xie8z@digikod.net>
Date: Tue, 16 Jun 2026 23:05:39 +0000
Message-ID: <7ia4v7biqe64.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> writes:

> On Tue, Jun 16, 2026 at 10:11:42AM -0400, Paul Moore wrote:
>> On Tue, Jun 16, 2026 at 4:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
>> > On Mon, Jun 15, 2026 at 04:13:59PM -0400, Paul Moore wrote:
>> > > On Mon, Jun 15, 2026 at 11:41=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
>> > > >
>> > > > Hi,
>> > > >
>> > > > I've been reading Sashiko's (AI bot) reviews wrt Landlock patches,=
 and
>> > > > most of them were valuable.  It found issues (security or not), bu=
t it
>> > > > requires to go to https://sashiko.dev to find them, which is too e=
asy to
>> > > > forget, and requires additional work from maintainers to copy or p=
oint
>> > > > to these reviews.  I sent a PR (currently in draft) to enable email
>> > > > replies from Sashiko to the Linux Security Module mailing list (mo=
st
>> > > > patches are already reviewed anyway):
>> > > > https://github.com/sashiko-dev/sashiko/pull/278
>> > > >
>> > > > Making such reviews broadly available can improve the quality of p=
atches
>> > > > we receive without much noise, helping for all LSM-related code.  =
We can
>> > > > fine tune some email-related settings if needed.
>> > > >
>> > > > If there are any concern or question, this is the right time to st=
art a
>> > > > discussion.
>> > >
>> > > I recently enabled Sashiko for the SELinux list to trial it there
>> > > first, with the goal of eventually bringing this topic up for the re=
st
>> > > of the LSM folks on the LSM list.
>> > >
>> > > While I think Sashiko's review comments are generally okay, you shou=
ld
>> > > have contacted the LSM mailing list folks *before* submitting a PR
>> > > that would cause an automated bot to send email to the LSM list (this
>> > > applies to all automated emails, not just LLM reviews).  Please hold
>> > > the PR until you have given people a chance to comment on the issue.
>> >
>> > As I explained just above, the PR is a draft (GitHub specific state for
>> > WIP), so it cannot be merged as-is, but it is useful for reviews and f=
or
>> > LSM folks to get a look if they are interested.
>> >
>> > > Personally, I'm okay with it.
>> >
>> > Looks good.  What about waiting a week to get some feedback here and
>> > then ask for a merge of the PR?
>>=20
>> I would suggest enabling Sashiko for the LSM list, but not enabling
>> the email replies at first.  This would allow people to view the
>> reviews and perhaps make a better informed decision.

I just did this: 611f4cd410d9a7f7ad923a068a6ced455e3a244e , for enabling
reviews I don't really need maintainers consensus. (I might roll it out
a bit later)

But when it comes to email policy I do, so I'll just sit and wait here.

Thanks
