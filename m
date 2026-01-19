Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B47260A
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855606; cv=none; b=smaYK1Yw72Az5WKVR083RhTjipYCj0rFVUAm/IyLsvjItrJl80ec1CJtgPghlnnc+3EgG/LSpxvTflykyqCJ3VdfXlhLUnsBWE1HynWf/jPH1QrhLOy5e9S+9ES7NNjcWHyb5+OFVloAXOYBfF32YWGLn1bEYmKVuMCx5LWQK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855606; c=relaxed/simple;
	bh=GThpleLyVlAzIlq7NuE8Ybc0GuZ4EhZQkax0YhHOBP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eV+pXEEd2rTawcT3wY8uk5VSMjTPZpHQjJOmHzkZQwSSpZGnp48zw0C48wD10csfoRls3vLewWcYhQQvGmVAtIWRsgaDmFlephRXE9t+z4OQRFcwhKKQygDLiKX9NzfPa9G7DwwsNw6u9+GQFfHvAnQMsLkUzkAQdF5OKI6GqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VCU5/KOT; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VCU5/KOT"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6c6f89f23so5247055eec.1
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1768855604; x=1769460404; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GThpleLyVlAzIlq7NuE8Ybc0GuZ4EhZQkax0YhHOBP4=;
        b=VCU5/KOTLtwnzkNNi24bWWknbQiIG/v3iEMWWTpPeOBf6TZDdE3MJ/YSpYfEVNVtYI
         2OR1gxWqpjfW9Vm/foo3mJkIFBH3xKNTo5wfbF7O0YjFpFzZLO3IUPTyofuzCxtVn+EK
         WCjb9IR3k3kAXmrgtBd2t0tItaFwxv9DCXZB1jHKY0yy8goSVSC4o0ITCgbP1HU9XdQR
         Ab7CtDh+0DvEcneczqnmRlCDH6X9hP+UlLQ8T18Ti7Ag5vi1MT9y03qvPyxiN5wW9kWJ
         UWta2dPYOArUXAbUUxTFtutI/Vmr6+9Lx/9vIPHzeRaKc8tN+xVWyBvYQKFj0FRcRASd
         UK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855604; x=1769460404;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GThpleLyVlAzIlq7NuE8Ybc0GuZ4EhZQkax0YhHOBP4=;
        b=juueZBJu0JTCA3oBnQ+a7SKwX3+FP18TxzZMvNVphOKMOuhEf0+vzfFEda4u7+rOJJ
         F19kOhiI9EAIQyHoMlXnMm+x9ehhHxgqZa44JEUSewop1iIHL3D2dn91D4Sm8yxN+PLK
         x+p3/VH18SWr0QdCjw70VcORDvSMNd2VIDD63N4bEUNqBkXHu6EJhiDnq5eNQDTHYF8+
         W673y+y9YdtlsLQYD/k4hGUKO4dIQahy3VUqYgReuxdu9tGjd6ogbZh1/BKH5yE2YlIE
         OIa4wNVchi5361Cm4YzQIbNNXy+purfOBkHoepgidfcJWTMfxjWCnH4+xRTdJsF+9zfz
         R0xg==
X-Forwarded-Encrypted: i=1; AJvYcCWFpQDwHfTGj4bXZ5ZB19Ceq3RYeT4QGtyB/RfAGSSc/53UtQWcu8Wtxbn6IaCJG1imz/xdtIO1vuMirYASAX8egoq+jyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01VIcAT4LCgBiZBb17tcwNKA/jI8Fh2VqhrFcTM2HM63NFiZ5
	6oa8im7RHkl7ABSlPlY5QfD8ax85Q2nSuFNN3ASTbM19Dvug7Id+3xwmppdNYAMAPA==
X-Gm-Gg: AZuq6aJwD0yrZwOYNTnMlvj3x5ZSZLaiRLgywJPGCr0Koq/HvqZn4Zb5bInllmcHD5S
	jvslfPCytQWlNNXANuW+XfPsnrfkNMl8i1g/enkAKC0zJyW/6NAtxcYrh+oFYHw7DCNL0mFeWW5
	tkiK6tJ1kH8VxGVnBjZLLBkz/4dcKAvrwZ1gg+iyDtVHuSYv78g67RB8WrvDObMV9/iKTTQfr7w
	SYBv9Q9xCQTOfQphaabBs+jeD9vbqNPpFtVIw7b8eTkhkPNNiUz0ZTAcoMO4yvrUI52f52KWfpp
	kAXZzHkXi+GUzmkxwNoU7cu5hAGu3L1zF/aM/mCeLocTHWlxkWDzWwEjUscMKxcYrQ454DFDzcI
	RNp2VLcPqMHkqcIcJHMWhJaJdljsUy0Iqj5IErwuhraMrWgcWLq71tdt3p4ECAmhakLCtrDP1F7
	fUZOeVe13PoUsDLwtuZAIk0DMV9OizxvPfM2Tm8d6OKmc=
X-Received: by 2002:a05:7301:4196:b0:2b4:7c92:3f81 with SMTP id 5a478bee46e88-2b6b381df3emr8278030eec.0.1768855602827;
        Mon, 19 Jan 2026 12:46:42 -0800 (PST)
Received: from gmail.com (209-147-139-190.nat.asu.edu. [209.147.139.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14264767eec.14.2026.01.19.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:46:42 -0800 (PST)
Date: Mon, 19 Jan 2026 13:46:40 -0700
From: Will Rosenberg <whrosenb@asu.edu>
To: whrosenb@asu.edu
Cc: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: ipv4: cipso potential BUG()
Message-ID: <aW6YMA11KFzSkgfw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Previously, it was discussed that skb_cow() has a bug due to implicit
integer casting that can lead to a BUG when headroom < -NET_SKB_PAD. We
concluded that it was not worthwhile to fix the root cause and to
instead fix the symptom found in calipso. The thread for this issue can
be found here:

https://lore.kernel.org/netdev/CAHC9VhQmR8A2vz0W-VrrhYNQ2wgCYxHbAmdgmM2yTL-uh4qiOg@mail.gmail.com/

I recently reviewed the use cases of skb_cow() throughout the kernel and
found that cipso_v4_skbuff_setattr() comes very close to triggering the
same BUG. However, I concluded this was not triggerable. Even though
len_delta can become negative, leading to a negative headroom passed to
skb_cow(), we do not satisfy the condition headroom < -NET_SKB_PAD.

Nonetheless, I believe cipso is using skb_cow() dangerously, but since
the issue is not triggerable, would it still make sense to patch it?
I figured I would throw out a quick email. Please let me know and I can
make a similar patch for cipso if necessary.

--
Will Rosenberg
