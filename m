Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119065;
	b=3HSBWRtaxNrCKjwgyQrMGGTRiHGr38m3lCf/ocpFi+A0gVb62y8Nb5DHdViDFdTi+3al
	 jTpJHLmkyAVXFRK7zVdVm+i8WLTcSWoCyqo1MRPDJM/nAy0YXCRlbkzFnSz9hy3fB6fmk
	 f2RCK+mKQkQmwwXzJhqDlcANHdKl+ar+bap01sn6mlaWtiA37wmlzEVpQgRLI0PjabAtz
	 vfMIffE064+5iJ2xbRjSX2IfoJcq2gimL7+7ug0OlEGeRGiCRGsPdsphdJu+ZMynNqwzO
	 St3wB8lxrXIEN2tmGwnsFfew4P+V7xT90XRJIO3vPdCCGWhxP1OXU+r99s2r3jwfOYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=DZ6MRBphpDaEsaEkwyVS8b0WlKh787/wwfa+ssjtUBM=;
	b=TRQ63H14dyff6gSNkv7gcOE5iqPDA3iFgbYfVvQkjVium9QVqdw4CogduqjpX8SvfPp7
	 g1HCPMpocumHEmAXMPzwRBcsw6/HjnYaYPUIBoyEIgYPh9oM+D3HOG875Ooe8Ru/xr/P4
	 c7BCxENGzqP6j3W3drZogpj86g9l+0Z00414ZNZRUfhAGOh4y2y4n8cl8GgHeAgfiLihx
	 MXvmCM5ia+jBTQZ7qs+fBwdg0EAYFyGZNBX1y2n9jamUjIM1IjelgLVZpUwhrzgdRU75A
	 Bl55I1d8uSOsMeNttOQPbXwWxJ3glmRHTz63eyRgy6t8xvWyfGtIqJX8w/IQAXyUECg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=jp0oF4Ys;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44385606A321
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 16:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44385606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=jp0oF4Ys
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso73670a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793119065; x=1793723865; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DZ6MRBphpDaEsaEkwyVS8b0WlKh787/wwfa+ssjtUBM=;
        b=jp0oF4Ys897XRGpeW6RKR/fHWs0900z2eISbO0/7YoTTJ1fFarjXa0F+Tp0M1QIRaV
         1g8zSJLLa2lNBbVlsUVyLp3zNvrpzucfIl+D14Xq31PvhpEZ+hIqMTwTXDul/RmgikfL
         CjByDjQ1ylYmmxEchddCELFvL65xpS7fbntKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119065; x=1793723865;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZ6MRBphpDaEsaEkwyVS8b0WlKh787/wwfa+ssjtUBM=;
        b=MOlwM4jmILYe1jYTDnh9et6AqpRUfB1f8A5XxoNDjeX01SYAKrTCZv3s9jhRYIVEBY
         VZl8/svyOAzY2mwwhWJDqu1wYl1f62gnz7/YDgzCgGXrDPBG3O5oUwCJxCGINEZOgRrQ
         YsAnscOWf7uWdJeBTbx/HUSzMcbip+JIG+wFYYiMuybkE7as5SsD0Cf2YJFFCn8XRDKR
         Wmdc8ym3TPJdmTZbZv7+NOjlRA1rlagNDy1rSxDEUKdrwOFS/YrUME6R2EYQ8GyKm4Zb
         BNVGiJ+B9vZ0OOHjH2BhnAsYbX7Idvd3EWIQw6fIbxlloQAuAJpB10dUo/Ab+toZkSs2
         sXbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFLWCQiyiQ02KUYCdXnu+jG1A8pUFec12BBnEXJ3hmrDgVo4RL4EXeB5hFBscTts0EW9kT2lWZ2W/xYLQBhawr2w0451Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrIigrUyRGE5cyZ+mk76DS0HY901tCK4q7cUaUiw5GM++UhmdB
	lm0wXqYVjuwvfuRvt8bO+ibd5H7hwedyn8EvHxuBp2R0KI7hhqOxV/VsIrxbDpwjFfQ=
X-Gm-Gg: AYBFou1yiWX1rXy7Gp4BR99l9rEYjDU8A2WXlnWrHsqENgh0986lvif0JW4Bf9RB4EI
	S+2HWxcL8D/i9WkorJAF1oNjv1R6maAbhTr8Jpalkx5F0tmrnyB0X75c23eod9e5Gm1vgcKGYA9
	a9RuRes8NWLy5C1tbs5tK/fJFUnqsl+guGXW02swoB53RnLP/bHykbRJoFmzOqw49SJnvdgHGB3
	/Gqub+sya28M9Snzbo9ljKGH1AHT99AnuK7CEZhm9p/m1+R0T0GH1WCAn2DM/2g+Us76mmqy0hh
	1ucpn6YidU2TT0/p6b2RVqcvgk68UTjfsayl2NZsjxj0RPjmD3eKQ00JSJzQOu8wnSSlvHhUxe/
	S15jRDdmlsLQeb/w88X/UEsFhxM6oC5LqKQhsh/JdvOByUi+GGU8Yc1LnTUHnBQGRKgypMFZnIT
	kzmB3LDp7jnvHLXgL1S18QOt0MlIy6VPS0BivxNwQrB10TKH37GpM3yYhkxdIekGGOFJeQ2HV1v
	g0B4gWlwqHsHDZ63SnvLr5FuLfxKG6wJ5R2B+kyv8iKDwhnayJ8rXFlWFXs/xsEo+MMdnsSOt1u
	l7d/G5Zj23PVoJfW4wfUaaGsG+KM+JyfAbSlZmmmuC0F2JLJHtqDIBqRI8WWd+7hKUfX6DFxXiF
	luCzXAzUx2TDEXrZfIuZz8Ng=
X-Received: by 2002:a17:90b:4cc4:b0:3ac:b197:1a37 with SMTP id 98e67ed59e1d1-3ade9b2d399mr8594261a91.3.1793119064572;
        Tue, 27 Oct 2026 09:37:44 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4041fafcsm5635829a91.0.2026.10.27.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:37:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 00:37:41 +0800
From: Chris Down <chris@chrisdown.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 2/3] mseal sysmap: Allow with CHECKPOINT_RESTORE, default
 off
Message-ID: <auDTVShTfZ2et9m4@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <7ff59c2ab6c234ca4d799f862eb7c3f22d671f99.1793094611.git.chris@chrisdown.name>
 <auC7SFhV_qj-agQp@gremlin>
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
In-Reply-To: <auC7SFhV_qj-agQp@gremlin>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Ok, sounds good. I'll drop MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON, and fold dropping 
the !CHECKPOINT_RESTORE dependency into the boot parameter patch. Thanks!
