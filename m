Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCA1F2C45
	for <linux-security-module@vger.kernel.org>; Thu, 30 Oct 2025 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784522; cv=none; b=PQY/HHZnArO38vHNZL5/WyKtD3xKgRQT4L8vtOaOPiT0Ak3dYSHNH5ohsIbC+q//CtuUlOoVNEEeiA/2E1Jobkzrg58L/bz0fdeeVevfK6wLwv2VOpbNPRsHmJQ+yxSAw75oZqbmtaWZRe2sJLKFfNTZSMCYpnZ4w23SQmfMJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784522; c=relaxed/simple;
	bh=IUoyLvpsMYGmhZ1JkQITddfw7O2lI9KoOiDoJhY8Eys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HRzOStyMUiH31lUUtbfZQ8wZDH5plAjBbclqh12h0pjiCNSIhRPEOht/AYS2U2f+5aI7jfYEpTgAUSo5Tizj+WkeHo/oWBFneeJ3S4euJ6N1YHsudvpWLqnk5n/rBl7qn07IZdnI/KIT6zfikSJp40WiKayItiqfdikKpgwzCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkR1bJ1R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkR1bJ1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761784519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ToFbPMVt0+7kTO9K5L5BO7bcOr/qF+9yBlHuBVL7TkI=;
	b=FkR1bJ1Rb5qv1GDKn10G7f0dymgj/sYQGkq2PLAAcDFTqqNYcdZ1XP4Lhn7xUlW+GxSyLb
	ktB2bFGIT0hr95Jx078PHq/lAruIEk/JcxzvriDcRbUjAYeTyiYS6WqoEjRWbbfsOcfwHQ
	JdrVoGSwNg/LK6NngCvbolipbBwUSgk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-7MK7Lz0cM3K1xokAyhFEqw-1; Wed, 29 Oct 2025 20:35:17 -0400
X-MC-Unique: 7MK7Lz0cM3K1xokAyhFEqw-1
X-Mimecast-MFC-AGG-ID: 7MK7Lz0cM3K1xokAyhFEqw_1761784517
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a26c0c057eso424001b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 29 Oct 2025 17:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784517; x=1762389317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToFbPMVt0+7kTO9K5L5BO7bcOr/qF+9yBlHuBVL7TkI=;
        b=WTvRPyfGckzxU3mK97HBMC3vTFnsGfFvifK7NcpjFhK+FPaJZPJqhPwIdsvwMxWj5u
         z9G4TrV5tlTzkCra8vi0m2M+Lo080WrICvbFwY3SohEhg8KJx/SmYtb1cnhbSFHU9Di3
         9OCr3iWKWm6E3BqPVkYWzGkc8FxqwQz0wOr5N8C/Vs5XJ0dAbUfpPp5fP/MnD5pw6lRS
         QXDLFmvanebl1fidSMd1eM7japeb1wXWzWmDJl928tQVaidY+a56LPUbfxNmTR+grkoM
         7QgC7KVut7V8Mm+V+/hTwhmt5m/g4pb2KOrpixzk52F21SjQJRs9sui2Nozz+Qr/NKAC
         wVkw==
X-Forwarded-Encrypted: i=1; AJvYcCV04+JJte4ZzTrWSEx2ihcv8eQQJSsinqdSTvWc1ZBisxTFKdw6dXMIUxOb6zgWriYJyi2slNO9d5bosQ5IXBtBVvUW2WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwclrSoyyKV9fdDPHBs57ctllPNpr2IKrCDVXeEptRF+kURtM3
	8Mkd765VU8RrrX/Q24zbGQ0nokvlSDzT3wlCviXaYjFjW29UUghu3VBPalr5QhWDHPOmVXpAmPG
	UkveqRK+R6pQC2eU9p3/GIFH1svPwY0z1r2WuTna3xizRiCdgeG/30a5LPOI/4sJ7RZ/syIHdgV
	OTBw==
X-Gm-Gg: ASbGncsFWOPa26g7xMlNqxxwOSceZcliFSUUPY8DHzWgu1on1Anh0I0Bxkd5NKTW6r/
	nnUdJoA0lDe6mwi30pmpJosg7dXhMruJbxMX+YQu/mVPexetD3/mbVdGJj5utNLhU7LsDlLULZk
	SmJ2UZXYVKvIOVI3T9ZINQiWfPk2kmsCG67obX+5q4gb2wdK9J3N9VzBctCQiNaOMiVtaD0Rr1M
	Bk1xpY0f5j6ueXWhnH1NFEWWigquVbp5vYHKS8zuRxMRzqYZ6mj8LrAQfgjgSMoqmXwRBw38cHl
	emChRq40bwfEAZI5E6FYnbV8+BcdhBSPvXRnGdJNSVAgAa9oQYuaOD/P2mDh9ZHebg==
X-Received: by 2002:a05:6a21:3386:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-3465481151dmr5293643637.44.1761784516649;
        Wed, 29 Oct 2025 17:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFio5AWXbLCe0GCxiEDNyLa9vmvddUkVGViUSSGWOijdJL70pEBNvbe1p8oDpeQ5+ERrHT/7w==
X-Received: by 2002:a05:6a21:3386:b0:334:a15f:8d2d with SMTP id adf61e73a8af0-3465481151dmr5293612637.44.1761784516148;
        Wed, 29 Oct 2025 17:35:16 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm16488075b3a.38.2025.10.29.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:35:15 -0700 (PDT)
Date: Thu, 30 Oct 2025 08:33:33 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <h6jeu3yf33p2ngcvaczjrghm3hunkjf5gq462njghryyc2qeph@jdug44kw6tpb>
References: <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <1987088bb29971883d2b5c06a31c8114c729422c.camel@huaweicloud.com>
 <497d1608572eec7d3d498967f0bae7d45023635b.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <497d1608572eec7d3d498967f0bae7d45023635b.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5K8Jj2xyepJcRjmloSX3u5nG49SA3ARpFCbll_3X4Kk_1761784517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 20, 2025 at 09:57:19AM -0400, Mimi Zohar wrote:
>On Mon, 2025-10-20 at 14:45 +0200, Roberto Sassu wrote:
>> On Mon, 2025-10-20 at 08:21 -0400, Mimi Zohar wrote:
[...]
>> >
>> > >
>> > > Another thought is to make CPIO support xattr. Today I realize that
>> > > ima_policy=secure_boot can also cause failure of loading kdump kernel.
>> > > So the issue this patch tries to resolves has much less impact than I
>> > > thought. Maybe we can wait until CPIO xattr support is ready? I'll help
>> > > review and test Roberto's patches if this is the best way forward.
>> >
>> > I'm not sure of the status of the CPIO patch set.  Roberto?
>>
>> I haven't had time to look at it recently. I can take the openEuler
>> version, address the remaining comments and repost.
>
>Thank you!

+1, I'm looking forward to the reposted patch set!


-- 
Best regards,
Coiby

