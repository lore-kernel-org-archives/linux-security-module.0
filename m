Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214559;
	b=GgIIduDUWZ08ZGf09UZePTZrtPRmUhbGrKbNiCh9U53PCRj4hbcGspboKu+5lkjq86Ip
	 pbB5ntyZYzRp8Fko7vfjIVT6R8dQjMwymVRbTskJvMmzZTL4tciYpCtG8Y6pocVsjHl8+
	 zfc2UKC5ANbodstSXKAV7hO70Ac8iBy6hE2qxJFrZ8x4L+1QjJWwjpYbefEbEGuF7/lU0
	 WK3v+NPYnRM8IADnGWcSFmlwhNM1BW/VuxXm17gflFomR2tYMJYO5VCAwWZo7NSJmvoE0
	 YZ6x4A8hIkD7g/S653dweZcSkUw6zgP597+55glkip9uV7RmGNM5ZY4qn3n/swxtz6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vHqmqtUv3ldNxNv4goZfjp24sRWMWgjGzY8HbYBqnOI=;
	b=HXz75FcuGYyK7yCngiNbHmY6Q2zHepoLyqx/ZWjGLcl1Xx0JDhtrazy38OvQS/k7G+2S
	 VhcOq/FUOyGLwj2V5R0dLaSHuldqS+nrRbIzp92i3b8ucTDrvYlfG5axThUbEEoVDUO51
	 m3oNtofBW+Nk51eo/VZAVpzZOV8F8oMXBJ8D0W7u636k0RE6tQ9fPTz/gE/hSgQhcsxPq
	 Twu4KbAXzCRhsnojD2cbPu6gF1zq7iLhAB47j1zAeXqn0Z4Fq8N0y9AFCvGObV/GUeXYR
	 ljNwubYgUlsDPpjoW7kCUz2WaV4SmQdIWKoWXqBSfN6S4EJsIRz5VWbsWJ1pWWCe7UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OJwL4udw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B31606A32A
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B31606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OJwL4udw
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so841654a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 14:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214557; cv=none;
        d=google.com; s=arc-20260327;
        b=UXzGrfzpxu5pRK7/qwdmzM8SbsO//51Exg8Tu5SvdqEQ07J8h+XkNokMhA/MddDLV4
         wYwatVh7e5pG0KEcG1TLNLYL6RjP/DKLiiZuzovrWkBw6ncx63cN54zEvVr8wGgg4iwA
         nRruV4QhcuRPHL7Ttmn6Pi446D+bbmJuEnRbrwEScXCRXwz8rC0dw7ol115Ug5jTyWxI
         SecWS7ihms/ntv4SJZPlddTcW6qE5D3qGHCkgzOd66NmiC944dcGVeqeOUJ2cinh7tI/
         3OlvSWjuhfagGvq/i7K/jqVjRF116/rGqSDeqYKhn28KM0eK2X7ZB9x44nNEEgTvGagP
         gm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vHqmqtUv3ldNxNv4goZfjp24sRWMWgjGzY8HbYBqnOI=;
        fh=kXOSLmDeYdJjrJdFhq0othJlNupY1D1aBLNOWcTSZjY=;
        b=GjHGX8z8XRxQ4XABU5IJy3S1VDZxCePoYdVc7H/Oq+if/wLKL36MzNKaFMyQG2wqik
         FuZe4jvSunj1ygFceMTcAmr7kEQsLQYoC86aLksIyNqNU3qh1LZ3dAqdHzOBrDF9UgWm
         wFEyDoiCqvE98qTYPZuIZeo9cd53ssQTLD3J/Q3ECwnV6zIa3YbLfBss6lWHv3C7JxMm
         YHjGLgTRCbGSpiPS2gGBDJTlu5hvFVkKJSjYEvpc9zRHFRMct7SJXF4X64TNjpt3Xu40
         0GNNVa4NENJ15YzGiyhD+9VGAWdvgdc1KbuSvR8yod5JBqLoxUFw/Kw8SX1VQI+CeQbD
         3POA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795214557; x=1795819357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vHqmqtUv3ldNxNv4goZfjp24sRWMWgjGzY8HbYBqnOI=;
        b=OJwL4udwjxpmrVlLHcONzEvKUwhIev56POEovLo3PpC21XYiIbCLjZym094IUqQtp1
         SzD3eL2YEmvY3tysOdOdNwsBvOmiPtoMmHs9W1NuU9fUrWicTXKcvYPxfOCck86JHzvT
         qbzhYmAnu4rs7/Vg9AJjp3SqzmuPPN3i0oIPTtuiuDD9ncyts0iF5uFGUBBego5huwqI
         UqKAd2WvunRkHPwyE5dN3n7lAhAjzJHhnmA6+dI+i7PADtHvZY9fGm65FaQVH8h/LZyC
         qOPtpKrdHbE2MqbsGQXCYLz9M1C9jJelpoD3tNstDXxXkAUrYEM8x00PwAvGX8rJVyE0
         16Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214557; x=1795819357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHqmqtUv3ldNxNv4goZfjp24sRWMWgjGzY8HbYBqnOI=;
        b=SyJgVMrX6U15isUrFWzBOBjyNWOFa3ysadz6coNtaPz0iFcAu58KYvNTEYD5wMOi+b
         QoroCEi6Xy46O5HX1h3YoBNjvYg2SmnWWsgj474RtewpxJsHxyt/7On0wWOW7GU9HyDH
         MV6MstfR7GiLMtjnar4B6zlI/cANRYTubDUDvv2fecImZfCjtGdcPWnhMw/lu6rQrRb7
         MGSlyMTfgahyC4ubBS9/1SRXl16OJv/yKdPuPETPI7vTuRzV9W3J/zff0tfJWJ3fmhkJ
         nmQKOSggSmEtvTHs8S7lzqz9/qE8owRuBQIMsDYdOL2B84t54T5IfPrFK1a2L11pNbpM
         8pDw==
