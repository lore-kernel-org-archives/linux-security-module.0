Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2E3D903A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200741; cv=none; b=bI2XK2fP9Lssvq2Fa57XOc8fKUi21dEH7JJnXoLkil+4aMo/i9ukxbLtNTztUeajcoBUmTmJkxkqqFb00J5OutMAwPKiZR2WkBPc/h3/L2F5y28c/qPuhDiCdV805EwXr4Cj+JOeHJiQKUk0ddhrxwEyA8IbX5ASv/J7FcBGtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200741; c=relaxed/simple;
	bh=vIAYbL49p25ExRg+QYdlbw0Imd7iQ0xScAHgx9IcBvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIoqXhHAV8pAVIokG/3UjtQsEc2HShxeCo7kP0UDcDMRWEad2291wgDi9K2vnpjdZFhI7uOPHv9wtv14PIfP3yKZn24z3+cLApD6RQImFSi/75osm4J4Qu7apqNARvOWnmUdgmj1+kVLA3VM+PFH3SsrnfVMKncdgeTMt2m23C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUNKuB4y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUNKuB4y"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-435903c4040so4454461f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Feb 2026 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770200739; x=1770805539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5cfc484zykYZ0mPb5c+zfv5UtgQ5YWzwUO/DNgxgU4=;
        b=hUNKuB4yLA0YxtgxmXpwTDxq+j6kZEcU9LYJ2l4XzbwnKX/xbMyS29rBk+FFTo3ncc
         Z6WRACxBdoFXfvqMc2fEgH4qYxesEDF2UGjrz2G/+kH+WBiS0kutrlkGeZRPBdZ2JnJ4
         Z3Bvg7osVwUfBB4zENtNkEU8AisK6TWCvRO2PUFFDfRT7d9zBQUQlRpFLWOstS7LN6eG
         c3yUDjBhjg1aeqU/7DgW4IDPTlaUlV0TIV55ISYDJOCtifasiliPPq3PNt+6OmcuWNUG
         rug7tBR/x0T7tiBOn/yanl3olcbOs+ILUyiOnyrgGwEzFRHAz2uu5CRzrtVE/QFHCaqI
         PqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200739; x=1770805539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5cfc484zykYZ0mPb5c+zfv5UtgQ5YWzwUO/DNgxgU4=;
        b=UbwnQr1AVeP9CS11/juUlso58xYeLl+QNOkiohB7b3KycHuSlnTDZTY1j8hOEmasr8
         b7AMYI7TL2wsPNydPAA20pL68VHD1ru4dX+tUaiRWGMMIV/PWkHNm0/Vn/75TNLiSnfq
         yLjjAsqlHIQZz2FDYtA4oJ/hATQ1LigP7osTeU8RSRPp0NseKBtuAUfvuCJv5HLXpkYK
         xozXKDXXUVufLh9AlKpre11uryZjR5QugjdVOG4g+MXZxnxDRS3ra5t/mOixm8l8iEQE
         cdPMjLs2NydGMGwiO86pe8IeY/C36/iW8M9TFNl52jClBZfAM6AJqRdYzWkswJZzbnAk
         sryw==
X-Forwarded-Encrypted: i=1; AJvYcCWr9CVeZtmp6daMZHKjnWBeC+Pzry3bGCCFUm2oWlHPMs6bGsnC1SFAGN8EJ1hU4h+HyPyPWSWJU6/CpLEwv3w1TnRs3ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyltlliThWgnOdJTcnhb2cP4OhILOgxgCJfdXu7monjYFLDz6I4
	mARHpO0g7TTDzHZ0yvVTWQd/BLcAO2g3InJX9oLgrs9r8JtuX2DtH4X8cejYf9a9/A==
