Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C8231858
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187465; cv=none; b=Qd7Onxr6VCpq/UD7LdQ60YuDETFfiwdQOSEzW8dfq4Akfq7wjoLVkjuDfnJ/Pp51TInYYRMOGRFTxvQ146YiDLwnLZX6uqC8gmdlTkjEzfAJ18Db8RP+qdxUKTGtH9kw2DPud4B/rX3dsY325X+qTMvLILx2LKL35B9GHUUF+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187465; c=relaxed/simple;
	bh=kqYAQZ609rJygFWC7CbHOEHNatKsPADzGjHUdHPU3XE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=goOINY6NRrSsWMRTy6rnw6qlNFLL9CpCRB4nMkcpcPQsnlKiJaCwzWNI1X2aLgWsRUIOvNC/8bEK4pRwxPQSjdIIFI839SG0Vatoa8SixfjO/+3yOIXahgJzU98C6YfaVRZ1Fm2jDOQwBjCaAyEN5twJuCb5oOSFiutJ+E3IHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dafyMkQn; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dafyMkQn"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7f121c00dedso3020338b3a.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 15:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766187463; x=1766792263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=dafyMkQngPq7e8Uy0NWFFTGBQwd9S/8Vop/KCuF40UJiabXtkbZnBMB53pgSUCRcSp
         cPUskdt2naTnhKRHocgbO+orYaYcKghLEQhP3XCXVCQuzRIaYgR8qhmMvJi1xLUmaSkL
         0xymdlos81DD96mztK0x5CZ6MM8CxCDjD2S5ImcuHaILrJuOs33bb2D0+RFFoqQz6Fdh
         GamPSfIQQm8hPjo8UWKhFto9eMjsOncHQPrNiNRU6zs/4nxj0BXQLBU4P2JVLv9gvJOc
         wo1jyCTAOzOeBXwqJN8QFQCHRVUAJS6k7nDLlQ+ekYQuiI876cYh273s0/f/gABLoo6+
         R1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766187463; x=1766792263;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=Vap8HRjTsfF3V3jZ2OmGqsN8yK+HSDZ0JW4mmQAmh9WlWmjCoeBM5GU/hf9RXUG6Yb
         l8HPHGYuSteDOIRaWTKoF8DuRiBBYbCpvR4Fy3nRBxptZu07wGQInUnoX7vIi4BWzC5a
         mrDPsgYVrT/8y4a1myiJLyQNq3XbIn2P3NY97fgvD0YkaWVXnC66Am4xQSzUlFET+xKi
         IvX1FZtB7jx/M4GXX9m3R1Rra/KB9fDC39ifqjNNhPN7qnwFhX8Ss3sIsUmo16vT7D+o
         bq+BLBGzHFL4ZXYWOm4yQr708Pha8VQRQNBS6aLEj0QOhE2t4zGIQNUesJ8HIugsrzx9
         8rHg==
X-Forwarded-Encrypted: i=1; AJvYcCVZdtL509hq6H+R/E15FjOCTEKHXtTVm0uaQH1rcgrHNiUIUVL41GwyCvXE01rW89MBxdvxFxxaSJWc6xtXVyYfgbhkwW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjUR5TrM5pUByNylbGfAvSt61MSaoyk0SgLNFFlSr2QYtaV9k
	DrgIUzLJq9Ul1KiETqElE//BurfjMhQPROj0Fv0aA12Md9ULiRQN9j1z
X-Gm-Gg: AY/fxX4yxG2OCfH9Rmitbfw8jV48PCDgs7IYvNE5ZSZ7pCwoqELnDWqY4TwMyi+FgAD
	HmjLE3IALMyraE2aNPlSoQC/g4GKroUNdZpt9W7soiddCjA9kJ1xBKHuONYSwBSj2rArbhZjm2y
	6WOfK/BTaCNhV9Im0g0V8UpaJdQqgFmYvqNA/SXCkgZ3D/A6F3HbfC7HbEO6xdDWKCO1jv8xnjA
	QFzZ4Y6gSW6ygat0cts1sYbecyrj5ehbvgDtCpx6ktJslxzfmp1fEAGW3rhYSPS+VcVR7hf1JA6
	hH1vNGikxp5w6g1IbAkso1xVKZiUUxPnbF7yshDbG+Mj+/SRqGphuLmqQAVsyKJDfNltVNRPJS8
	LbhFYzMXR1RwGTTsgWhsH3H3q4XcMR2J4UbjyTWUEttHXri0UYDy5184uciDJgWLJn7e3loewz6
	bdRGJeT9wgAQuCFNJVYqFC3kMVGHUJXtanNock27cKpJxviq442bGXlBHJ60d7CPq7VyykYXjqn
	zaarQsCNtRaSM7yVC4BN+sIPfJiw0gUWs/3DOjLo0Qj2wCLEet8ipNrT+GwZ960+L8ksNUt2kmj
	ANY=
X-Google-Smtp-Source: AGHT+IFD9VEfhTkWGAUJ+KrkgUpiheofAxrSZVwNtEffu0+8gx+hrdlGu9tKXSDKwQO+mDr4xt9mXg==
X-Received: by 2002:a05:7022:3a83:b0:11c:b397:2657 with SMTP id a92af1059eb24-121722be81emr4954809c88.22.1766180747284;
        Fri, 19 Dec 2025 13:45:47 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm10260116eec.2.2025.12.19.13.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:45:46 -0800 (PST)
Message-ID: <ae957ee5-cb47-433f-b0b3-f4ac8ec7116b@gmail.com>
Date: Fri, 19 Dec 2025 14:45:45 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
To: Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
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
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-9-elver@google.com>
 <17723ae6-9611-4731-905c-60dab9fb7102@acm.org>
 <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 1:02 PM, Marco Elver wrote:
> On Fri, 19 Dec 2025 at 21:26, Bart Van Assche <bvanassche@acm.org> wrote:
>> On 12/19/25 7:39 AM, Marco Elver wrote:
>>> - extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
>>> + extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
>>
>> Given the "one change per patch" rule, shouldn't the annotation fixes
>> for rwlock operations be moved into a separate patch?
>>
>>> -typedef struct {
>>> +context_lock_struct(rwlock) {
>>>        arch_rwlock_t raw_lock;
>>>    #ifdef CONFIG_DEBUG_SPINLOCK
>>>        unsigned int magic, owner_cpu;
>>> @@ -31,7 +31,8 @@ typedef struct {
>>>    #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>        struct lockdep_map dep_map;
>>>    #endif
>>> -} rwlock_t;
>>> +};
>>> +typedef struct rwlock rwlock_t;
>>
>> This change introduces a new globally visible "struct rwlock". Although
>> I haven't found any existing "struct rwlock" definitions, maybe it's a
>> good idea to use a more unique name instead.
> 
> This doesn't actually introduce a new globally visible "struct
> rwlock", it's already the case before.
> An inlined struct definition in a typedef is available by its struct
> name, so this is not introducing a new name
> (https://godbolt.org/z/Y1jf66e1M).

Please take another look. The godbolt example follows the pattern
"typedef struct name { ... } name_t;". The "name" part is missing from
the rwlock_t definition. This is why I wrote that the above code
introduces a new global struct name.

Bart.
