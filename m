Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC427F19F
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371374; cv=pass; b=s6vkRig3dudbMelY4ZHJnBibhELSBxxYqys3JSQajprC5W+K4SBcciHhSyPlKpBHj5WiVVaQDp6c07zCpe5UcaJkJhlGyDXsZea/uIghwNyhYMVDWu3tO8n4dauE5VWglUBWy287JgZfhurCZlUxCJhsLp0xRe+/rQgW2fJD6qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371374; c=relaxed/simple;
	bh=LXwNrxCgBG5GNnTd1emEhDjJRFk7DxW4KT7FqovDdJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sa0zQuh4Ib5UXphoX47zYVUIZhO41gDlp2wttX9+gYi68AckJRGEMZimUeGUIszgDwy89MAExPR20KANnxMpY07yq3/NFTDiuPjuUGZpVkMujhwLccx5pl7UMY+L9CKXP1n7QbOwzIbrEcKgB64AY/hTCp+4WY9L2usRdfzYU1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RRiPq9S7; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RRiPq9S7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so2690497a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 20:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780371372; cv=none;
        d=google.com; s=arc-20240605;
        b=cEauuMNWIz/RxUXkxC3hYWZFflVyf4t7vxaQUsSD+G2a7l4yHgoMwLPVwX/rqAli2P
         62CJfX9Pv9qYmlR1lLjOIU8heRYSXynW4k5OQHHGGgPksY6He3hsPsmdKpuaVar14goF
         1PTQZ3d7Xkdmbz3O3XXXeahkop0+3V94IRujNUh9YSt8HB2I/EJ/jpszy3qnNHWu664e
         wei8js3Kl/2+kjJP7gfP/XE7Rm/GmmLGPlFA9zOd2xwYzbtxz5IOJmLbmbzp5pyjhfm2
         3Q+QMviqm3X/4yUpfAQJ8RE6YZUc1l6c39luFFu6FFyaQOErJQwvEjSYbiZYLticQAjp
         Iq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=guZF8w5qy/YUI4Ls4upKuYEa/kskMCsJC4e+OUdLJnU=;
        fh=+1CiNNf33DsFd/QKubk9N4r25IXWNjOOtIe94txjndg=;
        b=eYGOK68MjwwuwIAEmF8rqeRgXbyqUpdjJ4m/yaNz5cPGiDvaDYH0xjSFvoaroYfDaC
         TA+d85fWDqNd0MqGsIncQ5rX26C40qwyQXk8SDS/b4J4OpNu/hGy0hjqaEpX6tY2lySt
         Wd9JbRuh9CqRQayqD5ALXoRB2E9DtPGnTrn78jyx7CQFTzmN29h+GgeBVMwjrsmp2PeA
         jXbb5yiVVosw6L+ceJhMBQM4CiEa2b9fCI5uHWONpZnF5PuB05XlMi5PIBEXqzScdiUO
         isxg4dBh4lYw71U/eE3yPUORLa+tPPNbkMtuGDyvu12DYbepT69KXK8SHUlVHZFf1pGn
         7tpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780371372; x=1780976172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guZF8w5qy/YUI4Ls4upKuYEa/kskMCsJC4e+OUdLJnU=;
        b=RRiPq9S7+5qmC1sGnMCJkALNcD4CnXVpVfd7l5c64k2pZGR/zzuvk7V3FoFcqBw+cJ
         tbYD7mIghi4SHd+hIdXOzbj/GwaWRHs0ktQ8pgXRjKRER9Guwgjl3j38RNKQRLIIBhV5
         qxriK8cudUhaY8ap/W8V7EJUxW79vLw40LXFCOMQoUaxiLsfAyyF9MSPQIuW5+jAeIWd
         RcMhyvBbTfNuaKnOxMohUaDJ/jvcGGfHq/AhpFXhz+dUx5KxJrWQbMeORu6dKruSqzia
         ods5T1RgnbUfM4q+40HO/bnR8Llk9TQLmxPO8/kLj4cLXlkyq54r2rzC67ZMknvsx8Wv
         Nwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371372; x=1780976172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guZF8w5qy/YUI4Ls4upKuYEa/kskMCsJC4e+OUdLJnU=;
        b=Tcro4GKVlwoohvw2u3F5DVJGPlGxFDnGK+euGS0isVRqSUsTW2ZT419caWUF/OwadQ
         teZUe1f2uws7oiWTDoTiOEH2o2rhtN0y/zqadtboDc33JpKb+knfbvNvjbWXLHufEeWq
         DKq3a+Vh1V50xVV0RuFh9Wmvl3o9eOVaZhK6+AgEfpgObjjkn+4KZbjcntD5ygzE9a9+
         hGAvjLK53Pal4W+oCE2p4CBSrBX/eqp40PL+zIwDMXuYQMu45p+0kh73YPdy2CUFFtXE
         pyXdQ5DW1TebIzxL86mqxKfEnn2E80a6Oqo/zObyE8jWhWJSJiUqm1Xo0h8/XmfnlGu8
         Xiaw==
