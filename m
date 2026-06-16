Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6636CDF2
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619116; cv=pass; b=TpO81K4U2Xmvg+yuANagQpxAS8GSTaRecyPm8OpFRAHmJoMNdvqUu2P5p5KSKO5Z2ZOJK8NwC0y08+wAkZa2wYlWVk0mBrWjURJvkyECp7cA4Qd0xOr25Yu8euPjt3uTc8KuJ1/F+RzPRr9jmvmmq2ntcBPxEV+uRwWsCJhTZaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619116; c=relaxed/simple;
	bh=XOT839ZUnmbC6i+ZNTrPHV5p7Nf4fmLOE3PmElgMq1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk7MZe0ecKJu6/POduzjGwZvI4HCC5qrG/8HHqW68jIgOQ4Vai5k5nfcTbM1etvc3sj38xTa2WOXmkIqp9nWY74uo+ryFwntJ/HyEfmZpPscLlk0i7hW4GWAtJBBLB3Yn8b22akfpHiIlnbmxblfM0OxBSbN83ScNHIYWzjoftY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S8QVDxYF; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S8QVDxYF"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so3322985a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 07:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781619114; cv=none;
        d=google.com; s=arc-20240605;
        b=ei3EjIKUKQMfyBJ0Mi07/2ixT5crjgoIm5c1aK5YhSFVt5MyeAQvyfuH1l5LaOGy0r
         43d4RHzxv5TbZm+pTQboccwhCuDOPMnSkifNL/5F9u/H8+/+PJT/y0l3ePXm2QNvTqEA
         Vth/+jOfHs+hRjsDYDNDD4cjwrkr4LzRuxqgrj9nJLjjb59sS3gWAnBSAE/hvvbS66Ll
         RATabZl+riR6g14NXHbwP9UoVsLHVYm5DWAu46JD4NYryzgUWRzpTh9GqatEPZM0bRWR
         wdPPdVu6One0xQCjVWfS56Q5AZdm1dVsn6R0Z/0jUlL2fnQBYRPFJQzI84O9dObkjFMz
         t+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mmerjkDOrPGzfV97bpVKX6uyBgCBlk1bg7OcSfg/xh8=;
        fh=hm+nMgha4rJFSOb5yMah6dR3pg56JC7AuYuwY8bQGwY=;
        b=fBZ2jUFYpI6e9gi4o/eLN/eOMipwapA2bpxYZbTRU/54WglqW2X233SRUeGF82sxoS
         MRXOzGRBqMnGIZO14q767Xi0DvJITDyKCJmaPO+tMdJawd0C6sD1PY8jMRllIVnC3tSU
         hAtTXT6q7lsPDlN41da2dewt9FyfqdD6eNRzrc7QzoPnT4o9wT2qzpdTAjpij7HN3HmO
         kUyhKkubhEXsccAs/8Pl6ECPg0kYZBu2ltRfnnH8e91xm1nQHYgbXE8eIhlSH1+EhRTy
         vio1UJ/Oe7UH5rn9Zo82Fi/0dhohOFNvzjy3yYPM4qKzdioHscCtpLvj65wdBxEX3Xo8
         1T4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781619114; x=1782223914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmerjkDOrPGzfV97bpVKX6uyBgCBlk1bg7OcSfg/xh8=;
        b=S8QVDxYF/hrXoSO2PiquRzJuK5nH8+zkJpRwWDvPl5PeQCSDh9Ui+2d5fqV1IYDOQG
         4195XbDA5u8V8ly7a+gIDoFs2LE3UKIhVrFpEta9KlVmLf8Uj5jG+59iA8aJwdX8+w9J
         uCSNS1YF3W505PMMKMD9La217ecHbV/GUC/zux+FcvxKc4V7Xbt7rBv7/y4lyO82uYQL
         J7WpDsPs5zy3hqelnyES1myOiIqTt8C/PtOxVJc6q7Mhk6PB8ADsk0BTYempBP/gPILt
         9XYrD5rf7pC7l6/1VaxJWxeQVaAkxt+20n/XlPzLFlc9AIKEFbX5BGn4MzX0hie4H8Wc
         I0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619114; x=1782223914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmerjkDOrPGzfV97bpVKX6uyBgCBlk1bg7OcSfg/xh8=;
        b=hWRYfm3Nxw/eTI8dQTdSzebuIfE8XGZBJLnSGaYdrmlHFkL28Vx09g0sYS25vIgbLS
         qsTrWvuHy2QCe2VDbb4uZOaW1+Yga8Um8tgy9feSigpMVgO0I57mkuSF4RBtJQ3ffiYG
         N6wqvrGr3fK/GFoKOKiRU2vNS2SU48iSI95FuAcCjRr27TtmFDcYZUEOfD/GFH+n4GZw
         d0SiToObFsslgB67URimaYXXJi1ZUw5qRg8zbI544xE9Ynp2yDesQhhDqOaBEnz3oOEI
         gbqPoG/m8AMN+aaFXFXNXxVCyARJ0V+fGBai+ay6EJAmHkFzzdjROgWg+DIkN8okNTiQ
         I84A==
