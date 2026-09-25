Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D014D7D4B
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351470; cv=none; b=C8O3ta4Dcle6qR0YmifYXW69H4FQSAoEslOLBf2nP0zSdhudDs2lQjQItYGWnf8bzMyWv/J+esxxfwyjH7PAvRiJ+4guOMrOn36OH9Ooyag9A9241yiQrJjNo4N7VuTJShwaJrKfEhRP6YKDDOD+8dK4XcxdH+zRF01HBWQaRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351470; c=relaxed/simple;
	bh=8Sl6QXs9f/prUlQJGcMmVpKU9w+SU9Wg3hJmmffsgtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvZI8eO/eP+6S6sNzSAyPFlIl/Iu1DWCmOfWZB/odSYrwDtvt3Tyt8297RX1/ZMMl4mUqZD52Ba3VZRY7QEmW+oyfAseqGwcH2qMB4ddsZkvslAefU6Jno1ictTYWIeIL0AmzRoolJOrvS3djHFXDlP3xj4YJ1uvxhboETGk/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2afd63c3e0so36716866b.0
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 08:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351465; x=1790956265;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7HjLJsKXetAb0Aw0AgEZE0vzcstRBizx1Ha0tT6wh0=;
        b=TsSxG6ArGuD4TOS4DS8tXAr5UfY8bFoR/VSmkYuzKswTbnn81Dn0lhpfFXwiIjXgNf
         oFqYUX0axH7/hO/5im+7JDLS+4baGLDeQGqAr3naD4/KIAPqKXhqleBbN4FkjPaAs6Us
         t0aCyyrCuZtoH9NtYZRTSa8mTjOr7arrCE8Wsoh4NsMdEufUyKOV4oWK0kSBE5mB72ko
         /dTkk0NtMWtvf/VHWLDIYOBOO+AaUiuFOYPguhgbWZiw6Sl4U21VD6Px4ulXI1YrHUJV
         Bq1SwOLZAX0b828wfRI2gjkZsf8s/oun6eAgAiuiZryVRP18vvy2FqzWdc2AJe8MMXmt
         sB0w==
X-Forwarded-Encrypted: i=1; AKwUvBwzQ0htC+fh04RCskI/+tFSPaWviX/Do6U6r8NqeB37lMahrVeC09A5hBdFm7fMrOQE/GTD3SyZZPl8o/NNvqn5asDMwV4=@vger.kernel.org
X-Gm-Message-State: AFuF++nJmMg6W1Q27gHscQowcHz3IdPxzPyFVs0lUriZlWY247bO2C3x
	XisZ8WMXohEyVupnqtS3Ct/WE8z87x3OxTlYtCI9OrBRh2cEn+N7xI98VTY7YbxuuEw=
X-Gm-Gg: AYBFou3xmvULsgTaZ75TybIvKYdub0DkWcyy3eV5zp/1A6UdoMsRDsnZETpIIrz5wpO
	ixs7ECCN6FGjW4FP6xE+w7HZ27Bf7DZQitDbMwpgwFHL/8PpcyRWyzTdIVfiwQY0MmIyQ2UHp9V
	KVeZLXz6D2Zb9GP1oKZDoDZM74/OMNaExNUiM6V8H1zuOJJIw9v7pCccCQjJeE+Igv7DFPo6oUY
	E34bws/3MErLcH/tGa6dx4RPJEQiX0bRkslHtl51a3OKy8B7liMx4uk8H5DxBaFmXqPaFDqz3Fy
	HYl87QY9g+6SZOEg5Nol5CGl1Q6GppbwDnaxAa9XpvrimYo1XJG4hu93DP4EjHRs6ID6I7xFIdo
	jHr8SAwvlanpgAF+aUXztkYCetZLw2SsJc8A3Vd90hD8W91qysXavYBBcYRdpoCD9Gdc6BgbMbb
	IHE7zGi5brNuiD+5YkggOpwsYIfpI0cwajK2TM2zxEXdVlJoKOuBzp3ojx0fr4uJ5wvqbYalAto
	r8Zw5qTmz5KatY3cNCm1r1cvSSxOERLVJjtZiaGgA==
X-Received: by 2002:a17:907:9406:b0:c26:19de:912c with SMTP id a640c23a62f3a-c2ac256d509mr664726866b.31.1790351465090;
        Fri, 25 Sep 2026 08:51:05 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae688528bsm133341666b.9.2026.09.25.08.51.04
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 08:51:04 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so170266366b.2
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 08:51:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzcxzuUCArjXkQ9VcrfQodk8F4l03uvaMNzVw9aQhKHw4hl4KaEUhgyJSL79GwzLBIpSnWIikTM/afPiOGKe/vuKYIspto=@vger.kernel.org
X-Received: by 2002:a17:907:e918:b0:c2a:9e6a:3b4e with SMTP id
 a640c23a62f3a-c2ac228e60cmr567189166b.0.1790351463882; Fri, 25 Sep 2026
 08:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919223438.3883567-1-benquike@gmail.com> <CAHC9VhS7sZQaPaRswKQ1ETrReEPB2f5buNAMGSXqZ1iBKTs+bg@mail.gmail.com>
 <20260920235249.260530-1-benquike@gmail.com>
