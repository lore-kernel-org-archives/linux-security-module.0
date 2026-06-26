Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4963E2AA1
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487883; cv=pass; b=Qe9jCLFDwuKFZF1MaaDC6ChClN/tNVtZU2NucgX4D1lI3S55tp7vPS3EZ+9f0lXRnstv0rWPQKTmBRHHRCYBHZwXG8T+jMwPMu2cWwkd0hekRQdV2T+mPLcNAWsTXUoE/AkDn4RIUFmxtVeBU0zDvwPW2Lo+Rd0q7ydrY+Qpdmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487883; c=relaxed/simple;
	bh=wqSHr1EWMYBXrlSAKcagfIVqRtNYI8IHYjPj6F5FHLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze7GfXR5eMNa8iQ50G3sjVkCuFcLpH6gJPI34VBbqm8QsmLJassrrI8XcKkNnnVVai3KQvy0UXbBHJ4aXhGNAyXxdlAsQxi0MJKLFiaaYOinofkX9qXZGd55YcaekljkaEnuIMQKcml36xCsYmbOuF0qDkO+jXNrSkUHdQ9J5fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WwfMYccq; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WwfMYccq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7ebfbf2d4so6436765ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 08:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782487878; cv=none;
        d=google.com; s=arc-20260327;
        b=C0EO3/sQxtnTjF4P8RL9ULDi+1nhpyAGfbE1f6JEgeKdz8zcotXUKlrgD/Iy3Z4vzd
         nyPrFB/tigkbKflNKZVfD0A8ZcPlP1hJJgAVSXGhgHhMCBGZKnjQi6KOaf+QO+5hrLpN
         y1u8U1yoY5+PN2gvxGfVNHJxixRtIvTrSMgpCEyzWs7hRaNIvnRuOsQhMSh6aAdQbska
         qUtikmsQGGHcJ0nPRIhMclnOoWb9RmFYKWPjXqIFqQ+n/sf+ScFNV5hFOR75XtQo0dCI
         jY7NbaCryZdltj0h9Y6YA1L/aBD5Wy4F21V7T9VeTjcBBo6Qz0JhHwek4KdcxfKcnUfN
         bOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3UX0w5EKmMEqjBcGu53wO3BCmqVyWzVn/8cvHr+BeY=;
        fh=jTtIpUpChRQ28VX57Kale1Jqf+DyeVSdkhgWQZk6DRs=;
        b=kaBdc+KXopESDwWlXgEUReFjXRGZ+d3csIPqmpWaDrZoxT4KtinDaQonlC273FVcrZ
         aC+fubZxBvbMpRIqu7TcEF1czoWWOAlk9KN7DD+DJHIaJUf9Bl3hiVBcKOPFg5FIjDjr
         4sCL0pUdBGEDXsD9bJ1jylnNHAewHmD6MZCNV4QztnMpWlRxXZHnGDk2Icm8sKQuuedl
         tSN/kosNmN7AwwPOZWC80os3uNMW2BPYfYvGSQsy2yiWQTdi9TQeRrVxO/XXfRCwn/a7
         7ocOHLFyAQZHjpJtsgFo2XHcTQpS+h/LwyC7a4xVeSkUJxvEXOHF9oKofzLrzYPZXG6b
         8wBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782487878; x=1783092678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3UX0w5EKmMEqjBcGu53wO3BCmqVyWzVn/8cvHr+BeY=;
        b=WwfMYccqsBUm52y+juQmzKEuofwm83E6WcDoFZNUzyJe0gmz4JB7GEVKXZw041gsMV
         uc8FpKgARxiBJaydTkAoB7nahiyicI6V/fSCwGPhcuWYVWXEWURzLc/vkASlYt+73GHA
         suEC6Lhnvm2rtiTG3Hrtg3RrTR+wwTxasPIxIciVuUcAi839yxU0NG5TrTTjLklazc5T
         AJZ0Wnz2y6Zh/h00p/GmVmCW35Wz/C/sJoidyWn8qM/Ty86vGK5zfcGv1uIE6dSlaxkY
         k/H6FRuNTpIFkz3h0OmTD2O7aJ87rQBiQMZ/SauMUpkQ9zyhHaWCOTDNCWJEQ7BR7Tly
         K86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487878; x=1783092678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3UX0w5EKmMEqjBcGu53wO3BCmqVyWzVn/8cvHr+BeY=;
        b=lusJuWdjHuSCJrWMuzRgW5hTz2PVGCULveD49wE2EtFhkAq/yNFa8NF4LhOd1sjdFv
         9z6UxlYaevFbqnKUSGa8b4UPNyySPdtFEzi55TtgAkvFkWqgFeIChhWXgIF7KLro6L/B
         yzOvLqQ9uw55bp+wp4Cs88qqqnlfZdq3suuFs4J0zIVK87gVU7kM26Daw0vTvyOT2xsY
         nn7qR5AXjBj+NmGgM7FYqVZnlmT+/gEq7zLlEhI5H4oO6Xm3GIHVqR6irjO0BhLImWcK
         AO//JFWvTiP0XnENUztpCzqk/qtiko0QPS27hxqjaCvE11wtF5Ji+dtBO+n/JweAXE5r
         3Ptw==
