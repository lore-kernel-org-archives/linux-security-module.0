Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED829B8D0
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369360; cv=pass; b=AThwyS9C91weKReftzIQRKxBgGZ2IW7a8fKqC/jKotav+Tdnh++e91v+8xiVqBy5iTE7/b5INdIKnUK4bo+cVXHy2JFJzB8fj8Amls5F4Imo8JuKglNF8jGyXP22XKccYam2HbblE3a2N4sfSW8oZl5KMY60N8/0hhCtVtHAD8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369360; c=relaxed/simple;
	bh=RnIW3qmnHLBRpyMDOu1mpA+jBoMl6x3qPFLQbmUMVl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PP2X7T3+6FDXGDcmz6JYCZtJU13kZiD1Y0XwCASg0wZkHr+s8O7sT18FleB/rnod3ZslbDseWdykX6ixm2Oi1amLRAO+o+cO5USTZeoW6ESl//QzExGd0OmjYoEqZpOjeDTF5dR2YWu8hTUchyILY3gkDUm/TE/dc6HnXnTuDz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WG4k5pad; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WG4k5pad"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2be1dd4af34so154069695ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 20:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780369358; cv=none;
        d=google.com; s=arc-20240605;
        b=G/l7caF4w1UrwMUvX7SoLVljhAiQNpCpq2IVK6xtq8TU/FHDmi1LC7DFIanwQAy57F
         YjfzJBwWdHLqCIayoi384r7Xvpo3Oq/7eSjUgJNND5JbVp1YpwVyyIeIwL2OgcUxO4va
         on3wqu/EfWDE+98q2w9LFMYPty/TgjIZnUZO4XBtQyhK9ExYQP3wdO2SCW47HtPSLiB5
         GMFlAQsYrJlnhp0yFnr08TwlyXYBYfg0tVjw496U4n3iz5IGq/6gZSNejN4vlboc3U7X
         PBfRTVVmdl5QwUpxFWt8ujZFYDVQgNLl2LoKMyQJrMDvvyk2tSc7AAyFpfZ7ka3i/dUh
         ESMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        fh=thJ4MpKw4tkwMbbueDJx6o/avmJe3bT/2S591vzyG8s=;
        b=aJaXRM0vswbrAnTGgu9RVjSOnJVcvFeXy4E8SyV8yyP1kWNz6P5RinBl1fk15sUK2r
         78zFXkHEY3mkzV0/xGq6vn2ySOzM62ZxAkTgqmrNiCHWOKaXj5szSAImjUlUTgSwsMjy
         LeGKaSqG695as5YTLgS0l2NcKqmEyNS/t2h55vCMvZfrwBw6u2O4z9Yy6/3p5iMGDhug
         un/XkStaedxbm66Inc5vvf7VfTCZC80J8zfQ+YNWnbp4LCLt93zX+T9Ayuu/OdZhfvFX
         ts40+3NemO81nbNfOAU/LLG9caS7Sh6zHO/N6ltkrKPzQBALOgh/bX3EB7SxtwO8SVAn
         FFkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780369358; x=1780974158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        b=WG4k5pad/j+z0EGjhJfou99wweYu862hQYxAv7rIAeGZ2w9AZUA3jEXNrngRPw7BHG
         LJhJsPx+i1DHiyE45BMqRDSTGNdua/UipOnwbzfGmOhj5Vf7Ny64/mCVWRWtMcUPrzf0
         vCy/1mP6bE0SPTk61TC2V4CeKaEBMn/WOAu39hhfaQIrZK5YyDI2f5mgI5mwypxL2rY3
         rErMT2KqhzBQwzXwI7dlL3qf2+CvFr0LqLo0lcBCVr3Yo8l2u2cgbv5EA/mHALNoy8iy
         9MVD5iE5EAitiGDXPo6vuR2u5WrpxUOiCY+8l/4/lgRkOSkDDO30aKXHxu8lqisz4+Ny
         LzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780369358; x=1780974158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        b=m3q9QgRUUUuvSyFpfUfaWpLF0hu0hbBxJ9tWSJMctThqcYpYAlF8GDIAaGyunkK4xs
         QL9g49zQkyUmDJkGcGWtFybeoi9PO52vDtJMxjBhWOx9cnfYA16ZH+b73PjVPX+3vkLw
         QLUlsWVrBa6RHvBZmFMl4d2gKOaVgwhTzeLWyVWraqPW/BmxvD6+HGuJqyqdI9dEy1WK
         KKhQqtAyT1ZXht+x/x52YvuEajr20G4r1yLT6zfsUke8ppCQl1rsd0nV2DAAjUKhisXy
         5JCKuR9WAnEx/Hk5y/0VGYZUAoGVDYXsJp3bJWuohH+RFQAJ6vGVj7o33wXKoGFaRc3g
         fjPA==
