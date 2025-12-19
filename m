Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701E345CBE
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180300; cv=none; b=C5w5ixCYsOSVTblKzC0g3tiPCRlFpMhM4X36X3aroAxddFCfn0bHPYa1/Mdgx1fpA93S2WBgLJQp1ShJTBBmLOXFXoOZBbVWTwyhypucaVhaNY0mxSVeJ/Fb4Z+bG7/XwQf/d2grR2t1poVlkeGp8ru1Nq8vua43UZhlnqMmsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180300; c=relaxed/simple;
	bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0hqeK+mNTl+T5ilwRFIKqpLLaUBLhqNqhQKDI1365JC6OpXpyuWP31n5+pJ5erhegYcTURmhFWfpN6h5QQExOp05Jkd4TYKayo9zmPj4MdYVG0oeby4BKTJ+Xx2Hpg35dtcrwoPKq+DBR7T4vtfRoFeivaxsqUAiEm2AkxOpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZXXDITX; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZXXDITX"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so2044288b3a.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180296; x=1766785096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=PZXXDITX8O2pITtu53MVdLOAN8xLa+E4T8O59SLKUmlhw5IGVuOVSaPVKr3RLgyRi9
         FFkrGh/mG35OypARILyigj6YN0GxLJ3X3MOyK+Jvg6PjLDf3Dq2LmoZ2Sj9s/vukVIFq
         LzzBAqPmENgXRvU7eSOKxVcijftEUHTO1jAq7CC7D0kpCfHRoPh2jBjS30aoCTlf+rtk
         nw9MA21zYZJBvVw3CEwwUHEc5WUM5bMNKamyH44/Jthx3UNRJwNqNDyGqhB/ZUDiPjj8
         /SJ5Mj3VpKOHOujtfOTulYT13laYJWXVJsjSmabdQezKKZkPMS3oWx9RPm6XWm7dEXsO
         n3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180296; x=1766785096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=lt3KrCTHfPPZyMs3qik9eremvBY7q88VTos0ANFVfMhzhGsYbThLaSLA47L7fTfyvF
         C/Hxq12M2Clu5tuYKhmutwLDpyTeWJZjJ2AgLo20m04mSsJLrupLEIUaHfkfEfmpkf4K
         Ip9FTXqOOi96p93SCNvKVSZ64MgRWKfJouJaymQ43J1yXoXBgu8Ap7Z3skzlqjbsXLQf
         7DzxT+xueNVrph145Josy6yodPp2fn66cQ2GwpXJqAb/85oBunbd4XvReHSIHIZahKB/
         jEY/RHhxudNLNFb+Dt4s/AtLXSkbchVbNg2AVbz7zCmiTtfGI97LzMb+DHKJNyIxhzMg
         +Rrg==
X-Forwarded-Encrypted: i=1; AJvYcCVISkooaQmt88ph7rv3MSmWPnbp2Ur6ZJbBNnz+m0Sea/viv/Epl/Llm3pgp/bPptdWRUIs4bRvgpPt655Oxx96QV5Wz+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWXc7ECv0jgfqnA8GTaZ2G45XgXwfwK/nyvYg5V5yZ4XFYLdn
	O/PjPg5Ln6ArXLWWz8D51gPi6pDctACU1iRSMhdvf5kDPuuswMF7t2vZ
X-Gm-Gg: AY/fxX7GBOSPta19PsUEt/SwQHQShLTwMCfAk2zz7LM5j7062fahSTEJzWBhUK1LcYO
	1zM4C09/vuY9MsN2ay7JenA8ax+CdOU5wPOUmMJiskA6VtOqJexJqtflyDv13N+umU8xtjvB3bG
	y1jm/1A0rgtHZTYid2GvaKGUKkb/bI2BOo1TLy6TN0JQwI6phu4xi+YiYSE3l3NYppiVVaijKEx
	0VHqxVet1v3i69aQdY4PsVMJXyesN0eOXQdgxIU0gWGKVDiR01OV09Xg9iYSjE0ABDdX2QMJDDr
	27EET0mmf5scaKrIzxhfPaWJC17/rm21lnbTQg/NwA0gfI33mk2Uozbk5H0rVqQGS6RMVGA6xka
	ju9NRalaIzOz9xWB98vgG9c07JBQY4F4Ew9YI0RbK2+uaZ8XOne28tDcZdSQnontTG8Ep7mV8xr
	1jm97GwnkhUNx572jC8l5ZWPpkI/33OOyFOCTLnZnHMFGFTh8UTy/6Mjz8Oms+a04uK4PH2xrwh
	He9v0uDuJF38S8QXmd/rE2EWoj8K3hyGFHuAl26Cy7BAVmJNNvWGozUrnsGY5BjhWGRDWepL9JO
	EdM=
X-Google-Smtp-Source: AGHT+IGivulZwqOvq9TkwT/0JBobQprm3JRJ6VtJUw4ydSXEmlT/iKTWxEeMw8/Q4ZWRYLdEwZEKQQ==
X-Received: by 2002:a05:7022:e0c:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-121722f462emr3455845c88.28.1766180295388;
        Fri, 19 Dec 2025 13:38:15 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm12051531c88.1.2025.12.19.13.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:38:14 -0800 (PST)
Message-ID: <34cda24f-acdc-4049-9869-b666b08897d9@gmail.com>
Date: Fri, 19 Dec 2025 14:38:12 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/36] compiler-context-analysis: Remove Sparse support
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-24-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251219154418.3592607-24-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
> Remove Sparse support as discussed at [1].

Kernel patch descriptions should be self-contained. In other words, the
conclusion from [1] should be summarized in the patch description
instead of only referring to that discussion with a hyperlink.

Thanks,

Bart.
