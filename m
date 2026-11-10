Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322304;
	b=0ECbfpeI56y7hQi8kGlbgu8wKIrfvOBPtwPqOVvC4zuEeEB1K7w+IximUoa9zAMZu8aa
	 jSr5l7wIpPnDCP6jmYhcEpLc57fAbetn94n7VI/vNFOu1Ixqj7CpSU4vk2ESTMRY0BUfj
	 h5ZUuQd7hoekkuy+uzgPUrvKmkjpcNxLAduAgcrbcNdMHxJqTnNEO0Yc6yCLo7G1rgJ2R
	 zI6bNX0F3jN1OKjzszFD+nqChefJMpnfPYfUsSlkhAIMAtiYLakK9Wj5y11MIAYrAMiVv
	 XUL7d/EUMl1HaTu2Qhw5IkUuQ4MH3ly9qyvrfZ23iKMvQphrjt2hjdpSlX2xOjOvM7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
	b=ZzGqqw3n2xTULrgROL10PQ4jnw/FiIwasUCV5aRw32nF0ocLwkn/IRWpUvJLwUmLhfTX
	 fjVw/X3FIwsog9vN943HJVTo2iKOVDY68W9U58GenXlwUuMDJDZ1vmLc09OQQaTdDUMC3
	 t8++LIPNkOSyMeZ0S9O3BX5KLv7Fb2U2OJKWlbYN8R93imZD6NkU0KoIRGp6xiOEO1TFq
	 XIDyJ6SwM21cNcm3rnRTM2kzDUfba89d5nuDLgXoizQ/lD9qwLJ0xHLFaSGtMkRI9JKZs
	 QzsRZnzA2FyjFQI1WdB1FVyX9WoQ1umLsM3cO5hkdiFSago0sjKKV+lK0X5Jjk4BS0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD0606A32D
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 14:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADAD0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IL+8xDhW
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b179528d56so118207a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 06:51:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794322303; cv=none;
        d=google.com; s=arc-20260327;
        b=kA1M1+IN95dtR0yeOSGQ38+gq4Ez7T1R6Cbc78HC9g2FEEppZFsnkppRQCNSR5aTzk
         jFv6qfQdwGxiqxpqoOGuIosrSpKllfkoQ1gcvQOgZaD2Yd2SBPkC4qyrtrlQAzVpUicA
         g7F1gytu79afWsZej/Dirl43f5gLCZ9Gu1xH8hBK/5Q5J8aBh3KzaM32GODzyhwvZ6YK
         CCkZVg6yOxbwhjxXaD3gmEcK/wBVuWWinKaTqUzE4i+MY4WoShakJT1kRcfODt1SY5tC
         qLPkLOLENRMpZEu8VNmqDVe4fAWKK7kGxxcSQaBqyzXV5njE7w9nLEhvF7wIOTC045GJ
         BHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        fh=9mkx/LszLoHk1o98atRY+e4utOvJzid4cGvDV6ezkDE=;
        b=iBnn1/XQDyPUQhN6rkhFv7mRDeaB4ud31Ob9Urf+ixEFyFcS+lIsOYxqGZRTMsvX+u
         ghpgRcvx1DcWG47fXcH600jqvEgUgdIn60kiHQH87mCeCQp6mXIPujLPTRgqBDFwOfq8
         UcabaRwuosevSOo7SJBg1B18Xd8+MRBAPk6px4Rc9G++SM/6urtdU5/obZOYTq7qM6vU
         NwiGqvzW367Qhbm8KlifzLeY+QOcVlsXNChgpZFnvXyMsdm3w4mV+2oUTvdz/bCwnCsT
         9f9PU7lfkJWsv8Bbk31Mrm8N8uR/UQUFUp7KgMUqArkFLdMXn5G6Tsprc2RLdGbYqqaW
         5xpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794322303; x=1794927103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=IL+8xDhWvbsY97lbmrxhet0Jxm/GEejFE1wA+kHdDdoy3r2HY0qfy9+Zo5tDyA1HCU
         92dTAWSC18xJKt+nqY3o9ZEOwugPfnvfyKVxgXTJccL+yGQZq3uA5w6FcKOdBgNjQCVS
         07UkwU1Ush9oWU9aQSyczjXfKDIKK13bz1vvPKKKZnAAbDJNUxO90oBj9mzTVwalm6uJ
         MzZxNoOFc+uElONJCp/htKG7NEjYziL9FbA761f4NJZqOMyMijk6azV7Si9VVAUAXV+J
         Tep1WbavDGNkRYBusn+me12VrKAKvlJoaba+qozCGl1bDCWa2Ghni1rfY8UzwuCjm2U4
         /4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322303; x=1794927103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXqi9+oAKFvDZXDHBvU0pPg5upNM7EyCnjhoXmEOydk=;
        b=1T9FG1V7UCqXdi4qUtFK8HhFWMwBbd1wkX+2wZHzXucOI/SG8pSzgKVY+6NjbSV9ud
         SMHdUwx6f4NJGvi7c6XJlTCFie2x3Q1BVAobrEhOA68vSujN7gk4eNxpFEgD/N/hCnDG
         l/jNPhW0w+hsLcxl68hvKkJdG29/l/IvRvoXLCPZjdZb9a0qEznnpTQcBMcJCIEUkO/c
         /KkkbvXwxPIuO9r/MQIKL4Ynggh+ux6p6tI6mAbTBP+4f3X8ppnl8J+9p1nUsEQyQUZ9
         IG7hdxM+09ADYHvqUbysfvI7IawwbYUDPqnFjVeQRqLmUUCz2Ui1KxZFbZKbeBg8ZDSB
         e4Jg==
