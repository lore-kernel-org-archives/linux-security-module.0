Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E036654C
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101860; cv=pass; b=ePJ8+knvT59b9zpwARNJCdJcVawmbrP0fKEP1PIQE6aNVuC1CxuW3XOW4RAnci6G11eBSrhv4iF1Wsycqda+wb5RRq9/PBWinUYtw9f7Fq4K6YXwSbw5halTwyaPtKA7ulkkVQDYTcWEDe5NK2P64LoSbj48XwAeZ1S0fDStGjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101860; c=relaxed/simple;
	bh=lp4Fd75D+zpd5S6rj0udL4uJRsRABOZub3NQTzGSAmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXI/gRNmDi/kS/4r1oaN/xuHA2hl3oFdMqVQkzMujyfxto3in84cMbvDMY0pB1L7jHE4/5WD1RsRq6aOCvTzmPozIURI952oIaQdHrP/W9Kk6UDV7b+BPZLRPY30JTpCz9KC4yfkYOaZrmqcppnSXvr/xioiqKU+xoC8TyNsr/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/uxCydu; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/uxCydu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so4320815a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 10:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776101858; cv=none;
        d=google.com; s=arc-20240605;
        b=a1QRVvo+x+7IGOT4uQQ6SQfkwRzGhK83nXCbCx+Saen/BAn3qmc4epk8prmRDdtLzJ
         TKduQlleY4wbxyGsVooYSOF0JB4KPCiTD+sVgGRaOq1crg9C47zXR4BvXO0StjZ6m/Lk
         xLHOqDka6Y9KO3RfDuLBypqWV04W2gXbUWh6lbGtgs0f4gPw2VlfgKIk6KVyR/ErTqi/
         25U7JPah1pUIjwgIGSaOlD9oTmMV+pbOWXvIantT4inVYiqzzLiw384t2NrLaGR9Zk2Y
         43r3iE6+f6bMgFS4dXA7zUTjzmFdMgUiKPCFD3INAvyuMJwh66yMYoewKhN1IiKkGsVa
         2oGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YYBG4x1DFbz+VBqkAR4RW8sKCaIDSRfdsR/wDZUjAbg=;
        fh=5WpnTWdbFMCxkxkw5WXMX5g+QKS9nOIXtyuSnll/MoM=;
        b=FlyG4UGuU0bQabPg+VQo+fkDfsuADmnO8hemF/0h3btQSNUZG7kWCG9x004/ipOtCs
         GxAnufowiFVDurigW/s0+58jrF3/9MNF8hIf7fOQDAGW38mjxToInPVrBvZ2vIohRorh
         wEtKpvYtFT9gJwnN7Y+U611w+Cp9E3WJGuOOSQvKve2vBhMAqKGWRnNYWxd5J6CSVoiz
         rq5AvXkPhU9p13Z8vXzWfleYvdplitmnubpFTYVZkXzhnXFCO0eAeJm/pRt7VqHK6zas
         bbOpy86BpWJ9AYxuuM/hoOXR7MShMw0ltmBWKOgtVcP+WueC2oXMIbhb9gNxHMwx6sUl
         wcFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776101858; x=1776706658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYBG4x1DFbz+VBqkAR4RW8sKCaIDSRfdsR/wDZUjAbg=;
        b=T/uxCyduePJXneLaudoUwIu7PnUI8rIjfbcIopWVyjbp7BxxMS70Td55dDcnUIUItW
         UjjE51xP9xJpSYET8LkrasSdXRyZa0Cx24Au6xNmwHatQddt9tssmzlHrpkCvIYA2XrW
         /LHbnm7xRv0pogErDN9NUE5T52UIeWekMESqhedgbHzJ9NFpxe1u7QO0e1H4qGrjGfu7
         Lqy1ZDQXoa99xDhqnASbGhDzHnV99G7KAf+YThP26iCRQGLLxNifR2U9sw93lbXIDttF
         AVCcPMgEitwunzTTzpEu3QR8tGLzr6P60QLpEMz0j5ai8XofRB+uSlPtdmlacwdGtlLX
         at4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776101858; x=1776706658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYBG4x1DFbz+VBqkAR4RW8sKCaIDSRfdsR/wDZUjAbg=;
        b=K8jVNkIThSOckoA6ovqOacaSIjGwdtvFmokWaW3fULS16RF/I8IewwAlJ4otF03FwL
         Of6j0YPOm4CDbZS3PIu8pFdngxO6DyKflceUIpbO5bj+vMYnHGpQi9HK3N05794hfMBk
         6uqR7e+LPEyU73aai3M2Wj7uELX0i6wi5nobKMemc5Nj5ud+4ojYOi3IDyLqNtt6qks/
         lHR6x+OTZloy3h2asSXj7cHZFKa4si15kq6YRmkZ993VYlJVRrSEDsVk16v76Kk0zLEw
         UFpc1ZTAsq0o4pGB1Ekgz+QfvizNiaSepuSFs+amv+5uXGGpiu09kTWWxjRt9uJPLTID
         0bSA==
