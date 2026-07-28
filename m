Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668193D4128
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278216; cv=pass; b=eXQRiPysTdGRvaYo5IB+xypayd+0YdswXwQidn3L6kpNitdee4LQfMLskRjwFzfcFQYCACyJMidiTuIPfcerGJkojurO/T9BDvvixDtKqzXOOCLcwySP0w83nRe+6tZD35ELAGCp6SP6xU6KdNCT/cauh5ym5rvBN2+kCRkOWxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278216; c=relaxed/simple;
	bh=M02jLnDZLppEIT0nRxyvQ22mYICb7N7bMg3FU3PevXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMC6wlYZA0Pkh6dGvyAyMfK+2k5BJkqSi/wxWbbbSoE0L/B7nc8nj0YU+sMp3WI5hEW5mIV8SQr3GfmfH4371XL26fZcyBj79k1hm+WQWkwwa5+YUcX6embI1Nib1652tIhcsHlGmmN0cGm31yY7PwT+9h2M5aEI8mB0mYptBgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IJwy8D6l; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IJwy8D6l"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacf197759so5521815ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2026 15:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785278213; cv=none;
        d=google.com; s=arc-20260327;
        b=Asj9keZSslAKanv8+hKD3/b9+JQhwGs3ftl1+Euw1v8kDGCGBX3EReP4i+XalAXUdb
         QF1iNp+Xhch0o3bQTZ9XzamLFOQ6lPrMlWwO9QPHBDNygEbwSkOGqej/RjhoMTux33kj
         49VisPE6IZaNDa+dg1+fKwery5p2W5NWYrUeVkxRnE/Mputd8O32p7fa5Uksufc3l11U
         5Uf4dI+xuyfS5Z0RHdR3FLihhV0PtnRgy/ixNOjqn9YnJmAr0e6r/kYxl91THriq2cdd
         RfNdg79/wSvNIQHIOro/EEbsoyoSQudXECezBUTy6JoLg7b2t8xaJg0LrrwGpqsvLplb
         SSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CK0107H/XBboOND7aXv6xIaoAuH7/inIuXb8QL0cJnU=;
        fh=XAVci8zWXAjF3lG9pm5wsj7J1j8noM/gCD/2UQEoK6I=;
        b=q0h+ah3AZvYIEA0ubpsG0Hxt6/KnH3pocA+NgDJwYIKkClBE4F9ODzshMTPA0Q/L2J
         Rf7+yo1apmcVQcpt+okrY+hR28HMaIXtEZFSQGOVmz54dYDidX3wf/doks8gGFxo5h00
         GELDWWy6mXnIY+p+Lz0F8c0NeIjG4aEPZtjVPEFgRaMH9oDJVYhWyZ9yGP8v0CNJUiNv
         fdIZLWL1MB/I2ZCFMVcsXBso+TRN+m1R9QGrn4hq/qXlhLQpf3Yn84lruJQTQVMPklwB
         ktnOQRwJVIeK1r+bI7JcAdrPCrNdNJG2PfY+FFdVNUSxD3uAsb/Fx72EIslWw8ubfYFN
         0BgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785278213; x=1785883013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CK0107H/XBboOND7aXv6xIaoAuH7/inIuXb8QL0cJnU=;
        b=IJwy8D6lujjUHHh08/BDtQ5FoVOWl5ZdjiXCd44fBX+D5EokCJcVE1P/qBpIyjUviY
         HIEIrud+bRT0EZTUdh7yta1Wcdkjxv0LtcbAWE0Qxd3I5ufsl0YkzhgHcKiGITd3FLj+
         WozEuTXLtkaNEKBiCy/sMWfmVmbfdD6WYpso2FhC+JOAKSxx8l1IbQd8gfhwuuLzvNJ6
         mC0tT0iP7gJMWqHoKy0LcqtOEWP2n+GO9Mev7IarAHneZINX9tpzLObsviHFP9UZ80EA
         Bf4ityBX5zcQhFc1SxpFr41J9oAq+hxoztPYSFXHc0LkURgVqOEFVZGhxgwWJmgwze/a
         9RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785278213; x=1785883013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CK0107H/XBboOND7aXv6xIaoAuH7/inIuXb8QL0cJnU=;
        b=M5PW9ENUXtGvdbBebmKNVhafiotXTMeIUbAOtePGL9J3HUSuq/Cm6b0nFOQrqOIvPr
         FGt9F73zkLrMDSshmp3Pp9C/TULq3KjwsxvYm3/CMVuBpNyCM2YpFndoOyxxt826mtMA
         TXGopLyIR0SZ5AjhyrJIY3KRm41Bq4I7sPsyf0V2/VGX5DEQMTV+TfHOrBmIInCu1BJT
         p0yGrwOKtToXH8xiKCBwikxO0Dmzn5lZMK4MKbBOBs69mJEEflwpkekZVq4Ol7b5Fey4
         xwWi1HpAnA67nllWLpvSfqOgTx4Mf/6BYUGziU9O2Gm78JImBVNJ+YslobKvWlGipDcn
         rQQA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8vtt5+Iw9n3X7RrWPtgC/qvTh89lbCimn4/hqxoAU6rEg3U5eGEQm7DUxB9rKjw1qgjLwIypJlhfI2Ifazle/D1kfYDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9oFA9oyQMJ3i0T/tvPHHhxliahR7tmKkPOpU2ZLxdh7KfM5Rc
	Lq6RanxYtMU8AnfPLQGnHYUjrMIEi8sge6fs0l8J7GqPLCbc5Q5hnjnE592L6FuK+z6LFf415FW
	/Ty6rfJt3pMSjBUiFCzZXFZlArXEIo2w+X3G7Mao1
