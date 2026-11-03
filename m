Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737898;
	b=Lmna6iHZEVN7Xx9Vjxk+zfsz44eXXppE0iuu8w19fij+fvvuqyqUp7ycXPYRomWBjVLt
	 crzZkR+B6IMfTYnY0ljXsmBC3f1/zrOm3RSdPPYG5mDGavWWluwLrCIN5QnIbdAv03kmH
	 oFNjoYj5z6M3TsHwToOFAtwLd7NhQUpHxK/MV0vzS7wFAJdeVTFCnqSy77Wz1BdoPxQS4
	 bEXu//ohEH0A3QBoUN7o7Q0idhU9X/SrV9a043Pdc9lDjCwBRyF0wN7K1NgSvLtBdU0n8
	 jZzBjMVOvu/3lcK8cP3ow9GSa3xJf76/f8PdRljrbVl9NZ/UzrQkzhrri2JgfV6xHSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=yH/XRG7heWWZ+jvry39cY9jHOPmxtv5uOcm4fDn0jL8=;
	b=frtY/CsMeUXp0Mupi20exZZMT7pINEWsyXbBHnY7Pcl5QA8ID4iy4kOOlSorUukD/AAb
	 X3Oq5of934tcaSiEGx97eSkHBYw+VEujv0FFjIH1GpTvMfiGe8GXyhYmPTIOh6piokUnF
	 eO+8TvD7cWFBoWkG2Sh9dJcWcQa3p6RQLZn/X+bTseaa5WTdnRLwsklxus33PlLaCLxhy
	 ncz2qPT7iSxXznD4pGUfVYo76D6tVcoh+1CZ3Zoh1nps1/sq7p07zTXUlKQV7EA/ujjwb
	 3+LFvZU55G8NUgJhMWt4UsaUbyveeqg7cNrS8j8XsgfNZjlFhDRkEGrhYBWzOtKu8tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFz8Yp7u;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94268606A329
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 20:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94268606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RFz8Yp7u
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so37452985e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Nov 2026 12:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737896; x=1794342696; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yH/XRG7heWWZ+jvry39cY9jHOPmxtv5uOcm4fDn0jL8=;
        b=RFz8Yp7uY0eJxd+1QzwiZ7WVFvlDvKXPH/KU7OnSu4C4lVInrMJDIUgw+t6NS3QwWN
         51a1+V0XGOm2kfNpKTsIFbU7XtCaiaeVNmEhgFeFb1/CrgAAdjx6RnrCKSI/GQcbxXIj
         zk4oXe/ZcmhoB/9RZoXaMLelwk9hUZc0kCiiJoa4eh/Mo95xbaQlqYkyTUWpyU5DunS8
         /Rk43e8dBuiwCxXMo+YKIA/4tuqPntQC4r09s1wi8SZN3fTyOhCC4XzaoNcMkwT97oky
         TyvMinMrf3bhPU4GoPScWDTt5Yyl27cvFCNI9OWgSMUN/ce15ceTsoEM8yVAia/L78Wh
         u65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737896; x=1794342696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yH/XRG7heWWZ+jvry39cY9jHOPmxtv5uOcm4fDn0jL8=;
        b=03AwiRjkhedjd40eS7AlarFjmRPqCQSCAuhqvH4xdSEW/RnaT3dWW73UTpLH4Kup/T
         4GVL2UkWC9iqU6t7FyMY2QKTA84jF1zRA+1e1P3JOsElxYqlgL0tcrsPPl9xJoPj3eLK
         TZdAZ7iFo5jFz0b4bJvVzxcGXcYDYe3mxV5RphXjaPpHrtqPmQRL/3INUBgbz0IpZkL+
         umuBnab9MdJVdkat4g7ibjnEGOdjtK/pQUauw1AgGDi/Gm9VJ6jZey0oFlFo4wTRTr7D
         BxhES61A8SEQzachAp90UXmKzjZoieXyUd5vO+wm5R4QSSKn3TdMKc4gg6JDp9vh/C2D
         xyOg==
X-Forwarded-Encrypted: i=1; AKwUvBwXQ3cfeTDKkTpLxjgTi+kUMicPr/+akRPMiTegs2FIj3NnkvWmU9W/4gewS4ct4i030csrdstRyTBEudDRoLVRYw9buk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3BhL1VXd8rxBfraiGf7/jB77KL5RtyfV8DFVSMeWEYIbtHZ2Q
	he5MWxe4z7h9T+VL+G45vdzaY9XelD7jA3V0d5E/18tJZo1v2sQ0+Lva
