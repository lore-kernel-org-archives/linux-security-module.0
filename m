Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722527587E
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180563; cv=none; b=UIJswHWRAsTGUY/01Bpu9su/rvjZKzLuosiYmTDc7U3FbQNVklmXIqBBJgnL756yvSoT+FId1xKQdTelenJLC13fybJdcnCjrDuKdZ4Min5kHYLHCv6zuvKDaorMrXncQpgCI7BXmLwRxTbJngnzH1c1Z8uOGKe2PxlDWVYS75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180563; c=relaxed/simple;
	bh=XXvUIRo6jJ9ogO2QQaUCxttK8WosB2XGObI8UYH72+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRohO8EhladWpIvXj7P2SapDOGAkrYYv1E/cS7u+8JUOx1YR4kK871jBTNsEIhddwvJrYRiesYL7y/oJhX0DswVpH43qLwAmIyg6iu0Pr1u00ukb6SzlIfyH1rBbSgGj4Sqerk3/wjeqVZTAMV6/imoTSOMo1No0PquoGT0Rkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOj/rZpt; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOj/rZpt"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c03eb31db80so1672729a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180561; x=1766785361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhB1Fco/aAscGV7BUmHv+KRyMsa6iylEkhRycjuIJTw=;
        b=AOj/rZptNUFI/4UnRqR9fG5FQ29cGUrYlcJJx2lflJCke/Y/I28A5KMi4N1CfFrm3L
         ow86AIq0BJG9HpLBXdf0gflqQQC5t8cN2KiV3kkBODaly4qmcOX5yvk80RVXbtRifmoH
         9sjvd9xJZDmyRyDGilORjblWWQMJNU6Agw7WMpFLYUaBksDg/a+fjRiH+L1qrHNgzxee
         Jc50o4OHuJWtqRFIa+GTKNf7qG/gwNOG10jYe9HOjwMv4hpHQfmChvlC+4bxyS64Zx7D
         8j1dm92dY/SjzI8eCA0tkgzlHwdV1ZCIC92qmEFfsCZGLieEWuaYI8kDGDZ5baKWEVWa
         OFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180561; x=1766785361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhB1Fco/aAscGV7BUmHv+KRyMsa6iylEkhRycjuIJTw=;
        b=UTkEtFTZ9NEG/Yy9OioU0rCnMHfWZ3OAI7qAn3IcKz/fnZbGV6UMWDd/7fYWEBo3i6
         aKQlHdLKYbjLTr8FQyuiAbUiL0h3mAERUt7Po901qcMToyTxLjKTwVxMLrb/IdcoYpBe
         P200KWT7NxHh7OKWDowpsnRQDioGFDAkCONcCtLETVkVtf3eSQhLgiAPrc5PE91BgO/u
         oDmWmKzjJbrHg1ZP/g28NccXqUvA5fECGx3qln7OF7yiV43OcV/KOZc2ncjInpeljk58
         mkm4CM6lpfl1rmBDWBC4rCO93YBWEv+6xrgkteIYYT1+FeGGHHjid8eyAo0nafBRh50w
         e01g==
X-Forwarded-Encrypted: i=1; AJvYcCUuilfBa0iFPiyf/F1+Scxt0A1mz+ePLQOIm3gVLxDwvNV2DjrR+jgvrZZ69k952aA9pAsYAn0N6vdRfsFnLytYlHPmoNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysQC7MATrDC/qcU3rYOMyAg8KxFNbqltfKqUknSEkeu7isT2tY
	n0RcO2EdQ8sxPiO37NxJ1Avo657y31smKU3zWXLteKg85ixx+edKJezG
