Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393F199949
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524260; cv=pass; b=OI4cJjiN+KyUsxGiQP2LgvXebAzJFYJxv3NA1lAyHwLdDc0KVuhoKlkWxSaET16YPMLLLjz/hGa2me6TuauDR4xu3LKRAhX6eCs7ZrCYkjUktdZiUxAuK/3jxEeaMInaLgFB/OPUYHzT+Yk2z+0XXqGt2F5WERgWZ8ql+a+KVGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524260; c=relaxed/simple;
	bh=4L+1CduCICSFsgHUjcOkN7OHpLxEb9vbNkxHmmODV1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar0CV3Z0DHy/iWHYj0TdyvDwini8LBrU5j2CFCasDVqK408lgovXhz0of9zDx3fNDZzr49+Kwh4yEt2ve+Tcn0y135ThMeO7YKXrbcm8qSoqV2PyWIXd87MEeCWj0t+3ywWbjMD1u/XNC41+KGxCFOcdcbuvjOmtif2iDf6W/Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UrI1Pd4I; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UrI1Pd4I"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c2dc870e194so2204359a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 06:30:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524258; cv=none;
        d=google.com; s=arc-20240605;
        b=RcmkMW3OE6dUj7WozHH5o4+IdXu7w8lGE0KVgOPd5pM8E+VnM2RVwtSyl98q+E6u5U
         vuB7vWSoZ8J/9noplTST29u5GdeDO26Ibw1BHE826SB7VbuZ6tbi1EXDw94tmHmIQkT7
         fsMihqWKXqyzDjx7fCQOyiDEVhK67g9xjk8EIHOK/KmQUNH93lXChbasnvM+4kWWBQcc
         ejjch/qrj4JE+yISXabXO4QvqPcQhqUgl7/rDlh5/62vFhZwaJQVZ2CJBPVjiPWgd/qm
         JmqL39LjWK0PJ+XOv1BHEREOsW/6ZZWSbO+xWmbKlDcqCSYYJPzvg1k3U6yLb6hWlBTi
         NNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        fh=FtNl+pFdSGlZkW+IyRu9pjgiFILLEk4H5M7tCufuLas=;
        b=PZbf5JMbMOjzLcDHvPqhqxYL3hSIsnm5mXc0HYtSEbXQrO6WrmU4ZtabevHAQGHENe
         mT59mT34eMebfnXRl56hcNjH2he/v3N/yzq2zjVUfFU5vaaoTt0zu9hw14Im8M9BOjnj
         ks3TLL6jNmLhBfMpVtcVEK0MaTFbQVPm8jZUbh6QIyXBNqODbMKo76iPPNIiJf/rtKKN
         Yvu7kGkO6qEBZ0qBavFluPfTSSvHmCKraUjIYntV3PoxjsuYzu0iHXT/BrT/aVbM/Zha
         B67gmw1AngTWYr2sZ11vKnnFvCew62mpQE0Cm2tIvcmMiMG3md69XHQrUXJTuiC81bf3
         Ya8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769524258; x=1770129058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        b=UrI1Pd4IPugpem4HPJfJXlQMlWX6aj69E1mR6VFoqA7ZFvC1MvYiVCvcg3yGgVmyaO
         awRjaG9fczBF5Y2VNkO/vyfFOqphG6Cv+3rNcD65WgHu7Gq9XvmAwIvCVhqs+KvXMpEO
         jhbeahL0iAc+mbKVsRfdeGrWkJKt0nj4R5D6yTo/GRFqNx2ScMMyyc5CEiwQ7tzOXIA1
         ZGQ9rCGMKAYWShY/jB/at3ImQpOGLWEtsMMMUj2/MFEHQ6kT3HR8LNresKlng4ShZIDZ
         3FvSgpZI6qQnTfU7xkV93bJst3nOrARuKdWfPdjbu5fStWNt+CMEu9RRSeiBT8xA52Zs
         FXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524258; x=1770129058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        b=w3lGqglouzecT9TmSVBnAkQZzBAs7kYwWS/jzPT4cyQoVvHikMeoVCWzoX9tUb6u0Y
         q9jlDlg577aKaz+sGIpVyLkua7T+LKjgefShstBRX+26L/ivz06NuLXXhKSgck49V1Zm
         SKs3gFrHmXWtyR9poU42D/9s0lSLWVZmiynNoILptLVS2zzyT+LC3NitUWj6Cd/WRHnx
         ikChNZPVffa/LZGKQwhyummrpMrTD7pEQOZGyeRnwCdM/piJ34M5BOhzH+Oj9lJ3WtNV
         nzPXJUviQwDTXc7KO+HC2xyc66quiWDTLtPGbgd1pucvQ1RFRoPsiXDHHAm+Y9kiAkB9
         IYfg==
