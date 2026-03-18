Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D52175A91
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797325; cv=pass; b=eVIUWZj7e5E2jt+VBTjYN/ugQ2FZujReZljCmPRaIdOYrJmKYA4IjysO6o2ZPHp8sYGa+sEwMKCpp3g7ezSvJf+0dauh0MhvDORAoVM+LHctxZBHgOeYD0Un1jXKXP2qs+YLIzGXV2e20dMZ0sMZtOQzDcE9K/xDwaCTUBdOMRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797325; c=relaxed/simple;
	bh=2V6jVvZ8DlZMKMdAwcrjn8MFYhru6PaNYU+Ll7okqFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3tg+hiIt9nkkIQ0WqOXouynsTIk+HdkbGTwn9+JwbjJmruoipapN6OdZK6KrEa9XGBgsvvzkEVR8GqPFIoXSfKi8yD3C2I0mJTNBVkVI2ahg3zirGW+mHvsvxLLP6nX64zFGbRL5fvVgPZ1o+mK+9Dg1MAzPOd6Nbht8UwDbpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I4GdSUq1; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I4GdSUq1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a871daa98fso47804945ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 18:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773797323; cv=none;
        d=google.com; s=arc-20240605;
        b=ixwJd4RQ4CJaIOdOl4r999mdo4aVE2s6F1zv1ClGlZ/avK7GorqJPfxs7k6rhHt125
         VSR92gf8jy46dnS/Ex42ClExYYOSjrrNIn1m4fWEk+mVw8FjMiDpDhEcJG46HEwQCvZi
         Jdrb94RgS07gFQPSqJNE4GnkMBo5T5liKJka55CKTGOkYK5wCKiHEfgfmHEXsGnsVTp8
         XmWoK/qWo9WtnzieaetHxSdDr4RtvhKdZKwjSeuAEiUKJ4Cf2eEiFBMI7so54VsNTOKQ
         vp5p3A0tij0ZlUMuXm2OgWgp8xP7/xX52YVpGV7/Y0pxXzWpYQWW6aO9QFZpqd1vsUXj
         6LWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mn+do4vOB08303YGsDqP48zKyD6RFfKsS3ht+al/j4s=;
        fh=6tssLn+3pRYil18nQE/u/WNwyQcOcugaGGpEq9WoRNU=;
        b=UZs42KAIS6AkWzV+RSdINq9E0daxDtSL7fbZRwfPKECGiKMFmrf68+fuDLp+TRJqvd
         nyx2OlYV9DPLjGDj+O7PdakrpEpesl9WP6kZriIKGtFMHM72T249Sm2kfGVFzg47eBdl
         hy/+lT83hQbu9CyiQ2syoMAeHrcLk/eCv0U740EBlFsgRKP/keSYgPZGsYWSOmigTTaw
         3h/o1b4V8fOPAzGMlpfbzFMKMFaT+1yw7w1c3iIg/mo3GfI6Tbdf9R6z1qfGCZKy5unt
         MIHwcjbfM+PIWL6HOS9aW4Qfmcbx4NMCIxEG13/gvZYcIzH+XB58BF3O6PrtVJB6BOlj
         dT8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773797323; x=1774402123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn+do4vOB08303YGsDqP48zKyD6RFfKsS3ht+al/j4s=;
        b=I4GdSUq14LMm4VhAg/tLIBIycxMLnPi5Oc3flQnubWNSIZGKBgSNtvQOyW4PRjncDI
         +jh4I0r2+Oo5OuxI2Zp9+netTaeteAXECFiA4bJJ1d8GPV8QbnR70XBny2FJOw69Hjsq
         31q1nMshbbSL7LRC3Ywu2SZLvuTzvN0+xOcHY2mJ+XeCmoYDeNlxaPu584qpkkiVkrGM
         7Rt5m6WUX3ZUYU8M4IgEegRzBHe5WJGRtVR0SYKBzivWulfRqdPkXeG5ulxEKfDiV6ZR
         5piR3A377SMRDBDQ44XWqcCPI5DcJHXCXbNyv7+/l3Mk6KGgVgVxHFR2kPUsAYe9tk82
         PZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797323; x=1774402123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mn+do4vOB08303YGsDqP48zKyD6RFfKsS3ht+al/j4s=;
        b=KktamOAO6WWVVLqMW6CqTStl3xaE6tHkU3urMrBcNp0DPXLJL3vKrxNgVl6BqAjSnU
         LdY/EU7Kd1sQnzn4LoIKm0I4nYcxLgDNRXigdwlysAgX8zv51CkY23NBxe9hRBML1sV4
         DxT7f5aDQLlTnLypoKSgH5v8nzEu1hlZpuqPOk6IAXRQ3WRoKlp2W8JzXJecNiDjcJS+
         Ze8qiruwR3QCe9xix2zCKv3IS/AACpZMkHuC7gMhfOoNbxW+Jz0vJ6RsmDODpqSJU8lc
         NKTkknZ8nJliJeMTldVvW+0o1pVKdsptKgHZCOefQAfyDkefZKCx/TFEewMyJi3ZnM/V
         vQGw==
