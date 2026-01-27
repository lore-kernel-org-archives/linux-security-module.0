Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562BA337B9C
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507722; cv=pass; b=bUesqmYKEtfktBWhoEgHAL5TjDp4GUZd0iJH9mj+kMpYJiIAdHz4MFwDYq3p0PGvY0uQXHR2BeZbRVMG3cpj97vkarEp2ICE2CXrocP19FVMVzfEduoWWTzrQ+mBectHP0Y6JhApUHCby8LbTph/K5y7ERuFkE74qz6PHSGonD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507722; c=relaxed/simple;
	bh=L5k9bsZhbwfNwvr7j5DDwdxvwj9ZYR0SCo9EvGBH7HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTpOPTKyd6qRJ5Y2OpY5ZuJiLXfEMots1VOkT8w39QswcBQHgvw+ANWHfluz8MZdA6Am1Q6GTmu1nz+dIplvkyn9fSapHsmRSYFsg9xoBfjuBlgZKPrP8fFP2QkuoEW6yxZY8Sf5eIExj0HK6XABG+AYGLUxwyNn+diBLk/p/kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=H4Mck3i2; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H4Mck3i2"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso3425686a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 01:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769507718; cv=none;
        d=google.com; s=arc-20240605;
        b=ESC4Uryo4A5ahT6HczgBpwgHgzOQPa3E1SVNmG/DnZ8Akh7QXue24xENzXGn+X5bd6
         QrNAt1Z2zfnGkJnSzlWas+3zjLQOH9oy9pKf8p5l+g5cyaRIsQ1TS4AoPYtTOftbwegh
         DqMI+uMfq1OKjOadRD3vMbfSgg1ixbf4GfuywEsadqNpJLe8Sl4a+EDdpX938EqtkVXu
         SVFr9jDZODjNV3HdMJxiAOG7RV7WwkkkquJJHvOCQ7KzuGp0olPQw0KCim6wJCCXcYZY
         cGUJYabr7H6bwqCP3Fno3wXjfZh1wSLmJDvHUJLuRGg8tcljLLZqC66r8tnaHS3bPhvN
         f/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYY0hqNAnxWfLFn4pFnO7Vxf2fGY7HRzxKFLLB4SB6U=;
        fh=R8peBLfkng4MN472cAytHSlOLwv1f5+xX2xLI7qX+TI=;
        b=dSImHU3xBYQgzRts2hAZNwVeq/04DUYJ1+jiTg1AIyhpdN7mAOjBQlEY/3cgnYEi/3
         LFuK1q4EslCa7ZBw6YCI4L1NvDXfgXm+U0NlXjyFWQ9hS4y6LLr7ylxIr0uHVyckYhxK
         VAhjloxK3Ds/K33+IytPC/idvnZWnyZboUFaJYwX0vF5m4oiSXxytnmLO7IdSXmA3mX+
         +Rqmf4uE5LCo1YqskWYXXJGyOVAvP/fbU2HTNnuDiwBGRuLqKkqB3r6myOIKw7m++NX/
         s3fUdBjcuuE+pRqxGuN5e48IePARCzGwR1vLk59LcJxRpdRamKYLuQ5fa9GL26cPHlnu
         uzOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769507718; x=1770112518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYY0hqNAnxWfLFn4pFnO7Vxf2fGY7HRzxKFLLB4SB6U=;
        b=H4Mck3i2pMLlv1r7qnIymC+enXwNN1XuYBaqWxDnj/sLEJjQLbkhgMGgtyTGlqmqct
         8dbPbNbSJ0SrRKmcQKjJkUxm5p2cnvIzAZLYB4J4w42UprN9CmbELdR2H8x/5p5J0MRw
         7VY6y8oWi7LPDpagiOftI3AuBhYRwprlmB9yAeI0b0j1mwmMQ3t0KVYHsb89SjIVRCjx
         EvxOeL9riTTANcEMNPCP/9ry2Wz4LUvgMaroO68Am+4iY4d8QZEAar06yV/GcluHkvpa
         xdUhkQEQ2WuRQRo/j0PA9RrEUPbSRU0N8G7vtzEm5ShauwAYFVRNdCFnoQFMWXZ/f28a
         LRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507718; x=1770112518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYY0hqNAnxWfLFn4pFnO7Vxf2fGY7HRzxKFLLB4SB6U=;
        b=MNr/2h/0KRnbVx62YszDjXXkFwxq55iG7kdTTcUb8N+/nsIcT5aASpeRlqXCKZh/z4
         IsIlFnCpuVdeEw3dc4a0RLLRDy2V5WFA1PMtx+FzNq3/cxrOWyN2TJdpzxbi1GsY3iYa
         iRmkaO7g49/AcFDUMh44RmczRbGbMaDom5C0ra6/PFyLkCznGAP4UN/GZEy2SHXD4TSI
         oZ3P6kjIRHGcpKi+oCYszDP3x/Y8ylZNGgI5l4qkpVZQdLhiSLtsiwUPmwkb4ip7DiXK
         K3keHGs+GWNui5NhZfOx1yCKvRt6/F9UHXdTPHJ8SRHgUB0l+OnQjsEWJSjOmSau7cwt
         Zyvw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Y3e82B69+wr0yYF64RatLGm6AnbfvJnGUR0LaxwfmC81QqsbKTlaEmPiDbaN0FN7pdpkeE9ZCZrcn9AoreclxF1pouI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAthGxmmgfRdkLrwADT7z+8zkS4kPaJyTxChDHRZfj/OEcOdVD
	yF+dK78VN487SryuvdA+QcYwDaZLNB1j1zElrsoT/uVxT1KYsHQk0iEdd4Zg++ixD7Q2T/FNJNr
	XvXmyljyxYjFrST2SLMK9UxuR17r0lxIULXXDXlFzDdHaIqw8agJ+SzCP