X-Forwarded-Encrypted: i=1; AHgh+RqdqPBIImFj0MzXXTXeycrXRxlGYJX7dQ57IN0b4E6fJCwLUIyjdcXHTqUQQ4M4am80/7dNA7uwNYTnGx1U78lYvWrJgLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++ww/A34U6kQw7CSHqAb1bCnHCgc4HdSPstKxcU/CzO3vW5O2
	0QxBYW4OXkbWKxhsGRfy41T/wukCdCoBlM2BqxsrmCD9H/3jKcTILgMcZtose4To/f7B/kx6yIv
	Pd6nd2qz9o7QJAkyGJbQx4ET2lYEKj/+AHngsyxKh
X-Gm-Gg: AfdE7clQcJnxVqYbmQnxSyomKpeiV7Rp74x4RFDRD+/3Zd0xB5tmgxny0T6uX94p0t9
	+mXsoC+DMI/IG6jp5+tuCHf5ZXyHasEKTokq0ax3/Se+n/c2i00Q7V2Nlc6lyqkoOtSsF9fuI76
	S9+4+G5WSwmUDIU3vr8kzDEDOwCrDGl1+NC5TjXrrI63b06kn9+jajzLheOBPmE10S8VaaNeZOQ
	QZLnQfiLFcOUR8SiRXGnGaJV2PVnkTP9ZMd65Er5Ry5vRRE862vw6tiVio3VVpCIc/+I9Vw
X-Received: by 2002:a17:903:19eb:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2c7fc74ed9bmr77478525ad.14.1782487878522; Fri, 26 Jun 2026
 08:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626114533.102138-1-cem@kernel.org> <20260626114533.102138-2-cem@kernel.org>
In-Reply-To: <20260626114533.102138-2-cem@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 26 Jun 2026 11:31:06 -0400
X-Gm-Features: AVVi8CcEZMeN8u2CIiqk4TLj89kobhoxWYGuWAl5i77ATSryI4gp2OXB1rc_eGY
Message-ID: <CAHC9VhQNURc=d4AOVDF-z29fjLasCiLf120Y-N3txEBccpkfSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] capabily: Add new capable_noaudit
To: cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, jack@suze.cz, djwong@kernel.org, hch@lst.de, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 7:49=E2=80=AFAM <cem@kernel.org> wrote:
>
> From: Carlos Maiolino <cem@kernel.org>
>
> In some situations (quota enforcement bypass in this case) we'd like to
> check for a specific capability without triggering spurious audit
> messages from security modules like selinux.
>
> Add a new helper so we don't need to use ns_capable_noaudit() directly.
>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  include/linux/capability.h |  5 +++++
>  kernel/capability.c        | 17 +++++++++++++++++
>  2 files changed, 22 insertions(+)

This is Serge's call, not mine, but FWIW, I somewhat prefer to see
code use the ns_capable_XXX() variants directly as I like to think it
means some thought went into ensuring the capability check is being
done in the right namespace.  Yes, we all know that capable() just
uses the init namespace, but I like to think that having to type that
out in the parameter list might be a good double check ;)

--=20
paul-moore.com
