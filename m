Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C861F471F
	for <linux-security-module@vger.kernel.org>; Tue,  3 Dec 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263166; cv=none; b=sK3aIewJZYwpccYfdI3Dsh4nVGVlFCu9kFs9M91zricI0Z/rUhqKdyVvNeyoLH/DKMGHQD2xvbvPLiLZc3EyPk4X85w3FDn1Tm1fTyOF/efbtnV+TfsygKbLdZlenow4BzL+Z98VBMlnygkNlLEGc9Nr9zYaqPsx6aHkfG3TSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263166; c=relaxed/simple;
	bh=RwsCeayLxIBBtsAIETWJ0FkpBi/Z2efzhYyPi01amOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjMvD54nuUzezPhLU3ebGvdVPeB3Dk2+Aj0NDLLV9kqopdJ6iwvcEl/e4dyhRebgnaDkB+2CICBW66WSWfFaCq4bLNZ07VjaIrDrBE3lGe8sXpOfSIDu/GmhsboJuJ4Rr/1fSWHr5oo5d9cDsKgOY0uG5Zt5kpo+8TiwllT2Cjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ED7lZhbO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ED7lZhbO"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef7f8acc33so31951997b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Dec 2024 13:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733263163; x=1733867963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EuP8ZzUM+WBmUmH26MMN9LOMJ8DZr59ZXfRDenlu98=;
        b=ED7lZhbORU0IFTiuhYYSZwg2VcmpP7Y5GmEOIEfSez0HFVDQh0z9aPUZXpQ/nvulIs
         bLSM66VWoWqMeF4AD8PZdX31SXiC21f4SNChNZs8XHTJUDJl4Q+YWcdw5xZFGZYbLWZ9
         Lxm7fD14T3hvOpd/FV8Ec0XCZYDh1u4Rk0XbyPDJfBkqv50OX3TI44M8nfVv6AQWN1el
         jT8n4Edi3UVoXLtL0DPziyG/rThtntQx2NlkF3p2+xDRrSZ0POEvnec5orRCv69xfDmi
         pes7VuLnFuKD5dTfcqiDXuO22dUBhhqdyACly/7sKnz8cE/e+b41CwPIOEGiC6v/GO2Z
         KTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263163; x=1733867963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EuP8ZzUM+WBmUmH26MMN9LOMJ8DZr59ZXfRDenlu98=;
        b=dzq5qSBaZKSTtKP2AvyOK89h0AnNhEaqL3C8JbwaoRTrSB8tR8QeAntAHfISIs/Aet
         h7HWVik/zMJKxzgqhG4cbWab/9rBFmFKHqbDzzQAsc89KcsDo6SvKdbVgEJT8CpRRdlx
         C20og/6TGc7AH/ta7zvuvet3s0xoOyAOS+04RvYTPDSLycpcwVm9AEZZdV9hEwttdZ8f
         hcsIBuWCaaZ3VB5kyPs2A89tTGjhieCeoW34qiUAp4CWNgAWvpKQuFTPTAsYq56EYWnr
         qKkHBGdiJoSpU9VzDpN50VEV0uwnnHgEnjLXUjgtwg0Rhy2sGxY3JQzT4kVWc8atopsV
         WZnQ==
X-Gm-Message-State: AOJu0YzxM05twXtoK/JF8TGBryci3DmbNmUaZHVsQ0Mbmgy4uTpwlOSI
	1X1LH/07yX2Cc7pX3iOai+dUfRgb7ym+F5GIYlzEeIGk6waZQ5ALbmkmS0YGw4sO2Zfxi5pBvMx
	W46Z+vD3irT8SlmyqK6vixQbsIglkGzqORZUx
X-Gm-Gg: ASbGnctIogsFKpsUC48BfuboN1gTxiKgtXKITgeSmAzF+dKxfT/S7kTXODr89/TnxJD
	mPBycVgvRppr/OwrvvXa6YeSAIsFVZg==
X-Google-Smtp-Source: AGHT+IFEqtZbgYPtZwKjc9p+EBNOVp+Ugd3SkIQtsMrFQ6FhGW+QKrzv1+Fv4IxraIF0aM/eNPIQ7R7dY3hxCII4qd0=
X-Received: by 2002:a05:6902:e06:b0:e38:c692:14a4 with SMTP id
 3f1490d57ef6-e39d418095fmr4499303276.36.1733263163167; Tue, 03 Dec 2024
 13:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com> <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com>
In-Reply-To: <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 16:59:12 -0500
Message-ID: <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
Subject: Re: LSM: Replace secctx/len pairs with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:29=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> Paul, do you want a revised patch set for the lsm_context change,
> or do you want to stick with what's in dev-staging?

I figured I would just move dev-staging over (I've already ported them
to v6.13-rc1 in my tree), but if you want to send out another patchset
I guess that's fine too.  Although looking at the related patches in
dev-staging right now, excluding the rust update from Alice, there is
only a kdoc fix (me), a signedness fix (Dan Carpenter), and then the
two fixes from you.  If you like, I can just squash your fixes into
the relevant patches since there is no authorship issue, and to be
frank I'm fine with squashing my kdoc fix too, which leaves us with
just Dan's fix ... which I think is okay~ish to leave standalone, but
if Dan's okay with squashing that I can do that too as it would be
preferable.  Dan?

In case anyone is wondering, yes, squashing does take a little bit of
work on my end, but it borders on trivial, and it is much quicker than
re-reviewing a patchset.

--=20
paul-moore.com
