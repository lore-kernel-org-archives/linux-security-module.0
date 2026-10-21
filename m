Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591933;
	b=vlw1pMwmF9Ep2+JtcTacF7aYJDUAhBHsmoUDVSKWKoiEZgwBVn+5NHxdkyMOffOFhX1P
	 j4ouYprGMFtaTcCmKfURcC/Ebcuo9rYDq2GcAZwAPTOj+AU2uB4mcjjA1WXwHdWkprxYG
	 j5QlZV0UwNPYcpW72WPng7JxU1GnkgKYhZy/v01dJjHtJB/wnrRKBcLU+omnWStAOXiyN
	 ks8FlwkILqjbw9Ll0xTdJkCP0GZ1qrmKNOZ4ZKTgozcGsFY0YMOK3eLXgCYgg3ClxjtAQ
	 XgB9xSUpqgzyF44JUKI43LQT5DvNFOts+bgmImdHHJVLTaII99hLTKc3u6HE2Rff6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SzXQb/ZXDrEukw06IuArBIagX+lqQulNXu92nJyQMUI=;
	b=Yftyx1pB8jVDNbhj+OOJKtU7MwZIfmHuwcDZKgCS6+zirx4MQhrm2BSHJiYvvLFmSA49
	 9SZs+hUFPLNBWh6E2vuL6IFAvWklrOdQzckpqpwPbHJtPDNO1SN5NhAVRg/O90DJkd4yy
	 ytDOQ0mloqjRMiUVZkmlhxLWMGulqxgUzqkVS+hwSyTP/p7S9FaQtjofshv3OwGNzigLC
	 o6UoaVJB2aUtHSkHDlLt6kg5sqViBmMdVWrFR+vqHvbMgSAjrDb9jmUpJWpOfIiBN7R87
	 A+U9KHTPnBxbZD0xYnzgPhwlcy/c+XHaeyLKs2RZbrgdJgUWrpCr7TTsshrLjdzaY0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=KD8tcyYk;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5A606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 14:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F5A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=KD8tcyYk
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E174A40264
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792591929;
	bh=SzXQb/ZXDrEukw06IuArBIagX+lqQulNXu92nJyQMUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=KD8tcyYkNHXoqC3vFZQw2WUqKfODUrEA3hSVLppU9rWSSyPUql5NVxYris9Y6lfb9
	 W4jcoapkYMm2FJVwHcar3G3uVOOx8HJP97kzrCgcRABGcDiC+8TbSpm9g0Q9Z1QyZq
	 8yVBUdyhMfrzhUsBnrc0/uTi37+3VQudjxQjGDi2luj64Qm6g3cUGLNk4DXc9dSlJn
	 PbOD6kNYz2nfVM2lkfb8xdv6LXHraUHy31Ld1AqQdApIu2hyG9Sv4HPmBijFxHXkj2
	 ueHTie9A+SCFGsHAx4EgpbLofajVS4M2DcqmcCjzYMYlHpb6Wo3mi1fskFI7OUaKRd
	 g8KBMPUzQMuc+wDKr8BQag/Zqp74i/cqVjpTUNfaa/ZYQZTO4ImDCAy3U9VPPi4THB
	 1kk0FsgLFa+7c4CO6R6OeTLB7fd3U4njh1Vo2l4p0zJ6srnzqVaRfaqEgjOKlg6EVI
	 y5mJMvuuhC0+W4zm4YpGLzOUwLK/mKao4wzv83BEtxwJ9MASMl1yP7uDqeg9cn/HgB
	 IzwH3HaOBMffATf7fD/dbH2V+Dnq0zG/1L/rTpL6WScdGOa0/BNlUwiIGC01YUa5Kq
	 GMVb58/S3CiCgaUiyBOyODH4BFKUE5grAArzkr0jVdD43szCnegce7t/Hwe+l8Q0kn
	 oCpYy9QrWm0fWIkigssXpci4=
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eabb3a1bd8so657377e0c.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 07:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591928; x=1793196728;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SzXQb/ZXDrEukw06IuArBIagX+lqQulNXu92nJyQMUI=;
        b=qJ5Q/hNDTtws6lY1NeCJ7TiSrL9Cf7VA+HcrA2UfD8XIT+H2fzvaBMtG7ku/xA1+xv
         xEEeGtyG6nYANeOGvYFymJXzTk3mvMdOy0cD6DrlWQRwhtZ3PqLZ/yJAZIqJwXBydIPw
         cGDYa0nfXChNjDX76Ep5CsJpFp3VzykQ2q+gZUYT0DjhlZ+yET8VERIrKvDN8aRj7m2b
         7EUc19aD1OzNy1Ypf1J0W6WbzA9+kmHeU/CBL35qsi8hGukBhLOv6q0C+X7iOjr5kKc9
         +34VXIUTafg9boP39l4OdLqO5pwGx/gkkUPJkaAd2akUdF6coVrwCnaprcgXFX+sIDQS
         XL4A==
X-Forwarded-Encrypted: i=1; AKwUvBwxOXqXqiPob2iz0efSBmo+nRcM8xVUcQyAflBtHdjqq0lZhW38/TRYkR8bC1h2CIQ1DqIL83+znyaHnqAin4OymZ4OrVc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJI+IrLiZGx68FhSL6BEWCDPi5j4X95YzsftvjdRPNTE1kmbPl8
	Izvpz7eXC+uB6nsP3GaQsaKKplPOfXAffimyzpJguZnMhuFSlS/g3LKdvqrPSnGIgge2KSts5tV
	zCy5ZeoewgpbqK8Ai6X5he7GxdT6BMetO+fbOUz+Bm9ejq7ECKdLXW10fWbgp6tlUiIfRKNixw4
	Mlh3f/iKqrziQxSYERcGcxsq0I1uej
