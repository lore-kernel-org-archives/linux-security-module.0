Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F81F951
	for <linux-security-module@vger.kernel.org>; Wed, 19 Jun 2024 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765196; cv=none; b=q2tdPU27pM+jxyMohXvyjQpcwhhc1l7ArHeFvmm6SkievpeYK0k1jFT4ccqbX4N+gPMicQSFQpr9BJyVn18vFclCvd98aWrm4dFYAQ9YxMHKcfYnPiJqMs4RjnBVIj0VNehJCYBlw1vy+25+EabExZz2qWQl4MQKtsmi/3Gce78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765196; c=relaxed/simple;
	bh=iMqmSwwJKEk86rH/nKD7XdDRMQTkghhI6+HKIoELBsA=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BfeDLicUs9uCxtbY7wy0kXH3G2BrHtI7fBKBr6sOyOR4u1mGDI8yQemEon8OXqFlv71+mC2SCJPzlIWEBCXDURlOwuZwJIwIN9CSNlIqy+Iy0zQIa7wyEt389tPLt3x0PMS2/v2wXZyQ+d3cXCiii/P7lSTDiru+sToK6F+MLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CsRz3pJ3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CsRz3pJ3"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4410316ecfeso29526171cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jun 2024 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718765194; x=1719369994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOFT5Zwvyu19iw955jyfAWgJsnYFPO3amcmBRSozpvA=;
        b=CsRz3pJ3xImIhQoOfhfXxvaAbTsb5CB1oAVavUivdwMQujI3cHbTBkpZXrbjSA9APW
         H3VNpx4754fWzm7P7nTaMcb+VshSGnqhYHgd2fxDJQybidmXvKTq2ljE523Bzruvv1gE
         S3kCV+n5jMPUUZN6onwqp18ijyy1KsCtoJdHjNmOojYFN+ajsKFB9DK9IAs6E6KOcIMM
         wJOE70uvWgctcsUSVYv6R0U4Swahr7K1usroRKS2nRP3ooDvfmko9T0ff7kjo1lhNmEq
         BXgYW41ORlsWonAuW9nDkIvBCXDeemjsfjNt/Jq+i04KfwFVgHhw/UfVNmIhzIVwX3vM
         ngrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718765194; x=1719369994;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOFT5Zwvyu19iw955jyfAWgJsnYFPO3amcmBRSozpvA=;
        b=ZmA7Hx6IjTHJPEo/hnp3G2bFhVIwAV6vIP2CDt1UgVwCAFwB55VRg/wuxKRVtam8yq
         0MeYi6/GF2jS+UCha6YGOTliftbtQ2PKHEinotto2//bJynhuif9NhzEXB0xBKDnfAXn
         UuQqughum4JRb+9FzF7HBVO5yoQEvRSJJUDjEN+22EXGJ3K2hKt+mpC1xTq2Fo/7+p5n
         1MJJnmTvjyOaMjf4kb0/aoykofyHJ2uc3m6Me5b/72pnqErsYlKkwfjqyBxsV3HtGNgq
         DTCq7xDfkuhGqI3GrHh6JPr1OQMjawqjA60XZNIJQCXDbk850AJfDlyVIMvIO5tBKDGJ
         safw==
X-Forwarded-Encrypted: i=1; AJvYcCW8XJvLZlIJpfcEeTRbwCnNuNumgt0DPIpIjJ68rsmAViR077BkKWFF8CEwn77oblQJj+oewLI7D9LrUiNL0TYxsYJI5VzkmydeTMSLDv9kQWYN1jRO
X-Gm-Message-State: AOJu0Yw62gmvqT9xfEJcrXyavguSiiNfmQ5+7/E2oRs8wR++5wLSQKmL
	QBZEcRg1iH6Q/8rDv3dUT4CqsxYDTieaCVy6tph0LRBdTPnhBDhGtoMrNlEgLg==
X-Google-Smtp-Source: AGHT+IE2jwk6bvRRgostpbMkXKHwU5guw8GnpUTmXKlOvUwiGuAXFmUKOq0lMVNtnsIJnkTJzMtKhA==
X-Received: by 2002:a05:622a:85:b0:43f:9ff5:1d6d with SMTP id d75a77b69052e-444a7a5694amr18154061cf.46.1718765194291;
        Tue, 18 Jun 2024 19:46:34 -0700 (PDT)
Received: from [192.168.7.16] ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441fc0deb1dsm61102671cf.50.2024.06.18.19.46.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2024 19:46:33 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <patchwork-bot+netdevbpf@kernel.org>
Date: Tue, 18 Jun 2024 22:46:33 -0400
Message-ID: <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
References: <20240607160753.1787105-1-omosnace@redhat.com>
 <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
 <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
User-Agent: AquaMail/1.51.3 (build: 105103473)
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 14, 2024 11:08:41 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jun 14, 2024 at 3:20 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>
>> Hello:
>>
>> This series was applied to netdev/net.git (main)
>> by David S. Miller <davem@davemloft.net>:
>
> Welp, that was premature based on the testing requests in the other
> thread, but what's done is done.
>
> Ondrej, please accelerate the testing if possible as this patchset now
> in the netdev tree and it would be good to know if it need a fix or
> reverting before the next merge window.

Ondrej, can you confirm that you are currently working on testing this 
patchset as requested?

--
paul-moore.com