X-Forwarded-Encrypted: i=1; AFNElJ+cePLgqfVVPbPDZtteTTfOvU9K4e+peAm2TBidxMDgn/l4g/IgmmyOLrsYJIBXCPRkdA4bbnByStQ9OvhqaC4x0s0rU3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ab5uhDeUsY0RP1yBsyunVRdgLITqZWTJlPPdeVUj2n3d56jZ
	bmwpvBykaQBZ6FdxGh9yODtMI+Ux/uBeVBfAfB4kjM8qOGfnwXij074Uo9m3sM2CSMe4E19K77M
	NEePdB1z/mtuWZW6EA59QpOhPKl2VmDM=
X-Gm-Gg: AeBDieuHGZH/1QxckmRoDDbrhRxsGqWQF8CDsS1fRRRLNG/7vPlO9/FHxuvTaogINXp
	d5BEDP25S19XA6FQZxrjExxNe6mVVkZnfyPFll9BvH/GhvKb+TtlUzto+TYRNX2/q5m1S+lyRa8
	7YpdO+TsjOPfGWCi4/OikgL3swhJsmctFIbqTe9CPS8UqM1aWdKszdWwmuRFe4UMTVEoKEqKE8w
	7E4xikRXlKNyEluJ12orNxPLbO+kJeAc77qalQaYnKMpMfLpVHkfsYNkyEpn15DX6vyMW4aNA45
	1cMrNUE=
X-Received: by 2002:a17:90b:4f41:b0:35f:b227:db86 with SMTP id
 98e67ed59e1d1-35fb227dde7mr5653922a91.2.1776101858367; Mon, 13 Apr 2026
 10:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408114257.298500-1-jiayuan.chen@linux.dev>
 <adhLQDIILT/sHpzL@mail.hallyn.com> <a17199c6-fb52-493b-b76a-505faf27cfa0@linux.dev>
 <admI7uhx8OZ5NzFS@mail.hallyn.com>
In-Reply-To: <admI7uhx8OZ5NzFS@mail.hallyn.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Apr 2026 13:37:27 -0400
X-Gm-Features: AQROBzAEpoZa_76jl-0FJ6LHwQNhQpsG_udCxaSLJEA79BmjXuUemBDc97p05wE
Message-ID: <CAEjxPJ5i1C_d=5kqAzUAKpxgOMyG+ydkVbZ2mi6zbyMWaPzmLg@mail.gmail.com>
Subject: Re: [PATCH] security: remove BUG_ON in security_skb_classify_flow
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Stephen Smalley <sds@epoch.ncsc.mil>, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 7:36=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Fri, Apr 10, 2026 at 09:56:22AM +0800, Jiayuan Chen wrote:
> >
> > On 4/10/26 8:58 AM, Serge E. Hallyn wrote:
> > > On Wed, Apr 08, 2026 at 07:42:57PM +0800, Jiayuan Chen wrote:
> > > > A BPF program attached to the xfrm_decode_session hook can return a
> > > > non-zero value, which causes BUG_ON(rc) in security_skb_classify_fl=
ow()
> > > > to trigger a kernel panic.
> > > It would seem worth it to have pointed at the previous discussion at
> > >
> > > https://lore.kernel.org/all/CAEjxPJ5aA01in+Z1yLF1cwe-3uqL_E8SKGK4J294=
D5eRG5__5Q@mail.gmail.com/
> > >
> > > Based on that, I guess this is probably ok, but still,
> > >
> > > > Remove the BUG_ON and change the return type from void to int, so t=
hat
> > > > callers can optionally handle the error.
> > > but you don't have the existing callers handling the error.  It's
> > > conceivable they won't care, but it's also possible that they were
> > > counting on a BUG_ON in that case.
> > >
> > > What *should* callers (icmp_reply, etc) do if an error code is
> > > returned?  Should they ignore it?  In that case, would it be
> > > better to change security_skb_classify_flow() to return void?
> > >
> > Thanks for your pointer.
> >
> > So I think Feng's patch is sufficient and can by applied ?
>
> Well, selinux_xfrm_decode_session() calls selinux_xfrm_skb_sid_ingress()
> which *can* return -EINVAL.
>
> So I'd like to know, what is supposed to happen in that case?
>
> Stephen, do you know?  Is it safe for callers to ignore this?

I'm in favor of dropping the BUG_ON() from
security_skb_classify_flow() and just make it return void, ignoring
any non-zero return from xfrm_decode_session.
A slightly cleaner approach would be to introduce a separate LSM hook
for skb_classify_flow() that returns void rather than calling
xfrm_decode_session() from security_skb_classify_flow(); then any bug
handling can be done in the individual security module.