X-Gm-Gg: AZuq6aLsOtssjkwIBYH52yi3YjnCT0Cqm2oRvS4NcD86ULs5ORfWRwZH1+x5TaXhlyy
	OTyt6PLjdTWN/ijYglIPs8pWP2PLRZg+cKmM15vjbUhYGHSv3ESoyk+k2mCwqiUZ0tP+dBwYaNC
	159ZcMOzeBiDgSujFUF9VHh8MjKs+aJVfAJOC88tYifqRxCdn8v7v2XVjWaZuEX3xzlJlXIl4Is
	9PJohe1SJCU8wnbves5JoY1EDbNBulNffZwSd1CLe/0CXLuEfKvZbGg+xQNG9YoOjWPad6U/XEA
	cHti4waylwVcUZVCkj4MLuUXbeYOtgEuxsd0TkBeguYhnMIRTuLvXixibewQkrdYf0VBIzm1t4i
	e9KyMXzkugA==
X-Received: by 2002:a17:90b:2ecd:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-353fed5c9d7mr1240343a91.18.1769507717868; Tue, 27 Jan 2026
 01:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com> <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
In-Reply-To: <b873ba2c8057aa749aa0d058002a30776d0a5248.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 09:55:06 +0000
X-Gm-Features: AZwV_Qg6oboibS8qbS6QxWmADKc2aUjC5oJj_WK2C3ladL1H3hO57bglwnxMO6Q
Message-ID: <CAGrbwDRgQShh==Vb_8QWoByKV-HXAwV_CGyAoAzjRrHU9c2KbQ@mail.gmail.com>
Subject: Re: [PATCH] ima_fs: Avoid creating measurement lists for unsupported
 hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 9:15=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 03:05 +0000, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <dima@arista.com>
> >
> > ima_init_crypto() skips initializing ima_algo_array[i] if the alogorith=
m
>
> Algorithm.

Thanks.

[..]
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -404,6 +404,9 @@ static int __init create_securityfs_measurement_lis=
ts(void)
> >               char file_name[NAME_MAX + 1];
> >               struct dentry *dentry;
> >
> > +             if (algo =3D=3D HASH_ALGO__LAST)
> > +                     continue;
> > +
> >               sprintf(file_name, "ascii_runtime_measurements_%s",
> >                       hash_algo_name[algo]);
>
> Thanks, but I think we can also print the unsupported digests, since
> they are there. Since we don't have the algorithm name, we can make
> ours like tpm_<algo hex>.

I'm not quite sure what you mean. `algo` here is HASH_ALGO__LAST as
you see by the check added. As it's initialized by
ima_tpm_chip->allocated_banks[i].crypto_id, I presume it's
HASH_ALGO__LAST there as well (didn't check this assumption though).
Do you mean to print hex value of HASH_ALGO__LAST?

> Once this is fixed, you can try to make SHA3_256 supported. Add the
> TPM_ALG_SHA3_256 definition in tpm.h and the mapping in tpm2-cmd.c
> (array tpm2_hash_map).

Yeah, I thought of doing this, asked the related folks and they said
it might be worth if it's a simple/trivial patch. Will try if time
permits, somewhat busy with bug fixes at this moment. This one is just
a fix for read out-of-bounds for -stable (and I managed to forget to
Cc them! hehe).

Going to send v2 with the typo fix and -stable Cc'ed if that sounds good to=
 you.

>
> Thanks
>
> Roberto
[..]

Thanks,
            Dmitry
