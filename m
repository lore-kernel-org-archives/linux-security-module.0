Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48E26B0A9
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623449; cv=pass; b=Iw/ydxRw2DBEhafDHKtfhE50p9bfPWxR3ivbYj+qseoG1k5Unjphy6+qT0yEjzWmCDYWn73SrdYULOwRqOzTq82fMJX7vDNELq1zb4nynZ2v4hW598TJsqJrJGu96lTIAj/1JuBJJaz8bsnQBw+2UByYwueOKBiqVIOe/YBPcf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623449; c=relaxed/simple;
	bh=ySVzSsVakcVFE2wtn9xhAfZhLDXQYnYd2gsVEtuaNQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7BRURcsPTrqTkEQLJrq7A7PUykY6zzJ+Ze9gtCajGhUKEVINIBo2W0gIO3Q7Fv2aA2lMHbVpmWM0MqyL8WRabs8tmhm1r9OXB1hggxWRnQx3BsNEbjQ7Q2mHaCZm3NvM0XMibtWnx7GSbQ7qKS7WvEBk6cq+PxUAvbmGIYCxqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NkOaPe+C; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NkOaPe+C"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2938902a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 08:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623447; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFdbevgXdtaINys2BwFRL1N3pm6xBQV7qJJ9qiGRHv12yAX7vTDUx+s+7P04ncY/Md
         mVWsz1PEGMkaOIvkoY6MXfX8vWjn7YB+dKCCXcbuibdb/ekCn1rPX9fkSN37uOiBw1Im
         vcf6YEPy23oML+WZYM+z/sakIGeB+NW9UKD+fvil0JVag0p2LJuo+n0FFdElb2sNkDFU
         +R9/aqraqQ2UxXdtj1pIzj8w6BwAeE/BC9rx0udysperi0Ic1UlXluEHoBlQjkhPsss1
         s7mpJ9VwQMXkOOmSTRBNd1noJryuyaDafEVbwow9ie1rzAIenyNzfkdQW569dHShAkeq
         9KEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l9DyvKp5GlTfWCFl+DPg3gMJrNtSEWY6qdSng3vxqLU=;
        fh=hm+nMgha4rJFSOb5yMah6dR3pg56JC7AuYuwY8bQGwY=;
        b=Iz5nrzJUZm1PYjGn+oevbNuNtJON/iNH/3/X0AN1lN2HIWgshtmL/kAX/o8FQrfZB/
         Ft0XwWgR/GdRT55ZyKffjL+nA0Ata1TY9TnL1Ug0PhtE66Jjv9t1srP5NmBUD6eVmcfR
         FnTvIlGXJ/IMjOIfjg82nDzhEADE6yyWih5SjNS9rs/+oBVNN3qwQityBWGFfEff5J8/
         ULh0WY55fFU4uRoqG+wTDlj+2drx13Tar9waRKPSIPlpw1QLvHpymM++n5kK1CqXGiLt
         ugq6HBhQNqY+88AhKOfgHPzFL8kU09UOic47dvIPPISInjqWjcp6EWhrTn4Qp3AgWMut
         c3vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781623447; x=1782228247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9DyvKp5GlTfWCFl+DPg3gMJrNtSEWY6qdSng3vxqLU=;
        b=NkOaPe+C8q0JTTo6iV9E0lA1H9OdjR2pRSFjnIRXlX5czwvIqqkVDTd5ovTbLOM0Jq
         RGjP1ir+uD2vVcmYx6SYni9bjTdRSC0byYSmUlKMrCExkEjDTq5SQIalxuuCsUE2bpE9
         vQcNF24y6gZNc0TOlpREu101/36t3Z8pVk/YOezQd2GLtk9jHB6s8EultO3RbQHSVKC9
         +bZ1RJNrD3y+E060rS3vUGSNxFZazo0xT1KwGZi8s8JY6w2qgZArMJf4UFNnhNKq9VML
         8VUGoG94vhzhZ8tU7BUz91theSgbswO9JqvEH+gfmvb1a2kKxfDuVnOHriq9pNIt9+Nu
         /eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623447; x=1782228247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9DyvKp5GlTfWCFl+DPg3gMJrNtSEWY6qdSng3vxqLU=;
        b=bGElukykGVRL5t8v42XQYxE2bvNAAKbbKfizrcP9QR5575SYKY1+Rm+FAkSuH+wi2J
         VGTApIoRKYArUVYfF2xdFfY9oEMFUeQs+LzE4CuGppYLhmWbkkoeNGetIwwwWRxFWXRg
         RRZijFtv3SKt5qii8kaBEZp5qA3Y0Zzwk/t6Mfb2nBUKX2RMUDXXTW3aZmv0eMuel6kT
         uN7citUIycp4UOHDayNDWjKXEgEVZGih88VNkifq4/KHPkB+0zU92mGObQlAMxsaVhCX
         puE+NwMnQQz5NjW0nTwXj/jbJzqug2S/81wWJVxUxiBgd7hetyyMKbftmC6e+C3TWJLK
         BJWg==
X-Gm-Message-State: AOJu0YzsDBrL4iFzYi4x+0lNlqiXW+i5/OQTCBm0ncsSCTUz5lG/NrWx
	yVvg423YgUDZhmGghugt+IiCp5Y6MccZSKmRkdHceyLHvMQJf1l/I+WQ4NyakhiIPojyzVuhonY
	XdHUNoDKzo7bEQJGNDUVw3VQPVaf8em5ql0e6UPxP
