Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816393EBF37
	for <linux-security-module@vger.kernel.org>; Sun,  1 Feb 2026 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769948660; cv=none; b=ENAzDhjATCjjkWQo81pEIazaXnJpizyXKkRuAgdg58S9EKVIYO4womTtbaO2NS2FJhDtYyV7j8SBiUVm/z6YllR1/ehxwggvrcGH4rD+H1LhfWcS9DX6QCYOQWhdbih0r1JP1Q3y96uHXBwl29IVbeR/92OfjP+5LmQjtcybIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769948660; c=relaxed/simple;
	bh=0dxyezSBXxR2vBnV9Dai/FVyByCJ+Ox8+m2CKRMBdz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw/3BDYssdRnJtnY2WPwBG80xISEeTfS8z+dr9db9f/jKELydqKnY6B2Jqdg1eQ7tm7M6Z5OoYuKWwJgj9WEm7BYXsW1e2/GrHS3uOqA7MLzu/iJBiFUj7/u85LfDdcSVO+F1ydHlFUF7ty4B2S0HKIMPnpNYhmDwCz+wc4Dkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn6PzIj5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn6PzIj5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee0291921so32635395e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 01 Feb 2026 04:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769948657; x=1770553457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bJD0XqFmy7P1SfnwsXT1HXYdW8Zg7bJemx9Wf4O7QrE=;
        b=Tn6PzIj5GR0VJUeDfD1nhnY24r0/z3Ro54RNtUEFnGX8Bhidv0W/g31zcU6Qc0+iAK
         5K535jZ0XkOTUJMOWZiaAtZ+c9xTAosxDvdM8oNjdLmQ1Cy1TxERbX3kGrW8roZ5FfE/
         a/0vI+WjBkA3Ftc55sRGnhuIH8qrbvS/6Az0r0jpOmMU9itGdPiZxTKNJXwRjN7CFVTy
         8cA5+pRzBwZcRYqjBit/BtV8mbuzXjbe1DZ6mxcsOFNSFahCsCL/wpMNLGBUgDZD9grd
         64fVAQBYhao5rioeRo/Ek00+xld5+r/jdg2wYXCzMQD7dpSx4bJlWAnQ2I08on3UxcP/
         fEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769948657; x=1770553457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJD0XqFmy7P1SfnwsXT1HXYdW8Zg7bJemx9Wf4O7QrE=;
        b=NwGcDRABkYf3Ah8+cAfrjvt4+2wtnGn6LNqOQLHwm4RrCJL4MCpCmwhwsVYtxm7rZn
         HRlJhRpOYdfg7KIMZwHKBHS7SagTJxmAF3mq8F7/jL19XEAS7ujIvlfNIJPvVOZ/ka7Q
         4DiuQBeUcth7HLRQLeAah5m944XERcD02p5hbKu60iBml5kxBCAcoLyAqX/5h8PumGNv
         xn4+ych0jRyhMSjPRYx80U1O9qSwdcDXMmpv4o45D5MSSsV+Kd2s2eKircGbTlTQwGBq
         +1Q/u2JLy5apzMcycOUOjgY5jzDKuiVptqyTixG29inQW7wPP+AmsJFJ56HV1Y40EKZn
         QLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJC/JqZi7uYxJDTNLB0IsRshlJ2u4rT5Mj9Q0MTgFH5BLGkU56k91dMftARoYGdtWdEdeTywedK0rdz1oGv+a3HlW4ji4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYaTw4lNL5vs20+3dTgpSwob1ddSmzz9jzoo3sXy4jtHsmWs1g
	zB6RiRDcyXzpLdBKFagwkwjUEeDBqmdt1W4qvx1Kd2L4IvOdGYLk+AJK7QiR+Q==