X-Forwarded-Encrypted: i=1; AFNElJ+m0UakpRiMVwYsc8PuVpTAgEkgEyTJDSWB3t8BfLkJIRNxBbpLpuwSjZi8XBkD7FA774jIl01r9kh/58blEJm6II2A8AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBw/VP6zeQ9HFw+S6kLlMIOoo4L1IgJ5nwCYS0m4MU6gYVzJzE
	yN9+AfP+su0JjrOmKW7LmFQMVYSVVD6zcVHnEltScRfKqopYI1LE1pVHLpxQtqu/gr/GR4OXZew
	wVIw2Hf5sID8x4geIkP64Rttw4xMEoJNz329LuXpoLoPDUIW25Pw0nw==
X-Gm-Gg: Acq92OG9NzAahGLVzN85K6tIdOLpmsp05sHpiCxhOkmuiDy5IlTEYDsGXTCZwb9Cxwd
	LSUqJ2KuJB5WuNNzMfVpj0dzkDTgJug2E71VfKRNfSMtFzDxvXWg1XZ9/YndbkX8R0+WdM+f3az
	pfy3RENsmr336oMK2k1umLyfmoZu8hvYd2JJiC4XDQ40HUoTIcNV0n+jMP68fJspD3KJeMyKUd8
	FGLJY+pA63LVS2CI8ibUC5lt/vPt14h3LgJUvE4t9fI6dpCFvECmomCjXTQR9bw6qBWEQT2uLx5
	y/e+hY2UUmwbyCWCsg==
X-Received: by 2002:a17:90b:3f08:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-36d81b3691dmr10366436a91.7.1780371372322; Mon, 01 Jun 2026
 20:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
 <20260528030915.2654994-3-bboscaccy@linux.microsoft.com> <CAKtyLkHtjzP3YsDr5-Gw0GRFB7Ch2h1amZzxy5taTt_+3gSzwQ@mail.gmail.com>
In-Reply-To: <CAKtyLkHtjzP3YsDr5-Gw0GRFB7Ch2h1amZzxy5taTt_+3gSzwQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:36:00 -0400
X-Gm-Features: AVHnY4JUWhcKv5czkOfNWOhz--OdEmA0wyzWix7EEYZek40C5DIJBO2G3ghYmDY
Message-ID: <CAHC9VhQ_c9BOLXbYRk3+9_TPHbFW93-NeTe3fypxnkQOif69TQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] hornet: invert map set check logic
To: Fan Wu <wufan@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	James.Bottomley@hansenpartnership.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 8:57=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
>
> On Wed, May 27, 2026 at 8:09=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > In a multi-map hash verification scenario, a logic bug may have
> > allowed an attacker to provide duplicate maps to satisfy the hash
> > check count. Instead, invert the logic to verify each map discretely
> >
> > Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> > ---
>
> I just realized there is no audit event if hornet_check_prog_maps()
> fails, probably should add one.

Maybe, but I think it is important to remember that not all LSMs use
audit for reporting, and Hornet is doing some new things from an LSM
perspective.  I think for right now it would be sufficient to use a
pr_notice() or a pr_notice_ratelimited() (if we are worried about
unpriv log spam) message in hornet_check_prog_maps().  Hornet can
always add proper audit support at a later date if deemed necessary.

Blaise, do you want to submit a patch to add pr_notice{_ratelimited}()
in the case of denial in hornet_check_prog_maps()?

--=20
paul-moore.com
