Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BA28725C
	for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965795; cv=none; b=ITATgQl42NGK/XOxV6XBHEFnFwVHx0+0yQwV6csGNHe01wG4TVavnI6TOk0/AQiRsErGR2rd7IcQ1nW8fl0LltYyBjD/k5a3AGWMERaPU3b3ZOP1wfGKwkN9QBQ3VIpsIx85fTgRcpxxwIWwNv5bOV+FRYZ33HO0VzoWxHAklF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965795; c=relaxed/simple;
	bh=vki4f//YpOA+/DMIEKosPdhpC7X1EIX6rn18AUOJIDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYkqIFo395lso9A114DYHnU9L6kN+M8vhLksRYBT10NpUP6OQQe8xegw3Qys+JSRHdAwfja5prBfzhB96hTmIzP0E65hic8+jdYIYG/RPIHGyGn5lNc9CJOLzsAICNkiMFN+PfgnFDuJaTZV7k16VRDJfJVth0oahWm40O07vzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc9L3fZz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc9L3fZz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso986247a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757965794; x=1758570594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/yBS8xqZruyRHXODDMQkHttngIp9wHEWvRKIBk6FX8=;
        b=nc9L3fZzeRDgR4liUamusx+uW9r+rY5mn7V9or3lO3n/DX5QhnP1EizcznIIJdAfYG
         hRYA0lXC+DC3dHF8Vlt7ZKWz0d33EI579c/jj8AnYqs5Rmfbh9pMXwKKZEPDa7mQ40uM
         UgVzGA9D2k8t3WD5XmCntjIi2V6zcNX6rt9kDlzCGb4UJ1SOJAzrKyzNgz6fvaDPknLj
         NRa4FzYcJdG8yT2NIWmNQ0ghh73wuxEZ31ir9EMd7e3Jq3D4Kqd7T2gaSVU0yN+pSN94
         T5g+7ossMGLSLpi2hTYuDdSq4ysdj2zKNjBTvlA/h2D1XYZARICgOt6wdyVTvZTla+zJ
         +KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965794; x=1758570594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/yBS8xqZruyRHXODDMQkHttngIp9wHEWvRKIBk6FX8=;
        b=H/1IabJP4dnD5HDk7TH0oIf9fQxSxF5oqj0d2lWjZMe+bvoY2pQk4F6jYfx86nxEKZ
         11HjO+FVqcYuU4p0sACb1Nq5D5OV2sa7me89rhBUSI/fHQbjG8yBnfZuKHok8u+Jl8J1
         Aog3gs3M4o9+fVLwinMjvUb658Z+AUUzDrS2D+PyoWFuk6UkVItpCgRLOGxMOCuy7NfO
         yWl9qCo8/QuSP11iFJ+wamieX1RX/kTtP+GaZ9ZXBMBGPLHfuEDhaPDBTy/QeN1UYg1M
         KKgrBj7NQSAaHHoFjJ1CUly9oBMQGdLfS4xTViORwJ1k7Ps0GsR0YBYKw8x69ESPCQQY
         /Smw==
X-Forwarded-Encrypted: i=1; AJvYcCXixsKzz0dY2likSOCNDgXfsEg7+jIMHkr8SskYFoSaD4cj1hpwQsFDUbbDQvdPHSxUEq8CilsDGdpnjf4rZdXnz3OaLuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65vxGRqRJBKaVGCHuLKgWuj3WauEdl8Djw0TjtHV4aF/+nxWL
	yn814PC0cHyxL26r7m3nKH04ool0vEQpugj+vYZgdwrZgqQmsnEi3ZQK6yFl0fdy99P9qut/9ab
	diSHTU8ybi32ClxWMxFIInJphiZ1uMxM=
X-Gm-Gg: ASbGncskarfM0io78bvBproW16HOCiYwCdLbB5DW48/aNyBCC7GqvBPxmyujfvlCRd6
	S7+bvDPc96Rh7AZuIpn+BJlvhY27TY+l9mdauk0kFj10X/RYIozvfDsKUG4ur7QLm9RgFKGi4tG
	45kskB4YKoImSWQZ4r315tWukABPySO1cn4G7dXx8P+4uTVd+IJb6gnuDAb6m3hIqievxXiKN42
	TvI5Y8vI9DMSODWmYnc/Hc=
X-Google-Smtp-Source: AGHT+IFPR0xNt1SdT9jmYfIls8wuA4gQdU6nOErPR02vY+QbY+RVRV/p069LcMoFMza2ywVDD048srLdsGemFoumkbs=
X-Received: by 2002:a17:90b:50c5:b0:32e:a10b:ce48 with SMTP id
 98e67ed59e1d1-32ea10bd062mr660253a91.12.1757965793696; Mon, 15 Sep 2025
 12:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914215141.15144-1-kpsingh@kernel.org> <20250914215141.15144-5-kpsingh@kernel.org>
In-Reply-To: <20250914215141.15144-5-kpsingh@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 12:49:39 -0700
X-Gm-Features: Ac12FXzQ6hNrX8nP9Cv8EeH1bTRHFp3dNUNpYMvmZX34bI4yuZQORu-aBvdlJ5c
Message-ID: <CAEf4Bza4OF5ihhEr_ihW6FQ5JF=pdHukFtgTprsuxYsasAsoKw@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 2:52=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> Implement setters and getters that allow map to be registered as
> exclusive to the specified program. The registration should be done
> before the exclusive program is loaded.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/bpf.c      |  4 ++-
>  tools/lib/bpf/bpf.h      |  5 ++-
>  tools/lib/bpf/libbpf.c   | 69 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 22 +++++++++++++
>  tools/lib/bpf/libbpf.map |  3 ++
>  5 files changed, 101 insertions(+), 2 deletions(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
