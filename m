Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442E233936
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009146; cv=none; b=WxmVJdSyl8H1BEPRhhR6yH71dE4JGoSQ5cTUhJamUV9l/105L9LuEDX1nDyHCzSgA+RZsXVbutpCoK4IgbY65vbLWvWk9PqRgeCPMST+wHCtS0cXPWJ7IuAyRDdTOy0GRKtufEuawkRJkeiF7OaZXpgnlG7wFelJ5LIvVRrD5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009146; c=relaxed/simple;
	bh=VuiMGsvrxoxHYIMjTtEAMKJLNMC58E+oDp1FFjB26XU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=dyAB5+YPK9KLyhRkb6RY1+RHqA57NSetwksESYDkKQb3An4hlxWwKkG0lCvGJqXXedQyycbWBFCQ9fYpVc7QjQdFjw70uUWDCdVLdarTPHdmrAWRmmCQuowcW6A/bkSnuScafSRYsKO4HdeE6sc5+6JuQpcViBmwdlHtOOe6OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL3guCmC; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL3guCmC"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so43808a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 02 Oct 2026 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009144; x=1791613944; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=DL3guCmCAoGGad5fqQhT+5W2N60ezuvD94VtFpob8EDuN/9oZNMQlKHDpKAkIFeIqv
         cOYuDc2THo5GGGolhJh0u08uEpd/a0aW2pVhSbGM+DGfgBTDKm22DxkQ6LX2FkKiM7yS
         jJV/jTe/NGZqAqIfD6TfS+NvtBajMlBp4v/HObTFUIzWKLyviiMPwG3ZAouqLj26zAwG
         ZcJjzfa+1isefTBiR26J43dKgCqETQBDF8CPhVZde99KZyOFaecA23+M4lrbFKXIXN/C
         dkTOqRKnWejNq/nzi8KHvYZV7R7OXmRw9eMk5898z5VOh6iUMuXoiZABMloEUTphOZXz
         PHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009144; x=1791613944;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=cwGKIyzyfrW4+bh7Bd1YFIcJnVHVUfP2pXXrUUj13Rk6GxD9UkzY5cU6wn2L+pWuO6
         x+GyWAVSULVdZvYApQWpjM2SaoVN3KFOesbbgY0sftqzq7erbUTI1HySvYbbSqW0yisK
         vazEWlJTSPnAnGbLX39JfvffyrRcEgm5cD0SBLDm5PJFtlLVIshjSZyCrxDSGxa1oEJz
         sfU5LO7hvCDZnrAvvZ/cMLyYVFSmc9ViINoAo6yq+QdI0MO5IQvIzG2Us0LLwW2axQa8
         CHoE53ShxRTnAO17sJj7/262wGw2i82RqDQfB24u0iZCJnVzESKFFXhoAD8BiiD+15ar
         c9ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwctthvoAjVNBA3vST+vqxkvH4lCwDIWfaBk+fEInwXDLl9dFJfNWr1tzw+ZyAj/zM/uD2+bTvmBnPqvfUZUpNiK3sf0zY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVNh49w4VggMBIzvPw/2E2DxgKuy4MaC4aIbw4v8pb07+P+rlf
	1SzSumQh7N6KHr3VFKLuXB2AnnSIRutNtdCqU9BOpzbmWnq6Hax+Plcl
X-Gm-Gg: AYBFou1Vt6kkDypSlKbKcqFeWVD2HvUVcZOuDmEDtG8BkQk0GNUUoHvZrPZLxENoyT4
	H1nofIBQeMa+sHtX7U2Pj9HYKwBqbMBV/0KBmIhKtlDcGi0XGK+r67DfQx8V2uFelYg9i6CpmR3
	3sALzc45ir8ZcoOhz4eh3Y4w7asQKXjaTSAc1yh4vlqp2bPh1y3U9+2+pBONawb1spBx9/A8B9U
	JN9KN448IFPjw2OmBzUzjOYsy0riv1JyidgMekm9XJvij3CQxIYOSDfrYSAdKTalGzmS8c0Ns+w
	gmcde+SczhYfRrP78/TUQ+/KBHUSNupNFlUC7abgZdY/An/mDZJ81Z/q+qKyjhpQIo3qChhCvPr
	MszGSAkN90UleFKrkELc4xK/Lz2wedbHdXq4TceN09jmh4RuJEMh0YtVWv1fkU4Y7Q5F5iZqVPI
	UcJ7TDLc0efr5Mq5zEMVznPzZ51UpKKWWwsd7Nd0AYy5baqFuOPO5U2BGqoOs7tRIuuAU4S0gx6
	Jh6tyNt15QIXHd8ru3ivwbH8nMgipozhBGqlYCSXutMRGvKcuRnAdZbU55fqbUlVByQxNNMp8DQ
	m6HG1yoIDVYieQ==
X-Received: by 2002:a17:90a:1650:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3a6e622a50cmr2049092a91.22.1791009143685;
        Fri, 02 Oct 2026 23:32:23 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b5c3dsm1823004a91.13.2026.10.02.23.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:32:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:32:21 +0000
Message-Id: <DLUZR540Z45R.3RTC4COS2IW2V@gmail.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Gow" <david@davidgow.net>, "Petr
 Mladek" <pmladek@suse.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "Shuvam Pandey" <shuvampandey1@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, =?utf-8?q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Jiri Kosina" <jikos@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>,
 "Thorsten Blum" <blum@kernel.org>, "Alison Schofield"
 <alison.schofield@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Guangshuo Li"
 <lgs201920130244@gmail.com>, "Ira Weiny" <iweiny@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Vishal
 Verma" <vishal.l.verma@intel.com>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <nvdimm@lists.linux.dev>, <linux-doc@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 00/11] seq_buf: Add seq_buf_strlen()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kees Cook" <kees@kernel.org>, "Bill Wendling" <morbo@google.com>
In-Reply-To: <20261003035906.too.263-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 08:59 PM Kees Cook <kees@kernel.org> wrote:
>   seq_buf: Add seq_buf_terminate()
>   bpf: Remove dead newline stripping from format_disasm_line()

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
