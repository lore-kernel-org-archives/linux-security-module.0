Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154919;
	b=JXVcO9PwlksKdO6gq3cn10SdWbcX26pXtpl3KW+MpRyKeSWRlaiI17ME90g7fQkN2QXm
	 0BWY10LJFhkQ+oW6S2lDyx5svg7poeYNWnT8eiFxrQi7GOmbw+hYAG0aZeUJfqiV4xp7L
	 WSNHC0INuIiPHtZ4z+/00z/XoJY3hAenRG8Y7MqsJbjnqhJxMuxnd0Iw6paL0S46k/0IH
	 +jaMDYKIceU/8Iw5tYtE68SRg+k8OksBS8bDz9lQHWT3g8tIusOGpzjykqrakPjovyunJ
	 jFRBj3cFdL4/42HEqY+392xLkLNZIY58B9B8V0PM1B05be25n8XMp273VB0/aLMxpgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=NqiEvNJc2p38Ujj7TawQCPTCe9qdBp/ccFJptwABHsY=;
	b=Z/N+qD1WzPR4MLuU4tx8/8C15jdp7z26emn25B6K+OXl+MrmAvwD8pc0W2+B8dgZEdhC
	 BOb/LDkPtueuT240t03m6arxNxasfNpexHkXVjlFofDk2K/PGLgNyr8n9D4WY3CT2bUpK
	 7jeZ1JDTmMIS8dDWB6rcyW6LaFV2sYQMymUbveajudpz4bT+0/ogLnULis9pcyIejtnkK
	 15TcjyX1yK0Vacfc/qIB/3xU6YA98XBgG83cb8KHq9J4TEoZ8WA9bNtEUe6ojvutB8BBa
	 5FGLCm/SilxMxHiO54KLCRZ/lfAqwFm4Xbud1Wy4oHGWYHbcqEc7CpoFjDJX7lFwTYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByZKqEY2;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F1606A31C
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 16:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD0F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByZKqEY2
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so1052895e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154917; x=1794759717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NqiEvNJc2p38Ujj7TawQCPTCe9qdBp/ccFJptwABHsY=;
        b=ByZKqEY2fqDhKWoL3BQKBZjth+x/iOlR20ruT+hrURNxCRwqYtsum7eZaEhd63rm50
         +GHBf5keyZIJ8BcMAlMHs7ZqsCdBnHF5w6cKrAqTxfqgHcqd5LZUhSdc/J/1gf4lqQaX
         5UsxhwT0VO/ynoe2i+sWqm9U+7By9WCmpaY0Lox+wkZPKASr25srJMuEjQHsG6shkRoX
         zhsnz6GCHInxjthTYMvu7UTKBmUrrtFOAyIO9PXkdTuZBmhEsZGDOJ3mKNTIsAygQd5g
         Tjq/dCJww5DtLMaK56lq+wtOcBNcgqgy63lXfEQXZnFZTlaw3naDMUuP1VQzT8d77Qf2
         yBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154917; x=1794759717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NqiEvNJc2p38Ujj7TawQCPTCe9qdBp/ccFJptwABHsY=;
        b=AjrlQSs91QBR56XnEThlDAbv4YeMWVcmlrXVonSap9WTShrPhA+Dy7BxBtJFiVWR7y
         /6SIDls6pd/6g4rmf6seJTPxVO0AfBOzMKhT9IPBE0su5GnhPUE/V1p9EnPursDvGyae
         7qegsXECMU7XxnN8hj9JRArBocvcREKpR0p0GpynfiCCP9ro6cajcxTJnG1y1cvC+PUd
         SoMVPOvUz0hJTrSYdEMbqA25NLP1tEZX0cebggKpek6pHU2XLdHzy+rHKZ+IrkZc24rF
         DRrfpXCi6yBM/G/hVE5/cqYp8h4dDbwjFJHC9CMZoSZZDYvfGzeE9EPKoLka3J/ORj5E
         xCfg==