X-Gm-Gg: Acq92OFL1FQzxyz2GvYBswzqm9QcvK0IYuqmnToupip50RLQbzDmBD7l7stD+3RxRl8
	D4n+IiE6p3YD6UxyCfFo0ZoxMW2ben6Yh/cazceBu5yyqGKWNPYiOq/OEFSO8n/CYKvNIM4Vjhk
	DUZuR/pGtm8gd9se8ynSnjHtnmwZdBv8go+kGkb+pce7oBfvvoh8prlDbeRDM0E0wUhmgmLJ07H
	POYRAfG/c0l6STHu0dBJurzNNNtrQ8jJaF9yjZYT21v8lGskkMP5iUn8L3+ZaB4MXxTHMY0XEL2
	RFyu0RI=
X-Received: by 2002:a17:90b:3e8d:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-37c528ff244mr4243093a91.17.1781623446649; Tue, 16 Jun 2026
 08:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615.zeinurej8oZ9@digikod.net> <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
 <20260616.EPh8ked0niko@digikod.net> <CAHC9VhRa8DQ-ekrmPQSg2pO9pBFj6GA9DO=x5kguGFTbKKyv7Q@mail.gmail.com>
 <20260616.aiGaim8xie8z@digikod.net>
In-Reply-To: <20260616.aiGaim8xie8z@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Jun 2026 11:23:54 -0400
X-Gm-Features: AVVi8CfG7acvH-660edmw_6INQnGnywkelyYTrpO4uSRVLA0B8-F6MPHkQIkf5E
Message-ID: <CAHC9VhQyN3CczsTHG=sJF8G=MqxGL6NO7assuAjuF9K1t-qDmQ@mail.gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, sashiko@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Tue, Jun 16, 2026 at 10:11:42AM -0400, Paul Moore wrote:
> > On Tue, Jun 16, 2026 at 4:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Mon, Jun 15, 2026 at 04:13:59PM -0400, Paul Moore wrote:
> > > > On Mon, Jun 15, 2026 at 11:41=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <=
mic@digikod.net> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I've been reading Sashiko's (AI bot) reviews wrt Landlock patches=
, and
> > > > > most of them were valuable.  It found issues (security or not), b=
ut it
> > > > > requires to go to https://sashiko.dev to find them, which is too =
easy to
> > > > > forget, and requires additional work from maintainers to copy or =
point
> > > > > to these reviews.  I sent a PR (currently in draft) to enable ema=
il
> > > > > replies from Sashiko to the Linux Security Module mailing list (m=
ost
> > > > > patches are already reviewed anyway):
> > > > > https://github.com/sashiko-dev/sashiko/pull/278
> > > > >
> > > > > Making such reviews broadly available can improve the quality of =
patches
> > > > > we receive without much noise, helping for all LSM-related code. =
 We can
> > > > > fine tune some email-related settings if needed.
> > > > >
> > > > > If there are any concern or question, this is the right time to s=
tart a
> > > > > discussion.
> > > >
> > > > I recently enabled Sashiko for the SELinux list to trial it there
> > > > first, with the goal of eventually bringing this topic up for the r=
est
> > > > of the LSM folks on the LSM list.
> > > >
> > > > While I think Sashiko's review comments are generally okay, you sho=
uld
> > > > have contacted the LSM mailing list folks *before* submitting a PR
> > > > that would cause an automated bot to send email to the LSM list (th=
is
> > > > applies to all automated emails, not just LLM reviews).  Please hol=
d
> > > > the PR until you have given people a chance to comment on the issue=
.
> > >
> > > As I explained just above, the PR is a draft (GitHub specific state f=
or
> > > WIP), so it cannot be merged as-is, but it is useful for reviews and =
for
> > > LSM folks to get a look if they are interested.
> > >
> > > > Personally, I'm okay with it.
> > >
> > > Looks good.  What about waiting a week to get some feedback here and
> > > then ask for a merge of the PR?
> >
> > I would suggest enabling Sashiko for the LSM list, but not enabling
> > the email replies at first.  This would allow people to view the
> > reviews and perhaps make a better informed decision.
>
> The point of this PR and the related discussion is to enable email
> replies ...

... and you've heard my opinions on that.

> the reviews are already there.

I don't believe the LSM list is being directly reviewed by sashiko.dev
at the moment (check the lists drop-down in the web UI).  Any
LSM-posted patches being reviewed are being reviewed due to a CC to a
sashiko.dev monitored list.

> As explained, my motivation for
> this change is to get reviews, and without emails I suspect almost nobody
> (will) take a look and that would not even be an experiment.  I'm saying
> that because I forgot several times to take a look and it adds more work
> to the review/maintenance.

I think it's important to allow people a chance to see what the
reviews are like before you enable an automated bot on the mailing
list.  I'm sorry you found it cumbersome to check the web UI, but a
change to what is sent to the mailing list affects more than just you.

Perhaps we do eventually enable sashiko.dev to post to the LSM list,
as I said before I have no problem with that, but I want to give
people a chance to look at the Sashiko reviews first and make a more
informed decision.

> FWIW, there are currently 41 kernel mailing lists registered:
> https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy=
.toml

Yes, I think we can all read a configuration file.

> > > Anyway, it would not be written in
> > > stone, we can update Sashiko config with new PRs.
> >
> > It is worth noting that sashiko.dev updates are not immediate, so
> > there is a delay between a PR being merged and it taking effect.
>
> Sure and I don't think it's an issue.  It's really easy to filter
> emails on any MUA if really needed, and I'm sure the Sashiko maintainers
> would be able to fix things quickly if needed.

I think it's important to understand that not everyone approaches the
email lists the same way, and something that is a non-issue for you
might be a larger issue for someone else.

As a reminder, you are always welcome to create your own list for
Landlock if you find that the LSM list no longer meets your needs.
The only thing I ask is that any patches touching/affecting the LSM
framework are sent to the LSM list and of course any pull requests
sent to Linus should CC the LSM list.

--=20
paul-moore.com
