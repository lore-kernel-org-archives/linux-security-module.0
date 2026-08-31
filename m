Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7E38E8A8
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211763; cv=pass; b=hq0+FZ9DClYKYR/Kii8SMKMnbIAs+fCQHsxmAvM1apJHIZKu4KKU0g/gI9Jfev7YrVxPIirnp7xFpSTMO/Gbk+yo2qm18dgTNXf9AJxlv+3AdF8I/6PUnoTLnc83wa3fMYm9JNHAVu+Sj9Nx0zMi0CDWXvcXDuBAlgo1h5TMLa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211763; c=relaxed/simple;
	bh=6dSr6n8f71eMNcsTQRedbNIMbv2X40uBOF5czoWCZbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl1fqLcWdq7mUDesqqynNPKppvucD0LkGMbkWIOTuNkWEvVJlaPyL9AP4eaaDEdn/nF1Ux2LK/KZfqdsXo9FQUQdeAHJ20UHf//aya5SypUiyDeAdc/qNbuCZ1hdpWD28IJsmQa236AYAq9r92KhfL1jxtcBekOWFwAdO/RVvPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VoXGlxdg; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VoXGlxdg"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca80d708489so272490a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788211761; cv=none;
        d=google.com; s=arc-20260327;
        b=hKpRsiLuCzXlc+1jC/pMpRskh6XcDT3qGtrCeiXzFCFyIli2QhN4R4MyZGrZFdPevv
         8p1jb37GmNEg4wUhzkzwP7MUhx5RWwYtzbWv+1yJ/IUefCwkLyXHmmtpuWxeVKZJphV+
         bIg6+sXO0qAykK3d9wi9L7CyaDCG7HwKCcwLdxJzWeZAGxtj8JD9Roi3tajUNk4CtuIq
         ZcNLRKDTtYzbybMU1QX0H0j+DLWnBZgW9gJgNz7eDRj2J4waKY8ipHMUdNJJ9l2FMKeZ
         R+Boh7Y1nK+6RkLyFKKqunczNPZW77F73P+DkzJfI5Q9m7HSRoqLpQSnQ66GsTdu8v9v
         mRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGP+omq5mcJBVNSA5Gjf4nhHLqpmKGJVzDeopx8ZsPY=;
        fh=zXLpA7YpfX43dWIdoSaPkQA0hGa2NZ0k8isn9Wvgqp4=;
        b=dmWCY7TZ1z/8Ee9Ou+PUZqIIrQj4iLavGj5HbBDeD87ywuwkct4dH906/aPdp6Fh+V
         34+eVWYP/7KsjR2r8PZSmcMj6eQc4rDRlufei0UQ427Oy0hFC+GtE1ghImYTMLbJS17j
         cV/obLOL9Huhv+Lto5EThMFxXa0XzSsaU6szGjPALqIneQ0vYNlUJoGCl3YzVw0PXiOF
         glTMCExC9w6HO2MDfd/5K7QBb9qzIyXH9xQsux635rIiXCn06yZWmy0PkVRUV03Ezkq5
         ReB5VCl7eFJUht4owBZbVQo+lLFxvAHS4JIu4MfNGIV/Whu4tLd54YioF+Snc8JwidB/
         j6vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788211761; x=1788816561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sGP+omq5mcJBVNSA5Gjf4nhHLqpmKGJVzDeopx8ZsPY=;
        b=VoXGlxdgCJWfOS0phaDJyAxtXkiIgKcq7ZCfEY4F/LkiAOky3Nkpaa129iqp/JwVZM
         i/B2YqQwHdCtd7bf0Ax64QaD57ST9bWqZivBGCeNWSWQqg+lE2ECcAX4VvXFXbFLR9GJ
         J3cKimwA9Q8IIVSV2/PcWdbrbj6IAtGesW2Q5dKbaEAC5MVs7cZY5FqgdNrQBRAFcfQA
         XsTr8npjT7vap6bsyb7SwZG/cABB/LaFSeSVTN7w/+zWk5P7xmQenWX1/b+D3VamG0Zo
         TJocSYA0veeKumODN9A2LvYwPq5KN7zorewPJGtFxLOLWOUBafU8Pqn9Qp7AjQZY0GYy
         w4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211761; x=1788816561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sGP+omq5mcJBVNSA5Gjf4nhHLqpmKGJVzDeopx8ZsPY=;
        b=jiC2pthLXS4oXaH4B3x2qaNU8lJCOPcJHLh3HaNqDunfuwNXLdQpAg92HAT2DHA53I
         zjJdn2ZHQrFBVv0ThNhaExKzDPyhZPFXaC1un71fb+7stVZcluaAWBzwqSecqXaOPoLd
         ySX5SU5aQApKrLZd+XPYECE25ZQP8Ubek9raDruRaCoXA2N2w3o42Ol/rYNgebVP/EFV
         jo+n5OKUG59OVCv1uGXxaCoAHFy+Rhmjhn3VhJuN0b3pz0BhMRH517leolq64k16eZ+x
         1Zg3N2O0JtxA0rPLGV9dX+D4ao9NlX7ZAjHJZjUO1vLLUjdBOGrW185W4n14l3zrzTPk
         5csg==