X-Forwarded-Encrypted: i=1; AL+hErF8Rrvw+Op4qm12B0tZNhh+xR/pHYMzn6nLiZ62Kz3CVorlKqB01MqXWAekho38f39czQFi1z6DN0wjfnUeRASDQPckLOw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Kil3N4YY0zsZomtYqadkbdnl3DsL/PbehYom7GzWolfzpfc+2
	wz2ExrqeFVWxeOn5hYkqQr7Mncqmfy5UL8sW54KXC8hdcq/DYEdFbuaucSTJONBoFta0In5SAtT
	nP9QLAngTm24Jfp7ETsE6/yy5CNzlGl5l9WlAGU8G
X-Gm-Gg: AYBFou0x18CJjFgomuZ/CKUcFGmOqyW1Atwvxjnava5tZqvKSHj3I0rK1KrwEodwNbr
	mujoRAa9SV3+VItKMX1F9wZ6xmIug1sZP3NUUmfObdMGAa46//kEQ9seIs4pEfXtZWBer8SiBW+
	GmBaS5m5SmTarwNeshmrHkMkp4gTMh5GeZZtG8/LFYGsx0bnMLlhy0fJSeA4pVZTFkVwXUi70J1
	oaN93Zu3hetxeD5CE8b5ZPwLsPiWQLjxJMBbztRL/a5dWsv05sa9gc3AIKHhhhFbN6dRVBfhUnA
	sHwDa7K3bqb0+r2hM3UTNqckgT3vV8u32DsBfzcMYgyhbeyzDmZot46wMaE9MYC+wevwM5mXUos
	qIVTw1vlSD3B1KJEALUKpA9xTt2CKHkgFDbk9C5J2n409858P3uMyC4kbAlJP0Gzb2+Kf
X-Received: by 2002:a17:90b:4a47:b0:3ac:17c:6e89 with SMTP id
 98e67ed59e1d1-3b166cd4924mr2650628a91.19.1794322302909; Tue, 10 Nov 2026
 06:51:42 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110144205.2404088-1-mic@digikod.net>
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Nov 2026 09:51:31 -0500
X-Gm-Features: AclHuK9azAwCWCYb7rf35P_Qkz1YTwRFSpYVlH2tFTGhGa4I1jRp_1554UKlQOk
Message-ID: <CAHC9VhQ7xMe8J+wRYK98Lw-Ff8dg=wJNEWgJp-MOqFixeZkiZQ@mail.gmail.com>
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Josef Bacik <josef@toxicpanda.com>, Serge Hallyn <serge@hallyn.com>, 
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"Andrew G. Morgan" <morgan@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
>
> Use security_capable() against the parent namespace instead: the
> creator's credentials still belong to it at this point, so commoncap
> returns the same result, and only LSM denials are added.
>
> Do not audit this check: creating a user namespace does not use
> CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
> that later fails has no LSM audit record.
>
> Checking CAP_SETFCAP when the map is written would not work: the
> writer's credentials then belong to the new namespace, where commoncap
> grants the creator all capabilities.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: stable@vger.kernel.org
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>
> This is independent from Josef Bacik's series, which reworks this code
> to close other ways around the CAP_SETFCAP rule:
> https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@tox=
icpanda.com
>
> That series still computes the creator's CAP_SETFCAP with cap_capable()
> and cap_raised() in cap_setfcap_level(), so it would need the same
> change.
> ---
>  include/linux/user_namespace.h | 5 +++--
>  kernel/user_namespace.c        | 8 +++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

Looks reasonable to me.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--=20
paul-moore.com
