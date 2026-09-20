Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153828505E
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867555; cv=pass; b=qfoSzK6VV2AVlfqkUzBx6UzxSFqOZ4EITS7SgEumUfmtLkuHdRav03Pb+0LFVWe/8fcnNUr4jKQqXZn0Nj/EegC6yPn3dhEy8Kam6H8Zbop/q4aD78SliLmNTO/id65lawvxd4C1tAg2LIa0e+42VnFwjheHkYXeW/+ghtVP/Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867555; c=relaxed/simple;
	bh=rE0jWmiH8mZl6rl9Yc+bmfiJlsxIdVsL+Q8JnRqVZlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLo21NKbQ+M10FIjIKXj7qpa/cKpDYDUmCT7dxvCesfATWgBOfe7x4fWV0WBnCrEJldeVzHdKtQFpDLRXSEA8fGsDKp0aOzoaIvkLVSRrcYB63ussVeUuAFApiUUAzIH1hWvXeF23RRjIq/jv3otM6TmOJ1Hntd38CeCNnKGkCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ITHPYTFY; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ITHPYTFY"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so1650829b3a.0
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 18:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867554; cv=none;
        d=google.com; s=arc-20260327;
        b=s9w2beGBvFFAZL38azWkiqpYx6tN4f6XXtofktph0NF6rDfu2g4zg7Cxl8NGW8rzyN
         zWWwy9hEPx/5F+ugLDMLeKcaZGYNjIzIli0CzFNmgyBZy7mVku1UszBgLKQpwljMtVwL
         RWxJLp2Qt8ftVvvLB/a6TIQo6HYXlxQxaSVPgquBw+prOugxF3EquMD0fub5C8qLHnkf
         DKI3jD8gqacbN7MOmVhGRvoyXbfJ3nalSkqKp31IOB2lqw6IYMNHeMZLBkr1mCoC3JwK
         HegBmyVrpnxbznQUrz1WtaIw1Z55UHXDsviUm7DWHBoU2eo4Ig3VrnhAkyt9ImAztnGK
         hmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNRnVH7wuWaValEcQugtvoveGgv+gdl3RdPnin3h+/k=;
        fh=fhA+VOgsZ2EhxsI1xEaeM84sS2qQHYN12fswBEHMGuM=;
        b=l0ucNEvWtG7srKzmOwmTGv/3e80Y8fVPr+n2vL4wpQP0gencrTCMXdz+BdkqoC/g40
         lnlLYkReUVea5ev3AwhYME0qde/PsLk2SbZke/lo+HjzxAw//fAt8Vj3B6mdoIYbGu4i
         zhZUZpeZUHPERJKP0u/qou8JAqXxwxse3erfh7vg271ff07lQrohEQ/61czSJs+UWQfP
         tMmqIQaEczCrPqHcJQDfO1ZPztaVcojFr3SYnk5wtrDS4Alfl/sAmb8W5ADEMpArJIEh
         CY2RhMrjW2ZpFondt8DcwK2Q0xTR+b2fyFkS/eG7n+vMF08cJUh4sCj5wi74n89d/qZO
         wAQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789867554; x=1790472354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNRnVH7wuWaValEcQugtvoveGgv+gdl3RdPnin3h+/k=;
        b=ITHPYTFY09cCVl7MzEnnEta1wLZ5p02SW98zHa6QunF+numSL9lPPU4myPxlSfOfLl
         t/JmSHSAVyQbDhi/qHx3XPUGYsX2gK9uHWaQH5Dv5foU3w0OYj15QfNQT3tmnf3v6QbV
         /Nu70CSbVpoEUYbdGO8NXLo1msD+kx6hEJ2YRa147gdHzQvzoE70kNUV0MTzy5Jfk3co
         z71fcZa0+7ecmLeuzQX7dR1BYgng87bqOJb4isuTy4Di0sUt9DSeaVotZ4iM5nZTKxC1
         YcTxV1NQOVFz4PJdbll8YVdbkiD84HvZoKnvGbRkPB3fBkPonGlF+qxs0SlgH07xShhX
         4Duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789867554; x=1790472354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNRnVH7wuWaValEcQugtvoveGgv+gdl3RdPnin3h+/k=;
        b=LZf/Mho2cNLdWsjllyH2WS6hEcNp1XyxpnGWPt3cW8ON4SsCWwn8dSnh4m86THVHlW
         gAKUiHjYBfQJBoD7SQByLCaHyn0+hyMYJzHkc3zLCAF4HbvDce2u7WM6nJCCCCQoo6xG
         SJFRmhzlqN6OLQ6dcaS0Vgg6MQHRIEYTXpqf1dXY6y+MQYoMcTcsr1Qv0yGFX56xKb8J
         6KYZJANOfvknhIX/RVb8lA/BSGO19AFX+IxucL3OwGBo7X45gZwee5UEv5cJzMAI4oPb
         dqE3wncWGamSrEMRASjxWrHTAfpGUjXwzRqrkzBMu0EaC3hIBuzVkvcfpGQLPBgJkBcs
         v0/g==
