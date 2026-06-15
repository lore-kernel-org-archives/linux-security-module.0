Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A7331716E
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554454; cv=pass; b=nKAvazlSvCngvtq4pY5DCyWJP4zHlCax/K4rVFgYYG/7dsTV2hl9kCb5T9Dv1AyZOO3+m5qNFiyYvScowlOHYsVcDMGDkg1PnBiG4vF/sYFJzbsBI40oIhbPt4RlnAb3N7GUxe70NOCgoeJ26+VwtBvnG3zi5j18926fObXDtM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554454; c=relaxed/simple;
	bh=dN5lKLcB7WQw/x0wXZra8B+Rff+JPtL+Q5IFLvyfZH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1GDlio3gA9tmJ95vXAvaYIVHRqBFItNHwhVUq389CffMqtTekSK5oZXz5g7KCeZBPFKS2/S+5yhcGzjYKW16NFtoCBPyM2n1FS45Z28JWgckm/73GYo7EhlEFBKmeXUs4KNxWyXjNRUkOZmAx48z3LdKPBUjG7r6lJ3fiOF0qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QrjGmr2i; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QrjGmr2i"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8584e80d59so1479265a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2026 13:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781554452; cv=none;
        d=google.com; s=arc-20240605;
        b=T9gLo2b4iOMwLcbEXvyEVEzMFNDiZrzevlNKns5iBTsFy6SwVxFKBtB1UoB+H3Z0Tc
         XgSrlE+hqwQRG15cJ22ALwv94I7I7OVe68bQlir9cIo5ajxWsA7cadUahXw/TIMtt5D1
         1ezH7E+l+ZNF0e1cVvlPT6FWezIZI0lsFyurbJl6z4sjcv/Ts1x68eKCBKEYRL8DZQys
         B+2TdQtCtX66SGZqWN5hL9uTISE2+PqTaBXXi2jZrZP/g6fEHYOXL+Z6t+g67Qg9TGTV
         AZxxbNXhzEZtKr60t+y0XN/sRNqayPbjdC8jQzGybAVs5vqVQ/JGJ1WKDl8l4UML/W69
         SE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOBAp0OrvFOnJWy9Vj2Mprp5yZM0V5v8P2zKj+t6STc=;
        fh=hm+nMgha4rJFSOb5yMah6dR3pg56JC7AuYuwY8bQGwY=;
        b=VW7FoBXCssRcVBMaNq4vk58f/qnsbcMEf16JUHgX8m6fitdGyokbEeEbgzZKZsB9dy
         OfBDUBMsls3wFbNi7XfGn6Dx55n+WyMhMFec7JtoEtL6G+9q75a6i6gqSqsFOdxu+YBU
         dX/l05BkunpQtRIvX7+AhIK9MszB9PnQ/+NFsetXrSJFO+XETZYxK22wlBQx4Njffzis
         Ao6zcBV3obVgOAt99uAzjzeEsXC095pA3JUmQQZCAuDUDwVG0qNhApncZAOCxXUFUAsv
         o1n4G2WSj/2Lc/mGEmxRQl+xcc7Pp9N8+JuUcUFZuLYtcb2NT1HpOwhfv9oeM2HQPpvx
         iBHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781554452; x=1782159252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOBAp0OrvFOnJWy9Vj2Mprp5yZM0V5v8P2zKj+t6STc=;
        b=QrjGmr2im1wQFhB5MZGQz5gC5xl0bVaWyM0loYLkYbN0NpyCBoQ8ItMxigyFan3jBW
         kfJiIUo8A0HCP9jwphZBcv7sAMGMg729RzGF7ysubd2RLiccZzM8K7ALSbh+RMqDa0ej
         jEo/pLQDReSVHxZ0MZ4LFc0jouegW+Lh5gnDY7F72AMdX7OgSo3AcpMsqxRYRlCksGuL
         nY92fBnU57JBcfjFwA78yHsGKGVL0DcR3Z/eFHincfu4SbM7r0+tdDe66xAS2kP1sGCh
         QpETjpFvXALpIdtXiLub23vfVHpQuNgWjYpeIiuTQL/JNjWEInhVpmdgGppTVXBGP/xl
         IVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781554452; x=1782159252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOBAp0OrvFOnJWy9Vj2Mprp5yZM0V5v8P2zKj+t6STc=;
        b=ii0ZmO2qdAqYVlF9f48upAdeV/p14SmJpWfBbJU6EpKkFYAGENgiNVEv+3C5eFQiKP
         aKlNXvrp9RBbQQx4mNRNsliQwbDMN1oczHble1nbMCE+C9QgPrZ4m7Tk5Yb3S8uqH2ex
         +dI3cbuNppSM6dcCSdopVRBIXuZ3bzhF/FI15i0tc8Mhlh5OcZ3di89mI5CwmhGHDbis
         QuM98s0Wnmvqorlc/1Ft0ymMa182/JtOwDdmsrCmQxqTHImLGpSYRQovFvP/PWqGc+dQ
         EapVCh0egXX8U4yecWplbsRIrjDIxl8KH/bX6to8n050DunmTrA3YPwQmiyVlpr+hiv7
         t0NQ==
