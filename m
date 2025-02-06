Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD11624DC
	for <linux-security-module@vger.kernel.org>; Thu,  6 Feb 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856951; cv=none; b=GaMVxElgNdwJNV9jl2V+0PYAtqB0YfcK7V+XW5AhsHQLoVgu87djVXtG4KdwvuM+Gcfqnl2K5gnh9vXdYevjwjGrPDLk/df0jYeyKKBddx0WiGhVFYGMvuc5NYxY2v1TJizsHloQhCsQnjgMTE/o7xMr3qc7wbhgNHB1IFyPR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856951; c=relaxed/simple;
	bh=gm5a18TPIE8jhjZVGIfDrBV0rkHyXJ5LhAXrIYfCdU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTEgm12FWhu/g7fAvOrWWuF4F4awQfUOp5VYP8iUdFhjxzWdI6WcOrA9hGmtD4JdUT5SRPf9nC0CUOXD6Ccc4nmfGD7vi4vmwbAzPJ65szFPuuw2ty83ewe67dvX3wBiESdY+s2YveXm6QzArGYcXaIzaPdzsgtIQWAMgKxMbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yq8KNIjC; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yq8KNIjC"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f9aa66cbe8so3788047b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 06 Feb 2025 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738856948; x=1739461748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4yZmynuAqAaX/fsICNG3Afvx5zVtUE7n592NM4a374=;
        b=Yq8KNIjCfMI2J+h0DOOG2IrpKA1Yi2yuRVl51JeDauRaifHtFuyfJnuBEje0om/w4Z
         vWEXZZEcaNAWMKEyV1YaAi21bCSGEENGm9wwuzagfDyH2IpWb5hJYTygBToTV6rYoRB5
         treIbnP9hMtByXKYPH+5A8ejm5TEr/BkfwXHqoAiqK39USiH0qxE+01MEXMoXxoMrjWE
         yV4Z9GBZsSsRLOdkhPZ1OAtGRrzo7p21kh06luTSomE4+OSijsCKfCVFYQsynYWUo/LQ
         ixdskHv63SqrmQDKCai0T6qHGN6VftFBZsV9A6WJthprXigrFk6KEBPtl0+IlWmOCTpM
         J22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738856948; x=1739461748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4yZmynuAqAaX/fsICNG3Afvx5zVtUE7n592NM4a374=;
        b=KvJVx3i4MVHO1h5/y2TWf/cIcGa4CBRsDacQ46vGSXuHmrmuKUgEAT5CtqMD/flVxz
         scRDqJXrI1Hm6IbaL8DgKgXprADnbJrTkos49ylFG0RZTwvnS16Bo8W78TJpt/KGO07b
         ulD87w77jTdHBboLTZcngOpBHSP9QUGsDCJ5CruEHAG3PTb3DbZMNMmvEOdbQdaauOq/
         8iKoqgCERxWy1BtTBQayebN9QkndhAxPShNcKFacZyKhKQ8W2NDPf99R1WUadadh/36t
         w1CHQeTxT69ywLvThFEINP7Jip1Dfj1OJHkYa2JlkAmXIFIOAWux/Ykj5Sltyj/+TtUE
         DslA==
X-Gm-Message-State: AOJu0Yz0FrpNsroTcrNfH7yEznssJ2pIhehoVjKA6bTyYv8IEZ/wV7zH
	4Eg2WbhprFtbIbh/YsU325Mi4Ydysrp/jpiiyatABfHhd63OLbsnyZ/MB9ybPRmICXngMZcTK2H
	9u+666Fzy0+0+9dwOi+GLe3eM9ByPkcQDkXHDPXBhZp5+MOVqLA==
X-Gm-Gg: ASbGncsLnxZVGt9VgGrKJwNE+OnPegsgX0gMeTyiPV1XcBss9TptL+6HPjCMy9kAdR8
	k5TJQ4JtVUtc/4a8b4KMCY9Uqc24NF5ujItorvhUP+1Mz6FuVdaHtf5bUYwwfoomrcXBoDts=
X-Google-Smtp-Source: AGHT+IFQMv8ErMjprARbuVDAhi7QMq8LWSphsU0CJhVswyKDLYm20gJ5SdMRSVF1SLnRrshn3RuDlYFo/kUPh+93LtY=
X-Received: by 2002:a05:690c:6302:b0:6ee:7339:ab42 with SMTP id
 00721157ae682-6f989eb2e40mr67811147b3.14.1738856948282; Thu, 06 Feb 2025
 07:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250205120026.GA15809@wind.enjellic.com>
In-Reply-To: <20250205120026.GA15809@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 6 Feb 2025 10:48:57 -0500
X-Gm-Features: AWEUYZnmKtRI9VO3HSoX82L6GrgusAeFSML7fobxuKG6UrraUu5tWEyugLuu98Y
Message-ID: <CAHC9VhRq0PrH=0n6okkvfed=8QQOfv-ERA60NNWvLXetgrB_2w@mail.gmail.com>
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 7:01=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
>
> > I believe the LSM can support both the enforcement of security policy
> > and the observation of security relevant events on a system.  In fact
> > most of the existing LSMs do both, at least to some extent.
> >
> > However, while logging of security events likely needs to be
> > asynchronous for performance reasons, enforcement of security policy
> > likely needs to be synchronous to have any reasonable level of
> > assurance.  You are welcome to propose LSMs which provide
> > observability functionality that is either sync, async, or some
> > combination of both (? it would need to make sense to do both ?), but
> > I'm not currently interested in accepting LSMs that provide
> > asynchronous enforcement as I don't view that as a "reasonable"
> > enforcement mechanism.
>
> This is an artificial distinction that will prove limiting to the
> security that Linux will be able to deliver in the future.
>
> Based on your response, is it your stated position as Linux security
> maintainer, that you consider modern Endpoint Detection and Response
> Systems (EDRS) lacking with respect to their ability to implement a
> "reasonable" enforcement and assurance mechanism?

As stated previously: "I'm not currently interested in accepting LSMs
that provide asynchronous enforcement as I don't view that as a
reasonable enforcement mechanism."

> If this is the case, your philosophy leaves Linux in a position that
> is inconsistent with how the industry is choosing to implement
> security.

In this case perhaps TSEM is not well suited for the upstream Linux
kernel and your efforts are better spent downstream, much like the
industry you appear to respect.

--=20
paul-moore.com