X-Gm-Message-State: AFuF++lMz8gdjkaPOH5c9bmfPE6BCiwLnUXkz1YIk16NDKIIf47fexSA
	DpNeED7RMwOUgrkjYvLeedR3ALxfPYqhCDCa04mgpNFKCxsvJgrMSjPVDR5PFiJFcc76z7WdgCO
	WKSL/O8ZJaUaU3pg4/8WHKz0wIiZu6MkbqxQcU0c898jcLD3sK6eRyQ==
X-Gm-Gg: AR+sD13CBP7DMI9nhlHoYbfAjDFivsFUqncTro/bqT6GZCRr86iPSFc9/iErQdEjyUK
	/L0sguSZyyvZ8zXh2i3dYrQcynU1GseQ3lr7E3pGy0qOvm7/z581y3LtGlDc5g9598SW+iz7ntC
	mZE8GBtDwSZ4mniRvfopXoTxgTaJcaLOt1YhK/EZAbnskHBAk7FsBsdbcHnc0lZkWevoGPyJ9F+
	pDdw/tedwJvqycMhX5n79YOUyrgTsznfg4+EblKCph0N4gUYLeEjLqHtbditCdDqAoMLFjTdmZO
	LNUTlaHv+dqKcT83WjlRIUU9N0LPM0zHQKnQHzpXbb0tvg==
X-Received: by 2002:a05:6a21:8981:b0:3d3:aed2:6f28 with SMTP id
 adf61e73a8af0-3d819cc0d77mr754814637.28.1788211761457; Mon, 31 Aug 2026
 14:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707080615.1235830-3-caixinchen1@huawei.com> <e7bf759345415ea1935fc845506d84d9@paul-moore.com>
In-Reply-To: <e7bf759345415ea1935fc845506d84d9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 17:29:10 -0400
X-Gm-Features: AcwNN1WDpUr4AyU4tqHwkQTb9BH7eKkK0gDZmEr1FwSZqBDqmpMv-_hHGogqz38
Message-ID: <CAHC9VhR38688Y-AphteLCAVcgLxcWXUUxg17XzQJE4wSND9OKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] security: Fix call security_backing_file_free
 second time
To: Cai Xinchen <caixinchen1@huawei.com>, jmorris@namei.org, serge@hallyn.com, 
	amir73il@gmail.com, brauner@kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Jul  7, 2026 Cai Xinchen <caixinchen1@huawei.com> wrote:
> >
> > I found the following path:
> >
> > alloc_empty_backing-file
> >     init_file(&ff->file, xxx)
> >         -> file_ref_init(&f->f_ref, 1); // only 1
> >     error =3D init_backing_file
> >         -> security_backing_file_alloc
> >         -> rc =3D call_int_hook(backing_file_alloc, ...)
> >            if (unlikely(rc))
> >               security_backing_file_free(backing_file); // first call
> >     if (unlikely(error)) {
> >         fput(&ff->file);
> >          -> if (unlikely(file_ref_put(&file->f_ref))) // zero
> >                 __fput_deferred(file);
> >                  -> ____fput -> __fput -> file_free(file);
> >                  -> backing_file_free(backing_file(f));
> >                  -> security_backing_file_free(&ff->file); // second ca=
ll
> >
> > Currently, only SELinux has the lsm backing_file_alloc hook, and it alw=
ays
> > return 0. When security_backing_file_free is called for the first time,
> > the blobs pointer is set to NULL. Therefore, double free will not occur=
 in
> > the code.
> >
> > Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> > Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> > ---
> >  security/security.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Merged into lsm/dev-staging, will be moved to lsm/dev after the merge
> window.

This is now in lsm/dev, thanks!

--=20
paul-moore.com