X-Gm-Gg: AR+sD11XDzQhcx7tBnf5f5V8HLJzjHqAeQ1w2EsQ4Bq2UjIGGRCaM7wS7eswzmk+jkU
	cYxWb3VeVEKqaLia+iAAvzUm0gcBBV7UkrgghYTrJfz8QX2zp7T4bv4CmDtHkEroXA7W30ws5UZ
	J7kuLA4bHDdPHUg43E/hzj3ORhvaAhZ9SoY2oy2BabxopG5SJL2Ez+rI9Kwm2AgdBgvbvN0oHhK
	uuCgt98ui2nOpVT7b5hFM8C5Qow7OSy59HxiYP3cjqXfmQn6vKs/v+CVxkwIuwlLhEv7e+3MrXa
	2Kw7CnFno47OeWuUFBqlvVHi2Def43fyARlc2m6lmYDH
X-Received: by 2002:a05:6a21:7014:b0:3c3:ab31:3d1e with SMTP id
 adf61e73a8af0-3c8ba615352mr5002886637.56.1785278212764; Tue, 28 Jul 2026
 15:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728031043.76586-1-heminhong@kylinos.cn>
In-Reply-To: <20260728031043.76586-1-heminhong@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jul 2026 18:36:40 -0400
X-Gm-Features: AUfX_mwTQWe6xSVtI_LXuNihbnOpbogzumOUuSpTL26BeefKmQtgAx1E7SqTrag
Message-ID: <CAHC9VhRHGYLeq9UN256DHNWx_Hyxo47SsHSDo+bJHX9rg4hHow@mail.gmail.com>
Subject: Re: [PATCH net] netlabel: check register_netdevice_notifier() error
 in netlbl_unlabel_init()
To: Minhong He <heminhong@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 11:10=E2=80=AFPM Minhong He <heminhong@kylinos.cn> =
wrote:
>
> netlbl_unlabel_init() installs the unlabeled connection hash table and
> registers a netdevice notifier, but ignores notifier registration errors
> and always returns success.
>
> Check the error and unwind the hash table allocation on failure.
>
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  net/netlabel/netlabel_unlabeled.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_un=
labeled.c
> index 47bae5e48db6..34704f6eb1d8 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1397,6 +1397,7 @@ static struct notifier_block netlbl_unlhsh_netdev_n=
otifier =3D {
>   */
>  int __init netlbl_unlabel_init(u32 size)
>  {
> +       int err;
>         u32 iter;
>         struct netlbl_unlhsh_tbl *hsh_tbl;
>
> @@ -1419,7 +1420,16 @@ int __init netlbl_unlabel_init(u32 size)
>         rcu_assign_pointer(netlbl_unlhsh, hsh_tbl);
>         spin_unlock(&netlbl_unlhsh_lock);
>
> -       register_netdevice_notifier(&netlbl_unlhsh_netdev_notifier);
> +       err =3D register_netdevice_notifier(&netlbl_unlhsh_netdev_notifie=
r);
> +       if (err) {
> +               spin_lock(&netlbl_unlhsh_lock);
> +               RCU_INIT_POINTER(netlbl_unlhsh, NULL);

I'd probably just use rcu_assign_pointer() like earlier in this
function; whatever tiny performance bump you get from
RCU_INIT_POINTER() is wasted as the kernel is going to soon panic in
this case (look at netlbl_init()).  If you make this change you can
add my ACK to the v2 patch.

Acked-by: Paul Moore <paul@paul-moore.com>

> +               spin_unlock(&netlbl_unlhsh_lock);
> +               synchronize_rcu();
> +               kfree(hsh_tbl->tbl);
> +               kfree(hsh_tbl);
> +               return err;
> +       }
>
>         return 0;
>  }
> --
> 2.25.1

--=20
paul-moore.com
