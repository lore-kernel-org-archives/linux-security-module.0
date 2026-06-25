Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D23DEAC4
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390687; cv=none; b=cuafr33nlua12Lfu+2Y1iA7fb8DSWJvXqYbNVfR8S/WXnWvHnMcYpoqSOqeQlmoKUTSiJH263aAUbGCdfw0lBOyPNXHMR+5LFvdOttjM1EvDMdnPT1rT8+AMb3IcrWw21SBvlmDKPWSGEbP8oChp3MDPftInN82+91a8VkC1Xsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390687; c=relaxed/simple;
	bh=Oit0TcphEo5M+bMP77TWtYW3k4a7F2pKJuE4t0E9+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbkjvtcuEuZt6CmLgRPTdIBO1py5BKknt+BMB2kEM60YcGqCNOMCFWiA7fZTpZW5zLOI9ASvLKKp8tonXXHRPlpFdRyHKXf8xF4YqOOJC1nZcLCTilZ5rYrgFnHJRMyUXT2xU8peWrRGA795OmGjmGwknkL+9XApbVYh4TAKgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUzLEjyY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUzLEjyY"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46e22950091so304121f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782390684; x=1782995484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b1vSJuU58s7WyIhPZgYamD1ZPuUhi34Xe2P8nm5CBMI=;
        b=gUzLEjyYAcjnxVmA3Cfs5tMvMZb+nzUwzlBRrPBgpfBWOkcIKiQejRsbz5cmmkqEpT
         LEj8SBO4zOo+Oy63AI3fFHQlhUVVcXMXS4WtynSDigDc79aA+ohJbtikHfTD+COp1+Ad
         w201qJx3g80NyrvZ3NefeKCfqr4UE74OXZsG1Y8kTD275BL4Uie5EmHUcnoTa8eD+i4S
         jfZRIUtkUM1lw6PVn1+gEuH/v1wmL3ti49PUqROoFz7F/WQSYtPgfbP+Ft2eRf73IJ8Y
         ax5Rfz54S47tblNqoAvEhgtNfGEgTbLr9onpHgs7Wgo5OicQJKK2w91cepe5LAeblk0h
         202w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782390684; x=1782995484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1vSJuU58s7WyIhPZgYamD1ZPuUhi34Xe2P8nm5CBMI=;
        b=rKSjDTTRzG/PMK3lGyrPUOUMtuAz321tawPLzXtfnjltV5LiolpvvtqLmibrOR2S/s
         o9GLoJBdqv2KdUYWmR1fL7qPd+GN+q2VBCBSFCi7XaqqX3IKl45JBw600/lAeKPaRq6X
         8PQ/aA4w7fguW4xDM9VFD1ujJBBG0LKmN+03w+LBWOmb+xYAHCAYR1ZU+SfWjFQJFl+1
         YbZymNWo4FtP18dIfc5oMG+8Q472+GU8g97tRMkqcbw+JGGKyqO3h+UYOsM+/9OAHfJK
         gXnMfXBycprrCkecf+sNT+pSJZY6sIE8JoB6EQ9CdVDdyMLsCFNhkp/EOmh6qLqHTbky
         7Cuw==
X-Forwarded-Encrypted: i=1; AHgh+RoFS+oMpUQK7ghE7x/A5bVIABE+DAcWj48xCnI4EHcC8a/HBS/QoPRybvl9Ct0spkVzJbkflpt4zqTR/SwHS0j9ZotGX3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4lNPkTIEs3HDQvwHpoRXaBMiKpzExtdE4q4FmR0SYZuQ3bW9
	jQY1LFAKDbR1hpKwcvjlujrJY852TCHm+7BQv07FKFg7oTTBiq5YAF8qMZVWEB5yQA==
X-Gm-Gg: AfdE7cmYJtPshuJcKDoJStSfDLXQNKa2kpv/+gORNZ1gbdUYlT+4W5amYSeOwJMNLiC
	OM0sFex7jxbgOx5r5JljnsATtDEk/neqZL8Pr0phTgNFfbV2OTQKMCxeDAeHKPhFOEoI6ZLuwjf
	xbyrJ794i6CYY5B0rGGeGpssCOWcIBtjl9Ww95CTTavV2AloPQ3C5DCu7X+Fw7wjyzrppVW5sRJ
	Q3x6HXb07e/4jHTuP0io1gyh17LYrNfJwjcbe7qNiSFz36NQV5k1HGnnuf67SkLFM5mJqz697G5
	llPbit1C0hD+q307bG/zjO5z3y64v/1srMPwCWlL0iPx87fIjywb8LGxT0mjYAUYbLwTVOf39y1
	oU1nn/bx3I7il+l9Kf0kNAEP7I5uB5aEQsIa1HAXJFtFV4KV8Wh4I5s/2eI05X3EMDkbkeAwJfJ
	oSi5FqvfQht8yJhvUApKZfSSFyYj2wfcucnTfZ4OZ7MEU=
X-Received: by 2002:a05:6000:24c8:b0:468:f382:b7af with SMTP id ffacd0b85a97d-46dbbecf652mr3506082f8f.0.1782390683630;
        Thu, 25 Jun 2026 05:31:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:7a30:b9c4:b9c7:bc90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1b754471sm15140848f8f.0.2026.06.25.05.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:31:22 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:31:17 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: landlock: Document fs.resolve_unix audit
 blocker
Message-ID: <aj0fldJZ2dl0gas1@google.com>
References: <20260625092819.1870049-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625092819.1870049-1-doehyunbaek@gmail.com>

On Thu, Jun 25, 2026 at 09:28:19AM +0000, Doehyun Baek wrote:
> The Landlock audit code can emit fs.resolve_unix as a filesystem blocker
> for pathname UNIX socket resolution denials, but the admin guide's blockers
> list did not mention it.
> 
> Add the missing blocker name and ABI version to keep the audit
> documentation in sync with the emitted records.
> 
> Fixes: ae97330d1bd6 ("landlock: Control pathname UNIX domain socket resolution by path")
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
> ---
>  Documentation/admin-guide/LSM/landlock.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
> index 314052bbeb0a..8eb85c9381ff 100644
> --- a/Documentation/admin-guide/LSM/landlock.rst
> +++ b/Documentation/admin-guide/LSM/landlock.rst
> @@ -52,6 +52,7 @@ AUDIT_LANDLOCK_ACCESS
>          - fs.refer (ABI 2+)
>          - fs.truncate (ABI 3+)
>          - fs.ioctl_dev (ABI 5+)
> +        - fs.resolve_unix (ABI 9+)
>  
>      **net.*** - Network access rights (ABI 4+):
>          - net.bind_tcp - TCP port binding was denied
> 
> base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
> -- 
> 2.43.0
> 

Thanks, good catch!

Reviewed-by: Günther Noack <gnoack@google.com>
