Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013259;
	b=JsBhpZYA+CUPP0lMhcve41LzOugE8thkyNDmt2p2v70B3k9lBFv7lIOyIP31H8jffsUg
	 GEsUBZ7iUoUUcl4YeQIw/R9XDthz8Fiiq/OzJOWVMLBuFLlmHEZMepZ7t00eEOz0qLHZc
	 y2UmMDFiRUgTw02SKKhJ5jtHi4mCLzGRcZ9vbtDDggLGl4dhVw9O54jT0FBceoukSYNh9
	 tmaZAEflEyCsVVsku5PIbx1wQl4ugUvEh33fDGwuhG+3+IDd0ilIVKxP25anhCliwUdTK
	 dvdViqHY0yUQn1k9qj8GgH04Orx3N4Hj7X80Qddby14/oQpQjWlx7I3Baxqt8Shsknw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IgtmGgLwdp7YHZZLZXtmuM3LeEAEVVcvQiETOOFbu8o=;
	b=yuRTcvr7W4Ybt+xaPCMpMckIKyi+R17wLaFjP32su52r5Qb1niNNjnzvL/EOZbd0QjbQ
	 2PsO27Y/qJytNF6zkaTcn5K0X+4Klh1vGrUJMQQeys40yZmPvxBSdf64TBvFjBk5rY6tb
	 y2FGrNeG4epM04GOxC67aE/krbU2I0vnhS+230XS1dyyvb2cCl25swxZq6reb77Xeqs1l
	 YCHClvT8Yq2Yxyhlq2tW8jswOHKZU7Sd/ZTAoGgpWhFRi6OB7nDF7UvOF7BWog6su4LoV
	 /8ltwZ0GLfwZOVYHX40ZxHhzqmGtjn0HMt7xNiD2pcnj4pPap2GB2e/ubdrw2SMTuvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mce3LPT5;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073F606A32F
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1073F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mce3LPT5
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9495f083657so134880185a.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795013258; x=1795618058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgtmGgLwdp7YHZZLZXtmuM3LeEAEVVcvQiETOOFbu8o=;
        b=mce3LPT5oG7C8F/QlXxfra+ftcUqbbosr68KVWr4liElvzqRdfBEqD/aEKIHceO+Aj
         +7TrSS0VWnGw72sCUYxtMjkg2MrGffSmsRtSP06tlj7q26d8E2nSTu4Z0BSvWs0M5cd8
         KB4LmsGi40TprWi9Dp8BnOyTEmFGkNYhFFanczHDzzKTNXuNvSPbFVnO0PIil/6+GCbK
         TBiO4Rkq/COIB6DJcfaHVgLG+7qjvdh1LPzUR7FonRPcRWRDNzUcdJW0Rcnl2JL9lKHC
         h5D0d4zczwBfyJqPh8GSUOsTeJtA1998BdswYK4nrDfVV55D9/VxOJDtpGtoQt8e5N5W
         k9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795013258; x=1795618058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgtmGgLwdp7YHZZLZXtmuM3LeEAEVVcvQiETOOFbu8o=;
        b=AY7t9fjzX6Mpm168ZXWJV9PAMavBXsmnzpQkyfaMkl4tTBReWTcgwT9/My4El9u7Sr
         VIseLJC/t8w1xky+E2cRvgXV0IDrCqw5b60ly8AoIcUnr568+J7uY9Nd5IlnZv+giOIi
         UYw3hItzV6yvnOUyjcxRYBcJWcl649HAxgY7Lpb3XkmeZV4+ZPvKUUK8eIptuNACY/jU
         8rdz9U0Ifs75KN961KbNbYDm+PiZOsd+ay9Ldlz2SsO9p7WNT/PsyvY6m4B0MfsQ0vm5
         L7r+4nz/t1dfOk5s2cZ3VfMpJzc28aeicQe+WKRn/w/bhtDn5ByRHD4NqbyKoJPdyoEP
         KBhA==