X-Gm-Gg: AY/fxX6GASP51A/nD1nAtXBzWyfCwwpLDR9I9HGx2ojsWEYxz6GlnvbjQCia0vbs1H8
	2cY+AUZymm7cvAoj1atWXgGpp2gX4UVRH/t+Na189mvoKg66mw353jraNpyUkHnDnqD2zCnO8jj
	A/4X3IUYXD4jvqB2uurTnrx/vXKputxHp9KkHjjxpRpvXEaPxEIqsmedJ6yd1cO0geL+b9nlBLZ
	yxg0KAgkl/Ie+vGUBuwf9oivhIMPEtXK+nO4/uvm2yNRqICg30JKeEeMAPedK8Hs5qZz98SoVJK
	2CMy+PhQO5rY7692tDQ5jIEcGUsdMLxfHU4CGRvf5msACN1opJtW9KzLni9Szs8FpT06KylsdkA
	diiJ379WL1AWmClfaeme2TfZNFKqYT1VmXDvZwOrBXnd+oC85IZipVB/Guf+Bo8WrC3MtYIB80Y
	n06elreESI7Rp+BAuN8v6E2S41SHYJCMcACRUmW4KiNjosImfxje+S+38Pe2ukpHiZq1o/XfRl9
	NdtzWAXKDVliuUNcTnCi3Zpwi7QrIYNQI+vGSYpzLh19Znb3fk44nwopD5T/PHVphxtANksYJ55
	Kl0=
X-Google-Smtp-Source: AGHT+IGTM6mjPPfNhqA9HPe48U2bDECheHzAzGuJpcTxojW/wC3VfdWLu4jNEE4Msq7vw7t+QoPUtw==
X-Received: by 2002:a05:7022:62a9:b0:11b:78e6:8323 with SMTP id a92af1059eb24-121722fd212mr4438541c88.37.1766180561251;
        Fri, 19 Dec 2025 13:42:41 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm11636083c88.13.2025.12.19.13.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:42:40 -0800 (PST)
Message-ID: <9af0d949-45f5-45cd-b49d-d45d53f5d8f6@gmail.com>
Date: Fri, 19 Dec 2025 14:42:38 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/36] compiler-context-analysis: Remove __cond_lock()
 function-like helper
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
 <20251219154418.3592607-25-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251219154418.3592607-25-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
>   Documentation/dev-tools/context-analysis.rst  |  2 -
>   Documentation/mm/process_addrs.rst            |  6 +-
>   .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 +-
>   .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +-
>   .../intel/iwlwifi/pcie/gen1_2/internal.h      |  5 +-
>   .../intel/iwlwifi/pcie/gen1_2/trans.c         |  4 +-
>   include/linux/compiler-context-analysis.h     | 31 ----------
>   include/linux/lockref.h                       |  4 +-
>   include/linux/mm.h                            | 33 ++--------
>   include/linux/rwlock.h                        | 11 +---
>   include/linux/rwlock_api_smp.h                | 14 ++++-
>   include/linux/rwlock_rt.h                     | 21 ++++---
>   include/linux/sched/signal.h                  | 14 +----
>   include/linux/spinlock.h                      | 45 +++++---------
>   include/linux/spinlock_api_smp.h              | 20 ++++++
>   include/linux/spinlock_api_up.h               | 61 ++++++++++++++++---
>   include/linux/spinlock_rt.h                   | 26 ++++----
>   kernel/signal.c                               |  4 +-
>   kernel/time/posix-timers.c                    | 13 +---
>   lib/dec_and_lock.c                            |  8 +--
>   lib/lockref.c                                 |  1 -
>   mm/memory.c                                   |  4 +-
>   mm/pgtable-generic.c                          | 19 +++---
>   tools/include/linux/compiler_types.h          |  2 -

This patch should be split into one patch per subsystem or driver.
E.g. one patch for the iwlwifi driver, another patch for the mm
subsystem, one patch for the rwlock primitive, one patch for the
spinlock primitive, etc.

The tools/include/linux/compiler_types.h change probably should be
left out because it is user space code instead of kernel code and
the rest of the series applies to kernel code only.

Thanks,

Bart.