X-Forwarded-Encrypted: i=1; AFNElJ/R7KNi2mhk7RkgK2AGDRzTYlJZWVJOyNgwLr3N/uVCC0GbI88HMOM/S4G90Msbnk6ObGUSDsPMpOBYPWE3lTEUdDRWi08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9gMwotDhvCyXeGQeFpnA08LJbXnYxFpVDaKXxqSUeJQoMFDe
	fW/0zOBA8UkYegM5lTNocBJmU+bRRdUIjz47MRpmPTz+0GKhMr8E3S8AlNx6Bl2x1EGN2of7kNO
	bQo4E1cs5uunQVisZCdsBBEgQ7FLegnidkxi2Ii12
X-Gm-Gg: Acq92OHPL9mLG//XlN4iYPsJRSvl3Rzo2a6WHq8Ow5VNM6YtZgGVZRzr+Vw9FZfpQXj
	7V4bcykD06ylAiRRwkyJk8IEBhEYYo2prHi5YirRKVDZITLz0v3f0DkZoXoPtpSvmCrbOvc28vf
	jg5iHriMDmhOtchhPAo25YBMlyitQ0OpZcBL6hlGYpFyUIwXXOBvqtciUk7oDM5X8PFj+ojZxkX
	Fh4DdoYlKy2Tmhe/LbbsjwQYeaCM0GZkkjBJYiBPN4/1JwZVNFZiknjoiSSSsTeFUtTaMCMvU2c
	7T7/9hx8gL87UyyaOQ==
X-Received: by 2002:a17:902:e784:b0:2c0:3400:5c42 with SMTP id
 d9443c01a7336-2c034005d88mr148499485ad.26.1780369358143; Mon, 01 Jun 2026
 20:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524041442.2432071-1-tpluszz77@gmail.com> <20260524041442.2432071-4-tpluszz77@gmail.com>
In-Reply-To: <20260524041442.2432071-4-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:02:25 -0400
X-Gm-Features: AVHnY4IKOEuFCYPopcTHkisDnIftyduVHmrJM7aEiXWe4ijxf-NYQbyG_FOKLzs
Message-ID: <CAHC9VhRM81w3-38sx103CFuow=+Jg4SNvJGWekNcow4s1yOAdA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] netlabel: validate CALIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, fw@strlen.de, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 12:15=E2=80=AFAM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
> header via calipso_optptr() and hands the bare pointer to
> calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
> calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
> calipso + 10 for cat_len bytes via netlbl_bitmap_walk().
>
> ipv6_hop_calipso() validates these bytes only at parse time inside
> ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write reachable
> from an unprivileged user namespace can rewrite both bytes between
> parse and the SELinux peer-label consume path
> (selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
> netlbl_skbuff_getattr).  The self-consistency check
> (cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
> mutating both bytes consistently, allowing a ~232-byte
> slab-out-of-bounds read from calipso + 10 whose set bits become MLS
> categories driving the access decision.
>
> netlbl_skbuff_getattr() has the skb; gate the consume on the option
> fitting within skb_tail_pointer().  The IPv6 option layout is
> type(1) + length(1) + length bytes of data, so requiring
> ptr + 2 + ptr[1] <=3D skb_tail covers the option and its embedded
> bitmap.  When the bounds check fails the packet has been mutated
> after parse, so return -EINVAL rather than fall through to the
> unlabeled path.
>
> Runtime confirmation (SELinux compat path with selinux=3D1 enforcing=3D0
> and a CALIPSO DOI added via netlabelctl): Udp6InDatagrams increments
> to 1 with the mutated cat_len, showing
> selinux_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
> calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
> option's true bound; with this patch the consume path returns
> -EINVAL at the bounds check and the counter stays 0.
>
> Cc: stable@vger.kernel.org
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Thanks for the fix.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