In-Reply-To: <20260920235249.260530-1-benquike@gmail.com>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 25 Sep 2026 16:50:51 +0100
X-Gmail-Original-Message-ID: <CAOs+rJVgp-mG1PtqHKnSejjnXiw8n6MA5ye2JGHoL0=JUADAzQ@mail.gmail.com>
X-Gm-Features: AclHuK8AHjiRwMxnh93efSsuU_hhOCN66FUp5ELHqoUEvyW1GbfwsAHY6Z1odGA
Message-ID: <CAOs+rJVgp-mG1PtqHKnSejjnXiw8n6MA5ye2JGHoL0=JUADAzQ@mail.gmail.com>
Subject: Re: [PATCH v2] certs: x509: duplicate cert->tbs when
 sig->algo_takes_data is set
To: Hui Peng <benquike@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Paul Moore <paul@paul-moore.com>, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 12:52=E2=80=AFAM Hui Peng <benquike@gmail.com> wrot=
e:
>
> In x509_get_sig_params(), when sig->algo_takes_data is true, sig->m is
> assigned (u8 *)cert->tbs with sig->m_free =3D false. However, cert->tbs
> points into the temporary ASN.1 buffer (prep->data) passed to
> x509_cert_parse(), while cert->sig is retained in
> prep->payload.data[asym_auth] by x509_key_preparse() after prep->data
> is freed by the caller. Subsequent signature verification on the key's
> public_key_signature dereferences the freed TBS buffer.
>
> Duplicate cert->tbs with kmemdup() and set sig->m_free =3D true so sig->m
> remains valid for the lifetime of struct public_key_signature.
>
> Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled by adding an
> ML-DSA-44 (OID 2.16.840.1.101.3.4.3.17) X.509 certificate via
> add_key("asymmetric", ...) and linking it into a signature-restricted
> keyring via keyctl(KEYCTL_LINK), which triggers the following KASAN
> slab-use-after-free before this patch:
>
>   BUG: KASAN: slab-use-after-free in mldsa_verify+0x95/0xa0 [mldsa]
>   Read of size 1 at addr ffff88800108c004 by task init/1
>
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x70/0xa0
>    print_report+0x153/0x4c6
>    kasan_report+0xf1/0x120
>    mldsa_verify+0x95/0xa0 [mldsa]
>    public_key_verify_signature+0x5cb/0x8e0
>    verify_signature+0xe4/0x130
>    key_or_keyring_common+0x428/0x850
>    key_link+0x22e/0x360
>    keyctl_keyring_link+0x6b/0xc0
>    __do_sys_keyctl+0x146/0x4f0
>    do_syscall_64+0xda/0x4b0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
>   Allocated by task 1:
>    kasan_save_stack+0x30/0x50
>    kasan_save_track+0x14/0x30
>    __kasan_kmalloc+0x7f/0x90
>    __kvmalloc_node_noprof+0x1c2/0x5b0
>    __do_sys_add_key+0x1c2/0x390
>    do_syscall_64+0xda/0x4b0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   Freed by task 1:
>    kasan_save_stack+0x30/0x50
>    kasan_save_track+0x14/0x30
>    kasan_save_free_info+0x3b/0x70
>    __kasan_slab_free+0x47/0x70
>    kfree+0x159/0x420
>    __do_sys_add_key+0x2b3/0x390
>    do_syscall_64+0xda/0x4b0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   The buggy address belongs to the object at ffff88800108c000
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 4 bytes inside of
>    freed 4096-byte region [ffff88800108c000, ffff88800108d000)
>
> Fixes: f3eccecd782d ("pkcs7: Allow the signing algo to do whatever digest=
ion it wants itself")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
> Changes in v2:
> - Dropped the net/netlabel/netlabel_calipso.c change, keeping only the
>   crypto/asymmetric_keys/x509_public_key.c fix.
> - Added the KASAN slab-use-after-free report and test description to the
>   commit message.
>
>  crypto/asymmetric_keys/x509_public_key.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 25cf8ac7f257..5c9165a83f91 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
>
>         if (sig->algo_takes_data) {
>                 /* The signature algorithm does whatever passes for hashi=
ng. */
> -               sig->m =3D (u8 *)cert->tbs;
> +               sig->m =3D kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL)=
;
> +               if (!sig->m)
> +                       return -ENOMEM;
>                 sig->m_size =3D cert->tbs_size;
> -               sig->m_free =3D false;
> +               sig->m_free =3D true;
>                 goto out;
>         }
>
> --
> 2.47.3
>

Thanks
