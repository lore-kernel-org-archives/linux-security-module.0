Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576937E2EB
	for <linux-security-module@vger.kernel.org>; Mon,  4 May 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918980; cv=pass; b=qXYYgdSHkevd+XdIsMwjnQa5HCpbGvZt0LFp8aBkL5vSeR9qk2Uy99iO2VTpfngBs+NS6GBIlDSX2xXeDfv7np2t96Vh5I3Ya7eSalqKK0Zuh8td3f3lBoUIcK7s9rtvyjk7cSUjHZWlx7MJtx8POx+JXgst/JrGwbv4PeVZ9Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918980; c=relaxed/simple;
	bh=J89mktNnFmnXOYgVvQ7xeDsm1tTmEiO4BHLI3UwwOSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvAd+euDb6PxWCP64yyNNbk/Rxt62cI4sfez81/WD8nkDafXxuppb/mXKBW+gGc+msi49OT9i+EgYU8Gmmkxf95wYCdz4EGUFSxzCBoYZvCelHhjamer4qT+Mc3W6bgM9PHa+sF39CBQMhHG/4cb6P5dpCX5Kf7F6//bLLrJZq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=T1ON11Yh; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="T1ON11Yh"
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 228053F60F
	for <linux-security-module@vger.kernel.org>; Mon,  4 May 2026 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1777918969;
	bh=mlkE2OF8cdoctIAf8Y/THoq576QJS++E4BXgM2HXU4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=T1ON11Yh3Ac2JcBJA+lyVhDy+yEiSPMQ6JObT4wS7IwhKz5a/0/2/33kuAdXfxuc4
	 IBLVDSJanzzhpKN3muP1aHyWoG/iTbp/R7wO1+RP/GV/C8WmfcPRzmz1+IIIKQ4nNy
	 huk+gZn38btSC8xecXg01xltAxhq7SbTf8kSwD63VGMQimuijfCa0XWMeLvqkfnKDX
	 w5i25zlnNRm4kWbYLzhumv5h/qsUDG8lwyqL5Y5NWUE3gcwiwtqQFMoNOdAtpGYJ5/
	 Z6ZVyIdL1Vwt2gBW1r7DXZSkr49IJEvu4nhKfRzXXPlE1rnRtZ/K/Lpe+a6dg8EAnW
	 JUFtfosblr1Hhk2jTE8NbOaNh+cDM03LGuC4qKkKbYf1og9JR4NROnHfKsLoETPBEo
	 dK3Gy+g3QtUd6VWeoxPMaj+2xUCchc+rwetlzbPUWv8Dv2iVo+Pcs7tUCj5mvHwBZL
	 85RywoWMoxjUQk9YLQZzEL04ZbPe6kFp6BZ8xN8HjtwCmJVQiM6BLUIkqcxaZryvEb
	 rYRWHNFTtLlpL/zMRFQZj4OTEAM0eXY7/YYSZZOHJqb1MeGQVZLQMcLA3P70TRakm3
	 pqausJQeRuesncyNarF6H6esgjebSSfd/ILvdOf2PorsPtIqB9BE0nNNSdoQGsx8sq
	 aNRcmEu2RBUYy7fLce8x45FA=
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-65c3132b7b8so5826482d50.2
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2026 11:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777918968; cv=none;
        d=google.com; s=arc-20240605;
        b=FN3hennAh3hmOoWd0h1XUJmaQcnutPLFPLAk/vVz3je6yfXTUD6fu3nCCuEXDWA4B9
         1O196B+J6jNwJwLtl6lzbICX2SBv4/tC3SAedtTm+Vi1egyK/KW+jx12HgGxh3uP3775
         XW91K7xlnjbAHDzVE3rj2oFEqCoWQTfVIQAdGzI8PGQsU+PcOGHq7xCPmrvRIsTnuC5n
         Qrpe4Ho00wcN/fflTr/2rB6oW5HcZ+nStIYSyhqBadp24jZhH7oATBohGKVjwdyIZ5pL
         8gyV1nJGjIcmg81LVxJZeDVPUuwXZ1SUSE+Ykc64QMDUvqVEB3prpZzXekLXz7x8hGev
         CWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=mlkE2OF8cdoctIAf8Y/THoq576QJS++E4BXgM2HXU4U=;
        fh=Qtz6CcYrfB8wTEKn1qPuzTC+K80n1h6yBs8UROaJsrg=;
        b=ik0EOw3kGuzVU0TGxotrgtqkNqKZ0qTI7Ox9Z47/iW1bgEcYawBZF5Xkq38WDG8pLX
         +QhT6cYKiQ+TgFD4+TlwuRsVw4aNQp7Wix8Gxb9f7QrG/AXaEkVhOfO2St+RHRUY6Zis
         fH3+15AFdJm3E2u8SXpkCbTCLU1OdMm5wK7HLOyYgUCKt51E3O/PiaqdU9PA3I5DQjzL
         F5HRThySDouMmLgAfDP6f/VIR3xKR4g6OpKZ1XCV6ZC0Znr7ZvSWAo+XlIdHVjFMl5vF
         42nWksu5eYueRPAwTB9OmgeWgYCtUQfzcdRmXpspjA0gUxDDVodSbB/qfMfy1QNlgEmI
         n9IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777918968; x=1778523768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mlkE2OF8cdoctIAf8Y/THoq576QJS++E4BXgM2HXU4U=;
        b=BKpZ6WYi/ZBGsqJpQLrvbLYqN5elv7kpU5EOidZLHxDY/ecohQQVH2/Ks9hFk9Vz2r
         bFB8u50bZSmNTL8JSVnJlw0Z4cfb1hckgtZrC0OGMXZuqZecEf5JONKvK+kxu8OXIfjl
         JKTVdyx8OVo15gfFsH59E2MPK6ssJFQbxcBb3mVYv80Sqpwkjozq8ZZddMria7oIPiMM
         HmJH5LIsw5DatFlnZL83JX9Xf8wTpKljsfn1RcTteTBXLF5AWTY0tXIGRmwb1CAbDwT7
         +Ya863CTM79GyGfqXZ/OOWG1zA8DpmY5BcYEWltKa0NKosAduMrR1VfIqv2XAlf15m5w
         Ip/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/c5UVuUg9zzezqFQdwvjdCD6fZ2yZ4nKVusKD4VGtsfZHWZKAbr4wn1McHL7S33kaRI8Ek2T2Ev7casmu5k5xnQjpZTXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMr5bHT8NbPqzyh48/BoVTJj8C3vEyLeAneNy0/zWjjXkxMTf
	9m0LKfVcS7qkfG0IqLhk/EFXSsQFECWNV/lI2iAh/YO+nqMliz/SGG9dLPIpTpsyGUj+COQ9pBI
	f7HUXKVjKMJKjdcg1OuNXTj9tS/agAT7nUDxFxfnd+t5+V7wLb0ocdRf+7CHKJUIPLYCLMskjsx
	nlLpKzMd+hN3/x0r43OaD/YfyHXgygn+Obs5oRAgYYYeM5HwXKJ/yKfbIGbGCYRSAmTgSX
