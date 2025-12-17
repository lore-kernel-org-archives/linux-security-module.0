Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9562264CD
	for <linux-security-module@vger.kernel.org>; Wed, 17 Dec 2025 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765938475; cv=none; b=QS6ev99UXBqNFy8SR1zJ68ocmKyzbvAiWD/bKR+DQGgO6ipOHr13FR0Tkno6nIueu9WaU16bj/xwABpTJqA4deIC/j/V8zr3xWkaip9fdfVPnONptTud4spGm1xKuSzVhVvZxyserr4yplNgnITinvaOUqWpMCWc3n29GcQjf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765938475; c=relaxed/simple;
	bh=aT3YEEU97Bca6ddJJYsZgHuzzQOQrZGCUK09PTv3how=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFbmPxE6LjOLSbsOJXgJofqcNTZO+gRfVpxNVD7Wwx2xvNPKLo0pqEetojcFYk0+b0A4sRu25oO2gfFTp1HHDTr+3hlbvYPjj+L9i2c5bZHe4ihmMH5pteX18WXU6HnxI7qjtiRXe9i0i3iz9kKl+7tt0jxgq3nwV7NcTzWeh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YEU9wA6q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YEU9wA6q"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so5618608a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Dec 2025 18:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765938471; x=1766543271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ8qqeFM12JCYkW9VCcf6IgSGSHtttRCm9XL5An2AGc=;
        b=YEU9wA6q3UHs061zxeDv/0PCeE8z1lv/U2rHGLDRySmvTwqrq5pvfcd84E1o9Lq7Px
         Dx/t1x3k85lgR3FSWBiR/nczfrh+boFW6jzkW3kMtXRyo7SXKla6zK9H/0rigMGn15Wi
         NoTC8r7cEjUIzTtunhwxNSZSqdAjufMjt+7byh7EDanH0KwisDmbUc9tq+Wc04/dZo6t
         /GaxASZALURg9K0MQhIC6ezOOfnT5HsFPLv8VC7wWxWRBV7vrHPDY+ObN0xcG85jU1zw
         HpVejI9LIeCsY399Rci03yOFKDxJijIPfB2thOM5qsal4zDkqvCjh7lJ87obgA9OMA+G
         InCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765938471; x=1766543271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJ8qqeFM12JCYkW9VCcf6IgSGSHtttRCm9XL5An2AGc=;
        b=dBucYCsCxHQKzY5+iX9yNpWpJ1moU229N+70qcCANmK/FWoeM5bOStXSvNC6y4azYW
         xQ3hMcyz1Wz9P34bIfGka5Ule9keXo1L2S1S5G50KC1od0JqCg5yK3hzZux8PxZ3zH3u
         cmLoZUgaahS92UWQRZ8F5WSgXSKT5TzZspHhmXUoPaOT5xA5uwVKtz+MGpqjHh6JZxPp
         3aPAFtK0yKoATm2efZBhgqNSIkkMY1Fi4HdNPHkVpLue7nmhIcZufkJUlwmUn20UVWyY
         ExdfCjGpVrv47qq0nv0RwSDCek6VunRBBH5AEEZJEpXdtrweBwxNCUJ0y4YT3s0lQnDT
         Oa7A==
X-Forwarded-Encrypted: i=1; AJvYcCX+X/xKDE2CU9CdAKLKjHOcdN4GU3HRMF++ceSmE8DATo06GdAENvcmmdZs1jkvP+s/p7ZLSAuBAXgntNcTcXa6gOIG2eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFG0iUNyZ11reCx4BdAPStEhYqxX+TGYDQSAX9+I0wXG9ZcvH
	pawHoaa5jIDQFQh556Ln3+lJRfwEAhbljEAFezNbyONf2pWlQEE3nXwZjvKUg4mDtKofJZxs7qW
	4tg+2SnS40GEl5IoYDKwlmg2Gruh7u6VNP2Hpu1l4
X-Gm-Gg: AY/fxX7EYfxuUaenW5lJX/o4/VY/lYTCyT1kydfFFm4xSKsgj33nPqn2goQ64Il8xOZ
	4gCTb8d2F+0Afc9h1edg4u8vaTnkK+HFBEw7IQ2B4mIhLuSRB7GkRV0zfHvQsHU25rLKpvuw7ay
	GCEbKrH7CCet6biTc3NoRe/0GTzpoudeZOMars1uiVXevjymBAEv6Ugl2tejFtIDagK2EXuip4m
	b/RHmFhRk9iLnLmDQrYfiK/qTYPll1WkVgM6K01DK4av8FWiMa+cKqpAODnWfFqFujcK3c=
X-Google-Smtp-Source: AGHT+IGa5bCdXy2eDFRMiIp85gX1ITVsGZfXkqJXB8XEHuy6HqNMrqN7lOYrjH4FnMPCpV8UuGH4zqOEanO4V2Ai+Y0=
X-Received: by 2002:a17:90b:3911:b0:339:d03e:2a11 with SMTP id
 98e67ed59e1d1-34abd6e022bmr15611483a91.14.1765938470689; Tue, 16 Dec 2025
 18:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHtS32-Zh3knxSdR=DUqQH4rX4QU8ewgu+KHGq6Af3qs9S0FAg@mail.gmail.com>
In-Reply-To: <CAHtS32-Zh3knxSdR=DUqQH4rX4QU8ewgu+KHGq6Af3qs9S0FAg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Dec 2025 21:27:39 -0500
X-Gm-Features: AQt7F2qprIYE6-HyVMTHleBbF-N1q77Ba2A-srAgPQlDo2gt1smd-xuGCyFzwz0
Message-ID: <CAHC9VhQ4=ALurNy_nBdqmdQ1dguupPnJ6KYAnU7B2UWhp9ydbA@mail.gmail.com>
Subject: Re: [RFC 00/11] Reintroduce Hornet LSM
To: ryan foster <foster.ryan.r@gmail.com>
Cc: bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	akpm@linux-foundation.org, bpf@vger.kernel.org, corbet@lwn.net, 
	dhowells@redhat.com, gnoack@google.com, jmorris@namei.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux@treblig.org, mic@digikod.net, 
	serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 12:26=E2=80=AFPM ryan foster <foster.ryan.r@gmail.c=
om> wrote:
>
> Hi all,
>
> I want to confirm I understand the current semantics, and specific issues=
 this series is addressing.

I don't want to speak for Blaise (or James for that matter), but my
understanding is that Hornet is focused on ensuring BPF program
integrity at load time; similar to KP's signature scheme which has
recently found its way into Linus tree.  Where KP's and Blaise's
scheme differ is in how they perform the integrity checks.

--=20
paul-moore.com
