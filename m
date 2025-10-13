Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4992248AF
	for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393973; cv=none; b=EUkv2whK1sbwvWZMmlsy18hm+UmUBu4tFkpYHxJJois3Hq8a7qPCWN5m3ju1GLwD1UquN0xTHVvfRbsLBEFV5hFCpB8y5g2z8NuTtWiRFAE0mrt1Dn0gqFqA50aqRP19ZzOjSz1wqRBkm3OXC+Hc/mvE+aeiFQN9mc7VwtgE4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393973; c=relaxed/simple;
	bh=ma9v2xT7M3ivg4AIw/Z8J0gsYemmtAoP3TBU7awWAzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EilRl/qN9y3BGQeR9mJ+G3bi9xMChk1tZ8/OsNgFjuGf2uu4/zy/rPLit3SEZVqFkkSGb1gZruhNzYu28mCxVg2ed1+LiRp4IPkN/V51wNXJIdtaQJzcvnnFvWv1sxWkpjTZ5NUsgyMLHKbD+xAlUv7qBw4ZEKmke3+UEsQWyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7NJ53oa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7NJ53oa"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57d97bac755so14549e87.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760393970; x=1760998770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ma9v2xT7M3ivg4AIw/Z8J0gsYemmtAoP3TBU7awWAzE=;
        b=A7NJ53oaSoGYZu2GQl27mmFOiGs/n1f11Y0cAlHR6loozIyT3bZqCTjccakbndqiiv
         9gSYS4Z5fC8xfUOHfVOSmcoTEKAPj9BIqZ5mtPlf/MiurlCpNT17ecKwrWBhyHZlmGoo
         TrazH/sgDqkkDRKCKfmpN5U3e/2MfHQVg2aGyOqFE65yzM/BKbLIdmvvdozjnrVKBdEw
         8zwpTx9rp7ylDCJ+6Rekc0lHqSjX//4klnN11iTSNQIXif5I2qjEUN34cue0LhShxqGz
         fde8pgv0lfCO7F46bGT+dHxipuzAZ1my8A+5mCLn7pnPP6HArCE3dYqd6RMVGwTS47CV
         dlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393970; x=1760998770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma9v2xT7M3ivg4AIw/Z8J0gsYemmtAoP3TBU7awWAzE=;
        b=nu9aj+iGCteH33hhktNPKZjpQiXDohmL50g94h8p5/nqjX/+i4BWTQAeGh4WNMDOh2
         /I7Qvn1BYI9YkOVbhd6fp3dQGRQda4STghJve1qNhpAw020v1l3XdBc0z9mWbBm/Ugwr
         JQYIn7UI+LjNL4lzSIb4DDDtJt7eyFd8d2e083ewmx8S7kh+Ug83HN0fMD57Qhr5+8v1
         JoiZo1/HEWD1sKlWhIjsuu/xct3EZgj1C1FHG7XRCkb/edweDFp9A6rmSq3j4ovMqP5C
         BEbLl3Ar2mbONvytebyucwnArFVGQaU5kY6bOtvMs72UGDDWhT5hoGGrZuv3bZky7qPQ
         rPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKCCKxPYetH3EatOcrf2JShRffDwarqDSoiWE5WF4QYSZEo4654tBdgccRrJB4df8Gn+sMcH71an1+cOeHLryM2PQGlLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYbDHrr1nx3ct0KT4KoNs0yDkJpD4Yx2ksawyigtE4vdcjtNf
	FXX2Es16xv7FuMvRQ2lK11gMfB1W6T3EIL352QwO+1UeTTEy5QfDEd9tINPzfLH54hnC37fc1cZ
	89rTuoVn+lbEpmL9XsvIv2m44Y5fycIZx6+uZ5r5d
X-Gm-Gg: ASbGnctG4CRvE5Qbab+RoLh/rdQ5GABhNTxw7q62TCDELQeXs2jp7iyzvofA+U/VBzI
	SyxghTsKdwW8QlYgueU24Cf8KSwyZNR5FM60hcpWemrQjYCOhJ6YIQJ3lZ/SzbklBhVo1rEMOR/
	9CsVB0p7O4NrcwB27RPU6Pe2nDRcN0NQZmj+q6bpXkfQZcpF5S/cie9210M4vHJNluP9N/RbrOe
	t2W+DIdzdnraeO0lr5QdqnfWHJkBzfFBUDh6M58tq9rwCQpUxMJXF4ofIxr
X-Google-Smtp-Source: AGHT+IH2agZQNsxWmqsBYnl3fXe55usQuh642aHhP3MFbn8LGlt2Pg0yylueB2iKG4HwW6byAodCaeXty6oXUuFgH0c=
X-Received: by 2002:a19:5203:0:b0:57b:43e0:ab17 with SMTP id
 2adb3069b0e04-5906e606842mr1391493e87.7.1760393969505; Mon, 13 Oct 2025
 15:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
 <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
 <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com> <CAHC9VhTSRkP=jNw8bLRx5em6MnX9HTywBqXGsJCBPQ9MKJym=g@mail.gmail.com>
In-Reply-To: <CAHC9VhTSRkP=jNw8bLRx5em6MnX9HTywBqXGsJCBPQ9MKJym=g@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 14 Oct 2025 09:19:11 +1100
X-Gm-Features: AS18NWA7D3oTpokkkAvP9qlsJ0ghTq_pG4HjoY0XIByf3fPOLCDdAvWcwYRjfTI
Message-ID: <CA+zpnLcUSO5Oum8iq1S_wdhkx+1xhehpTRtxBuaabQVHt-koLA@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Hugh Dickins <hughd@google.com>, 
	James Morris <jmorris@namei.org>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

>
> ... and the patch is now in selinux/dev, thanks everyone!

Great! Thanks again Paul, Stephen and Hugh for the reviews and help to
land this work.