X-Gm-Message-State: AOJu0Yxl50d/zAHyzLqi1PZ/v4gk61uGD9pNJgG5l/rUIrSOA1XmFt6U
	LHWb5cYzyCSvyZeeeeOUE7MbTW3gqWkR5WsNIBt5ca0P7gRtyNH0JJo+NLwKTejIU58jLQo5dQB
	Nb8vAs1vBlE4Hp/pldnfA2A4FSarRfONpx4b1nIMB
X-Gm-Gg: Acq92OHC08xBovnEFrrTI3SZ/tua+r23wGGL8VuNxx6jwFwCvdgi7fvG02hc5e5fAUM
	HZBiRi+wa/53tKs88IjazNIWQEXmCLb8PkYt0WuENOtGrctrj056pnmD7A1DdLVVRupOpQai3aZ
	GznmDcrK2YHaza0VSzP2frzdGFJXzFslV9FYGn/wZOc9y9ubHf5r3uh/cFWWqN92C2R3FQVF4XL
	y+4MwQ+B2KuvQdsFK6CPCuvzNh7USLOBbslI2jYzetWZdowPKccw1W4vZzkjndZOOLx7L6hQxz0
	lo3DgUQ=
X-Received: by 2002:a17:90b:258c:b0:368:f179:ba07 with SMTP id
 98e67ed59e1d1-37c2bc658a1mr16375202a91.9.1781619114133; Tue, 16 Jun 2026
 07:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615.zeinurej8oZ9@digikod.net> <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
 <20260616.EPh8ked0niko@digikod.net>
In-Reply-To: <20260616.EPh8ked0niko@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Jun 2026 10:11:42 -0400
X-Gm-Features: AVVi8Cci0EKdSebS-l8LBZ6j2tnmFUw-8wfnDw-TPfiQIKyFQ-Puf0TWVpxapns
Message-ID: <CAHC9VhRa8DQ-ekrmPQSg2pO9pBFj6GA9DO=x5kguGFTbKKyv7Q@mail.gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, sashiko@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 4:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Mon, Jun 15, 2026 at 04:13:59PM -0400, Paul Moore wrote:
> > On Mon, Jun 15, 2026 at 11:41=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > >
> > > Hi,
> > >
> > > I've been reading Sashiko's (AI bot) reviews wrt Landlock patches, an=
d
> > > most of them were valuable.  It found issues (security or not), but i=
t
> > > requires to go to https://sashiko.dev to find them, which is too easy=
 to
> > > forget, and requires additional work from maintainers to copy or poin=
t
> > > to these reviews.  I sent a PR (currently in draft) to enable email
> > > replies from Sashiko to the Linux Security Module mailing list (most
> > > patches are already reviewed anyway):
> > > https://github.com/sashiko-dev/sashiko/pull/278
> > >
> > > Making such reviews broadly available can improve the quality of patc=
hes
> > > we receive without much noise, helping for all LSM-related code.  We =
can
> > > fine tune some email-related settings if needed.
> > >
> > > If there are any concern or question, this is the right time to start=
 a
> > > discussion.
> >
> > I recently enabled Sashiko for the SELinux list to trial it there
> > first, with the goal of eventually bringing this topic up for the rest
> > of the LSM folks on the LSM list.
> >
> > While I think Sashiko's review comments are generally okay, you should
> > have contacted the LSM mailing list folks *before* submitting a PR
> > that would cause an automated bot to send email to the LSM list (this
> > applies to all automated emails, not just LLM reviews).  Please hold
> > the PR until you have given people a chance to comment on the issue.
>
> As I explained just above, the PR is a draft (GitHub specific state for
> WIP), so it cannot be merged as-is, but it is useful for reviews and for
> LSM folks to get a look if they are interested.
>
> > Personally, I'm okay with it.
>
> Looks good.  What about waiting a week to get some feedback here and
> then ask for a merge of the PR?

I would suggest enabling Sashiko for the LSM list, but not enabling
the email replies at first.  This would allow people to view the
reviews and perhaps make a better informed decision.

> Anyway, it would not be written in
> stone, we can update Sashiko config with new PRs.

It is worth noting that sashiko.dev updates are not immediate, so
there is a delay between a PR being merged and it taking effect.

--=20
paul-moore.com
