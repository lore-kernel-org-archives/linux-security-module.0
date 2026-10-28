Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166945;
	b=MIZa/UxZA24dTqr7CHMlZ3a27upux1UVeP1ZRTecN32Iyei9ZNz29V2hbPyaaMpPMvFO
	 cifoBH5xiTcrkY3UZSB6QeLIMsCHeieYx5O0SSAZpd05UaLRTlTvQuX+ByFuia6HX5yHq
	 25QfIrSmhjkATpa/IaQTUe3AvoHo/gp5xjCItiQ5IpbrciV6QMCfGGp4BAeUski80u53L
	 J8KNbT2i32N1tOAjOe4qNumq00GsdFHsAr47hX7qyK3hWRfkJj4ccmVk2IDuTI5Dr/Nwm
	 rMR1e7lohUGSvkFaOiIqvU9wu19gbVEupCRCQdmVGZCyBu808dsmL1VDlxSaz6znsww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=hLkqAi8ctPqSRIwXUevfGPv3vaKrwbjwbnl9pr4s97k=;
	b=LDh+7UcesWaw7SPcHrQ0cAmebNk4EuOH3lOQcrt4TvzxdQ/QmtOnzlDgi6yER8fvMPY7
	 nCKqBJdZM+b9CUgsU+fvdVgKQXf14B4IAozeTUVdko8mGXvvnPASlA5QiDjT8DsTjeja2
	 ma9zM6zG3RpSPgGjSoPbY9H2EayFnGSWhpfjpEwl1rd+5QmHg2AUBHS0hQvWM6NlP+fkq
	 S3R4Y616jNSYmJ8Ez9QD7WwL+VNs0EjAS4YCJrmqj6PuJ7JwLoh7lpx9SUGmSb3j0dyEb
	 xQugsfasJnOhniKRiNuQg8Ig7fJrwHLGF5gUVyysEPht9qU/SHmSfxrVRJ88abJOFJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=S1bmZhe5;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE849606A31E
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 05:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE849606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=S1bmZhe5
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9d7791b00so3719775ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 22:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793166944; x=1793771744; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hLkqAi8ctPqSRIwXUevfGPv3vaKrwbjwbnl9pr4s97k=;
        b=S1bmZhe5omygstKNn+fR4XNnXR8jlOAug6FHViW62htHZqlaaV3C+husILnE2vlUDF
         qUlYJF3FxNHUTl83dYgzukZI/bHzvwRlNtWH7gR8fWpMpq/83wx9L/j3lJilHpU9YOHo
         cfLpDdCxwOCvGatK4hqkL/OtX/o2+WygsNxRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166944; x=1793771744;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLkqAi8ctPqSRIwXUevfGPv3vaKrwbjwbnl9pr4s97k=;
        b=hDm6LT2vNq77DDSKBYKDY42N+pXtJyY2pdLpZhoL0pa3cVyOYdPL0fVy05L0PX6s6r
         3ywugXbYQ7CLnQc2UdoBby5PMXScGZ3Ppj78hjIH9wwIUREFU2dPdXq42ZGLDhSYFRae
         5e3sAA9C8Alh0HPGPxXaMOH8DExcCTG+sH2yMaVnWVqpgWGZmDMZXnwJOSqsS0ZSx91J
         hadPzp1sMKIaJaZ5OHzVfMpu8Nm4hcaIYOGTWOIstgibI7hT/XL50ly/tXNQrTuw02NG
         +0ibHeZQ3eOo1+utBfgScKOqJ6lM/agtZCek5UXrM1Ta6UNDS6fXh1Q9O8B+sYMgwad2
         ewzQ==
X-Forwarded-Encrypted: i=1; AKwUvByWi/WWu6nYc+JjfmAID1PZgRXBK84WnkjK2ukoZchQur2mAeuewC/ySPwruP9cT1Tkebi450cP053A6oD0K4OadZCR284=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSaSDOdc6siwJLr0GLeCo11Yt4gAUGNNYlJ22r0l5kKqcTbs7B
	rIFu251/Ed9LXi9TEuN9a2K1n8V7eJ3ZFDYCqiGvOlghiSGCC35mfQGaWVHqTllaq/0=
X-Gm-Gg: AYBFou1kauWT90e1xdiZY0WcqfYVg2zp5QhHwnQWEbUyf8ESQccBupMumcDhJw5Ok86
	Uoto973nFQgDVbjiqrwhxUlSTwcchxqI8D5ARo4OQROkXkEBdsq+insdVOOTy/29OUk7/XeRc3p
	141u3Z5e8zk27X2cwCB1NdiOmLZDUZe3M/eTO9JRd9BFlrlKymZZmurrU0DFxsHJlzHGlWXrLg5
	/AU0p7rnkbDCSR8szhwac/9UUH/6iOwz1BXu8/5GVMvxIdOG+wioUcrCgCBx7uJyTJiEsyvxujh
	iIXEg58BPD13a0Hq+/R7OsG33jR9WGDnKiXsy+MQqp7hHBzz5ajqNWpPwkYaHQW/RpaQ3EH/oTR
	xc+foeIAOCk9Djbb6ozfpo9TSq8hOqHmhlwguUi2HUyS9mfdAmnucU4z0g4twdFbWg9Usiow1/t
	c+heaBP97I7Te5z+BfT6coIiTf2hKRegxq1P41M3z0DqktRnfN+T2CMbenZfbnrR37mtgS7nyxf
	GrAVwWhLYzWdjkNRXE/OBT2RyViw02nEVVCFVoI/XC1RJjKo2uwWFjRspqnpZtyr0ikzV7GJ5dS
	fl9u76drxmIZ6e6NR6oTBwY4xLAm0idhXJLUg56Si8pjgn9MaHTjrECY7BTvD/f61osthe5kru1
	RilZJxlIMIPmpJM9GrYzNxD69e7jEaD93k/CrcRGEISHgNGkrGE5H8aIu5GgyuXweMeLkO9hC
X-Received: by 2002:a17:90b:4c47:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3ae5811b551mr920591a91.33.1793166944108;
        Tue, 27 Oct 2026 22:55:44 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9019a4sm1368356a91.1.2026.10.27.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:55:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:55:40 +0800
From: Chris Down <chris@chrisdown.name>
To: Jeff Xu <jeffxu@google.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auGOXLB1XZFWcTfX@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
 <auCxjbvY3qPv1sV6@gremlin>
 <auDTMb6WMFUpxeZy@chrisdown.name>
 <auDTptDQsB4xBcz7@gremlin>
 <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
 <auGNkhSHpBRd2U_5@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <auGNkhSHpBRd2U_5@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Chris Down writes:
>- run_vmtests runs with -T expect_sealed when CONFIG_MSEAL_SYSTEM_MAPPINGS=y

Er, the other way around. I meant vm_runtests passes -T expect_sealed _unless_ 
CONFIG_MSEAL_SYSTEM_MAPPINGS=y.
