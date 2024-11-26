Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E717C208
	for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608113; cv=none; b=OYqHAAqVh9qh68OFqAWIU7ZYRswczbOLF31jGeB9VgRPdBH8pqrbJpybFNEeshP0bY6O1ytfuUI22c+5TuL2PMF7Uy0dK8cPzhGSNrrTK3A0HQ7cGMfjM+UVKA85aQ7sZf7m2WUBrixwNt+gVnpCnyP1ZVttgLpBT65SNDqlh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608113; c=relaxed/simple;
	bh=HClPhchoZHieJ4PXk0ZPMDdo+jy31usGVuk4vyKuzbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tS3TRWQxX0MLVb5QzFjr5YaAhBiCeiR4h90sahgm/90XeR6Mq6jEDRaHC/UzjXAK7Uj6gHyCT7Cp0qldW3FB99yLiqf+Lx/QoshVukp0N5YhYj37EO+oZiaueDuoEkT5V34PHiVlqy4rn2/Z2A/5gTF6Kuf/JWa3It4yuR3OU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I35rT2WP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I35rT2WP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732608109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAfqafsxwrqLArJ1cwO4NK3iIDoMu1BiTOyHhDVtA1I=;
	b=I35rT2WP5st8oh6fMLR4DwWfPbPiEJ8ZmVH+1gnRBSnkhiEWkpZRcP0rW2hO+nDspNI75j
	6igcNdPzFIIXt9OXYHCSAKLRj3R2gA/rDD8pLdqVl9XTxW+DBUp+M2M/xfxCA4h7IY5EXK
	EamCkQPh7LC556GxoclOR+Enrf67FUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177--RsNtY8SNz6cXZlR2Fw4Tg-1; Tue, 26 Nov 2024 03:01:47 -0500
X-MC-Unique: -RsNtY8SNz6cXZlR2Fw4Tg-1
X-Mimecast-MFC-AGG-ID: -RsNtY8SNz6cXZlR2Fw4Tg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a876d15cso67525e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 00:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608106; x=1733212906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAfqafsxwrqLArJ1cwO4NK3iIDoMu1BiTOyHhDVtA1I=;
        b=Q4oAuCc3sPiHhe5YCER7OyPlWuytT4mzJ7mwzV0IexQUenhVHNMyp7uz+RZzmZUc7h
         e04+Lv05gj0wXux2rfP9ZUDdmzrcfW9FknV2trUoPAwdeZgP8PsS7n4YxgdNfCxhsAcU
         D7VNT0LgM57FiQBsyfcfh5guUPNloFbANrogw+mMb1z4KMi5OyUE1L3OgC/M4HrcXYAi
         K8+XJX2vVLJgNh+D2JCgC62OqtSvogx5j0GcRNXHY6m8I/eB9sAHYhuFHHRWaJGwhFQp
         GeqTRGKBA/1hGn9kLEaHXQBiK6QezUjq4peZ1G0HCVKC+sqZnH3bbWI4egyi1b5BcYWi
         jnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC15cM8n5SujMZnrRTfI08xjZCH2JQf53KY4E5lFvKwdztcW4xGZpLRbh4GFqBDLnvea3sH1kdN4O89eR0GGEaMxB6Frs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06R1D9cDhHZ/CPsZ84okYuwpgYtL/1f22YRTNwoD4XtTrdsV5
	gm3LPW24py3X0UI3zWajsTk7VYQuaRNFbsKjP1ujbNEu44FiZI8oSRzFZv+6/wfj/EsOpZNFFFh
	H+XEClFkgUFAUIJvhPa3hBHvONO5RFcjWXOSyZ1pS8Z+6NNtPw1usf43Ib0nX65ThPANGy6KTKA
	==
X-Gm-Gg: ASbGnculwqsIyEDlQ+dbQD7ykHUFjfur553GGYS9BZvRyUEsTD89rUlosC5bXy0Gx4q
	ZL0vUHjU3EEb49GYNfRJPNch9eiHR/V1T1dy5XljO9dR0R9XTKkbh1dNDnHexFUbKvC30l/CydW
	3Z4qn70fYLCcRdblWIk1PMrW9xOEMNobdAllHY1UUnSNiDgySBM4B8dCJqiXLcWKSEV9VFMEPVA
	HfcLJ/5vlPhUYfjhzSo6YMjcluZZz9p8g+Oxo7v+4q2Dqdbh4ufoXEn73mVUcAs+hx0N6A2Fnzx
X-Received: by 2002:a05:600c:5253:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434a4dfa99emr15576595e9.0.1732608106706;
        Tue, 26 Nov 2024 00:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Zs+v/tKW0ky58iJbPzmLtmmXAe1KS/DiR3119yAT3rtX8xL7zpJ9OBnWLqLvIaKIGk8HBA==
X-Received: by 2002:a05:600c:5253:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434a4dfa99emr15576215e9.0.1732608106313;
        Tue, 26 Nov 2024 00:01:46 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafedbcsm12725815f8f.41.2024.11.26.00.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:01:45 -0800 (PST)
Message-ID: <afe444bb-5419-47db-8b2e-b51945dae752@redhat.com>
Date: Tue, 26 Nov 2024 09:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] ipv4: reorder capability check last
To: cgzones@googlemail.com, linux-security-module@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Serge Hallyn <serge@hallyn.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-6-cgoettsche@seltendoof.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241125104011.36552-6-cgoettsche@seltendoof.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QWZ2gy-cMY9Tj2WC8IhHGZ7-bW9wgr-i16FIkfJ6ANo_1732608107
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/24 11:39, Christian Göttsche wrote:
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  net/ipv4/tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..bd3d7a3d6655 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3406,8 +3406,8 @@ EXPORT_SYMBOL(tcp_disconnect);
>  
>  static inline bool tcp_can_repair_sock(const struct sock *sk)
>  {
> -	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
> -		(sk->sk_state != TCP_LISTEN);
> +	return (sk->sk_state != TCP_LISTEN) &&
> +	       sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
>  }
>  
>  static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)

The code change IMHO makes sense, but the commit message looks quite
unrelated to this specific change, please re-word it describing this
change helps capability validation.

Additionally it looks the net patches don't depend on other patches in
this series, so it would simplify the merging if you would resubmit them
separately targeting the net-next tree explicitly (add 'net-next' in the
subj prefix).

Note that the net-next tree is currently closed for the merge window, it
will reopen around ~2 Dec.

Please have a look at:

https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/maintainer-netdev.rst

for more details.

Thanks,

Paolo