X-Forwarded-Encrypted: i=1; AL+hErH5UYW/RYQMGatmZiA+9qHDdqujw4aRFGBH13CEJz0Kl3dmawIWLHc9PQcR3oAn9etre+WVguskYNMZjjZEK9eaVV9ypCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QNxms24xnfscgbbGSKYLbZWRqp+ul6AQAqjYxEyWNsHeJZ/em
	8VMnPToZyLLatZHCljcEaZAFFGwm1IMUqLuwtHrTCPe0gp4VbijOGzcQIxcveX4dL3EWY6a+iJP
	H0K6lshvl43TnwidU2vv0gmDf7ZsMKnqJGeH2ha3a
X-Gm-Gg: AZFdTZdqE44VgvRSm7Jq7IoC72tvbVDDhkRBRjgoczEvq2FGXvcQhmIFl3P2mMYKTU9
	iy2aOWU8QGwZjAiQbxNZgYE5GEpKgQOHxMXBdUWGms0PavAUvXzoDxGw/w7xSU1za0hM5kctF0i
	z3DKnBkWwK8v1SBWVXL4kTEVPmAFOiOXM0/HJl2I0+dTsW+Z2LxO260nSxRF+6LgOlZonO1pJ6I
	FCNJFt+LdyKy46PIkeoJByEp77gqXGLqpqajncXqMssr/uwhUI6G3oxcpQaWNVf4+zJEu0ygLT2
	ERQFYesNgjGZOtBbp8RTRmshJY7s6/ICUTyZ3JpFKROTxghrj3tkXz2uxt2s6jRMR/oBAKjyAl2
	oYi40K6fwr/0t7+FAh9Ta0ybO9AVxm1/0mVz8CXZ9R9WO3Rl0BxREMN+Yw3yJLQJMkq9w
X-Received: by 2002:a17:90b:2e4b:b0:3ab:884b:659e with SMTP id
 98e67ed59e1d1-3b41c8e1705mr3678138a91.9.1795214557060; Fri, 20 Nov 2026
 14:42:37 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1791023194.git.tjdqudcks0424@naver.com> <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
 <asLNxHYQ/xQ6KaWy@hallyn.com> <CAHC9VhRMCfahvx89HjSoHfyKR27swLdt2HZuM1enmoi_gxRyRg@mail.gmail.com>
 <CAJ-EccMjtVkvM5bZzUKDAPcOAKZbd1Lc59oNrW0U8m=s+4R9eg@mail.gmail.com>