X-Forwarded-Encrypted: i=1; AJvYcCWAyYnFY5SICZSmc/JOr2rLVOOz3Zxd5H5UHysw6rafYB7s5+UbAe95zby2Cv8YNG6FmcGFw1T9nqUv/ODNGa1qX4V96B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIMudVXVI8joRyemVzAyFJp5tLxlkx/dlSwiOWhAkKUIB50WA
	ocCoriHtNj+4HKPeSCgKFK0kaA+NJIXzhbNDB+rT28sbjV4QIvzcJ39gIV1IR0QfOgmgAdY0Hze
	Lgsm7bhunSEvxkAlyeYDvCa+JObaqORVg+nlewMt+/JxRZIZJFCY=
X-Gm-Gg: ATEYQzxykVv6ubQTxp+Pdptv9r4f5Y/AELrrHhvQpTN2c3PziL1m+eqlF85pZh1dQnN
	uj3NMtuslOmVl3EgdRRVY5YI/EwwcCbyDd3mTx1FOSBfjFdKsNt2Pt1ArS3v8GmwsSoIVZ1FSwD
	bRLbKiQC7AyElaaprutDxoUv+IvD4DisZnJwsKx2S2rK4iDGID04A1htfj35cALrrtF7CYKR5nV
	4yVMnntNplFv43Ym+gc7p+y15XeHwwnsLZc90drH87qV31eY4wzMkqK2DsnDrcihkbn0iB29lpI
	999BeBnEnoCQajhObg==
X-Received: by 2002:a17:903:a86:b0:2ae:80a3:ca7d with SMTP id
 d9443c01a7336-2b06e3f8b5dmr14388345ad.39.1773797322844; Tue, 17 Mar 2026
 18:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2697b9f672967b1318630f2ffa21914f@paul-moore.com> <20260317232041.330576-1-utilityemal77@gmail.com>
In-Reply-To: <20260317232041.330576-1-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 21:28:31 -0400
X-Gm-Features: AaiRm53h-GwzyyaZmhjSG7xFKi5WW3mgA9p3jsbpEqD6OVb1qbMfwU_zcGTi8w4
Message-ID: <CAHC9VhT+scwVSoMNBKgVMnTNdjP_qVSECScmd+i0M3vj-pM-RQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] lsm: Add LSM hook security_unix_find
To: Justin Suess <utilityemal77@gmail.com>
Cc: bigeasy@linutronix.de, brauner@kernel.org, demiobenour@gmail.com, 
	fahimitahera@gmail.com, gnoack3000@gmail.com, hi@alyssa.is, horms@kernel.org, 
	ivanov.mikhail1@huawei-partners.com, jannh@google.com, jmorris@namei.org, 
	john.johansen@canonical.com, konstantin.meskhidze@huawei.com, 
	kuniyu@google.com, linux-security-module@vger.kernel.org, m@maowtm.org, 
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org, 
	samasth.norway.ananda@oracle.com, serge@hallyn.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 7:21=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Paul,
>
> I updated the hook placement as per your suggestions. Moving the hook int=
o
> the block does require duplicate stubs, but I don't see another way to mo=
ve the
> stub into that block and properly handle the case where CONFIG_SECURITY_P=
ATH is
> defined but CONFIG_SECURITY_NETWORK isn't. If the stub is moved into that=
 #else
> block it will never be defined in that case.

Oof, yes, my apologies, I must have still been thinking about the
LSM_HOOK() change and didn't think through the problems with moving
the declaration.  If you aren't too upset about changing it back, I
would prefer it back the way you had it in security.h originally.

Sorry for the noise :/

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..3f8c23ad1199 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1641,6 +1641,14 @@ static inline int security_watch_key(struct key *k=
ey)
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_unix_stream_connect(struct sock *sock, struct sock *other, =
struct sock *newsk);
>  int security_unix_may_send(struct socket *sock,  struct socket *other);
> +#ifdef CONFIG_SECURITY_PATH
> +int security_unix_find(const struct path *path, struct sock *other, int =
flags);
> +#else /* CONFIG_SECURITY_PATH */
> +static inline int security_unix_find(const struct path *path, struct soc=
k *other, int flags)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_SECURITY_PATH */
>  int security_socket_create(int family, int type, int protocol, int kern)=
;
>  int security_socket_post_create(struct socket *sock, int family,
>                                 int type, int protocol, int kern);
> @@ -1712,6 +1720,11 @@ static inline int security_unix_may_send(struct so=
cket *sock,
>         return 0;
>  }
>
> +static inline int security_unix_find(const struct path *path, struct soc=
k *other, int flags)
> +{
> +       return 0;
> +}
> +

--=20
paul-moore.com