X-Forwarded-Encrypted: i=1; AKwUvBxFcY752VG3XLe5mZ82XcJhRGkKqTRiOASObTs4XLW8hV26Ocsk8GF2d/3wCH9Pv9utZEEPzknbjdpQ9PfdadWNoK6O8Ic=@vger.kernel.org
X-Gm-Message-State: AFuF++mYdJjvMS/NVCun/+34vehz3SN05mqkF+w8+2npRY76HbDb8K6Z
	IYw7WBosoINBSULWhSDCJF6gtUr3IqQEGQ+/pKMbaXaspl8QZcj57f7XhAgrbzHpUT65PDLkt9l
	GViI39Z4chqg33AveWIgsZL/si0xYAwaJeW6JnabP
X-Gm-Gg: AYBFou0W9/aGwLfTpFOMkRJu/izhJ1q5wehXP1Qn4oy4PzHF8L7k5C0/cs5gh/D2Fgu
	IAkmJ+h7uMFsePu09zXiO4/PfpaHFLPPm1s/99OuCF8SkWNAmef68021g+aZW+q898CNfSVtsjv
	t4RxWGHQyNAmCB8i81G9Ef941dJEnO1pXOvCjrTQInChaV8BhPZEuAPm7crGwHRErtsq18j9DVl
	NAZDYE2zdAy4s1/kNckbckq7IxPGjyu82Djf2xZRMyV6nW4ZnD8CGO4nF8W7Tuj7L3trNI7m18T
	0jnpVCMBtGqE8HO0CR4tCXmv3YHwYvqsXIt9WN9GK4kexnJTOqSICHsOLf4BFXHiLi+49F4QrR3
	agte1uz0YFnI=
X-Received: by 2002:a05:6a20:7f8e:b0:3dd:a196:907a with SMTP id
 adf61e73a8af0-3dda196a7a5mr6025808637.68.1789867553821; Sat, 19 Sep 2026
 18:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919215243.3472150-1-benquike@gmail.com>
