Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF836E55C
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568329; cv=none; b=d3vCZp79XEuRv6Exw038iTB3pCrzRvR6J1Of+KaAO1Hpa3+5o82UGdTobw2/QllzYd8TycBqUaxXzboRFENOzdQGeIV53y3KV2ZXgjYoFRy5A1EXojyVqX1iblmsoA1ZY3Q24exoOld3tKOuJ2Z169qQGN+vvxz3LLM3pGUBZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568329; c=relaxed/simple;
	bh=OSbaGxylfXTH+BLiDHzD+DY1WLT+SLGcOG0mg2DHMmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X32chOGY4TVHSc9DH0mmSznw5VQNLAAwUUgYg+WB0paTP4/AbLVVjPdHzdkcgN/XRhnaWbsfm9F4wAJmdRmSJ2Tzgrebb3OwqHMgYbkT+p37QKPVfzXO/q2rCR9YZpI/P4D1nfbYUvRH/zNY+LDg+pOWz3FeTAu/PAo+Ia75wZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NwoEblo2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NwoEblo2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34372216275so7514091a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763568327; x=1764173127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpF77zHyfnr/cz+JbdZsh8tIY8WKpVhk9QMFKr7llHo=;
        b=NwoEblo2VFE/32LmWnRcRcQAZZa+StX94BGys39TTvziLCo2Tldd19BgvQ5tfvP+w5
         NTyEbOPSZSljhKbdCWOzCjuD3+9iygcsozOpuspca96shhUP+jarsP5XptLoMJG6x5RI
         s/t3yPrMOq7zFW9UKRGrUN2lmb1Yr97663LPAW0KXp9p7kxcpt7oA3o4AxJ4qGaAbvji
         ibWsiu1Hf5CIVvy3+Ov4c88JC9X0oWbPPiYm/WXIxrVfKYWfIF6uh14Pk/uFdrrcS8Pg
         MF8rjslRvuFSLN89JMX/gVCQBtKmloCa/9xWimS0x8J9927IGy9ZeoUMwq4OcTEGSdUA
         e9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568327; x=1764173127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpF77zHyfnr/cz+JbdZsh8tIY8WKpVhk9QMFKr7llHo=;
        b=tivWqI3aUqsgphDRpStipnKtdcyOgUUkrtHRTHH7WTiuG5XJwLynLLG5XLRNmPPu5W
         jkt0JQogV455WOs2p94HO1Ocs9yKcjB96jyn25GKUwUHEiIk9stfHBlzCWJz0/m0d534
         zPwxj1EEOZtgnZjrMLWthgTAoSG6BHRtGbYSIlDzdfq+C3HQf7LtNWCx4NI+s6K0vdJC
         mAfNFyJuQkspwyOWMZEW36ju3o3wAwJMnatgSD3eqEXO7IWOyBvZh1/MsQVUknEtfN6b
         U6TVupXh4ARrLX/n5wThGqWHKpQGNkUXEKa7hqQ9IQlDj3XEosUMK4WcViKKnFFq0+NO
         6AeQ==
X-Gm-Message-State: AOJu0YzWE5ZK12KhQrJ6yN3t6CeIVg9VuLdHBIfHj0rp+jXpQno50LHm
	DCar8IwgUlBbfq/x7IZ7v3oq/PoV512TzpdZpCfGAOiaVVbYJfWpWLtLZZLw/f3nJKV3++Y+WZY
	JnhYXxGCEIZwpLdBMrcy36TEtpP17vsgvU+eY4eoa
X-Gm-Gg: ASbGncuY5oJLQ/Lv4ME5ljbOXLTDxgO/D0c14y8YlI6O6XDxj4IL0iwKeAJbQPxWB6a
	jSeD6DYbTvM9s0wtLsZO0FpPSmon2weNatCru0Yz8i2sO31H9mho/VOnDPeDFW2JdH6BZSZDTWx
	gOXsYTKKneXZ6+5UKVnbAMfMcKtv1eGwd0YEnLSACmCccQguTjvy/GLx7ngq6bbLLQXsZvIPuwx
	Di+3ilkT1IGn8ZJ125iiWiWQLj9eGH8ErKc4lSS6Lm79vEDk90jHUD6v/bNe1OE8INf9Qw=
X-Google-Smtp-Source: AGHT+IGhSJgJumD9dQw1DhQiUVKgI9u3Mi6+ILBIAkOX0AQAIlkIpnvugUtHp4WrLNhandC9paQ1kIXGLSalIgTEiZc=
X-Received: by 2002:a17:90b:5804:b0:343:5f43:9359 with SMTP id
 98e67ed59e1d1-345bd41362amr2979431a91.31.1763568327160; Wed, 19 Nov 2025
 08:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3641397.L58v44csPz@daniel-desktop3>
In-Reply-To: <3641397.L58v44csPz@daniel-desktop3>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Nov 2025 11:05:15 -0500
X-Gm-Features: AWmQ_bnRMwXNTT0_5ZL3bKd4u9pGiecXMJHCC4DeXdxerVAc_McB9OTW1sE0eWU
Message-ID: <CAHC9VhQNGnm6NBSrUmfwoEwAxqedYbHckEkb+J47W5gWjrKBOA@mail.gmail.com>
Subject: Re: [PATCH] lockdown: Only log restrictions once
To: Daniel Tang <danielzgtg.opensource@gmail.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Lynch <nathanl@linux.ibm.com>, Matthew Garrett <mjg59@google.com>, 
	Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>, 
	James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 8:22=E2=80=AFAM Daniel Tang
<danielzgtg.opensource@gmail.com> wrote:
>
> KDE's lockscreen causes systemd-logind to spam dmesg about hibernation.
> systemd declined to cache /sys/power/state due to runtime changeability.
>
> Link: https://github.com/systemd/systemd/pull/39802
> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
> ---
>  security/lockdown/lockdown.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Adding the Lockdown maintainers to the To/CC line.

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..4ced8c76dc6b 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -62,9 +62,11 @@ static int lockdown_is_locked_down(enum lockdown_reaso=
n what)
>                  "Invalid lockdown reason"))
>                 return -EPERM;
>
> +       static volatile unsigned long lockdown_reasons_seen;

I'll let the Lockdown folks comment on the rest, but at the very least
this variable should be declared at the top of the function.  Yes, you
*can* declare it in the middle, but just because you can, doesn't mean
you should ;)

> +       static_assert(ARRAY_SIZE(lockdown_reasons) < sizeof(lockdown_reas=
ons_seen) * 8);
>         if (kernel_locked_down >=3D what) {
> -               if (lockdown_reasons[what])
> -                       pr_notice_ratelimited("Lockdown: %s: %s is restri=
cted; see man kernel_lockdown.7\n",
> +               if (lockdown_reasons[what] && !test_and_set_bit(what, &lo=
ckdown_reasons_seen))
> +                       pr_notice("Lockdown: %s: %s is restricted; see ma=
n kernel_lockdown.7\n",
>                                   current->comm, lockdown_reasons[what]);
>                 return -EPERM;
>         }
> --
> 2.51.0

--=20
paul-moore.com
