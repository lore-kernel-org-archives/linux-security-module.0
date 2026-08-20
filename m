Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33C415B65
	for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222718; cv=none; b=mlbtEkONKU5hPkYI8bqkHNR1j6FyIPmJHg/9La9z98BtIlu/pPRd2nf0tMbNlUDWeIS1iMw1ktpxd9sg7WjxwcAN8Rv1chZWhx+nm7qdAf/jBCEgxAGVBEYihRZVa02DYS3P/NwJY+pTA+qIc7py8fiCpEreezyAkF4hUqs9sNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222718; c=relaxed/simple;
	bh=s2DV6aiUDlhhJrEieuWVDHjMawqLaOWDdtsI/zGKjI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNiivVTbT7EXTxlnoOdsWEGobDYk4d5vEpg9xoO90nmj4Q6r7gwKYZBkaq6DgfdO0naMysO9PvBCvrlWrInF1WHzDtMmfYWLfqkdaszkcPvMwYNfJIh4ymsXqR7eHqadF5iV8dZ3KG8uukB4JZhvQxZOnRl2DZ4plX2qXtpU0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lb5m2TR9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lb5m2TR9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fd4531020so1278479f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787222714; x=1787827514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JHW7GNPdc6v3nkxo9K3w/f4XcAk4BjyG4NYESGzqVro=;
        b=lb5m2TR9Apnr9DvGHZWyW+vaK8ppda+GPGttAkOWNxToLXtyNyHSdWB6lezRMsmpZZ
         Hl74PGKLd82PFyp37m2i2lB/UdYZqRYfh/KigoW10PMQiZOuQT5fdYVVDfPDVdrFoRLe
         6yDsIrb2v92fpjWZk892PTPtp7YuRZZye6hfkhpZ0xwXqDwnGXjlTDWLo03nOxV+qy/f
         bPkT/ZTH602xZoX8n3yz2CPwpTWHsSPMnAAGsJm/XwlTuCJDupU5N/UZVjYzmKjYZP1n
         cfHh6ikbeuFyWoM3p45p/Cy7IRwAKV+MdvohkRZD1nb/61Et/HUx+j/Ukd61+P6XEx2+
         TVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787222714; x=1787827514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JHW7GNPdc6v3nkxo9K3w/f4XcAk4BjyG4NYESGzqVro=;
        b=QJGgbROajloLCPS6gt2WvKHettcNssPFJZ+OtQIxdx8YeRsigortLHXMFPR54Qv0jP
         GZY05FIUdzFrwRZAujX0FTj75MhGiccsbQFyHzJOhzKJ03aVCRp5t0Rwb8d4Ztrtjx2F
         QRtaCqpBI9RSL6Y/p7Tp1Qto/XIruMu8NefP8xGHSF9gj5vcUvxBf2Y2RfeCMoMH26Sh
         X8yRejP4NRvB/g1mXJmGHzV9HFqYcIXMV4yyC4VZMPAIxmaUGtnfVZ19J6mygVtBf176
         X8R9e69Rsf+EesFqLhrmfEXhfSIsafSgwDF8QzwlpDpdrQ2cBYr/JSAWE3ftkbPTC8gC
         mfsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFANndaVVKFO0WY05nVPYw+j6AVYOgsQW7B+uHQUcReED7n9wJJhFla++ueRboAG12+J0cBcbyE81xHpXQmaIYk+Tturg=@vger.kernel.org
X-Gm-Message-State: AFuF++nMvhSLoRkPv1x7dlvFvy1XrsANcLP2ZLM1SfmTOua4v6DwfF4h
	91Hvk/Ycop9WFYwMuU5D/JI2SWb4gtTbR/2uILcA5XiLjVQFFDokJP42YAzP7Xg3Nw==
X-Gm-Gg: AR+sD12D0ceukcCMlv77TpYv+43MXXNmFX5ooInF9VqKgO1NbMUq5G1N1wOrBDE/f7A
	uyMgNC8TX4caFaxjO0klPwmcCe9pimu7ZiWPiY1tAIxpHGE3H54ClMmmQfdmyvK/1haxVIO0Fll
	I9m9AmX8CXj+Jh1rKj6UUSq4B0VKJmapWQjzX2PBwFxXkjPSqXZrfCZo8L4Z4PbUA28fklbiYIA
	2fbUjB4X4y2KUI11SN4BR8Yb3sOPFbcaej/BM97C6yVdAFikeBeuE3b481n76cJe1KgsC1DMApN
	i9/nzR9ij76VKHobMxj71itX0vIHl727L/0Sf+yeP7yoQBq2zRXWj2MXGE88KMbutA2Gs8XDb0w
	kHmx0Gg1A498T6fmxsIZgPS+0xX+89KBRoxqPIDFcoKx++svdhUna5kOSB7GwPAxIj/ybDP7jRS
	yu2oKAT/YDiw0JPGTbB3T8qN+o8mUH7EV6O9Js/OnRYKL9F/TgEg7ZnbipDNcSie7lKzMBEPd5Q
	Fd31aigy+JoUzWCgW4=
X-Received: by 2002:a05:6000:2405:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-482b1fd970fmr18114147f8f.15.1787222713504;
        Thu, 20 Aug 2026 03:45:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d956:c85e:ab42:2c9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b7d3asm11766234f8f.23.2026.08.20.03.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:45:12 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:45:07 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/19] landlock: Split struct landlock_domain from
 struct landlock_ruleset
Message-ID: <aobasxUDQ8b7GYXl@google.com>
References: <20260811094338.288094-1-mic@digikod.net>
 <20260811094338.288094-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811094338.288094-4-mic@digikod.net>

On Tue, Aug 11, 2026 at 11:43:17AM +0200, Mickaël Salaün wrote:
> @@ -45,34 +50,27 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  	new_ruleset->rules.root_net_port = RB_ROOT;
>  #endif /* IS_ENABLED(CONFIG_INET) */
>  
> -	new_ruleset->num_layers = num_layers;
> -	/*
> -	 * hierarchy = NULL
> -	 * rules.num_rules = 0
> -	 * access_masks[] = 0
> -	 */
> -	return new_ruleset;
> -}
> +	/* Should already be checked in landlock_create_ruleset(). */

This comment is now itself living within landlock_create_ruleset().
I believe this was inlined from the original function, maybe revisit?

> +	if (fs_access_mask) {
> +		const access_mask_t mask = fs_access_mask &
> +					   LANDLOCK_MASK_ACCESS_FS;
>  

—Günther