In-Reply-To: <20260919215243.3472150-1-benquike@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Sep 2026 21:25:42 -0400
X-Gm-Features: AcwNN1UUreSec9NyLkvaWFAQ9DB9RVlT6GgTGCc3Y8l3T4QYDUJMKR-P4SIbpMM
Message-ID: <CAHC9VhSxPmufV8Xve=kFX3kH6aBztyH9+tSynrXUEXcgTuw5Sw@mail.gmail.com>
Subject: Re: [PATCH] netlabel: cipso_v4: reject empty MLS level/cat lists and
 zero tail in cipso_v4_delopt()
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:52=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> Fix three bugs in NetLabel CIPSOv4 handling:
>
> 1. In netlbl_cipsov4_add_std(), an empty NLBL_CIPSOV4_A_MLSLVLLST or
>    NLBL_CIPSOV4_A_MLSCATLST leaves local_size or cipso_size at 0, causing
>    kcalloc(0, ...) to return ZERO_SIZE_PTR (0x10), which bypasses NULL
>    checks and installs ZERO_SIZE_PTR arrays into cipso_v4_doi_list. Rejec=
t
>    0-sized level or category tables before allocation.
> 2. In netlbl_cipsov4_remove_cb(), also inspect NETLBL_NLTYPE_ADDRSELECT
>    entries so IPv4 address-selected domain mappings referencing a removed
>    CIPSOv4 DOI are properly cleaned up.
> 3. In cipso_v4_delopt(), zero the trailing cipso_len bytes with IPOPT_END
>    after memmove() and pass opt->opt.optlen - cipso_len to
>    cipso_v4_get_actual_opt_len() so stale tail bytes are not re-parsed.
>
> Fixes: 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integratio=
n")
> Fixes: 389fb800ac8b ("netlabel: Label incoming TCP connections correctly =
in SELinux")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Generally speaking, unless multiple problems are tightly related, one
patch should focus on fixing one problem.  As you have identified
three potential issues that don't appear to be related, please break
this patch up into three patches and resubmit.

Thanks.

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index a05aa075de1a..4ac1a4965abe 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2025,9 +2025,11 @@ static int cipso_v4_delopt(struct ip_options_rcu _=
_rcu **opt_ptr)
>
>                 memmove(cipso_ptr, cipso_ptr + cipso_len,
>                         opt->opt.optlen - cipso_off - cipso_len);
> +               memset(&opt->opt.__data[opt->opt.optlen - cipso_len],
> +                      IPOPT_END, cipso_len);
>
>                 optlen_new =3D cipso_v4_get_actual_opt_len(opt->opt.__dat=
a,
> -                                                        opt->opt.optlen)=
;
> +                                                        opt->opt.optlen =
- cipso_len);
>                 hdr_delta =3D opt->opt.optlen;
>                 opt->opt.optlen =3D (optlen_new + 3) & ~3;
>                 hdr_delta -=3D opt->opt.optlen;
> diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cip=
so_v4.c
> index b080e666523f..9bb28236b8fe 100644
> --- a/net/netlabel/netlabel_cipso_v4.c
> +++ b/net/netlabel/netlabel_cipso_v4.c
> @@ -185,6 +185,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *i=
nfo,
>                                         break;
>                                 }
>                 }
> +       if (doi_def->map.std->lvl.local_size =3D=3D 0 ||
> +           doi_def->map.std->lvl.cipso_size =3D=3D 0)
> +               goto add_std_failure;
>         doi_def->map.std->lvl.local =3D kcalloc(doi_def->map.std->lvl.loc=
al_size,
>                                               sizeof(u32),
>                                               GFP_KERNEL | __GFP_NOWARN);
> @@ -260,6 +263,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *i=
nfo,
>                                                 break;
>                                         }
>                         }
> +               if (doi_def->map.std->cat.local_size =3D=3D 0 ||
> +                   doi_def->map.std->cat.cipso_size =3D=3D 0)
> +                       goto add_std_failure;
>                 doi_def->map.std->cat.local =3D kcalloc(
>                                               doi_def->map.std->cat.local=
_size,
>                                               sizeof(u32),
> @@ -680,10 +686,21 @@ static int netlbl_cipsov4_listall(struct sk_buff *s=
kb,
>  static int netlbl_cipsov4_remove_cb(struct netlbl_dom_map *entry, void *=
arg)
>  {
>         struct netlbl_domhsh_walk_arg *cb_arg =3D arg;
> +       struct netlbl_af4list *iter4;
> +       struct netlbl_domaddr4_map *map4;
>
>         if (entry->def.type =3D=3D NETLBL_NLTYPE_CIPSOV4 &&
>             entry->def.cipso->doi =3D=3D cb_arg->doi)
>                 return netlbl_domhsh_remove_entry(entry, cb_arg->audit_in=
fo);
> +       else if (entry->def.type =3D=3D NETLBL_NLTYPE_ADDRSELECT) {
> +               netlbl_af4list_foreach_rcu(iter4, &entry->def.addrsel->li=
st4) {
> +                       map4 =3D netlbl_domhsh_addr4_entry(iter4);
> +                       if (map4->def.type =3D=3D NETLBL_NLTYPE_CIPSOV4 &=
&
> +                           map4->def.cipso->doi =3D=3D cb_arg->doi)
> +                               return netlbl_domhsh_remove_entry(entry,
> +                                                       cb_arg->audit_inf=
o);
> +               }
> +       }
>
>         return 0;
>  }



--=20
paul-moore.com
