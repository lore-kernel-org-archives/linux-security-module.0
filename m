Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258761854
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727051233; cv=none; b=bX3ntU2vZ+uRZBAUu/OEzSx7Q9bgw0VvqT9TqXoQ3luMcVPRSHSGa2+LYTgmmOsbdVs8fACNST9MVPPmg2leuIaaM49rTgiIT5EhIRwEggyt9G4FHnqfWpXhsXiXfZE6Vnfi89ELf5kbvYXEH4K7HDA7ykqbo64OGVa3I5rJ9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727051233; c=relaxed/simple;
	bh=oLxuxNCpKBxvXYvoL6b4Q7Aizd7jXbH6X+IyWKEYb58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcpdL5phu5dwxBPGVNcLvcnAZqO3XpaX8CX1H0RgQoLHZu2+CTdeQPDqGAnTXcGODQjtX2fMYxmOR4nubJcMDgelsN0fpvmp1x3fOP5st7Ggv+FRhKT4ytbS5RiI8phV8k3sxqtlKFz98ZKoJa7sILYsi7ig5yy2/O9XMPuEPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QzuD7/8M; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QzuD7/8M"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6da395fb97aso26877107b3.0
        for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727051231; x=1727656031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi8j4LrsfBHpaAU+oOhGbxOKTJgruMUCSoATW7J/yC0=;
        b=QzuD7/8MwSy8KyO37RHc/eQpUw8Tc2tilmbZPsBGXIlU4XByPd4/+wsxNmGb58dcbD
         jNzzpnhiirdGkF+MgfsSBbKJz1xlxLKgihcMWGebYJ5toCvdY1lBSkc/UfjhLOvjSwL9
         pUGZsOrvf3eMnrgs3Q/+Wk6tYyp/qQj9fRbooX/hAoTKozF6BsIpF4RPOCPPO2N7c9Ni
         l1tUtfVFdj81KOuVq7qzPasPDSoprxsxsYq60NZ5hIf+geyRCjhJ/Xu28lMeNecRAiCb
         UqqNzGNyqTVlxGFjU1rWa8H6eJsa0QTN/9DONZ1pVElg5P3vq/IlZCp7JesDycNlQZoL
         4xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727051231; x=1727656031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi8j4LrsfBHpaAU+oOhGbxOKTJgruMUCSoATW7J/yC0=;
        b=v+DEd60wcJzE7O/n7YzYLVhZaha/wzOq3zS58/ecNVgFUO1vLFOcJuBtp1ERRa3aIQ
         vmOQ3f+mWDtBH2B/T7/QvtFgpnfDKksy+ruIqL53cK173VfSSJzkvEwr2T8jVf0rrpq5
         OpBhw7a7JKKJhiPAFSVh+J0DlwcceCtr9Mj/7xQ7zxw3ZWmON9+3s7H97JNOiaoGnNve
         VMMB5swDlSIw9SQE0hzOd0yokpoQMvTfIILrvA8t/WYv1j2NnirkR5FnQMlyYyuQRgty
         aKw1fQYpZpmXu3h65IyVmfEFtgBGppzyYtY0a8miRgZJH2+2wfrKLcmleQAZI+ueHvON
         ZpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy73WzzGp08VHNISu4GynCVgNbKejPiDNEyEIzYHo5V4blSTsRnfBxZcH3iY2WWECMGQGPH8qN39RrgihImD9GW4PXcK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygx9egLHHGwqWF4/+aPgkyGXwVQiitIf3JoGC42EbOO14GuWTQ
	8jNXXE3Zc7j6it31xB7cm2MWQoHmTG0zZVzzz1QPBplBzLUPoRXmUeHpLM1PVQ5ggyRvOnieON6
	/dP3ADUwJUsTUlJDxDIu3DRf/WmE4jYSNzAocJzoVtcFQ1Eg=
X-Google-Smtp-Source: AGHT+IHcatybpDEQzXCmvPF6gj/lvbSwHzmNWrttTn6Kr/ycJO3vl8uev83L1AwpATO4K+zKtnaxiV5/+vn9MKrSO10=
X-Received: by 2002:a05:690c:2fc3:b0:6dc:8359:fb11 with SMTP id
 00721157ae682-6dfef0195b3mr57322077b3.37.1727051231133; Sun, 22 Sep 2024
 17:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922145226.491815-1-linux@roeck-us.net>
In-Reply-To: <20240922145226.491815-1-linux@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Sep 2024 20:27:00 -0400
Message-ID: <CAHC9VhRWhknpRkKv7-yZza-kr1Bq2nhch8bYm9BsfDpurFir9Q@mail.gmail.com>
Subject: Re: [PATCH] ipe: Add missing terminator to list of unit tests
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, 
	Fan Wu <wufan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 10:52=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> Add missing terminator to list of unit tests to avoid random crashes seen
> when running the test.
>
> Fixes: 10ca05a76065 ("ipe: kunit test for parser")
> Cc: Deven Bowers <deven.desai@linux.microsoft.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Fan Wu <wufan@linux.microsoft.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  security/ipe/policy_tests.c | 1 +
>  1 file changed, 1 insertion(+)

I'm guessing Fan doesn't have his tree setup yet, but if I can get an
ACK from Fan I can send this up via the LSM tree for the next
v6.12-rcX release.

> diff --git a/security/ipe/policy_tests.c b/security/ipe/policy_tests.c
> index 89521f6b9994..5f1654deeb04 100644
> --- a/security/ipe/policy_tests.c
> +++ b/security/ipe/policy_tests.c
> @@ -286,6 +286,7 @@ static void ipe_parser_widestring_test(struct kunit *=
test)
>  static struct kunit_case ipe_parser_test_cases[] =3D {
>         KUNIT_CASE_PARAM(ipe_parser_unsigned_test, ipe_policies_gen_param=
s),
>         KUNIT_CASE(ipe_parser_widestring_test),
> +       { }
>  };
>
>  static struct kunit_suite ipe_parser_test_suite =3D {

--=20
paul-moore.com
