Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CA2F12AE
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855384; cv=pass; b=s/XYAzDAiQzNc2kU0M6XJDxYq+lKJwddBix5DyYm0xRrcUD4HKnAPBrqn58ioci8AOAlpHELLekoSFJAfkSXlM2DtVCaoY7d+H8TAj1rVXCln4jYZM3vQkYDiqNjaYjmvp1fMQGOwb1M6kD3YEs0mf+bFYu9ivXKWYpzxxQaVjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855384; c=relaxed/simple;
	bh=ETQ6eDY+SrtspdH+SID48Rk/pkOlNOXeML+vzVx/MB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWQiGASOaS691YPtjD0c1LgZ4Eyuhqr6Dk408eqonjfGH38j3xn2qGRvKe4VftX38aKRmenK7L8ibitVqvlnxYtk8z7nv2lNMIRny5J55svYq84P3VFE+kBHvL5wcwe6nCTJY/9pI2F0FZIoHvBbx+kFjoGktlPVXlPTJIzHZSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEKx2bEE; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEKx2bEE"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12776bebe9fso235241c88.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 10:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773855382; cv=none;
        d=google.com; s=arc-20240605;
        b=Lo46cOnJ+dxsMLfW+C8IO2FrmSfzZ9RAMA5uVkumPkgzMc/RFrIjMEVN/uvmfGWjGX
         vxt7t4tUuiZrtWCMpDulUhFBkl6Mg8nG0xgp0h8Bq/6m01B6GGqFNzm2gYbiq2WanX26
         5mOv4J0+lf1Msg33G9uS+cus9kWo8jZaOwEZ0bCGRU5TDg5M3ABE1HdVArmWpjd+Vmly
         WsbwQGM9tbF0aFKU3DFJSpvLNKfIDXfm8rDHTpbyKFoP3tpyti+vP5plbcDPNciPkxUl
         cEtsXxI4+rPXuu2SAAzNewtPiDelzcGzLZNC4EdrqYe2EfWw7S3/Mvo8DHhl7NPBt9Jo
         841w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        fh=8W2TX+ZSZ0lmtg2PkYYh1IMe2e0+iuH0BoG28Qc9dlE=;
        b=EqUhGKCBnvT1ou6H0W/t2f4YKgB2cY5ED8aUvaI0Vb9so0rCKK04xNDV3P/glov9vF
         aDr5sh6l70oAMseIViTUW5zu+Akqrc/Mh1vRy2eW/4PyMOVXl/TVSzbDjOP/G6laBd5f
         jV21Vx+kdA1rb3GsZTq62SQ9q8ALej7USaq1wKPeSX/CH+8GMSGqwzzQvZTs4XxIP5OG
         Vfi1O48tDrvN6wA5Si9X+/uLKJayOXdmXZpE241jscadVG4IbIXuXjvQftCtWFjOaXm0
         GeeJ1C/KewKENIV0AH+trGLwKn2T1HLqCOxEY8O120nBMjbEKsAoW0y8uSrKVn2pN9Qv
         S4GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773855382; x=1774460182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        b=AEKx2bEERz2f7/KhHE67goH75bm9Og/0PVyvWwlEceqQjFBei7zXZoBUWdUkoXEANx
         DR69Zal/tu31gALsnZSo/ZhVQNYDObJZYIrEtOhrRRBs3tJ4nlQ6oOMJFsIOnyZ6RQdc
         1KsGem0V/nyu45S9KijOPLujW5iOxOSXg+hCsrk9TT+q8drCb7OHSRhJzFeOd9Bb1GAO
         RVbkFi9+3HoA+dFpQNDpJa3Zp1lEK4X2ZtgcERoc6QZiVrtrVTym8PO1PBgO3hBWvOtG
         D1J7cXk0DH6mQrMS/PWC5/Pb77RM27ULnDEd+TWcEZmTFZtzK+IPM0yIL2cqN6JiG2Ch
         yZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855382; x=1774460182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBZBsMC1tuLlkRKALQZa43xF7bjMBt9AHLZN8Ng7/jM=;
        b=m/VIAbS0OvhjZ0Ckyd8yzKIVt8G7Ku/i4SDp3NEa6irwB3iEHPxKYteT/pp2LYmhCn
         M8OMPA9gxLg2Gs9ku7KSfimOutyC+gvdX0Ie5Zi6N+ss+rs4Y5PSukY92+4Zf92Vtly2
         iw5KCWKgGqkhfgK3syWO3SIKzymw3brssRHqjorS8yWGVx/rEpsRmDvzVYrwJloR7raP
         HLXquevpBaCR37gUGykZa6hXjH8j/uuPl8rCFpkqIOL+zENnkxWT9dGvdFwJAr09xl2I
         J6+MvgvuO3IrtN3bAnOt4M9gnjEfRxQ93jXd2YbDV3h+OrMQK1Qz8a8AOaieF9KqYrQr
         p7rA==
X-Forwarded-Encrypted: i=1; AJvYcCUCI6IPi9cYujSyor7EglgrQPjePhiZznzHR6h665HvGW1jKSwa2yfwz5uPo70ZtLim789kfyWHVIB4cqBMT3DgXme4KiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwftzEHtmNmgSaKl/5I148k9pp1qCkb40aSzUtjeNvZvwo4b4Wh
	Vy7wUaytC7BYm9nMR+BMyA6yZ/bQvdSkubWWxOTMgg1gW7BbRnE0NmWTBjw+eDiHQm56jLZOMmK
	o3e+UZJGrOhxEzA87iiFEJXCoTaOMPm2xun4ute5r
