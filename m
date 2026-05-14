Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881C34B192
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777844; cv=pass; b=YwURn6hDAlemJjBCs3bq7abUp46LEl6543sXmv+ai1n8SHj0fvvcOeXI4J8RQa6waMRJ50Jq8OJq9hN7jm3Oq+32CIWHrVZ6MzBxD0sSs/PLJnVo9oXpMCz23AU9tLPfip7DmnIuu8cvqj0396oJUpLTivBG5DYf+8nJkkudNOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777844; c=relaxed/simple;
	bh=gTLzk65Wlq7iBwMKl3jnKKhunklTk1bYtsmu8SZML0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HizLSHVUN1854b2ijPoRKK6trcqq0NblHlHPrXxYRSGzFyarn1JqQIZf1JcVGW4sLh7wWMc5RVxjzlpiwP/0Hf2NqW20uJFc66K0V9duWyX5h3Q1myanW1jSPyemBfu58YFxbzVazDGPDTF6xkttn1RHT033Oeh2Ub2l8n65Xmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ov7LMCC4; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ov7LMCC4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b45cb89f7eso52784765ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 09:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778777839; cv=none;
        d=google.com; s=arc-20240605;
        b=Evq83VP2WWH+lKjQxev7z1CHo1TbV/vcSDBm6v7iY/gUCV/AszVwPA4c2DQNhs1OZs
         4FzCjTA/6pl1GVWTXhJZu55gbLNuPiBS0a7252Q9KVN1lFf4HwGLKBPi2VVejWBlj2Jf
         ojgAxgXCMjLMNNbBaHW0fc2nu1rnmh/aoRGhQGjGsGMaAb3SdU9A1AayFwR33u30s6NV
         /7nq3GyAblSVjXWeryKEWyO1Ejob0L/Ehdj299W6VpIu6dzTy1sSNA6FDbVdPlvwqhaa
         rts5sA2mtUuFALkOcYRWhuNBSvTyxf6hrFirKBYy3DpW73I/dp919t5IiUId5MjmQ3vf
         IYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5jJK7BgqyarUsPKvk9VN44OC2exHpd5VUzVJYJ7s6AA=;
        fh=GFBaop2R3GDr/Ojxg8k5XzSiX3sUG6zNbZPZPxSdKeE=;
        b=XXcHUAPwj0JAbuMcUKqO+9GrRgsRgk1qA0w4JNkrV0YG214XCstNoctr3oEX1yDlsz
         qLr1MNfANK3GfDkJ/+L3MuoZOZC2mFRApHcEUl2DUJNArUM6YOgEkXsAA6c5H/3DjUrP
         H6icfIK+dGZG/L435Q8QRFhdb04ePkptIbxZmaU8D88a/60s1AH+oIPKc+llTao1LMTw
         QJK+FGdqy9Zh90aQeF0euli7P0oBXtdKt5eHVuDeXTzzNQ0AkcEsPg0Yvs9Tw2Ys9O2u
         FtGS3elIwqh3eBz2KU1GCj9d6beR88bplwAKq138TVs7MMSr7QjxhdHvbkAHme7QRu8T
         yFfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778777839; x=1779382639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jJK7BgqyarUsPKvk9VN44OC2exHpd5VUzVJYJ7s6AA=;
        b=Ov7LMCC4FU1FnsHaAT0wCzJFWC81iDNKwQZ2k6k4ZgGq8b2kDz/xemXds2WFQR5EcL
         LzvJX7pdIVOLDOcV68aQTZiZMH7QaFJ5maOIUDhTojqTE4vW+zA2IwIUGWoEAt0+EQC8
         4U7tVWvEm81hhr5RfKvj6Hs4iaMAN9orVJ/rx5rqLtPtH4oj5mFZvLiuVwMteJDQoqUB
         CiK35gpBnvFo2o7Hlp2BF03zWxKPeeVFSxd+VRA2dkK6Xp/nTKFdIqDaE92u/M8KRrT0
         D1QHkb2utxpRsjvYD21h6jn63ZMO0tcJgAuGhaaJElfgB6QSExy5CKTy2n50HrMseggK
         XBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777839; x=1779382639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5jJK7BgqyarUsPKvk9VN44OC2exHpd5VUzVJYJ7s6AA=;
        b=onnLjWZSwQQWMqzuJpr8itYJWeXUmYzJIvm08IPyW/IPEr9Ba6piC5vUydBUdB+H17
         MsH9DwVCra4/5fbovd3Fvyx9vUt/mvh1bq/1Qo/6IVfxAElRbRQ7pFt72vUvtt5OBHhR
         sg0D/vK6SRA2evkWJYecJxH6UEfMXZfP4yYxuw5YIJZGDgn6DgGJnj2f8cBUJJymu0Hi
         FuWlEgWypix+h2uLCBPgDeTJrFle5Sor0LAI5g/oCEf1KvtKkxwc6QPU0zLj+dD/IqgF
         V3LV1HNS0QtoMmY7fa641xg7xhBHYEbgTa5FCSRggzKHcBpwoPjuD3ezvw3jQD48VtpL
         YcsA==
