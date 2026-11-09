Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794260613;
	b=RcKc6dg4d3JHhghqr8lTkGC7gxkqHhXB7NP6Rxhk3loy+ZN/00ju7HnuL5z5psyJvJ/T
	 oKagdIFIre1evT4G8enRgLEU+n/cS4eu5p92OdxXX/VTxaAlxJGVOF+x/wFq+VUAx49rx
	 FBltE35uTJV545QXKez8qDSkCwlSrjc/wTDAi7XeqFBBg8g5Eb4qFCTWUx79s85H3advT
	 pzcfeyRNY2wqd468MnMSc4+0Bb7y5dG0qRH7A8KhzGQyuSs714DmbrjeJMykicKzRhYzV
	 +3JxUUykwbT/S5Soex4E/VFca/jFsiLdB44vI4eV61Udp8rHEY1Ye0lVZEyqzoMgj7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
	b=BWL446AB+1RUaEV2CHCW5h+MTC9cMgjau+qibU0gOrAR1Pra6pPiif4JhI54EexFfcCU
	 PqveQtmf16Ktx2jNwJ/BG/6gvcIbdV5wStogLtoQyjmaj91sFRjjw5rzw3IhEy9L7mHWO
	 KemQdGGCbnJ8tCwb8WZSTFl2MXnbs4/NkcGHw3QgTy7UVr3fDgCFyvN+qyBLsZVtaztlt
	 r7EkAlJp/aiH53zR3gYeakZuPb/FE2FQotEfM4cQcuudKVgQXUb8E5LE7DKJ4XYXg9b3K
	 ax2QgLZ9li+k9vg/5xD55JumHw9AfnKMC5NE1mCzkiatl/+yWds3Q/hXAkN+4zJ8irw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FW4gnI7a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8E606A339
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 21:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC8E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FW4gnI7a
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9eb579c0eso7674755ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Nov 2026 13:43:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794260612; cv=none;
        d=google.com; s=arc-20260327;
        b=PnW7UM/ufwHpI4WDxo6qqkEU52BBkJd6738L1rO09nntLHzGmTY4VPQ+KTtlIMMl4x
         0cYPjyPqtZeCK+FZpje2fRI+X0PXtS4XUAW1AfHK7srHhw1SbRXIWRNB3OpwgWS9eIcz
         acTUqXnG5ch+7q948b9bg0QgcqmiqbyhtZukl+jGhGmBTzCOHYN7/dfNQGoTEGGL02a+
         /GPSMNgkO0N/bVid1LUdZMtPBHqNUEZzMpiPYAKCVjtS4VJanaLY8H2onx/DvirnyFz9
         wVXK5sJg4fX/d+MuXUNaTm1ldkJ78tCID+ZIIZljhMT0QIPSNmIrCUiukHxGRdAG9J1g
         Xtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
        fh=m2v1M8pLvK5g2kEeIguvAuoH2lwwbD0UgMTKFexCqTk=;
        b=sBLc+3CaJVACclAM9eCIjl+fs6L0JBZ34nH9s8Mf3WMCge98zOx9y7MFal6MCZI0CI
         GNrLxBpwQqBcAiZUUgkfZoO44Sedwxynj+o5UPZPJGTgSbyssTxnzpvi0e2CGdG3q9qF
         DinLNzhNbmu49CSTL/RTt9AGOG3gjS8a1+r1HMDxX2wQHxBwzf2MaiMI+SgwBgDVRvzB
         jqFhcFKpn938M60ppdsNuFqahEIt+monzs6EflQHUWgBcFBgyU6ZEEBDQqylFDdFnUlq
         7NTcmTiuGEdaFDOTWxPRWZ9G3yo4+qWKIruA88xx2amatlASf+rZlK8czfxhJcTLkpEF
         Kosg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794260612; x=1794865412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
        b=FW4gnI7aMUlA323PNxL015rukDYP04Zp2osLJYPTqp3cS7461mJbHNd5hvGgPfpIug
         L+0Doxyf2kU+3vFiciaolTBmV+ckqNY3nJAkw1+cZsmzDfX4nloMnQzdnKVJeX5cdnfK
         2wotiY4ynIUAgt66k7tD96aX0m3W2b2O9AQLAHaMmMe5KT9xZgD9kTHtwz4lIwsHtZve
         PtJNB6GXee8MKEY7ZymfwJMvkYKh9eFuzoPXYWhzRb9YS9OSBNTkweNp/uEGFSa9iGpQ
         k5rHAO+2EsG+r1J4qNIQJR5OoVe9LWRll48pS1Q9avCI47fRiWCb4zk5ljzciYcsUAvk
         Dk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260612; x=1794865412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=egVFBvHDJNnnMmGfg7wy9Moe6un731T3YHwLUE5cFTc=;
        b=EZFJyOHv9D/M4bji2jk+dVs+p73jRwz2TagrNnhPZLC8r64RuL9a0iBscDL5MDjju/
         EI/BPXs6zPJnMhgb/sCeNlsqTn4Um+YuwJ+Jm8LspuGJjWYf2aMDyly5wB8sUYP+2yI0
         rey7ET7T7Kr3byi82mPnjBysJeaeQ8M7x1wXwVRegWlaZUp0+t6j90dNPQNtwGCFj3Cc
         1hoUocFbQNA0Ij3nbmd4YFU6Qzx96L+Oev4KT5F4BnDWoPZplCvGYRFDj8lhU/1Y+K2s
         wUiJ+n9OPaHOa3rQ++qlis7u0AN8QKopPK/p4Yj5sjUyxuJ7opXxKaV+m3svX1AO9H0F
         kcjw==
