Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61B29D0C
	for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724131036; cv=none; b=GzYnXy1E+MfXXfMA9HPgiajgTOuDsXwElRfbcZ1tvT91QZS4z3S4qWLhOZz2Nf5mi64H6BtG2CTNwILgPFXk3sDPv6hdKEZn598AQODBNmjKLbQIq6dGVRYTJHcYY3zQk1bXK4LcFl1CttfryO7mrue6/jip7PVucLZvW4JbLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724131036; c=relaxed/simple;
	bh=MuASzcs2JgESdJgHLFM+gVymXMAUi4749BcdAvCqrmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf0QpdH5j90ukYvEB72mQ91pxtwrmg/JhIN1cmcNPns2WWAe5R6y4JW08CWQGoSNetnoNi/9PReepCVCv3jDykxZ9/OX7/wSFQnhXcZDe3/apcn7Qd0nMCsIrMA1hxkNo9N6RysOozeOk9NngOC0uod8wFmUKPd9OBylPEwdDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UcafYv3+; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UcafYv3+"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5164718276.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2024 22:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724131033; x=1724735833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuASzcs2JgESdJgHLFM+gVymXMAUi4749BcdAvCqrmw=;
        b=UcafYv3+PPuYKx+kGb8fAICfQDf6PwnmX12YqV8C5gaEifP/Vkeh/UM/gF7YSueZme
         1pkyWxNVaqgnqZg1FagfwhVGf/qXkmcmVsAxb76HOl8b6D7BSF2jlRHfp8nvbtL3R4hJ
         wHjDHs4gA3EBbbdhTpiZaOcbLYhcDhx/IwIOW3xxSoS2fUP4irdVUvoDjeVBCgB2LZm+
         nkUfiA4F6njasRttEzuxS8meytxqxnSNLQRC6P9B1hQhacSYN523Uf8vH3LzfoPT8Y68
         2jyiHqu8lOrnsGJ53jxpgGjsuNxmcUmxX4eJpiiejMR37BkIHVwtRwXO9CBH22RB3+5g
         VIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724131033; x=1724735833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuASzcs2JgESdJgHLFM+gVymXMAUi4749BcdAvCqrmw=;
        b=CqWvw4q7mNVsr7vvfZ2VEWg4xbZ6JYKrtPLerbHvMptE5+U5NZxbsFrQ70dAqXuzXb
         820fZSMwIfcFE3DZKcLOdVVIr3mPJPVcn8AqICg4ENjFWDgINb0Hc5riR3I7Xc/s0v3i
         7ycty+C8VRsNri5Wh3J7x/mpAt1SJiftB0Q0/dbVHwiVFwemQgnWP4AikkYdrckvTNJ6
         NxdhSze2U2E/7ikb+CZA45C8E77xo0ZtPMHqqgHSuMDUFNI5nN/k9gZRZDHekwbnLo65
         eCkZikplkcsvw/YJ0aSWd+O2gHa9q7Rph2GM3O8mx5o5gREZtL6yMTctRzB5ZSt9j1Bb
         BG2g==
X-Gm-Message-State: AOJu0YxUzOcMLtEuwVA0tbVv6K3nKj0yXrlUww+m2IRDGkSBNe/gCFgX
	CZAmiDiovTAvKV/RgkNGMHcH4UK0qoLAidcgKiXhgMuTo+WE2TLu1/lE0c8ibc+4xNAFUnF6g8L
	fe/kyktNHNJ/jlp5Z9dfRFnASyiwdtEJOsksEvp07u13IbzQ=
X-Google-Smtp-Source: AGHT+IHfrPlvN8+XxJaQBQZz4fzhp/OSucRWlRy0ZXzbPc9/8h1wSiTsGZ2OL54sYgkDKf6jhS2qo1kjmQfJZkv/tnQ=
X-Received: by 2002:a05:6902:200c:b0:e16:5343:ba5a with SMTP id
 3f1490d57ef6-e165343bd48mr927281276.15.1724131032666; Mon, 19 Aug 2024
 22:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org>
In-Reply-To: <20240816154307.3031838-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 01:17:02 -0400
Message-ID: <CAHC9VhQyK=EqZVBduLZCpN3m9pTzPvD_UhMZr92H1BhHbScC8Q@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] Reduce overhead of LSMs with static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:43=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> # Background
>
> LSM hooks (callbacks) are currently invoked as indirect function calls. T=
hese
> callbacks are registered into a linked list at boot time as the order of =
the
> LSMs can be configured on the kernel command line with the "lsm=3D" comma=
nd line
> parameter ...

Merged into lsm/dev, thanks all.

--=20
paul-moore.com
