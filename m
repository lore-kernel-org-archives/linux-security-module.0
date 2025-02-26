Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAC2222D1
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606060; cv=none; b=ijBuEKwXfK6wn/uDW71JWjzX/2/PYQjCf+PKnvJwm+2VJSJBxzc3mteAlweXl9fnK2BuuJdTjgy6EMnt5+2a9/lsYFkIdHxVYHfp+MN1bI1oBhr9KzBKfZZT2OhMR6lRGppfZ0QuS0furtEwDOxjxZcoIgn1te41+MX8Wd1IRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606060; c=relaxed/simple;
	bh=M3B+ZsqxZ4I34BVHwzLC+l7DLPs8esTLc1OEfaFetAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MUu4x7SoxJb43MMOivS88G+EUTdxaQ7IlZcrmPUGXZcFd1Q5gXnwaGD8tWV91PKBiQ430SYk8t1u186EfcIVSP7P9Qj1lXYqibzp1apX/0UxhFgsQKCfWCNJEA55Mxe9XuDTmnCn3DeMIRgKeDCVErEk1NdvTxzXTaLOPPrT6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVrTPWpm; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVrTPWpm"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dec9d39295so179069a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 13:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740606057; x=1741210857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3B+ZsqxZ4I34BVHwzLC+l7DLPs8esTLc1OEfaFetAI=;
        b=VVrTPWpmVGJqw4BvdPL9C3CmnGYUBCjpgjE3cnJWZTRsP1r9sMJbS2/DNCWijEdNTp
         YwPKqmehPv2RFNurJRMNw+X6cPUbL0RZKpbm/BKxszxuU3LF4K4CgMnYEU6HPJXseaW6
         t8grU75uPDQJqEMd1aCd284IyNdRNPkiqSxUKa8bK/yOB7HTzvcSSrz8+1E/9MkX+xFh
         RhIqLme/e0XbHCDxqxyLuQiGoRHkf4/ZGHCBrS3/+Mj/+drVgh4ysmjjLVfCBqH4kC/1
         Sjxi8HcWuqkD2JWB/PD+j6ibJ3wv3GuRCLwxahn5VEG94s/o57EPRtZHA7DW2aEmhhdr
         Bl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606057; x=1741210857;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M3B+ZsqxZ4I34BVHwzLC+l7DLPs8esTLc1OEfaFetAI=;
        b=DWFieEDTl3x9C2cJ9HT4MhbIT9mdSIEY3Glo3b0mwOtzcZslpNFYjObQsaxDfxekU0
         5qKgryyVRQ9vX3jozW+GhlnC13hqY1PhLgFxHNrP215EK7MJ/N6JVWl9M374/cYeCxeP
         A1DWvkDuKQFqKOzshSpfB3qHNKLD7JNUeGYdRvl4q0weE5MXVgXHb/JtPCPOcBZihioI
         fP0Qj7XMV5MnJqDtNKPQ75vVn4P8w0oOC+lXxHATpGiVgN0W14JzmmdPusOI8aD3nokP
         rypYTwhSVQEfAGVL+yIM6hNYh3LjnPoEaUaH+K38WxF9qJknncedP6vr74/ps9hVZPGG
         iKwg==
X-Forwarded-Encrypted: i=1; AJvYcCX/94vhSyPJat6nVqVpsoB3Kaq6doD4NDgbP0JgFKfhsWGJ+gYWR3P9s5N8kFjuoW2RMInq393SUEG2cu8TGAVt85hW348=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwBjWjkfLZjIn5LZtMX+bYYKE9e6/0WBdYTOlysDqDg1scuSB
	1AAAVwGt9ngjENLKUTsaT/o966fMINJMIHNbsa/8h3QlLdYcJpuactzb3rKtrrwcU3dwWIit3MQ
	A4w==
X-Google-Smtp-Source: AGHT+IFqy60kk8gHZxJF2clJAn1PaPcuwkicaXHEAUhIIG6HiilCo8npPzLf4GxyRbiots/PQcIwTZVoS3Q=
X-Received: from edc8.prod.google.com ([2002:a05:6402:4608:b0:5de:d475:6838])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35d1:b0:5e0:750a:5c30
 with SMTP id 4fb4d7f45d1cf-5e4a0dfc708mr7355742a12.20.1740606056903; Wed, 26
 Feb 2025 13:40:56 -0800 (PST)
Date: Wed, 26 Feb 2025 22:40:54 +0100
In-Reply-To: <20250226212911.34502-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226211814.31420-2-gnoack@google.com> <20250226212911.34502-2-gnoack@google.com>
Message-ID: <Z7-KZuA5eytW4lrV@google.com>
Subject: Re: [PATCH v2 1/3] landlock.7: Update description of Landlock rules
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>, "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-man@vger.kernel.org, Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:29:10PM +0100, G=C3=BCnther Noack wrote:
> This brings it up to date with the wording in the kernel documentation.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>

Apologies, I missed to add a "man" tag to the last three subject lines.
The last three commits in the overall patch set belong to the man-pages rep=
o.

(See threaded view at
https://lore.kernel.org/all/20250226211814.31420-2-gnoack@google.com/ for t=
he
full overview)

=E2=80=94G=C3=BCnther