In-Reply-To: <CAJ-EccMjtVkvM5bZzUKDAPcOAKZbd1Lc59oNrW0U8m=s+4R9eg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Nov 2026 17:42:25 -0500
X-Gm-Features: AclHuK8McY1ik9ic5I54PqjcEuVP28e3vO7azigKd93SO_GqYl3O-C3M45QZMNo
Message-ID: <CAHC9VhSZVo-TMR7Z9xM=ECVB5xFZhdnHK-OHpE_i=1g4dhTfNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] security: safesetid: use real GID for GID policy lookup
To: Micah Morton <mortonm@chromium.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, tjdqudcks0424@naver.com, 
	linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	Thomas Cedeno <thomascedeno@google.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 1:44=E2=80=AFPM Micah Morton <mortonm@chromium.org>=
 wrote:
> On Thu, Nov 5, 2026 at 4:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Sun, Oct 4, 2026 at 6:05=E2=80=AFPM Serge E. Hallyn <serge@hallyn.co=
m> wrote:
> > > On Sat, Oct 03, 2026 at 07:34:15PM +0900, tjdqudcks0424@naver.com wro=
te:
> > > > From: Sung Byeongchan <tjdqudcks0424@naver.com>
> > > >
> > > > SafeSetID policies constrain the ID transitions available to a task=
 for
> > > > each source ID.  id_permitted_for_cred() always builds that source =
key
> > > > from the old real UID, even when it is checking a GID transition.  =
If the
> > > > real UID and real GID differ, the policy attached to the real GID i=
s
> > > > therefore missed and the lookup can return the unconstrained defaul=
t.
> > > >
> > > > On current mainline, a test task with real UID 1000, real GID 2000 =
and
> > > > only CAP_SETGID obtained non-allowlisted GID 2002 despite a 2000:20=
01 GID
> > > > policy.  The bypass reproduced for setgid(), setegid(), setregid(),
> > > > setresgid(), setfsgid() and setgroups() across three clean QEMU boo=
ts,
> > > > and enabled access to a synthetic group-protected resource.  This s=
hows
> > > > a SafeSetID GID policy bypass and group privilege expansion; it doe=
s not
> > > > show direct UID 0 elevation or a universal local privilege escalati=
on.
> > > >
> > > > Build the source key from the old real UID for UID policy checks an=
d the
> > > > old real GID for GID policy checks.  In three fixed-kernel boots, a=
ll
> > > > tested non-allowlisted transitions were blocked while the allowed t=
arget,
> > > > existing-ID, no-policy and UID-policy controls, and the existing Sa=
feSetID
> > > > selftest continued to pass.
> > > >
> > > > Fixes: 5294bac97e12 ("LSM: SafeSetID: Add GID security policy handl=
ing")
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: OpenAI Codex
> > > > Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
> > >
> > > Seems obviously correct.  Thanks for the find and the fix.
> > >
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > Looks good to me too, thanks!
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Micah, assuming this looks good to you, are you planning to pick this
> > up?  If you would like me to take this via the LSM tree, please let me
> > know.
>
> Hi guys,
>
> Sorry for the delay! Yes this patch looks good to me -- thanks for
> catching this, Sung!
>
> It's been a really long time since I sent any pull requests to Linus,
> so it might be a good idea for this to come from the LSM tree if you
> are up for it, Paul.
>
> Let me know, if you think its better for me to dust off my old GitHub
> repo and pull request etiquette I'm fine to do so as well :)

I guess it's up to you Micah.  If you want an excuse to get current on
merging patches and sending pull requests to Linus this would be a
good one.  However, I also understand that it can be a non-trivial
amount of work for one patch (which is why I made the offer).

Let me know what you would like to do; both options are fine with me.
If you need some help on the administrative side, e.g. sending stuff
to Linus, let me know and I'll do my best to help you out.  If you
would prefer me to include this in the LSM tree, please reply with an
ACK tag so I can include that in the merge.

Thanks!

--=20
paul-moore.com
