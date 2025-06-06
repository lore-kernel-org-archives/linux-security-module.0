Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E110289E2A
	for <linux-security-module@vger.kernel.org>; Fri,  6 Jun 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232680; cv=none; b=MYQjyb9TPHgxchAUF5Ek91mpFmXSTfS642j77vHzCZDsk0C17X8OqF0DXH4eY/186tacpB7BZiL71NHxgYTIgFmlas4CamxlkZgsbKWtb3ab4+DtB2IaA3AkkvLqIEzOQXMNb+PfpQCoN1GiiQ662lCu0ufbl9nrnCg0FkIY/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232680; c=relaxed/simple;
	bh=/tiGAY6fu7wdEem/KXRpNh5Pt/VNU4PJ7/htsCBz4dc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jTCiuZ5sEja0NkrvEXKkJv8bMoE7yuuLY96mRTQ5tD45rW9XolU1oqD2wKtfX58EJ19P72OaaIwceXSPqMPYyaesORxBdw8zJXd3AQoFr+CWvKfCXBADNLhfGzmXYBPbs4bZVNG6fhJ5CglefSfnWOpcwI7kOo3B//8EKbaeOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLU6HFc3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLU6HFc3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso4688675a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Jun 2025 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749232677; x=1749837477; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iY0rx+rsGFhLOqPuTkJ4yj+5gQ+KGCTGR4LraOSflH8=;
        b=KLU6HFc3+6t9HxAfaa4HaoCjrWjoObO12x11wO+yVHronn5R+tqHqWVdM18/fBIXGx
         H9m8fVXAJR7Yx8WDSCfvLg0mk5dCPDr7CiU/u5XB3xr92mjuQKkxSPZyO9aIj1+VCOd4
         SplpETCZwDusqVSXgblRhUzAVqXv8QW6XcFGyrS1Ot9/OTDhq8G5+aBOm5VOfDBbALEL
         x71WVN7apdSlrUnXMyA8KiSS7ckT+ipdKC3gJ8qsrnnWPrKn6WxqKCsCvtkGE/ZoySp7
         vMZUOHASZ35Y5acDwJH5P46g/rHjx2cRawZ7/t0VtZJjESJwJKvNwkcto6jF+bSjXfmp
         YSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749232677; x=1749837477;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iY0rx+rsGFhLOqPuTkJ4yj+5gQ+KGCTGR4LraOSflH8=;
        b=cO6wqHgvZdOQRvc8lSg3PpTLXl36g6RoSZFPulUAtZHvKzh+mJbJZEH1VGyHGwf0bz
         0UdhOhAiUgVnKvQ1rUaHp/gnC8N/3V/k1K03EwMcXPXjfXdTKdj0huVpiPdyKmaQc685
         lOBQSzA79xRY8wJ30l1KJoeb86C20J2cb6BXXcRADo/2iLZu+Ty+YMcezYOeZzvajxJo
         qRlbUdjCzVILTrztYCk50Gv7M9WMujzX2p3h72xYOPyfv8j0z0C4BHn3iXPaRyfwWpNy
         1vEWPdYB5tio3WePf+twMREbJMyrKIC2xhtFYxO+jSAfIDByDXPVuoytgWMW3HF2D3XY
         aUGA==
X-Gm-Message-State: AOJu0YzzfVcWPz7hTmClUd1x+fb/wQX1zKecFdSUYAmF6Ft40Me4fLxW
	C3XwO16Fg2HE9KVLIWQVBLPHPSHHUkrt+W1Ikz7bygUCuZpfT91BmtmmmI1U9FcElWe17dKr+xy
	SAC4c41Do5R6pPtzUpu1cpDXUuL9coAdb2GVbGfawJZiCW2AnljoPkl+Q
X-Gm-Gg: ASbGnctODXryFEAlFahrLmEWxu3lOBB3gjI2zps/8oOI3saVFL61nAf67WdfRzfxze7
	N9jXa/M1geEnGBDJYlAfWsdldDEWiMqHrSW3NivfIHnH7whGOpe0iX9DYAKSrINdnLm8zxhI96R
	DVWMuDbbskdXBZ7WsKKiRYTkQdvLkuqYTy56aDlrRkgtY=
X-Google-Smtp-Source: AGHT+IE71Tr/UaUl8jIMjyxGK7J2EOHDxvH1ZD8EYJWB3KzPEeUZGeWn+M8kX/Nn1yukjbWsfOsQBBvKF1T52ITdsXM=
X-Received: by 2002:a05:6402:b43:b0:607:7811:ed9d with SMTP id
 4fb4d7f45d1cf-6077811eda3mr2728538a12.15.1749232677134; Fri, 06 Jun 2025
 10:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luigi Semenzato <semenzato@google.com>
Date: Fri, 6 Jun 2025 10:57:45 -0700
X-Gm-Features: AX0GCFsXA3MC7LeEtCiu-8tcQZyW3fJMsWmjFzphwIr2LZDuh1B456NdP3S55B8
Message-ID: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
Subject: adding CAP_RESERVED_# bits
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recently I inquired about the decision process for adding a CAP_DRM
bit to capability.h (to become DRM master).  It occurred to me that
the process for adding ANY bit would be fraught with controversies (to
say the least).

So I looked into maintaining a patch in our own kernel sources, but
that was surprisingly messy due to the build-time dependencies of
capability.h and the way we maintain and share sources internally for
multiple kernel versions.  This would have been quite simple if there
were a few reserved bits, such as CAP_RESERVED_0, ..,
CAP_RESERVED_<N-1> with, say, N=3.

Would this also be controversial?

Thanks!
