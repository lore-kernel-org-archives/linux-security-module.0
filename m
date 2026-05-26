Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815332F76D
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763902; cv=none; b=S+y3kW7lU8xqrEFmAtv2OXZFv+0lDY7aae688jD34a4Ns+XskDWhjHRNZSOhYvfkXSvOujzXV3yQvEi693930oKhoGl9gBA30dpqD+FGOv0ViN4k6Pa+MwwQ8QhcvRcjHqVnmDq88JlI18+kk846ZO6xkNtNYZ4ad80RQ1AOaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763902; c=relaxed/simple;
	bh=8vhr9Wg7uUxJbvzDz90EdzM/Ds0msmcqnAGHXjP3YZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5YpuYPCxei+5D2Y1jX4i/mAN6PlM0eMY09JXmias8HhDcvKqTFMNh9OturnYj9uPtAfp5VyxbSuc7mbJMekLnsuxLSJGqZzICmeSS4oLX4b7OLxLbPqf87mVCU/2sWMxSuaYsiOe32e765n3xTVZsansO1+6TqllhVi4gZxPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxPPFb59; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxPPFb59"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1370417c01cso1148099c88.1
        for <linux-security-module@vger.kernel.org>; Mon, 25 May 2026 19:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779763900; x=1780368700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vhr9Wg7uUxJbvzDz90EdzM/Ds0msmcqnAGHXjP3YZQ=;
        b=VxPPFb59pkjKpHyN3HrbOV3n2J0o8rhTK1OP5gELEswEOcXfsBXAt7O2aP+NfbYkeP
         Ri3NP6A7ZXEAs6gPP3eah2pHoLBtpiZDScvKEoVuJ3UHPBLGxGieTT1mflX2aZwuahkv
         oqQIQ5u1bZOIBKuNJ9/b4o4+asf6KoAxwMJ/Qm+eY0Zx9Ro7wcPIiPcPvvgrsHtCQUBb
         Po4r5exJ0viYHVE+Zz6fW841iKsXCx6ABigoVV22YRifpQN2nJ1ItE2JgZPxS+T39oC3
         hSqM5Tek1gPwf19wBsh/UIJaCtrPgh7DQei33XMBPey/U59Fv9MrmIoyRrAGukfproi+
         kpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779763900; x=1780368700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vhr9Wg7uUxJbvzDz90EdzM/Ds0msmcqnAGHXjP3YZQ=;
        b=hvape2aoiqGzSqRWgyArFY+lB/hqd8+Rg4o1OIHNv8hWGnGcS7NR3trVb5BFKkuJJ0
         Xh7fMtSYEKeyvVhkPtSl2ALaS2pjdUf96yKk/XmIu0Sbu0xjcvYpBEUkX5jxg4raku2Q
         0vVHcaSsCqdZhRc1yyTQXEL2Sw8QhlTRip7BHXYKpkTbS9gEmU9isInl+OLBgmD4T0ao
         dhW2/v/xcewhAd2ffisnTtZGgOB1FsmGldAWrR3i5VJveKsx9f84qXzQmCx9upGf95Le
         hXvSOOFUQLB32uNILYOT3DYHkczy0Vjv9JuNvlRDDa3vn8nr6mkmIy0bPvDx5goGxkRR
         g/9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+eWHHB4uIao6ZbUadCbvwf4Qb0GekFTYYfoEYdRNBDGwQmxOTPactdCvxDw9ffLpWNTGI/Nkat2jpEjUcZubBra7yyh9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyEEOxuqBULC4jCCmidN2JwU6y9wvkad/oedUYNpuHg9Mr3o5
	1MONAGCW0EtRYhaZS26LsKVBKA6hNdGZNMMvEikdQv3YKC2Yh2W99xjr
X-Gm-Gg: Acq92OExsHuEJUZuOBPBDInKstyIZCm9ZBu9H6HRwymJ/ynFP9AAwJDnpQnihgHxhzD
	ptyRLc9YzGQ7ML6wN/2I3aDrCK1EURU4hsX+nbXhkjM9WkPdyxn/aunT30k95qtBUq7OiUpVnEM
	HJkzOwO8Juz6+KgEhDsTm6pqPhN0nCclrSGVt6vjilJhYiyCadbTzJ+dSlyUsmI/JWlbxMGrdgY
	5ePGMs44YkSJjyIZhuZSKdDtndrlW+gKLZkgM7bYPBTxkeGAuK0ATEVnzYIniiF/1ogc0IAsUgB
	TGtOWs9MqECnDdDuW6J1Np2RmpPzZfOGe++mu10Rj+DRwpRXle+pJ2/+yGCrgdDHU86SqKFzsFE
	cJ9nR+dV7Smz2r+tOAqMe9BGfzevGTYvg/YJnSQ/GJvwoEhEjVBcSu3cMIwvINSb1XkT9emBth0
	LKywDZltqh17YEmOeZ7U79WLPAIDbmRiW4DcTPqg==
X-Received: by 2002:a05:7301:678c:b0:2dd:6937:79cb with SMTP id 5a478bee46e88-30448f91fbdmr7196485eec.12.1779763899632;
        Mon, 25 May 2026 19:51:39 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30481ad4cd3sm5592363eec.27.2026.05.25.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:51:39 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [bug report] keys: request_key_auth payload use-after-free in keyctl_instantiate_key_common()
Date: Tue, 26 May 2026 10:50:50 +0800
Message-ID: <20260526025050.3369044-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519144403.436694-1-eeesssooo020@gmail.com>
References: <20260519144403.436694-1-eeesssooo020@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, I sent a candidate patch here:

https://lore.kernel.org/r/20260526024838.3368409-1-eeesssooo020@gmail.com

Shaomin