X-Gm-Gg: ATEYQzzQCobvv/QsDq4VGkXHyNjiVAlTDX3Jquvrgi9J0Up6cA8k8H28R806P/pQSFT
	xkOWxbczgo3Yg6Ake+xBpWJARLoRBkgLEuZimGEU49pB7tG/2LyEVytCCddRu9TxF6rSdkrGZYw
	1wBi/+YwKOCcxUJJ8Toj7T+0TybGieznNN855WkKtYlWPYbu8jvVHW69fQR7CBKEd0fkImv9Jju
	j5bx7JrIHkltNCikQYvqfJvC5Q9SccjhtSQLebz9ZxGz9SsXQy1IQrlgnwWn5jl2mt7U0I67T5v
	/PlUZQ==
X-Received: by 2002:a05:7022:102:b0:128:e2a9:d97b with SMTP id
 a92af1059eb24-129a71c3221mr2167012c88.42.1773855381476; Wed, 18 Mar 2026
 10:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125192526.782202-1-jarkko@kernel.org> <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
 <aadTgsbzDDkCg1Pr@kernel.org> <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
In-Reply-To: <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
From: Chris Fenner <cfenn@google.com>
Date: Wed, 18 Mar 2026 10:36:09 -0700
X-Gm-Features: AaiRm53CRvkQ4Q080Fnyv4js1FR3nt9n7ROPC-ZktGzrj5RdGkL16HIOocsid-Q
Message-ID: <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Jonathan McDowell <noodles@earth.li>, Eric Biggers <ebiggers@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies if my long message derailed this discussion. I meant to
support Mimi's concern here and project a future vision where
TCG_TPM2_HMAC doesn't conflict with other features.

More concisely, I think that:

> tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled

is not a compelling argument for removing TPM as an RNG source,
because TCG_TPM2_HMAC is known to have poor performance already
anyway.

Thanks
Chris


On Thu, Mar 5, 2026 at 7:37=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
>
> On Tue, 2026-03-03 at 23:32 +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 20, 2026 at 10:30:26AM -0800, Chris Fenner wrote:
> > > My conclusion about TCG_TPM2_HMAC after [1] and [2] was that
> > > TPM2_TCG_HMAC doesn't (or didn't at the time) actually solve the
> > > threat model it claims to (active interposer adversaries), while
> > > dramatically increasing the cost of many kernel TPM activities beyond
> > > the amount that would have been required to just solve for
> > > passive/bus-sniffer interposer adversaries. The added symmetric crypt=
o
> > > required to secure a TPM transaction is almost not noticeable; the bi=
g
> > > performance problem is the re-bootstrapping of the session with ECDH
> > > for every command.
> > >
> > > My primary concern at that time was, essentially, that TCG_TPM2_HMAC
> > > punts on checking that the key that was used to secure the session wa=
s
> > > actually resident in a real TPM and not just an interposer adversary.
> > > I wrote up my understanding at
> > > https://www.dlp.rip/decorative-cryptography, for anyone who wants a
> > > long-form opinionated take :).
> > >
> > > Unless I'm wrong, or TCG_TPM2_HMAC has changed dramatically since
> > > August, I don't think "TPM2_TCG_HMAC makes this too costly" is a
> > > compelling reason to make a security decision. (There could be other
> > > reasons to make choices about whether to use the TPM as a source of
> > > randomness in the kernel! This just isn't one IMHO.)
> > >
> > > The version of TCG_TPM2_HMAC that I'd like to see someday would be on=
e
> > > that fully admits that its threat model is only passive interposers,
> > > and sets up one session upon startup and ContextSaves/ContextLoads it
> > > back into the TPM as needed in order to secure parameter encryption
> > > for e.g., GetRandom() and Unseal() calls.
> >
> > Neither agreeing nor disagreeing but this patch set clearly does not
> > move forward and I spent already enough energy for this. For better
> > ideas the patches are available in queue branch.
>
> Jarkko, you totally ignored my comments below.  I object to your removing=
 the
> TPM trusted-keys RNG support.
>
> Mimi
>
> >
> > High-level takes don't move anything forward (or backward), sorry.
> >
> > >
> > > [1]: https://lore.kernel.org/linux-integrity/CAMigqh2nwuRRxaLyOJ+QaTJ=
+XGmkQj=3DrMj5K9GP1bCcXp2OsBQ@mail.gmail.com/
> > > [2]: https://lore.kernel.org/linux-integrity/20250825203223.629515-1-=
jarkko@kernel.org/
> > >
> > > Thanks
> > > Chris
> > >
> > > On Fri, Feb 20, 2026 at 10:04=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.=
com> wrote:
> > > >
> > > > [Cc: Chris Fenner, Jonathan McDowell, Roberto]
> > > >
> > > > On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > > > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and =
thus its
> > > > >    use should be pooled rather than directly used. This both redu=
ces
> > > > >    latency and improves its predictability.
> > > >
> > > > If the concern is the latency of encrypting the bus session, please=
 remember
> > > > that:
> > > >
> > > > - Not all environments expose the TPM bus to sniffing.
> > > > - The current TPM trusted keys design is based on TPM RNG, but alre=
ady allows it
> > > > to be replaced with the kernel RNG via the "trusted_rng=3Dkernel" b=
oot command
> > > > line option.
> > > > - The proposed patch removes that possibility for no reason.
> > > >
> > > > Mimi & Elaine
> > > >
> > > >
> >
> > BR, Jarkko
