Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A9352C54
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785973541; cv=none; b=lfIXYz39SkJWQ4hXm9TgZ5mSUcGwykho2jZGLB7gTKD2fWGboNY46Dg1hwrU10fmEMAYeRvV12fz0TYiHtVy7tq7iNronpzTicP3GUgt9wkQUBo7DsENkZp7x4JVJ1GexzYD6ZxpJ+Fy/3fki9unUtlmuiQWUxy+8LuhYssixcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785973541; c=relaxed/simple;
	bh=pH7dxdWyKhgYjTxrzmDhqHXUO8kKsgDrXDDIjMYz7XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvaT96ulDc2d7jBtn1KPIviZa5vAxL4aAQVOtaHNzF2rr4HakjqrhWA0wzWBKULoBLb1ciH1nsFrEiMBISSmEzK20gmh0ZqXiKUkOAqUfDWK1DbheBVKJcuWd4aZRkDc0tNs9UZHCQDWct6wcPS9f217//Ag+KyDfvaOjP9iruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HCc5+GK1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="HCc5+GK1"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A37C03F62F
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 23:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785973536;
	bh=Xd2gB0iO8ZoT4UtJBbjUQuijskG434Qw0vWALETHor8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=HCc5+GK1aNUYWRK42KDZSkULCvxUkmFSGb0im4YrQqf0cu0uLrAsjOe74p1hfyr3m
	 /ke+D9VJ9FYoChYuTtnLwN1q1eM4tdGPdN91Hx4VylG99YcQsGwaibZFqu6u1M3t90
	 KbhoPCskp2JL0Rirdu1rIRGe56sI+hDyBGreeQwx6RfDhNsyKwWCsUGnmbxH1eM1CA
	 uEE0HqhbJPIw85DTlX3TBifSy/aCRHhTOXEwvRNOviXBCGqfkBE4xaPti6tE53rVrP
	 OLzT0vZye9EuzBjITvDzzhLY00s2p++Oh2VijvhL3pRelN0GWvTVZuGSfL6sioJ5GZ
	 OuFdWccB6N060NHnTLZtUCs5foF1BnnODOeBmiEupb+KbvGaaODE1JOl63BVEMdBK8
	 C262aAKaOmRaq8/ISXPSb1bZ4751YMeRzhtk2bw1fv9E4LgGQvDuYNsNbKm0jM6ZeS
	 L8C5yqiTZ1EJU7mG3Xlm5r2dKw9YS1NsiSj+p0Q0odvs2AnF8nAXJqGZ9+K45UPhIi
	 C6ZZ0h7f6CBz3O6kM5jkNxSj2h0CYTQQyQzs3/eZx1kH2lhZzYm5TnmOdZmXmwEm/v
	 qKclvv0qBQw3S4i2BN8eaZUS5TUQiOVQxS8V2/uQHC6oJybiNtpkZKkXP3pe9Biz+A
	 f4WuTSCnQISi5hx+NLPq7f0g=
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e4ef486c7so325096b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 16:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785973535; x=1786578335;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xd2gB0iO8ZoT4UtJBbjUQuijskG434Qw0vWALETHor8=;
        b=K1A8bKFDW4zlAWRU+RpzPhgwMVTJKf7UV40yP5u/Bom+OrHdM9ouE6qnBQ4oQy9gRi
         P9x+0UErb7HVSaG60GwPo8BncrL8R+0BsUnK2g95QbvayxMf6w3zkjHHM1WH9mcSI/Ur
         ygrCTmI8KTrMBfE9ic2fSuHuxsvNyuPhmDfkl7boSK8Uwv7uiPr14RR4lBt8YrM2hC22
         azrjJpI3oQmGTof5s3tCgyR202KQS/GzPQORPjuqiDkdHnt8o8HWWnl7dvJNurwAKS35
         SgzFDrL2YW/XIbF/qhogXZGtoHK9/FOulYF6KoYoLzDPTHowFfbQ7Z2dxM4CgSrLKD/I
         w5UA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/YX+HICByPvlpp+uVlqOTfSjZ4hal7ngZylSJTTm6IxCW4PLaKo7HbMz6SyVJhNTfi149sLb7t5/Apc9xn8m2greG8cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaBcN7jqHpmlBFGWtGbBOUPdNv4oRCVNnuaQhq/6FkuJrHK1P
	RBAynN7eLcMoloj2FnHWxji49krh7ajlV+yid7Q8pTQ5gbVVBFZShyfKQUOxizDpKoeOv5LTxhh
	NS5XuWe9vgE911Z8buH9fiaSadKJDeMQUk4ACqDvnBcQaPpwOAkr0ZsgG5BBLhwySPqjCmiDriZ
	j/dzg6xARzk/uwmckA5A==
X-Gm-Gg: AR+sD13lqeNfiGDPLWyNdDhQGyCJRdOXVDJFpka/8fTtV1r+5eaFPOXHUK9MozJyfkG
	686MLcAKd+x1ogfki7tHqV+Settt82sUiAZ7uLMJ7ixDe5zQA7elvX6NggpkJMtAnid7KlGONm/
	7puNgP/a1Aynd+hWAbmb5jxjsOVZWh35LsuJ3xnx4/1lF42ODJJqWRqr26jYt5TU+et7BKZHuzi
	+oKs8cLpERuyoIfK1l9A/cMXAlwmN/6X7bz0aGQdDmBJgmxf8E/wMqtHTJpgPFpCQ/ThV0yoH/J
	93lNsMMfhat8i5laoyUSrT5c+0+tzQaP8PtUJwc5CWn1tMA21zpfuY1i0DJxpaKoFEjnki6T8lz
	sTW4Owjg/VZHsGAc=