X-Gm-Message-State: AOJu0YxcYDTRGxgtry6p+n3bLm/E7ZivlX8tEnLeXJMYPke1kTCVY4Kv
	k8DVBPvVoKl493VNqhPGtS+O8PLtoq0hzT4eUioCluTGxPHDT0IOG+mhIyFVs5+qzAOJ6ZiSWOO
	eFTd6Y0ZyDmepMsaWoFqFUF8U7Sxs41e30ewIUyDK
X-Gm-Gg: Acq92OEjCOr1YnPgYK6L0x3U5fDdScjDSA/+ONXBIV5ZZtrdThzVLa9oTN98lHmt5Vt
	2h81ivTyFEfWDQ/j3ME787LH4M/BDcjVnAdOczzWX6FJfre3pO9I4XPi09cWQsI0WnMMy0tOGmS
	RW3F3nmvTKGI/xD1nwxVCNk252pm3bXU6RaT1byRQhTDnDlAHwUqd2VLSbNbY/NvGSBygQp06lA
	Ha/OlHa7AVyljUeOpExAwCFebyuJhxKL+6jliVnW108cM5zNWUH0E7c4HQ7+3brHc2TVmXeWmLe
	ex3ZLWM=
X-Received: by 2002:a05:6a21:3d89:b0:3b7:d9d6:9fc9 with SMTP id
 adf61e73a8af0-3b7d9e5f9f1mr2403549637.2.1781554452126; Mon, 15 Jun 2026
 13:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615.zeinurej8oZ9@digikod.net>
In-Reply-To: <20260615.zeinurej8oZ9@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Jun 2026 16:13:59 -0400
X-Gm-Features: AVVi8Cd3qtvo9laeXmNE1xHUqG8S1fVFDN_4vCveRADQz_4qhqKW3-tq1qmqozc
Message-ID: <CAHC9VhQxHEuznN-xiMJ-LCsz2z-UB0ri6MeMn+Ajyn1WUTDNDw@mail.gmail.com>
Subject: Re: Sashiko reviews for the LSM mailing list
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, sashiko@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 11:41=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Hi,
>
> I've been reading Sashiko's (AI bot) reviews wrt Landlock patches, and
> most of them were valuable.  It found issues (security or not), but it
> requires to go to https://sashiko.dev to find them, which is too easy to
> forget, and requires additional work from maintainers to copy or point
> to these reviews.  I sent a PR (currently in draft) to enable email
> replies from Sashiko to the Linux Security Module mailing list (most
> patches are already reviewed anyway):
> https://github.com/sashiko-dev/sashiko/pull/278
>
> Making such reviews broadly available can improve the quality of patches
> we receive without much noise, helping for all LSM-related code.  We can
> fine tune some email-related settings if needed.
>
> If there are any concern or question, this is the right time to start a
> discussion.

I recently enabled Sashiko for the SELinux list to trial it there
first, with the goal of eventually bringing this topic up for the rest
of the LSM folks on the LSM list.

While I think Sashiko's review comments are generally okay, you should
have contacted the LSM mailing list folks *before* submitting a PR
that would cause an automated bot to send email to the LSM list (this
applies to all automated emails, not just LLM reviews).  Please hold
the PR until you have given people a chance to comment on the issue.

Personally, I'm okay with it.

--
paul-moore.com