X-Forwarded-Encrypted: i=1; AL+hErERMI8h7op4Qqj+pqku+7fp4tvodxBgfTdkcrO9r30ONUWmA2ZmPEE9rQ7WPFMbixxo59dO5n8E36trbNoYko++EutX0NA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hEZbjQi3ZaWEQIC7s/UAhx1HBIxbEm9O3V46NjWSSVzKl9vlt
	RJnUavGyBNRChU5K67KrfqfT6XQgUgX3G4PXbg14DmNSyH5HnCj6PZWl
X-Gm-Gg: AYBFou0dWqphKxqGsMF78bPyDwWkMrOc4Bi28p3uUGykpCtf2f0dx4+f/iWKPPK7l27
	8Fhrf1K+m4S83lXB6aD14ycmYERajttysYhPZJuTnbavQoBR7bM0U2vHFPVnT2Od11YOOzuf3nd
	gGp3LruDLCUbnhB7hwfcpzBfmEL8Uvn6F1ymgDPSHwogzPW4pRLwvPwQEnmzzWshWI5nrX5Mkol
	JjcTwrphdbxixkgOq77xavoETIdRQb27iqLKWFshtexVeXFYXNxihe92Mg3YThrg/GUyi+mvOkc
	QRaRKynHJJbJ4BdHwOv2r63OT0mgxD2T4KtdzxtpLxEy46o4XwcYHmnchxHre7/Q4yd13kjwkL7
	L61N6WvonmQj6F3MZTZQVaH6iNzv1Ghy8FB9X26BEndPMM6NkWSiOslz8Fy7yt8U7096tn/IC+z
	UJSuykETrTAcoOSD0XCr212pcjpFhbaXX6tnNd4w0WgSt2EsM1WMqQVuY0QA4DuxukwakRdEpyp
	pf60bcaPK5sUzeLdkKvI4uWpNJuEKrvRURLq4lkPgmgOu58RGVZmsKsfvMPL+1zrgwmHF2eEu5x
	lXTIUL9WDME45msHUB3RCwU/n3TjHLEcdmHSTbwsLIRdc2HHdsJC
X-Received: by 2002:a05:600c:3f16:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4b9633cee64mr34051605e9.18.1794154917053;
        Sun, 08 Nov 2026 08:21:57 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7d54d6f93sm272669515e9.0.2026.11.08.08.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:21:56 -0800 (PST)
Date: Sun, 8 Nov 2026 17:21:51 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Shi Lecun <shilc2025@mail.sustech.edu.cn>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	gnoack@google.com, Fengwei Zhang <zhangfw@sustech.edu.cn>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: landlock: clarify F_SETOWN signal scoping
Message-ID: <20261108.5b4268b47da6@gnoack.org>
References: <20261107.2f1fa9977739@gnoack.org>
 <4C69C1457B12AD80+20261108055048.3745750-1-shilc2025@mail.sustech.edu.cn>
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
In-Reply-To: <4C69C1457B12AD80+20261108055048.3745750-1-shilc2025@mail.sustech.edu.cn>

On Sun, Nov 08, 2026 at 01:50:48PM +0800, Shi Lecun wrote:
> The signal scope check for asynchronous I/O notifications uses the
> Landlock domain saved when fcntl(F_SETOWN) configures the recipient.
> Adding LANDLOCK_SCOPE_SIGNAL later therefore does not retroactively
> restrict these pre-existing registrations.
> 
> Document this boundary in the IPC scoping section and link to the fcntl
> documentation for I/O availability signaling.
> 
> Link: https://lore.kernel.org/linux-security-module/20261107.2f1fa9977739@gnoack.org/
> Suggested-by: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Shi Lecun <shilc2025@mail.sustech.edu.cn>
> ---
>  Documentation/userspace-api/landlock.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 3d45b956b640..cc9c5b102b8d 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -499,6 +499,10 @@ The operations which can be scoped are:
>      This limits the sending of signals to target processes which run within the
>      same or a nested Landlock domain.
>  
> +    For signaling of I/O availability (:manpage:`F_GETSIG(2const)`), Landlock
> +    checks are done with respect to the Landlock domain at the time of
> +    ``fcntl(F_SETOWN)``.
> +
>  ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
>      This limits the set of abstract :manpage:`unix(7)` sockets to which we can
>      :manpage:`connect(2)` to socket addresses which were created by a process in
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.56.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thanks, looks good!

–Günther
