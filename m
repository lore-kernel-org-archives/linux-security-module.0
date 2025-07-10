Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832BD2797A0
	for <linux-security-module@vger.kernel.org>; Thu, 10 Jul 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163449; cv=none; b=rCprtfcJQlquD7A9brZBzB4UhgbmoCcu/seEtbuTAhIVjRdLDan1qotx1Oqt5qB8u/xQ7/XdWwPvgmujZOG1mP4mZ9j6j53Lj/SToFsS/VhDC6Q1eQR2VqsvU4iCEnFVevoqv81lQnwTXAop03y9GT+Urn9r/oT+ov9Wy1zQZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163449; c=relaxed/simple;
	bh=45SIG5rPi31Du7cZARxkbmyB/fEEYfkUbHU85m7Yd/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6PS0iOC6EtklGFcoLVFun0tmSQW3NVgVYa9e6JrZRZRsuq2VvGxesBI3C3fjYt23Nsp7Gc+1JkwZ0ik0eScwqotBmRhhL87kdPHXob/F6UGKFBVlL6Dn+NbIctSuJhHI1FFBsXk4ZZ8uShCFOOBrdkjS5JqbfcoVkFuRV8tS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5iw7A8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5iw7A8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSCoFxZmQFbdN64FGaIzAmf+ZfaD0SDOkGG3PDCYahE=;
	b=T5iw7A8v9WU2q/I3QxzbUqBdt/StGFEQmHpcpSV+ifYnO/fskZIIs4lLFoZERwqIdTikFF
	yr3guxTktdJ+I/SbTLQ7/B2uPxesXQ+GD599ocXNR/WIFZ9mG846tUTCncKp/l/EBLcbPk
	3X14O/1Y4EjEcpzYSD/TzXC7/M3KyDA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-7I1BhRMFNSuoRRRwqyznaA-1; Thu, 10 Jul 2025 12:04:05 -0400
X-MC-Unique: 7I1BhRMFNSuoRRRwqyznaA-1
X-Mimecast-MFC-AGG-ID: 7I1BhRMFNSuoRRRwqyznaA_1752163444
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4532514dee8so9265285e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jul 2025 09:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163444; x=1752768244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSCoFxZmQFbdN64FGaIzAmf+ZfaD0SDOkGG3PDCYahE=;
        b=Q3lnokWV3Z0ZN3X18o191SgPVZGAOXfdaqvVHn1Rfa7K+2xxDBD1WX6VJOVSxYQBvp
         6RDD79XckkfJ/wRTHVdGbowUcUgN70hFZmFYDGW55fEBWNmpNu4N+euQlNe8sPH8/xyP
         u5UUZNOVPcQ0w2VAPZd+MgUepgJM/FNv+7Zv7/7+MXRqytELsD4O+2TVfq0qQ3Eb1JjL
         3LkW3fdOoOydK6Jf1vP0mYLFMNaGjWOjUj25wR7qrdWs31K/MFNwxdW9HLWmupkAdkmh
         ZZCztNbnccbSssThJKtrGM+rNszRjddl4i6fcCLWQHzhTV5Oui9cjQAJoVWwBaFDmvCI
         UctQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKYCLMRVA6wT8BYpxzdm8WmFREkLERXU7cg65UUz14QLs3htl14vRUdPUZeL7sBJoLLcRRZcVesyCPO+uxrw8kyE5UjSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6te0qEh7PHn+ZocPaVjV1xaziPW49E75b/Yv948mxDKV0FYkK
	eZWCQD0Ax6fLVh3vSZx5v+7IZAAl0bP/soEsSrLuscJTAemBR+puk9TKbVsmRiRQ8WKPBUd4Mav
	Mp/RegXzKn1y17WCooppC5Ry8LSCxINXYjOLm2yn/0T/OTag5BzE7lJLvRJFmWeEUB8ZH4xsdm3
	yDVg==
X-Gm-Gg: ASbGncs1HyL/wVE2VCGCJBip9g23+0PmLlj4Vs7TcXtrXtKzo2mZherkHc8hfmBC+yV
	MQxDBUQAzspgTIsEZr4ZnKX9fgrrkL4syPFk4OMZZyO2iOIiLIG7yjvwigRFDuwcxrrLxs1tDg7
	gJ+RkcRhGvwYwCRCP3niggnz6dtUrwN/zxumCU+SkPoSAQPbLBPyGgH0EAxZKkr0Jo1370mDjZK
	ElSfuR+Fr2lsvCSNW9/NSV3TsKeIF+LksaQdnl4H44/oI2p64bLy0lm0cigy6BhudbJDvFtL4xQ
	o0l+ObgfwO3xDC2oDdlQzbt+PWBHAqrYhBjcYIxM20q4fOCbZrvsGp1AoPklTtDm3HIPew==
X-Received: by 2002:a05:600c:8b07:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454d5404715mr63093125e9.32.1752163443508;
        Thu, 10 Jul 2025 09:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQsXap6CXeZtb932z9EyvfOv6madp5+KBeR3+NEb4XXN6+C92DcDbsyl7FzhVwLWiFi+d5w==
X-Received: by 2002:a05:600c:8b07:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454d5404715mr63092535e9.32.1752163442931;
        Thu, 10 Jul 2025 09:04:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032e9esm62029605e9.3.2025.07.10.09.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 09:04:02 -0700 (PDT)
Message-ID: <e0f9befa-d29b-4cc4-ba41-e38f398a6589@redhat.com>
Date: Thu, 10 Jul 2025 18:04:00 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
To: Kuniyuki Iwashima <kuniyu@google.com>,
 syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 paul@paul-moore.com, syzkaller-bugs@googlegroups.com
References: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
 <20250708231926.356365-1-kuniyu@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250708231926.356365-1-kuniyu@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AgIUO2NHod-NeQHsYCGryfFFhSLuYwHVtGCraOykpCQ_1752163444
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 1:17 AM, Kuniyuki Iwashima wrote:
> From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
> Date: Tue, 08 Jul 2025 15:54:02 -0700
>> Hello,
>>
>> syzbot tried to test the proposed patch but the build/boot failed:
>>
>> net/smc/af_smc.c:365:3: error: call to undeclared function 'inet_sock_destruct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>
> 
> #syz test

Please, strip down the CC list to strictly skyzaller related recipients
while sending this kind of test, as they may foul PW and the CI.

Thanks,

Paolo