X-Received: by 2002:a05:6a00:1c82:b0:84e:242:4bb2 with SMTP id d2e1a72fcca58-84f47d119f4mr254409b3a.4.1785973535042;
        Wed, 05 Aug 2026 16:45:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c82:b0:84e:242:4bb2 with SMTP id d2e1a72fcca58-84f47d119f4mr254365b3a.4.1785973534645;
        Wed, 05 Aug 2026 16:45:34 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84f45bc4c29sm143194b3a.52.2026.08.05.16.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 16:45:33 -0700 (PDT)
Message-ID: <075aec24-cb7b-44ea-b3d8-be913a87c958@canonical.com>
Date: Wed, 5 Aug 2026 16:45:32 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] apparmor: AF_UNIX datagram send slowdown after
 6456ccbd2ff7
To: Chengfeng Lin <lin2530632123@gmail.com>, georgia.garcia@canonical.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <CANGjgdnoz4NdqzOV9+SZaYTc+O_GkNNn5NVp+ZpHUQbp5h-QVQ@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CANGjgdnoz4NdqzOV9+SZaYTc+O_GkNNn5NVp+ZpHUQbp5h-QVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 10:33, Chengfeng Lin wrote:
> Hi John and Georgia,
> 
> I found a repeatable AF_UNIX datagram send slowdown caused by the exact source
> delta of 6456ccbd2ff7 ("apparmor: fix regression in fs based unix sockets when
> using old abi"). In a bare-metal parent/child/parent test, a standalone
> sendmmsg() workload was 15.30% slower after the change. An independent larger
> runner reproduced the slowdown with both sendmmsg() and io_uring SEND, so this
> is not specific to io_uring.
> 
> #regzbot introduced: 6456ccbd2ff7
> #regzbot title: apparmor AF_UNIX datagram send slowdown
> 
> The standalone workload uses socketpair(AF_UNIX, SOCK_DGRAM). Each sendmmsg()
> call sends 32 messages of 128 bytes. Peer draining and payload validation are
> outside the timed region. Each point had 3 warm-up rounds followed by 15
> measured rounds of 65,536 messages.
> 
> Because 6456ccbd2ff7 was part of an AppArmor series, I isolated its source
> delta on one controlled baseline:
> 
>    parent 0bfa1c2da7a8: AppArmor topic prefix through 50d56a1a366a
>    child  30cb02a874b4: parent plus only the exact two-file 6456ccbd2ff7 diff
> 
> The child tree matches the same baseline with the AppArmor prefix advanced
> through 6456ccbd2ff7. I used a fresh boot for each point:
> 
>    point       mean ns/message
>    parent A          343.382
>    child             395.831
>    parent B          343.259
> 
> The child was 15.295% slower than the parent midpoint. Dropping the first
> measured round gave 15.289%; parent drift was -0.036%, and the maximum CV was
> 0.137%. All 45 measured rows passed the payload, length, count, and empty-queue
> checks.
> 
> The machine was an Intel Core i7-12700KF system with 32 GiB RAM. The workload
> was pinned to P-core CPU 2, with governor and EPP set to performance and Turbo
> disabled. All three runs used actual preempt=none and reported
> /proc/self/attr/current as unconfined.
> 
> As a separate check, the larger original runner used matched actual
> preempt=full. Its direct sendmmsg() profile was 14.841% slower, and its
> io_uring SEND profile was 17.953% slower. I am keeping these results separate
> from the standalone percentage.
> 
> A separate v6.16.12 -> v6.17.13 perf comparison was directionally consistent.
> The children overhead reported for security_unix_may_send was 0.27% in both
> v6.16.12 controls and 6.77% at v6.17.13. The latter included the path through
> apparmor_unix_may_send(), aa_unix_peer_perm(), and unix_peer_perm(). This was
> a release-endpoint comparison rather than the exact source pair above, so I
> use it only as supporting path evidence, not as an internal decomposition of
> the 15.295% slowdown.
> 
> I understand that 6456ccbd2ff7 fixes a real old AppArmor policy ABI issue,
> so I am not suggesting a revert. Would it be possible to retain that fix while
> avoiding the added cost on this unconfined AF_UNIX datagram send path?
> 

thanks for the report, we will have to investigate and get back to you on this,
generally speaking we try to keep the mediation overhead for unconfined tasks
to a minimum using early bailout and some caching. The referenced commit does
look to be doing early bailout, so we are going to have to do some analysis, on
where exactly the overhead is coming from.

I can't promise we can get it back to what it was before but we should be able
to do better than the current regression.




> Evidence bundle:
> 
>    https://github.com/lcf0399/linux-regression-evidence/tree/7b9862c7ac2d5f9622725912d7f0df95011bcbfd/apparmor-af-unix-send-old-abi-6456cc
> 
> Thanks,
> Chengfeng