X-Gm-Gg: AZuq6aKhRYWuIJMHgbqu8nfVFMWeO9Okh8HN1JzVVM3giGQOEimX+H9uxlsMo0TPZLQ
	Rxisx1AapLWqX5TyUNDHIkva2bCjbrkgvwllirwM3CX9Unqfugj42jlLfRZsL8OQOHRT8WZGTUG
	MtcE19yS0AgCF4JJf74GbTVlQF6SsRHeFObiNSnDlZQSSiJGxvd1RwWWj0LJrXBQg1af7MoDklF
	a5oUAf8tEDZ+qUHW2YW83u4zaGrcDhUhfhBTJBlFFTkpwyjYjZDfUV+xnbpdOzOuKJlYDa395XM
	ew2LVq91Q8lKWTLYSSoY7/RJ19wrNkfs5KKe/cozUc+dxUkiIPBckUXJgHUOYaMMG2AzFRV9TZq
	p115t0yXbirPrI6qgQFWZnxuY4fPNcYbaiWu8GG/Fci9/MBVynlfKYK3IjYeBomhviiysOKtlpL
	xzbt3cZyt/2A/haj1Srm8vh1o/ogzvixBAFXwr
X-Received: by 2002:a05:600c:5294:b0:480:1a9a:e571 with SMTP id 5b1f17b1804b1-482db4d77b9mr104503945e9.22.1769948656592;
        Sun, 01 Feb 2026 04:24:16 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bfb59asm368427655e9.7.2026.02.01.04.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 04:24:16 -0800 (PST)
Date: Sun, 1 Feb 2026 13:24:14 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: gnoack@google.com, mic@digikod.net,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] landlock: add backwards compatibility for
 restrict flags
Message-ID: <20260201.616f24966d36@gnoack.org>
References: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
 <20260128031814.2945394-2-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128031814.2945394-2-samasth.norway.ananda@oracle.com>

On Tue, Jan 27, 2026 at 07:18:10PM -0800, Samasth Norway Ananda wrote:
> Add backwards compatibility handling for the restrict flags introduced
> in ABI version 7. This is shown as a separate code block (similar to
> the ruleset_attr handling in the switch statement) because restrict flags
> are passed to landlock_restrict_self() rather than being part of the
> ruleset attributes.
> 
> Also fix misleading description of the /usr rule which incorrectly
> stated it "only allow[s] reading" when the code actually allows both
> reading and executing (LANDLOCK_ACCESS_FS_EXECUTE is included in
> allowed_access).
> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  Documentation/userspace-api/landlock.rst | 30 +++++++++++++++++-------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 1ed25af0499f..c8ef1392a0c7 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -157,11 +157,11 @@ This enables the creation of an inclusive ruleset that will contain our rules.
>      }
>  
>  We can now add a new rule to this ruleset thanks to the returned file
> -descriptor referring to this ruleset.  The rule will only allow reading the
> -file hierarchy ``/usr``.  Without another rule, write actions would then be
> -denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
> -``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with this file
> -descriptor.
> +descriptor referring to this ruleset.  The rule will allow reading and
> +executing the file hierarchy ``/usr``.  Without another rule, write actions
> +would then be denied by the ruleset.  To add ``/usr`` to the ruleset, we open
> +it with the ``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with
> +this file descriptor.
>  
>  .. code-block:: c
>  
> @@ -233,10 +233,24 @@ to effectively block sending UDP datagrams to arbitrary ports.
>          err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>                                  &net_port, 0);
>  
> +When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
> +similar backwards compatibility check is needed for the restrict flags
> +(see sys_landlock_restrict_self() documentation for available flags):
> +
> +.. code-block:: c
> +
> +    __u32 restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> +    if (abi < 7) {
> +        /* Clear logging flags unsupported before ABI 7. */
> +        restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
> +                            LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +                            LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> +    }
> +
>  The next step is to restrict the current thread from gaining more privileges
>  (e.g. through a SUID binary).  We now have a ruleset with the first rule
> -allowing read access to ``/usr`` while denying all other handled accesses for
> -the filesystem, and two more rules allowing DNS queries.
> +allowing read and execute access to ``/usr`` while denying all other handled
> +accesses for the filesystem, and two more rules allowing DNS queries.
>  
>  .. code-block:: c
>  
> @@ -250,7 +264,7 @@ The current thread is now ready to sandbox itself with the ruleset.
>  
>  .. code-block:: c
>  
> -    if (landlock_restrict_self(ruleset_fd, 0)) {
> +    if (landlock_restrict_self(ruleset_fd, restrict_flags)) {
>          perror("Failed to enforce ruleset");
>          close(ruleset_fd);
>          return 1;
> -- 
> 2.50.1
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thanks!
–Günther
