Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01339023D
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610754; cv=none; b=jWAtuRcB5JdtKtleVD+jbza0v5us+Z8MNl19XtVVWo0nId17Eb6NPoL7Sa2hiL7gVZhM2N4djYrQbBv+1Yro3RZgudBPv5Nwfl327hPkqOhUwp9JPHmY3Mz/9N9iR9ovwbjgtEUk4Rl8RgW5E9Zb4sHTr594vNnnjDt3WsfVocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610754; c=relaxed/simple;
	bh=EcLDMvBjjbTD/cKF5y1BkO7ob6e6OBIu3jcREkFicZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+cXLbap6rZc8eKYPHwlzeekGPx66dlpZ709VAV86Q9yOGfjwZaZVhbtQqE3IA6+a0+gGVGF16BxT6N2AdYDaeSlkCh73RONyk+Cp3RqOvt5VAvKgn1PGmQC5/+s8Kmy2w6aGaWq6999wybryWfkbCq8fL5JkM0kJaasQPcN4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNnTPrmD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNnTPrmD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso235871f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772610748; x=1773215548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaji8MiSwOMoEhpHJ9TfGIIdRoqWhERpR7BNI+IYVW8=;
        b=FNnTPrmDvPeJsl7KgOkZBHjigGbAfeWKOyNkXPj/ux+4SYrQn4MTPSHMrouYmSgqIa
         YuFUNmIKbBGjpl8HC4GdNNkeY3ChhyRlnRpH4V0ri52oDep3hlSTOoliQedMT0Q80eJ/
         u74NOjzU2/l3poPflXJgxfZbtt5Jd1H9iW1nzjA/GbFpj7Don+kWtej1SpQqfk5AYi09
         Eb9dLae/TK4h5q3fJZKI1g95C/udZxLAoLe0Upb2/LygfKo5T5+smDUdi37tfQZDsldY
         1va/Z7NSVaRop+Elt1Nxco58Kr4VF80cTnrvUk2M/x5YabCEcP0q7FV2F+ubPjbxO5dH
         6ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610748; x=1773215548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaji8MiSwOMoEhpHJ9TfGIIdRoqWhERpR7BNI+IYVW8=;
        b=bC8k4iGko+CM4OGSY8eKKEwZAFYBr5j1sbOVwHyy0S5bxL7bllrI2c6pz5ctfMZfVb
         U6temM2349q7746Y4Akbva3m33sd3wUPFxk/KaS7i4T5GBBjeBTFIbF/+N/m9vzFu95B
         Q9+XCm40RGEpEm8NQi8vxMnSRb/RnYxgh3Hc7LgHNJxzbmgI/QcmUcGNXqyxJLBYjsL0
         Vg3DS2ReX55CQrUmxbiGxV8mq1tFuxb27lZAnmOdyrDbw+txbv+dKdjgrJ20edKfg9R0
         THfkLmyENORV5HvD18IvP3hg3QWShDDG7nOagPPCgxo8LW2CiertGl7gMhdOSvKxQxkI
         Wdxg==
X-Forwarded-Encrypted: i=1; AJvYcCU5uzJcLJkdY+YELU9r7SAGcfTn22LzYjgBsZyQxslDBY3cLTIOyQQlCTtWxfsg2pF9zSMJr9sqF9UD6Xhp/fFG//6AiuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBi+zSgGqUooZg1Ml3oDbBMXfqUP0ziKniHo2k7U70G7bZl42G
	snQ35jzb31eBWjBklcVQ3IBRihFUhgX0OJ7gE2DBJI5FfFDmAPnt13KczYRg9eQA4aA=
X-Gm-Gg: ATEYQzwoMw1XGN+zeiLpzdkqpF1tVjnquEVMxGxgnH7UR+krlPNQHSi6OLwKWvVe6gN
	rNMakCZUg5AdOyw/5PcOWlYlVm+XowLYZdPFyLqif5Zk/8Ee0Ys1FEvNisnKZ0vDLsS6OjvZf2Z
	UHZ06qOjm0q87rDvEuAjDk/amiyJakxOvX7ETeKysX4IpWmKx7860VWfj7vOZ+5GSeXxWBQ3foR
	zeEdWZDAbCrQfjpfQWmluwJGy56AKGsTBCwv/NYRcN4ADsNTXp4lLcu3Si7X/RKjNP2iuEX46zn
	dwcMHUknKH8tTl1ECuTcv8oXYptjcYcswYoGB7ykUIVMQUmZULgQw+mO8MMi3bsGdnPHOoRGTJe
	2zRB070Qe6UypAl4aHvLj+T3gBF3x5zQeCyUdaCSwTU53j5WozUQZJr6DmGTQQSWsbIDcbuKd7G
	eQNeeIQKWk6jjpvkHBRJsbXYQEYoX5PJXbSyVQi5M2EQppgWYm6mjzOABHDnxjwVSFFJiZF/dic
	kiqRnFrY57fyI/H/axYrS30CPwaPMOUGQ7oj3u4uT7uvmcbvv8rrdjnsrQP+GHZAqLHk6RcPtxB
	A+pP
X-Received: by 2002:a05:6000:4301:b0:439:b886:20d3 with SMTP id ffacd0b85a97d-439c7f7e5b7mr2101563f8f.15.1772610748337;
        Tue, 03 Mar 2026 23:52:28 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm42229774f8f.3.2026.03.03.23.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:52:27 -0800 (PST)
Message-ID: <97a56169-b71c-4ad0-8992-c6e2d381ff02@suse.com>
Date: Wed, 4 Mar 2026 08:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] modules: Move 'struct module_signature' to UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260302-module-signature-uapi-v1-0-207d955e0d69@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/2/26 1:42 PM, Thomas Weißschuh wrote:
> This structure definition is used outside the kernel proper.
> For example in kmod and the kernel build environment.
> 
> To allow reuse, move it to a new UAPI header.
> 
> While it is not a true UAPI, it is a common practice to have
> non-UAPI interface definitions in the kernel's UAPI headers.
> 
> This came up as part of my CONFIG_MODULE_HASHES series [0].
> But it is useful on its own and so we get it out of the way.
> 
> [0] https://lore.kernel.org/lkml/aZ3OfJJSJgfOb0rJ@levanger/
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

This looks reasonable from my side and reduces code duplication. With
the removal of MODULE_SIGNATURE_TYPE_MERKLE in patch 6, as reported by
the AI, the changes seem ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