X-Gm-Gg: AZuq6aLcLfjvuRdhbU6St+pRu5BrqAWAz9Rr6Txsp+s6oHpqs4e6jgnZ7+6795bhO/6
	wcLm8SXVrh1PHPuJ5yGsMOrWJRzeynryVfSYccV7JJxKZL54mCj/I9hoG4CJFF+IkY7QbOkKPSo
	YfMdKHqP1UvcJdoLxpXueQcl1Eg+cU/FjJx02gyteM3WNO+0SAB4e/v02UWjoRHNCFJuO1kkKiD
	K+zrC9+q1C0QmSX9ZZOi1dY/jrkRkhd2BosKfl7XAIkh9S9HXOoR0mwug3oY3pAVXONpkZELUE+
	gO4lPeLZJDGIDCRWUF+YV+S6l5c5ZegYV665G2iFhg1JCOqgx8z0d0eFCFU17N5o4cuDfP2cHns
	SEgLxZ8mmRCP2Z08FEtjpQUNbJEFyYWHf3FUC6B0CLkncIxk1zsrQJxwaogio0SBwv/ZNP5c+JJ
	upgjYi+XOkNSvuQBmk7Cb+kOrpBlcjvNYutzdjBJH9Dw==
X-Received: by 2002:a05:6000:2211:b0:435:db95:c2ce with SMTP id ffacd0b85a97d-43618061c60mr2812656f8f.55.1770200739223;
        Wed, 04 Feb 2026 02:25:39 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:dc18:ae3c:a190:c516])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a3bbsm5405366f8f.15.2026.02.04.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:25:38 -0800 (PST)
Date: Wed, 4 Feb 2026 11:25:33 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 1/5] lsm: Add hook security_unix_find
Message-ID: <aYMenaSmBkAsFowd@google.com>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
 <20260119203457.97676-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119203457.97676-4-gnoack3000@gmail.com>

Hello!


John:

Friendly ping; as Paul said in [1], we would appreciate a look from
the AppArmor side whether this path-based LSM hook makes sense for
you.


Everyone:

In [2], we are currently discussing how the UNIX restriction feature
would work in the bigger scheme in Landlock, and the current plan is
that long-term we would like to support semantics where a UNIX
connection attempt is allowed if EITHER:

 (a) the path is allow-listed in the policy, OR
 (b) the server side we connect to is part of the same Landlock
     sandbox ("domain")


With the currently proposed hook, (a) can be checked in the
security_unix_find() hook, and (b) can be checked in the
security_hook_socket_connect() hook.  Unfortunately, it also would
mean that if the (a) check fails, we would have to store that
information on the side (struct sock LSM blob?), return 0 from (a) and
then later use that information in hook (b), so that we can check
whether maybe the second possible condition is met.

Q: The passing of information across multiple LSM hooks is slightly
more complicated than I had hoped; is this an approach that is
recommended?

Therefore, in [2], Tingmao is suggesting that we change the
security_unix_find() hook and pass the "other" struct sock instead of
the type.

There is obviously a balance between hooks that are very generic and
usable across multiple LSMs and hooks that are convenient to use for
every LSM.  

Paul:

You have previously said that you would like hooks to be generic and
ideally reflect the arguments of the same function that they are
called from [3].

Q: Would it be acceptable to change the hook arguments, if we can then
avoid passing additional data between hooks through that side-storage?
You can see Tingmao's proposal for that in [2].  TL;DR: It moves the
call to security_unix_find() just after the place where the sk
variable ("other"-side socket) is looked up and then calls the hook
with the sk as argument instead of with the type.  That way, we can do
both check (a) and (b) from above in the same hook and do not need to
store data on the side.  Is that an acceptable trade-off for the LSM
interface?

Thanks,
—Günther

[1] https://lore.kernel.org/all/CAHC9VhQZ_J9316Us0squV_f-MjYXPcex34BnJ14vEBxS9Jyjbg@mail.gmail.com/
[2] https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/
[3] https://lore.kernel.org/all/CAHC9VhQ234xihpndTs4e5ToNJ3tGCsP7AVtXuz8GajG-_jn3Ow@mail.gmail.com/