X-Gm-Gg: AYBFou0QlxwdPpec4YFidwP+Jo6SuH94L37x9FpZwSKtypIzX7jkJhyKQnQarVQKBh4
	YVL54QDuijDoqJjrTQGBZuBgVE5RtQTpUSk4Er37uY584O8al8MIy0EjRd5HNfyrBjUxhD40wj/
	YKY/pc7jSX0+WiohgMwr23QEdwS59XGdyX5MNijAOXMfcFixBkqlJj1MorUgMfuqpZyYn5Wj741
	3wQy2pgTijtrbssiB+fh4N4dt80ecsSPt3dpFePc1rWmEE6Nhcd7JZlJNEkb4fcjBL3D+OheThM
	R+Nw/csVUxxW/JMmHUHqfIegMayINyxzAEkYYvu/O5sjdLrrTfdrYDFD/wYU33JyMtRx3eusSfB
	AmWO2DJu4g38T8wA6xM0hxKgq5Y/LJQA9rtpLAO/fxxNMgmAoP55TRNZsWHZUQv8b6p7l2WkxU+
	HbPOdl4Dju3SysZTRsaBJ+WbR75KqtJZBNKJmyvImGvcoy6D0L+YONAJEL80mzaQefHiK9891mM
	Acvl61hSQFQwxZ2i7SzSYoAYm1BfiigLJy1WUy1K/mbhIwcf+cLBNs8dQpKm5kgJvqkPVBectz3
	7NlFobYlglyFoh2loj0mABJcTYNECZpQW2hGPQmRcUuiDlyyjOc7GkW/0nGit4Qooj8M/u3R8Q=
	=
X-Received: by 2002:a05:600c:1c17:b0:4a0:1efa:c74a with SMTP id 5b1f17b1804b1-4ac18b7ddcdmr302817215e9.20.1793737895986;
        Tue, 03 Nov 2026 12:31:35 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b411de95b4sm4931815e9.0.2026.11.03.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:31:35 -0800 (PST)
Date: Tue, 3 Nov 2026 21:31:33 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: fix the regex_escape() error check
Message-ID: <20261103.06edcd6fc9f1@gnoack.org>
References: <20261103163917.641130-1-sashal@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103163917.641130-1-sashal@kernel.org>

Hello Sasha!

On Tue, Nov 03, 2026 at 11:39:17AM -0500, Sasha Levin wrote:
> regex_escape() returns (char *)-ENOMEM when the buffer is too small, but
> matches_log_fs_extra() checks the returned pointer with "< 0", which is
> never true, and goes on with a bogus cursor. On 32-bit architectures gcc
> also warns about the cast of the pointer in the error return:
> 
>   fs_test.c:7474:24: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> Compare against (char *)-ENOMEM instead.
> 
> The size left after the escaped path also subtracts the prefix a second
> time, which can make a long path fail with -E2BIG. Compute it from the
> cursor instead.
> 
> Fixes: 316d06b01130 ("selftests/landlock: Add audit tests for filesystem")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
> -m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
> KernelCI's 32-bit arm builds show the same warnings. The changed files
> build without them now, and the x86_64 builds don't change.
> 
>  tools/testing/selftests/landlock/fs_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index f725882fa4a78..27a78434d1c21 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -7470,10 +7470,10 @@ static int matches_log_fs_extra(struct __test_metadata *const _metadata,
>  	log_match_cursor = regex_escape(absolute_path, log_match_cursor,
>  					log_match_remaining);
>  	free(absolute_path);
> -	if (log_match_cursor < 0)
> -		return (long long)log_match_cursor;
> +	if (log_match_cursor == (char *)-ENOMEM)
> +		return -ENOMEM;
>  
> -	log_match_remaining -= log_match_cursor - log_match;
> +	log_match_remaining = sizeof(log_match) - (log_match_cursor - log_match);
>  	chunk_len = snprintf(log_match_cursor, log_match_remaining,
>  			     "\" dev=\"[^\"]\\+\" ino=[0-9]\\+%s$",
>  			     extra ?: "");
> -- 
> 2.53.0
> 

Thanks for the contribution!  I also stumbled across this one when I
did a wider cleanup, and at the time I came to the conclusion that it
would be wiser to fix the weird way in which regex_escape() reports
errors.

https://lore.kernel.org/all/20261008142604.39107-20-gnoack3000@gmail.com/

Does that seem reasonable to you?

If you are looking into Landlock selftests, you might want to have a
look at that patch set, it already fixes a wide range of issues.

–Günther

P.S.: Mickaël, gentle nudge!  I would still appreciate a review on the
      selftest cleanup patch set, even though I know that I need to
      start rebasing it soon to make it apply cleanly.
