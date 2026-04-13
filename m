Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD622D8DA3
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083812; cv=none; b=D8+imdJwcNu+0zlvV/D3gEFZnKLSXFve3lP5oQspwutdRxus1aIMbHJq2tsRiBG3gwMgSk5AkXBH/SsUaq7PqeT92wQAHZZ0cimZpcYteFt5DoJs/Ofc2r3tWpDhKe5vVTJutzcvTHopOkCeUuHxqYJwCLcKCLMiNXONFzHcfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083812; c=relaxed/simple;
	bh=fp1+rn6aQA4LS+GiaAbtBkjdODiYMnTeNpGGLuf5ygc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyN1boCsgUnMXSilrswi37TR6bPwViLVyGzKuBlnTeL/0RI4E3Ks/S/3gzN3i2xJC9numKTxCFyPnmDBtqDxwjy2MFzvzJQi//s7mNdwV2UfZLlMgZQKYzL27QiOjNUvfID2zEgd6zGOkeD+sTsNORU6PbwZpUFi7H7EQ+Ql474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJSehsK4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJSehsK4"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so2634429f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776083810; x=1776688610; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cTT+ZJ72+mgm/l6USIuxnml/G2zeNke4eYNdS7r+Wkc=;
        b=wJSehsK4GvxGi9L+HUSwrGR4Aa0mh0R33HHavhF9vw9ndVW2IiAj3BbSEnOGQpdyeL
         SQ98HAalaP1Xmj64BLs0Zzea3/uWdxvV6wqhA42cQsQkWElh4gbVtZMDEmD/tGveir8A
         qmG7Znv3s3zhkF51QmhByvP3Kwe/dijvBoA97oRxnDp9McD7o0D3o7iKbrMjVh6yUY4N
         WQXjiOKmZ7TMSHpUIsPgLQ+KYjXHmd8kiaS9PFKY/jZ08Lz6rWQCG17BszTgxMCsm2hE
         fw2fpyi+uhNn0VsPcet2mOjiacgMJWiUJHWXf2DtDKkFITKF54WlAVnlBGB0iDRCtNu0
         PERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083810; x=1776688610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTT+ZJ72+mgm/l6USIuxnml/G2zeNke4eYNdS7r+Wkc=;
        b=TUSFT/Hox2U8FMe10agcsydt3tVHCmHD6QProuYDBsY1G0Q5n6Vpizs1Rym0wCG2dX
         JpfKmcmsPhdC3mHz2snyItpk79jiVzkCqdlcpdWl6BZMqqU+vzpPRk0MBMMgHp0off9V
         AgQka7YA24K4b4NQ//mfUsONOhGeUFycCx0HC9NhSDNQqQX596mQz7Hwm8ckF0OlkKJi
         Rq97YdgpPfjJ7HkGxJxSqr49JT6BsON3IJDsGqzuJzR33tkzXNNqpDjpTAfL/Hhu8e0p
         Lqnc5g//SCQczNjA3IcSH/pQ0FpVBDob48SfgzY2sOYbadEidV9ISGLkKCcZKcBbO2DL
         2bCA==
X-Forwarded-Encrypted: i=1; AFNElJ9b8pZdMFoq32QZJm6e+ViI6ZsJwskzI/lPtk7EIl/0XOTYhqPrWxIjlVXHpl5pTt0DwTkbFjRUCzHABPVb1FlyGMtQJE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAx0FTt09BggkiQQ1B1eJ6aDSZCNWv2OmvEgxueTvIfnkUwb/
	j6h6hncup4D+izlT4ndvCFvx9FU9GEOsZ8tKRym85iWJHAb1IAnYcBtHUuVN1fW8vA==
X-Gm-Gg: AeBDieuHffz+DIjn6V4zylT0lYZnDfl7h/Sufz7/eM8ACd3/m3KqfQDtdyLiDB2pMj1
	WuZRLMciPisRqe+ODUWjhD9tUrvm+Z0vA7L85+52LJjs8zNX8AdeU5FsYJxuzjvUs53RGsnZosq
	VMmvr4PjZAWZ1fn1N5S3nZLxFl6TgKsMfHvNUSxQryABcqEmi17cWSUb5oxRL0oF6EO7UFvexMk
	4ECSq23gTtsL5KsPTYR8TjyncUfNVgWAejDtx7r3N5t/6tawKnV7knjPfNbxhEyXt1clJj6uQbV
	EE4PaBaZCFPcbPd9wq1uiyzyl1HNVBuKbMcZ5vWoSM585+U6qv0oBi9xlr0pzrnCpd+8bUvx+Qs
	x/o9anImmOHaRJTkTTyvO759OIvdzrADtaG8xp81bebgp+0KYFRrCKrlGYnb3W59o0EUT74Pngp
	9uuVi824uH/0DlqNSFyfuXtTTWZkXQ0+wKV/s/nypgdYB4M6zSLh6rRWD8s1t/qHe/
X-Received: by 2002:a05:6000:4387:b0:43d:7508:c9c1 with SMTP id ffacd0b85a97d-43d7508cd32mr8442973f8f.50.1776083809109;
        Mon, 13 Apr 2026 05:36:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:4828:e29f:fa0f:9dd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7a6054dfsm6643851f8f.17.2026.04.13.05.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:36:48 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:36:43 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Jeffrey Bencteux <jeff@bencteux.fr>
Cc: mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-security-module@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: Re: landlock: Add support for chmod and chown system calls families
Message-ID: <adzjW7t7kJjne6Ze@google.com>
References: <20260412095233.34306-1-jeff@bencteux.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412095233.34306-1-jeff@bencteux.fr>

Hello Jeffrey,

On Sun, Apr 12, 2026 at 11:50:39AM +0200, Jeffrey Bencteux wrote:
> This patch serie add support for chmod and chown system calls families
> in Landlock.
> 
> These system calls could be used when exploiting applications. Two new
> flags are added for struct landlock_ruleset_attr:
> 
> * LANDLOCK_ACCESS_FS_CHMOD
> * LANDLOCK_ACCESS_FS_CHOWN
> 
> Restriction is limited to files as the security.c hooks for both
> system calls seem to only applies to files. More digging is needed
> before being able to restrict calls to chmod and chown on directories.
> 
> It adds basic tests for both family operations, one for when it is
> allowed, one for when it is not.
> 
> First patch also fixes a bug I encountered when writing the tests.

Thanks for the initial patch!

Before you start your investigation completely from scratch,
did you see the prior work on this topic?

* https://github.com/landlock-lsm/linux/issues/11
* https://lore.kernel.org/all/20220822114701.26975-1-xiujianfeng@huawei.com/

That specific patchset was unfortunately abandoned at the time, but I
suspect that some of the discussion still applies for your patchset as
well?

In my understanding, it was in the end blocked on a LSM hook change.
(If this is needed, a common approach for doing that hook change is to
add it to the same patch series as one of the earliest commits.)

—Günther
