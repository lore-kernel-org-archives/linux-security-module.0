Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DF2038A1
	for <linux-security-module@vger.kernel.org>; Wed,  6 Nov 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909609; cv=none; b=u0BaeAzWuMnOEunSu2Zzt+T7dZy4IakZG5ZftzPH16hdKhlV9V+zoDaO07PIFoN/TJkhVieGaBhBpjlmv7vtdB4/DTJ+8hOeDEwVNLmn1Xp1o8AUrMo/8nKEO26EahTkC8A+NdJgu1f/64Ej1zj7bfzG2MdwUrkBRtPvXMy3uCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909609; c=relaxed/simple;
	bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE0BVBoDlZEum2w7fwwNxUDBBWB8CNSfgsJEVEyWPcIUPBN9jrLZ9qEUo5r1jTvotWeEHuzW2acrmVj8o2Ke7rY7yIUg1Ua3inT5L3P0b+2AWBucNxRIGsVj6s499IQ6LTyRc7JQ54Ox/Thj54i/bSZxmYUXwo1i40zYujsnJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hU/YAvu3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU/YAvu3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso1928489a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 Nov 2024 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730909606; x=1731514406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
        b=hU/YAvu3V3AKoCL0JQeAwrYpOeqIzwE1bk9WndnCxcDQe2rVvHAu/zO6xOHqI2MG2t
         Kfu47KcbINiUWk3IyPoxp+gZy3KrpmhAQlowXZ90SnMGJVX+KmY30CPcJ5QFWJTunkM3
         vHF+XmTFmUzmj8P6E0FS/AvQLkncgsBmdhMlhd+Nrog9r8LL2scepdGqSq2arA9MP6Te
         HTXFficdROcgyNmHsi9jxq6NwwJUKTQwOeO863YzM3HjwgbI07KjkNHQ67WVR6DJ36GT
         deJMWUfzWokpF1ZuxV+7jjJmCshTEVXeknkNnUWb0Ue4aK0S0Q8v3fiMFtYfijgpQ3UF
         iG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909606; x=1731514406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv3/rlPRDtLUJmWm0YAo7VqvOVpmHgyu+NFk1LMsekg=;
        b=WlN0vAQ9ZNr8dRznvmSAySyAIEQWWqBWklYvluCCSrqkGh7WiDL1x0eq6SzPcFESGj
         Gu97CxmYtRBY9iP5j7epr1g5XmXPg9RCRXbKV+KdVAdA9TTb68vuclh2ZC+wR4N4I41P
         aAdbDJhO0qAXMCLYYokitR+YP82F5JDrbWbQh03Oz/e4d2vnPWSP/QY0/o15qtmOf1QZ
         E02rCx8vmqZATUF0iREbix4X4my/l5qZTu6l9CHxEf/3D7gULNNhAw3ENAl91sbXbnde
         FH/pzbwpBFvV0YZ9/wbVH+ic1//RrtUsuz2W3bPmjlzM8htjKu/soZfKD5RPrGH8SY94
         DY6w==
X-Forwarded-Encrypted: i=1; AJvYcCV04vcWWsuwMVpL0b728D+YChVpCWIDN4WQ/PbufdMhSaa2pzZ5uDdoeRd/hb6ir07U4vjh13Sa9NofVHIZ2aPVMdD7w9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYs7dr6F4wvLR77qiMmb+tWk83KHg8C/YW5gqfj8MSlm5bKGcZ
	gAAmdK2txQ8a4aaNmNaaoaLSgeDLk9fRoKyV2TKpaVcDoBZqD7qljroJ1uwOx52coAl0ZK9ZPk6
	T6ykLEws65wre+f9Kz4xtWY40rJ6WVYcE0FU+
X-Google-Smtp-Source: AGHT+IG31oDzIcRRZTXFrc4mSbTzWqOQQfaIeoJMNJyfUTYdBMy9A+Bq3DpljUJqC6apMGKNF0ibhLvsqlER0Z4uNjo=
X-Received: by 2002:a05:6402:280a:b0:5ce:dc71:5928 with SMTP id
 4fb4d7f45d1cf-5cef54d1b5emr3165558a12.12.1730909605487; Wed, 06 Nov 2024
 08:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com>
In-Reply-To: <20241106155509.1706965-1-omosnace@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 17:13:14 +0100
Message-ID: <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> SELinux tracks the number of allocated xfrm_state/xfrm_policy objects
> (via the selinux_xfrm_refcount variable) as an input in deciding if peer
> labeling should be used.
>
> However, as a result of commits f35f821935d8 ("tcp: defer skb freeing
> after socket lock is released") and 68822bdf76f1 ("net: generalize skb
> freeing deferral to per-cpu lists"), freeing of a sk_buff object, which
> may hold a reference to an xfrm_state object, can be deferred for
> processing on another CPU core, so even after xfrm_state is deleted from
> the configuration by userspace, the refcount isn't decremented until the
> deferred freeing of relevant sk_buffs happens. On a system with many
> cores this can take a very long time (even minutes or more if the system
> is not very active), leading to peer labeling being enabled for much
> longer than expected.
>
> Fix this by moving the selinux_xfrm_refcount decrementing to just after
> the actual deletion of the xfrm objects rather than waiting for the
> freeing to happen. For xfrm_policy it currently doesn't seem to be
> necessary, but let's do the same there for consistency and
> future-proofing.
>
> We hit this issue on a specific aarch64 256-core system, where the
> sequence of unix_socket/test and inet_socket/tcp/test from
> selinux-testsuite [1] would quite reliably trigger this scenario, and a
> subsequent sctp/test run would then stumble because the policy for that
> test misses some rules that would make it work under peer labeling
> enabled (namely it was getting the netif::egress permission denied in
> some of the test cases).
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
>
> Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is release=
d")
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Can we explain why TCP packets sitting in TCP receive queues would
need to keep xfrm_state around ?

With thousands of TCP sockets. I would imagine that a similar issue
would be hit,
regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
to per-cpu lists")

We remove the dst from these incoming packets (see skb_dst_drop() in
tcp_data_queue() and tcp_add_backlog()),
I do not see how XFRM state could be kept ?
