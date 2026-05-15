Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BA2D97B9
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778810063; cv=none; b=sAj7XRySQB4Bv5oiGv07/Oy3Bmg3VY4V8VIiah2ek7/rjM03QH56tIfHLz1PpyF/5MPwKBGN1eLN3QNhjWMhEJfCrWmt2s/I2KrzFgeToI0gTXP3/ZgBgwRRMz+wPKS9MogPUIxRyaVZysf+CQs0k5BMOPW+bngN65WPPzqPRPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778810063; c=relaxed/simple;
	bh=pz0h4UNCAo14J0am+TiW9PpM2Ri6BTU/add2v13HRFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMe3GK2RH1i3NPj2z2XSGCCS+etTFoFdnM1QA3jcchQwS6418k0CBkkleH3ZrZOo+c0kp5EaRincxtJtX0099uIhAlyf8deFdH9lomH/kxyY44QZbbh8BVCUr9wN6UjuuOD/HMX4S+stpiIV7cPAOXVy3LpZ+QoC0DGk7H40N4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaqP2WHd; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaqP2WHd"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so14281359eec.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778810061; x=1779414861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6aIIgsz68MZV6oUmAQjwz2av5i5wsvnZFL9Y0CDyu0=;
        b=eaqP2WHdyYEroFXRCQ942OGQvNAf6YR7NN8sMcZ0Wd/7qN+jo33FS/+xYWXGwYcFUc
         KqzXr8R6n9o/dt358f9J1LJ7IFmWeb7Kbb6JoHWnykadeZjBUfNbl/1nd0S4UD3mI740
         P9JI6L3PK+hcWRy0/dCURJM4GAQrIuYgdLFKYQ+FkTQIcJJBoks3SA31uU4B0Tm6ClQT
         6o7q1ZUsrlm4OGbmM+GRapE4bNB0RgE8yRYfd/Op1qa7OvTfdrSYFsGeYtAwtZPKDrAe
         vsYe3DebYlXTbyAsrkujBtsp+iK22q3fKop6rKkXnNQ+r8TRiPhFgYSDGE+wXP43cmsP
         NkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778810061; x=1779414861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6aIIgsz68MZV6oUmAQjwz2av5i5wsvnZFL9Y0CDyu0=;
        b=Sje1/hdfEh0PeNMY/aS/4/kvYEo3tRy4ZbNYLJGaYayHWOqJaVAElpOZAj3CDmbCPt
         1uu75YOFvlymy1Sy1YjFvyvHTcmPXHOda8umvWDNpLwt3VfGntgl3tcBOdlAGWkSmbD8
         KKsJO9F48bdH7bdgglcfQBa8Tnv3F+SlFh8YXfyEsMw/SkSJgkYhf5k0vkJPka+AO6RW
         LNEZew1sim1WfYwBOMuEe4EuN3Nnj/kOSHgC+MIPUCXxcGLGbZHWULLUUpJuNmncJUjM
         pWnIY9/UMAbOUQOoOgF2KLDB88sz+0aYXixuf7S1T2uUT0IRoXOOU0YC6pQDcyLqwT2P
         dd0g==
X-Forwarded-Encrypted: i=1; AFNElJ+d1QUMhnRkvgQz4/rrwGQfC3rB4O2VcDEWj5/4GCsD/Xda7ZRQZs+Srqghrmqw9Ergi7M9NRpwDLJXUuvi1yhAAjq1eww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4bNGEuP0o/r3nM8QQbX1UNRRvzeRi8rANNTIirmok1J659UQB
	/bPhjYpEnn3tmhqgoeNYf8d6GmiAJKsNWToS4tXWUYf411fGq1eSagxQ
X-Gm-Gg: Acq92OERBuJ1zGXDzOs0YskUoztARk/UB7PoffzpfbekhmSUn+MovbUnz0btZ53yN9C
	oj71OjrX8OPpe6qNrha/rD0a4b9Dd2c3Ux3AkNDJmOZJURWvV1EvOIFk70jWrbqoBLxwsh5JuGL
	gV9edDtO4XC/kYYB2dZWZdn75s1iV+8zdabZKEv8IqC9iQR1qWtni5iwUE1BXM88gzE0e+ovyVH
	SMCTELrkOS2KmDHsT7i+pdrDoz1FNsyysLj+/sRkd3WEtL+8/zDkVUxCoHpvefhfop8LVpIgAu3
	7g153TioG6OWiWhqTmjh1QVG8lvNwVzFKCqIVUVk6OhD+9z5qgN7+5sowWsZPzM7UhviA83Ukfv
	LFllONaENhvijmT20sd7lGCU+9lBQAWVVSMexeevuIRLK6LnZNix6MGmRdLWnMhMQdBVtt5I8FE
	TsATlWNwXgniYlfPLPdBdq7QGrSzAoS8V4MA==
X-Received: by 2002:a05:7300:818b:b0:2da:45f8:1b41 with SMTP id 5a478bee46e88-30398618bdbmr1053214eec.19.1778810061432;
        Thu, 14 May 2026 18:54:21 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm5373421eec.4.2026.05.14.18.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 18:54:21 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: casey@schaufler-ca.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	lyutoon@gmail.com,
	paul@paul-moore.com,
	horms@kernel.org,
	huw@codeweavers.com,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 09:54:14 +0800
Message-ID: <20260515015414.186955-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7e165421-a688-4025-a33a-8eefbb84c4b5@schaufler-ca.com>
References: <7e165421-a688-4025-a33a-8eefbb84c4b5@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Casey,

You're right.  "SELinux/Smack peer-label consume path" was wrong
in the CALIPSO patch.  Our reasoning was that both LSMs call
netlbl_skbuff_getattr() in their socket-rcv path, but we only
actually verified the OOB read via SELinux's compat path
(selinux=1 enforcing=0, with a CALIPSO DOI installed via
netlabelctl).  We never tested with Smack and shouldn't have
included it.

v2 will say "SELinux" only on the CALIPSO patch.  The companion
CIPSO patch keeps the Smack mention since Smack does use CIPSO.

Sorry for the noise.

Qi