X-Gm-Gg: AYBFou0/5yxMrwJ7UPJ+T0BZoU77wv0WW7GzxV4j7ZJMD1bI1GMx69E1Z9+0AbzMVjr
	U2hSy2zNN2Ncn9jWwzYKjfC1bdDoKTacjQIKY8F3GNIk/iO3GBMBxSTXGAKTZu/ewmZMOVkpD38
	/kxAk5RD72zIi4Jy5h6b95R/ABnFmf9sDxj5RZ9oEC+VGctxBDxT/TSi3hLI1kUHxp/lGW0IElr
	tfxt4fwI6A54qqm0+9cdUttH5Zs4Hgqq1in/MRFV0bbm6B5gDzouvSKJxN2mB8NiQEuY6Gb7nOm
	0x2Jhgfkt9Zxl7Xqmbv2/2GUcLwC1VEE0v50YdQC6HTptMgnYw+Ge336yFSWpxHqVQs+QzFOOUU
	j40FkMXodg8in
X-Received: by 2002:a05:6122:4d09:b0:5ea:e17d:fc73 with SMTP id 71dfb90a1353d-5eaebc1413bmr930787e0c.3.1792591927722;
        Wed, 21 Oct 2026 07:12:07 -0700 (PDT)
X-Received: by 2002:a05:6122:4d09:b0:5ea:e17d:fc73 with SMTP id 71dfb90a1353d-5eaebc1413bmr930771e0c.3.1792591927349;
        Wed, 21 Oct 2026 07:12:07 -0700 (PDT)
Received: from [172.16.19.55] ([209.178.136.2])
        by smtp.googlemail.com with ESMTPSA id 71dfb90a1353d-5eae97be251sm3236799e0c.8.2026.10.21.07.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:12:06 -0700 (PDT)
Message-ID: <b7ef16d3-3c10-4965-923b-ed46863fd3da@canonical.com>
Date: Wed, 21 Oct 2026 07:12:05 -0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix NULL ctx->peer derefs in unix socket ctx
 updates
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20260824155822.9214-1-maxime.belair@canonical.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260824155822.9214-1-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/24/26 08:58, Maxime Bélair wrote:
> aa_unix_file_perm lazily refreshes the AppArmor context cached on a unix
> socket. Two of the helpers it uses assume ctx->peer has already been set:
> 
> 	update_peer_ctx ->  l = aa_label_merge(old, label, GFP_ATOMIC);
> 	update_sk_ctx   ->  } else if (aa_label_is_subset(plabel, old)) {
> 
> where @old is ctx->peer. Neither aa_label_merge nor aa_label_is_subset
> allows NULL. So both fault on the aa_label->size load.
> 
>    BUG: kernel NULL pointer dereference, address: 000000000000004c
>    RIP: 0010:__aa_label_next_not_in_set+0xb/0xd0
>    Call Trace:
>     aa_label_is_subset+0x3f/0x70
>     aa_unix_file_perm+0x5e8/0x9d0
>     aa_file_perm+0x45a/0x550
>     apparmor_file_permission+0x44/0xb0
>     security_file_permission+0x40/0x100
>     rw_verify_area+0x56/0x180
>     vfs_write+0x7c/0x480
>     ksys_write+0xbf/0xf0
> 
> ctx->peer is only recorded for stream connections and socket pairs.
> unix_dgram_connect sets unix_peer(sk) without going through that path,
> so a connected AF_UNIX datagram socket has unix_peer(sk) set while
> ctx->peer is still NULL, and the first write that needs revalidation
> reaches the helpers above.
> 
> Both derefs date back to the Fixes: commit, but the update_sk_ctx() one
> was dormant until commit 4483efe4f215 ("apparmor: fix shadowing of plabel
> that prevents cache from being updated") stopped @plabel being shadowed,
> which is why bisecting the oops lands there.
> 
> A NULL @old just means no peer label has been recorded yet, so install
> the label directly instead of merging or comparing against it.
> 
> Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Closes: https://bugs.debian.org/1145111
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>

Acked-by: John Johansen <john.johansen@canonical.com>

this has been pulled into the apparmor tree

> ---
>   security/apparmor/af_unix.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index b908e744818c..d04d9cd268aa 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct aa_label *label,
>   		if (old == plabel) {
>   			rcu_assign_pointer(ctx->peer_lastupdate,
>   					   aa_get_label(plabel));
> -		} else if (aa_label_is_subset(plabel, old)) {
> +		} else if (!old || aa_label_is_subset(plabel, old)) {
>   			rcu_assign_pointer(ctx->peer_lastupdate,
>   					   aa_get_label(plabel));
>   			rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
> @@ -700,13 +700,17 @@ static void update_peer_ctx(struct sock *sk, struct aa_sk_ctx *ctx,
>   	spin_lock(&unix_sk(sk)->lock);
>   	old = rcu_dereference_protected(ctx->peer,
>   					lockdep_is_held(&unix_sk(sk)->lock));
> -	l = aa_label_merge(old, label, GFP_ATOMIC);
> -	if (l) {
> -		if (l != old) {
> -			rcu_assign_pointer(ctx->peer, l);
> -			aa_put_label(old);
> -		} else
> -			aa_put_label(l);
> +	if (!old)
> +		rcu_assign_pointer(ctx->peer, aa_get_label(label));
> +	else {
> +		l = aa_label_merge(old, label, GFP_ATOMIC);
> +		if (l) {
> +			if (l != old) {
> +				rcu_assign_pointer(ctx->peer, l);
> +				aa_put_label(old);
> +			} else
> +				aa_put_label(l);
> +		}
>   	}
>   	spin_unlock(&unix_sk(sk)->lock);
>   }