X-Forwarded-Encrypted: i=1; AJvYcCVreLh2wTu4pFR9WlOmaxQLXzRnubrb7PSvtP57EaZ9Po95hZA/UPcP9w4FpjH4B7BJMO8IH1Si5leY8ksS+zFzuo/lxrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaYu6VMfPZ7TveL8d+aPNvB+zyvDMGZvLCmX3oir5621aK7WY
	vkDzCk27Au0cwEQZbmaYLf1xBYO/ElhnvBdeT3h2LaISRXJAA7LPkIr2CMKQ/XPRkax3fUjSZUB
	zARGjgt0I/FA4P6P0LonJdMzToMO9LrHxXBP0JPy8
X-Gm-Gg: AZuq6aLJ9V5qvjUXLsY/88Tq/5EGXnx61flSpzxQ1zPhpIvyvQ4STF0r1Ipxy1VFcvQ
	2PLfMhHbjTOetlr1bvpw1/2QOQKYb8Z4ImCEowd2CEV8CSJSPVRtfVZwK1Iy/s8AdSKN+js6puw
	8I7IpR2vgPvvh064mNUSb+R98e5V9+1CxZF/MuTrd4ZpcJBY0Svel32+eWth6VO78Idl7xohlvE
	NWGT0dTlTv752uNrZ0O3Wr/KvvIJi+Y9c/mgKuaD1udv6pwnOmTOjygZ73i0FHg7NQ5MKEJCqyF
	jqSpQ+q/yWAMNWMn0pqJPjXbU4qxtFZg0wk/CW1fY1UBce1fqJ7bEg7EGDkhTsy+eEMbJ0RrWJd
	y7H7Rs9HNicWnKUjOIe45
X-Received: by 2002:a17:90b:51cb:b0:340:a5b2:c305 with SMTP id
 98e67ed59e1d1-353feccf407mr1736081a91.2.1769524257987; Tue, 27 Jan 2026
 06:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com> <16c446c001a96a9878ddec9726430d7001c3f47b.camel@huaweicloud.com>
In-Reply-To: <16c446c001a96a9878ddec9726430d7001c3f47b.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 14:30:46 +0000
X-Gm-Features: AZwV_QiPE-wr7bzvtCNR8Zj6-bvGnDiuzbDIAnCn8Y0x5J3sx1pzHd8HlA92AzM
Message-ID: <CAGrbwDQWo8Eebtu4FHsahtJTOkw4jXgncm4paFY6uyU_GkqVtQ@mail.gmail.com>
Subject: Re: [PATCH v2] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 2:28=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 14:18 +0000, Dmitry Safonov via B4 Relay wrote:
[..]
> >       /* 2nd: template hash */
> > -     ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size=
[algo]);
> > +     if (algo =3D=3D HASH_ALGO__LAST)
> > +             ima_putc(m, "0", 1);
> > +     else
> > +             ima_print_digest(m, e->digests[algo_idx].digest, hash_dig=
est_size[algo]);
>
> No need, the last one is ok with ima_tpm_chip->allocated_banks[algo_idx].=
digest_size.

Cool, let me check it and I'll update it in v4.

Thanks,
           Dmitry