X-Gm-Message-State: AOJu0YxORjSwlhNoVN/u0VbufFtWiGgtUqcAqOja4FkoGCS4u19jqJ2+
	LabUoQO3wVDqpoJgWdZc6un+pNbVz8CzcrGiKV9Sqm2iTtAUqmCAiZgKqXipJi1A92GmKOkHJvg
	8J6XnpxVknU0uTioEcsqjzktlBeTaJT9Yvo8s+XKA
X-Gm-Gg: Acq92OEjltfUlOobewQVfjSX8xL3MUQcmb6tq7zEwlV2KO7bf4L9zrsMBDfpXclr/Hu
	54rfpowWzOZhlx3Otq7PHwoENWDov4m6gYVQa63/FEpfR3oyWsp51cotB54N5WASV6W+ARyiCIW
	a18FiqnyG6Fg4a8PQF8wOvw3MG09g92+W3TL5q/BKI0zI2cUwtx0m0BEGX4eeIpY7tuQmX7B7wv
	UxZGHf9OhBLT80YE7TF3FZeZtE7MBUE3zarP5prdig6NFWjChHsCXB7P8VAWRMFQT/NFMpoHcL1
	4i8V4nnjMPZ49apIQg==
X-Received: by 2002:a17:903:3c30:b0:2bd:7ff4:ab0b with SMTP id
 d9443c01a7336-2bd7ff4b216mr942485ad.39.1778777839419; Thu, 14 May 2026
 09:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514023640.574020-2-paul@paul-moore.com> <CAKtyLkF87QGh2PKjkhnD7XgsM_sDoDOrFq9v4tk7n7tTbggsng@mail.gmail.com>
In-Reply-To: <CAKtyLkF87QGh2PKjkhnD7XgsM_sDoDOrFq9v4tk7n7tTbggsng@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 12:57:07 -0400
X-Gm-Features: AVHnY4KYHJaL1r6CIFPXikcE8UPl98ituaGYOgLGJtA9vwhTanORPT36v1NKo8Q
Message-ID: <CAHC9VhRbgbMuUO=2n7CQ+fLoZux5YWmthOPp9aPUUa7XD-o+xg@mail.gmail.com>
Subject: Re: [PATCH] ipe: restore the kdoc comments for evaluate_property()
To: Fan Wu <wufan@kernel.org>
Cc: linux-security-module@vger.kernel.org, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 10:19=E2=80=AFAM Fan Wu <wufan@kernel.org> wrote:
> On Wed, May 13, 2026 at 7:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The Hornet integration patch mistakenly munged the kdoc comment block
> > for the evaluate_property() function, this patch restores that
> > comment.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202605141037.VVorBhvP-lkp=
@intel.com/
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/ipe/eval.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> > index 705c4ecfda69..23ae1edf896b 100644
> > --- a/security/ipe/eval.c
> > +++ b/security/ipe/eval.c
> > @@ -331,7 +331,9 @@ static bool evaluate_bpf_kernel(const struct ipe_ev=
al_ctx *const ctx)
> >         return false;
> >  }
> >  #endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
> > +
> >  /**
> > + * evaluate_property() - Analyze @ctx against a rule property.
> >   * @ctx: Supplies a pointer to the context to be evaluated.
> >   * @p: Supplies a pointer to the property to be evaluated.
> >   *
> > --
> > 2.54.0
>
> Acked-by: Fan Wu <wufan@kernel.org>

Merged into lsm/dev.

--=20
paul-moore.com
