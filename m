Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793288981;
	b=br3TfOwbFGIUvMNcXMVIxQzG7cekZUIKG73I9SQvt0Cgb7U2GDLO3+3RDfukWZJGgFYh
	 HnthL/9BbhglmlJpSjXqktazukZaI+93PhyOCCUsmicJWDi9EfiedFJm/O2mx170+caZM
	 3egZrrlrKTSk/jHe17Hrzm95rIdt8Ye4XhteQgvOHyf9bktW4PFpZmmaER4swyX3teh3z
	 UWa+22aQeh+xKFLNvnt6Aj38wj5bL+yfcJGpZw9D6fbe3W6XERNyetPrz133o0eZjtAyA
	 P3yfrH1/9qlcna0Rk49ktlR1sKLxRPDcl7XiPHdkbFBexHbTpMhJLUP+Kb4YTanSRuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
	b=CL8WThCX43hxk1HlZzlH34rGdFVb6mQ2qUnWj0GZFhHSUwKUmyVgdQjkasTA1xgHscRN
	 kZydNJk8M56J4izWeSAIQ4SUP6hvknl2fYM9r4Vr/FUe8RRHGMnU5328G1J3eSP7AkK25
	 TSYMhNhtWMnB092KOeROdo+Oo/TI0XAkwrAlNRQ8HylJvCzP+AQvPALBvGS+DATx64laR
	 t3jkSl9BPGgrPtBmhkiTJfqB8YGeD8Kc4zch7VlWYVp8qA9khpJKpIx6xE6CkWc+oWXeY
	 yd3vyHgRPE8mtZfAtOJEwtR9sw0fwD0IZdBtd1LBsLOZuGZgpCHTistUX0otRJVLm9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dcAaee+S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21A606A31F
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 15:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB21A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dcAaee+S
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab395abf79so21322237b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 08:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793288980; cv=none;
        d=google.com; s=arc-20260327;
        b=MKGexXhqhpNjL/KYJFKmXrP8mqb+3JZuyPm++GSozx0Q2h0pnKBrE8BAUU2nn6n/zI
         4Hv21ndtbMRlYc4BYfOi5fiVjrovV6nQSNVUTHkVdy5c7SreFQo/TBFccGrMnQOhbCDC
         R33hEuxKZTfPCYtaUFC1IWHjr9vUrzVkLMFUgTUmXzribJ/t/CeLXcjbltwMEmUI97cM
         IqhCQ9KJayLdMZ+jrHvA6cvVucaYO/NB2F5ZSV0b0IqCXRVZZ/1uohNZv9oI4A2ECdFf
         nF1VOsN38228ZL/T0T662u5AOQUjMONPDVZFNys2rdTwvcPGBjLEFIaQHBtESTtjq3r1
         nYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
        fh=Scvw0pj8S4x3J2UADhfMufxdBP7YfcTDrOH7LbuBkXc=;
        b=r733oHeT/vTUq4fznGVjxnNfE1Zq0QSjQavZmM59075ESu5D9SFJYZPO4x8AsJeJwM
         XqUF1+AHek8LmrP/K+hA7L0gfwmV+e2WlkKQlUMDNiI5oBmBy+tO651xYCM8yIYkp74o
         +2PPy0tHESvYv1LghPcUoGYqZhJ1pWqFYgf9Xwe3L/9duMoZ8vWnSr82F8BUYD5oRka2
         N4eOZPY5Bd1uEwV8/zn4n1kgHYJhqVEQ911llAM6s/yjHMYVblXBGCH0kzmKCIQ1zpLA
         TlWznbbmMmIqc9CdlCuH6h7DEDpFbA+tiTa0UikGXapXhp5ZGwX0lKgLXKrMvEz0Jux4
         2c/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793288980; x=1793893780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
        b=dcAaee+S80BXfYgGuIWlMPBosR9i6QOVqlb3vY8l/9iLrOGFm4+unNUDtzGxGKyFok
         12itqDDa4OKJG7gxl5X0/Z5LCZ5XMw0rWJ4xOU0k3c4iJ6cNbZgfgoRMJe6YaOpNHua1
         lV6h4ZR37JaIght9Dl3mG0pPKgqN9UvyZVpy+m8yUwT8n4UtUsVM1dvkwKjzDUnG2PfT
         YxPF+I4avo3XTgDKQyFs4LDafCmkMUjLyVIW/AOR3KxufhBpfK0ADP3CHeEY5YwlL1Ax
         yy1ZevKVxXWeX95dN/+heiR4nSOxEhBPanoY6PJM7ZVxGbgFyY6FgcwO2mGaqagjj674
         zrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288980; x=1793893780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/khPgYt+Z8Eyq72Gf1KS1mgbVWdyIQPBrR+ezojWw9k=;
        b=DNmNeTSEgkkh8inX33wKlI7C1cq4nciFsGrz17h5b/xhzryhDaBCk+LawnSSPtWqpF
         R04q32RabmPDjo2/m05zNjkZyDQJm9Hd3DgUWU7Icx9GyavHdeeI4QcBdSzlbg2jlFy8
         DDDdcfmxIQTnhsCLyO98jgOhHqpFsrxrDXUGPgprHupj1P/UJ9L7rHKsg0xs68DrQC7r
         z/BeLY70Dh2+Hx9ZI99TwEpZXKMBFWgiFDIk2FJGppbngUWkf1QF96/PzfJZzXzKf5lt
         A++TvVNadiYUjNnP3CV2ER6DzzCT4CF9fuuQee6ltPamRFdhm9CHY8zM5Pqq/dESRoaU
         3U1w==