X-Forwarded-Encrypted: i=1; AL+hErEvWH5fAESazp3aerHgkzat7GFOeMUOd/pLLkuNbnpa/2CBVm2qc/IfN31bNiyoz51/puQOampyXSHe6guBKBgLoghj8x4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oiGsAtoBiD1/hT8V84cAeaBaoqR87WtY+UQkhCdwEpx/sJBCi
	GtnLCOVMKLBzKNrpdeswhavv9JfR4puyaaiZLY1L+3Kcc8IvPyftSlppcujo6zYBSbCsMb174AH
	dmEyPF4P7uIdGEw+l8oS9M8fxA7mSHxGnX4Hm8Ta6
X-Gm-Gg: AYBFou2ZAlcdSSsAKxrTY5+Bq0LaImJQy6BEfdGKVmmFrfzY1P8oyku9vdzF7SPbdUv
	b0OBu/Wt5jXBNKkGfet/B+ZuGG6O2sUC5XLuH/WdzG6hzo6a/xIsb7wpIXFkVNkMRCEY9LJPz4B
	bkePC95CsfSS2ur29OJnrxio2oH642ws5DfR2jKqvmM9tqyaaoZmstkN2+9QqPl9n1o06Mn6f1h
	52Jxo3zjtCCVGZo5NzjfOZg5nEoB5CqKIVpgPQ3/CmkynnK1MfDAw2GWcBkjB4Naom/LmdokJZ+
	Bw3LXBvDG/C9xzipVcpBaBcFMxpWCyQVLljBF6gi7uwT7UAv3+4IKE7mFBK5kwH0qUbuxYbNfP2
	WtDJnrqHorm+xWlwN1/k8yyMzRICnFCdIi+bt+8XDwMB725jV2OsBMKk1d/cwwB8wEoON
X-Received: by 2002:a17:903:26cc:b0:2e9:5059:4477 with SMTP id
 d9443c01a7336-2edb9204fc8mr3620005ad.23.1794260612359; Mon, 09 Nov 2026
 13:43:32 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109131736.3060756-1-edumazet@kernel.org> <20261109131736.3060756-3-edumazet@kernel.org>
In-Reply-To: <20261109131736.3060756-3-edumazet@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 16:43:19 -0500
X-Gm-Features: AclHuK-NpM3KCLNneh-FJ4Qf-jlAznfnWoEfbHj5uijUkh9x-gO47OPcJX6vtyo
Message-ID: <CAHC9VhSxp6VuS_UKir8K_SPktik9Jto7rp-y+yi=V6b3rHR4+A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] cipso: unshare headers before recompiling IP
 options in cipso_v4_error()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 8:17=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> cipso_v4_error() recompiles the IP options of the offending packet with
> __ip_options_compile() before echoing them in an ICMP error.
> __ip_options_compile() updates Record Route and Timestamp options in
> place.
>
> cipso_v4_error() is called from the LSM socket receive hooks through
> netlbl_skbuff_err(). ip_rcv_options() unshared the IPv4 header earlier,
> but at socket delivery time the skb can again be a clone sharing its
> data with other skbs, such as the per-socket clones made for raw sockets
> or multicast/broadcast delivery. Writing to the options then modifies
> packet data seen by the other users of the buffer, and a concurrent
> recompilation would hit the same check-then-write race as the one fixed
> in ipv4_send_dest_unreach().
>
> Make the header private before recompiling options, as ip_rcv_options()
> already does. If the copy fails, do not send the ICMP error.
>
> The issue was found by an AI code review agent. It was not reproduced,
> and the fix was only build-tested.
>
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> v2: no change.
> v1: https://lore.kernel.org/netdev/20261106234313.2537882-1-edumazet@kern=
el.org/
>
>  net/ipv4/cipso_ipv4.c | 3 +++
>  1 file changed, 3 insertions(+)

My apologies, I missed that the v2 had been posted while ACK'ing the
v1.  Anyway, just so it's explicit ...

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