X-Forwarded-Encrypted: i=1; AL+hErFjke8kRERv/9aK8v1veeB1uNwg5+aCrJOZ5f1eUyzJXkScsu7sWvotCwImfDWZ70ATYoh64ySCuCGPIeVuHpq2KJvbFZ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z++7gZDOiMYIsaxuiOeHMT/9/Jej+9bsOvwWuyBcmSyFZ1ULuXV
	Fab99/y7HS2ASB7l4cpp3r3ex8JBIHUJFz0di5kTLoxcA7M0RQryaAz4OKe7U9ctTvk=
X-Gm-Gg: AYBFou1Lqnh4Oxr7JsbmZDc6bImeaY+drrgkP9KIStUv+b/+3rZsK1BoQtjzAtupbh9
	oGbaP/B33DtvbciTnC4dl5CqduSxypv1GK+v7u1kFzfmsQ3Jq11WMgTxDrXdPs/n2DklE+tcmw0
	mLcDyvYN1mSG44Ej/RitM8EiPuDMYxiC/12PtXTAsq22KADTgNpvUjGLOISvpVzctgXMsduFVy2
	BbuOC22dIp63OP2731KS9DO06kJtuzUYKRV7Ixb477medpQwG0NXfVaUEygSYghTmDyLjJ8V4DR
	UpRq3qLZrm4J9mIFfkGsORfaNbNZ1yOKYv/4ujN6YRCkY5BoOtRVvsuSWk3Q+0py1rwR7QVonId
	j5FiE6Zebb9bWmJTkVxHisSNTvaHJrzsrP6U5iqsdGX1xX0XaNnk7YwNCSKsrsDFLrYlU5U0msT
	nZNin2k9MAKBseLY5hBA3z9Yp3CPyA1NlQPLpBEWG03q11sAjcZOVq7XFma83wMBnKWk/XB3Qyz
	sWTnZh4DYN4HQI99qClht6BMDAW88jTDixC9j9HYPKm0OUv4zf7wMQ0EL7ZEr3FNzANOdvVmwy0
	gV6fX2RwTVySwEIaD9ZM4D3q2Wf2zUBKPRGRa0UybzqSejQ=
X-Received: by 2002:a05:620a:880a:b0:93c:b5fd:f33f with SMTP id af79cd13be357-94999722106mr491978585a.27.1795013257845;
        Wed, 18 Nov 2026 06:47:37 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b81d4a0sm193898585a.43.2026.11.18.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:47:37 -0800 (PST)
Date: Wed, 18 Nov 2026 14:47:34 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@amacapital.net>, Ben Segall <bsegall@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, John Johansen <john.johansen@canonical.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, 
	Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Neal Gompa <neal@gompa.dev>, Paul Moore <paul@paul-moore.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Serge Hallyn <sergeh@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Zygmunt Krynicki <zygmunt.krynicki@canonical.com>, alex@amutable.com
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
Message-ID: <wdwc3b5edgtgvrgqfhlzhrachr5hrqb7ahipcuqdz5pffxlc5b@662cpwhxwjer>
References: <20261117231352.3816603-1-jarkko@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117231352.3816603-1-jarkko@kernel.org>

On Wed, Nov 18, 2026 at 01:13:39AM +0200, Jarkko Sakkinen wrote:
> OVERVIEW
> ========
> 
> A root namespace (rootns) is a kernel object backed by a file descriptor
> that binds together:
> 
> 1. A full or partial set of detached namespaces.
> 2. A dedicated PID namespace for spawning processes into, signaling
>    members, and polling or waiting on PID 1 exit.
> 3. An initially empty mount namespace (CLONE_EMPTY_MNTNS) that must be
>    populated before going live, without inheriting host mount-tree
>    ancestors.

This is what cells is doing https://lwn.net/Articles/1102593/, you may
want to take a look at that work. Christian, Lennart, Alex, myself
and others are working towards this in a more wholistic way. There's a
lot more that goes into this outside of just the object itself. I've got
my version deployed inside Anthropic for securing containers and I've
tripped over a lot of pre-work that needs to come because we can tackle
this. Alex has my rough outline for kuid64 for example, which is
necessary for making sure we don't overlap UID's on the system and
create holes this way. The cells work/anything that wants to have clear
security boundaries is going to require that as a pre-requisite. If
you'd like I can include you in our planning so we can get something
that will solve all of our problems. Thanks,

Josef