X-Gm-Gg: AeBDievb8HgslQd2eIpHRPa54lS8r07toqtpyJwUQ2u3Anle1CAZffQA5rO1bvaE0FB
	uw4qxQpvRkoz6sa6wPUPwkgre4ptkCtZOEeXGJp7oZXZ5OrDJp5b4cbibBFGrCfPa7ediK5H6CG
	OrgH88YndYn/aG0S7MpD/vowIUMK9d5McBIX3yIcP/rzQDsXHDHmr7tJLYarCRXu8xAAHkg72eJ
	xdjsYbcvCFaS1xGdFaq/JtZsJV7ctNn2weYi+qT3Bt6mRDotO1arsocvvKZBM1O/noanEl5QGbf
	Xg==
X-Received: by 2002:a05:690e:1303:b0:657:a1d0:992b with SMTP id 956f58d0204a3-65c3db767a2mr9828863d50.43.1777918968062;
        Mon, 04 May 2026 11:22:48 -0700 (PDT)
X-Received: by 2002:a05:690e:1303:b0:657:a1d0:992b with SMTP id
 956f58d0204a3-65c3db767a2mr9828823d50.43.1777918967644; Mon, 04 May 2026
 11:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503041243.200895-1-zenghongling@kylinos.cn>
In-Reply-To: <20260503041243.200895-1-zenghongling@kylinos.cn>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Mon, 4 May 2026 11:22:36 -0700
X-Gm-Features: AVHnY4IzmAOXlVcPCGPAGXRMLK1bN81evXNi72TVJV6ZTfLoviASNGsa0ZBWq1U
Message-ID: <CAKCV-6udZtokztssHe7Okfk3QT0H0=i+kDy65_BtSdAASAr6XA@mail.gmail.com>
Subject: Re: [PATCH 1/3] apparmor: Fix return in ns_mkdir_op
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, neil@brown.name, brauner@kernel.org, jlayton@kernel.org, 
	jack@suse.cz, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 9:13=E2=80=AFPM Hongling Zeng <zenghongling@kylinos.=
cn> wrote:
>
> Return NULL instead of passing to ERR_PTR while error is zero.
>   Fixes smatch warning:
>     - security/apparmor/apparmorfs.c:1846 ns_mkdir_op() warn:
>       passing zero to 'ERR_PTR'
>
> Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dent=
ry *")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  security/apparmor/apparmorfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorf=
s.c
> index ededaf46f3ca..1d7b1c70f22a 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1922,7 +1922,7 @@ static struct dentry *ns_mkdir_op(struct mnt_idmap =
*idmap, struct inode *dir,
>         mutex_unlock(&parent->lock);
>         aa_put_ns(parent);
>
> -       return ERR_PTR(error);
> +       return error ? ERR_PTR(error) : NULL;
>  }
>
>  static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
> --
> 2.25.1
>
>

Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