X-Forwarded-Encrypted: i=1; AKwUvBxxWi3U0uZm3Aed5XAxDSfGmXpCCG57yfA1zl7+RdodwJJ+UumQgI+agX+OGp0e0EPlq8XJb+aXnJXGVSQNJc9yrnPMLXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8pZIhu8TJ/cUpUWVdvH2neEfgbRuUoekk0accB5e9zOxNasg3
	FaWpgQg5YaZAz8C3Q0A4yu0mBzF4iajwHqPtBRs7WamTkYb4jxp0tZ2nbuoi9Nm5rsldNgRw6BN
	8eaxsiyO+o0nS/Tt1jmP88+J9xjMj5mo=
X-Gm-Gg: AYBFou3xTyn54Oqd+0MKs6Y0BK1L1k+PELVn4JCGYhTYge3Th8RupFgIbyaTKSHBNOM
	FWYg0Fek84fgD90AMeOY7oydDtOH+vFnsPtvfVUsXP5KcYP5NBCj4cdOR45POD3Zfru33+tmEPu
	YaHxNcs8cwUle1PsLJAo3yroy9eja77xaziiwF/Dm/rmU158h55cmiVbZ5S9qN+5RHzIpUMp0e7
	R7QKGq698CXiWQrco0JybhLoU1Or+9jnv5nwxd3RPoVCmAfNt7C/2hmeXY7cAT+s3muVSW0rDO9
	Gaas+/vLXVjlK2uIOmEAmEEm+HPg+3VOldyi6R+k5469LBlky1+QCI2Erz8Ic/y6JoUy+idzZwG
	2JO/AtOhJt60E65HruIqJJnPsYeI/Q1uddtscc0lqySrP18c7CO9sqg7sbMsf
X-Received: by 2002:a05:690c:38b:b0:8b0:c71d:2b2b with SMTP id
 00721157ae682-8b1b5d115f8mr52613777b3.45.1793288979677; Thu, 29 Oct 2026
 08:49:39 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
 <auNGzJIWFt64IMWY@kernel.org> <CAFRLqsXdUfqvNyzNpnz=dvgtHrVyRhYoZqt-CQUo98HW7BtNJA@mail.gmail.com>
 <auNghmbNdKLQ2hmH@kernel.org>
In-Reply-To: <auNghmbNdKLQ2hmH@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 29 Oct 2026 23:49:28 +0800
X-Gm-Features: AclHuK_tM2GHZqt-tCPoNWRLY1HXoFFSXOkHSMBhJQPhDESUOrTm0WDe9EcLL1A
Message-ID: <CAFRLqsVKXJxqpPCj2od3AxnbuEa2Y6PMz00kgAq83pMH5Rchmw@mail.gmail.com>
Subject: Re: [PATCH] keys: Protect the update method check against type removal
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 23:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Yeah, overall I think this is improving and that's why I'm nitpicking
> stuff. What I would wish that if you could hold with any other fixes up
> until we've got the previous fully addressed.
>
> I mean submitting a fix trial that is not correct is not a problem
> or wrong for that matter. The problem is that if you put stuff out in
> volumes with patches in various phases, the odds that fix will land
> to the mainline tree rise.
>
> This is exactly what I got pissed of last time. Just wanted to this
> clear this one up. Also, you can use that on-hold time to re-check
> your unsubmitted patches one more time i.e., do your job better
> ;-) At leas for me that is something that I want to continuously
> improve.
>
> Br, Jarkko
>

Thanks for the guidence. I will follow that.

Best regards,
Cen Zhang
