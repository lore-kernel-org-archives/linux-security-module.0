Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87196BA50;
	Tue, 25 Mar 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931349; cv=none; b=r4Gm3A6swrZpg0O0e4Es08xcoq1S4PldKz5phiHtM5x5dKtgQ3JRcKcGjQpBfIm7WsPWvMjD0DfyO3a/5pa14ixpbZW+jKeuB4gHN/j94Z3ZtftEta7F3ZwWO6imnLaA11XYu4vrOGcWUygFx1DRaZs0U4NHq6uQHHLz9c1QmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931349; c=relaxed/simple;
	bh=GQ1usWDY/9UJHM3rPLJhK3PbcVc8D/tocEAt9WKi4i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPzkNYwW+aJuLccJQYz+qE64tOvNWIV1xHACB4GZvRB93bbpm5czwcyMUqGvA4OjnLhY+3uYJV0nWueq1OX/brHECVMpsVPrr0Cd8wFR5g7nBqHtP2lWXPxKVuIB+hwx+TRc2sxQJ6OlqnaQz0l/WmhgCaG3+lkK6enrMku8es8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKryXs5+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKryXs5+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso55784885e9.2;
        Tue, 25 Mar 2025 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931346; x=1743536146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=grP25x16Wo7Fb4WipDbMu3jz9s4iEFrXl9o03iMXH6Q=;
        b=jKryXs5+gxYgzmq9Y4ElM3e4dfbgxa3u4QCMZAc1xt4CUKkvHCf4fI099vVUzjUA/r
         yHx4w6WTAVWz9Tv6/j9C9ksiBPHql9h/4TuCyit4jNvsdGojDA5xNx7h1wm1nUWk5mmN
         taKlySfXhUzGcNJSNv7nPm+gwDBnqm0opEBnV1WUx78mkNIf6A54xRFiOy0faQ5h+7nG
         w0x+BJrln5LDvZwoLloFv509U3X+XS3OmTHtuebT49xDU4mfiLRqo8idKZ4znYp/FUfJ
         tdtBX3I/bkij9DJT6R9r9HnZngiCrb/lx7L5nPPkAWF+ohleFzpSEOoZhMm0dA1/xUtI
         ACsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931346; x=1743536146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grP25x16Wo7Fb4WipDbMu3jz9s4iEFrXl9o03iMXH6Q=;
        b=U6hdHclnX5zZBmvr3bwAMWXBg8UICs0x6ueoAORQNuZfNgjnySzhfYhTPRbKLTT8Dl
         XNd+zPW0Sxa9NO47zfOQ/c00t0RhTH1jGkh71t4nOnmCOtOG9fCCIfs1bw0MR8SF4CGi
         tiCGwSF+owFEnYNzusMJePbp4iYGczAnhVjzXvgTAACxlL6BRikLyALbinq0H9VV0ws5
         5fBXx7oDQWqbkG2vJ82Yq0SPZyDt/8RjXxAUHBiz6GV+L6EM2bncC2qULG1lA/acD1Dg
         R8uadUiPW/WgHlwGTQdEI4qQqopkiF8s5rzZdlFnL3PJ3fKIvNfHo+jDPP7/5BAiUeV+
         CeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAGrSc/EA5Owh7WwL/Ya0eYciEWpWMCbOHcCt80Y6fFrpVvg8oh1hM+0yxqRDe/h6YIkClGMNM/zVGoSJCqK5iiNqlMLRx@vger.kernel.org, AJvYcCUuiZJ3miKZt+3cid0AJO/kCi5I+6WVDTQwn5yV6MR6slyH+AjV61fhs/o6467uTCaydBKFFUHCfd2f8/kS@vger.kernel.org, AJvYcCVuYmJlH+sFWWbotQTaD9SGX+boMD2oHdNdvLLnj6oAOUxlObSVm8UWHC7oHlXiJiWR0IgS+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQknC4x0Nhz9Y1ttMPFzv/JKWzNsgCZ8Zb5NX5NlzXLZ1LEwcD
	B1dbbRXRSn4ZxoEw+HYfOeEP0f9IEAJG5SaqpIa0AscqoDlVE/SJ
X-Gm-Gg: ASbGncvVd4qbWA0DhxsYMIKlOD0JAmn5P3rT6Z/OLNmDusnzmY9P0IPHyK6hlIAFsgY
	5f0XgB2mGHUtfUVEO++bUoTf0K06iTp/YaFT+ORLp9mKO3DKtxYafQQCj+JyKjvtQ7U7QGqj4mG
	q5s8SVn447IKGTxwB6FsSefiegirX0rroDx1dV1JbG6NlnDO8/L3X4sLRsl3bmpi4k817SwTmv0
	OYcHkYFdsj2Zi6hYlibBcRI+FHikg3itk1X0ig9buGa/e7wPQvdJlFAGPXnWMghoonXpNCFX256
	9x0wJk4cqEDhLCQiiT5ymzZfx5dIDyS1G6ikxoeiVQ35uTL2fQBQFRqkoTECYtc1SNhno4c=
X-Google-Smtp-Source: AGHT+IGFskIGDs/TGx5glreuMOfmCRl15OlzDlLN6YqYkZAEgIdWGB3N8EyqUjMnpcrTDfnZD8yA0Q==
X-Received: by 2002:a5d:5f8c:0:b0:390:e7c1:59c4 with SMTP id ffacd0b85a97d-3997f90123cmr17136626f8f.13.1742931345512;
        Tue, 25 Mar 2025 12:35:45 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd9f058sm159064355e9.28.2025.03.25.12.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:35:45 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:35:43 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>, Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 01/28] lsm: Add audit_log_lsm_data() helper
Message-ID: <20250325.3932dbc7b476@gnoack.org>
References: <20250320190717.2287696-1-mic@digikod.net>
 <20250320190717.2287696-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320190717.2287696-2-mic@digikod.net>

On Thu, Mar 20, 2025 at 08:06:50PM +0100, Mickaël Salaün wrote:
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 52db886dbba8..a61c7ebdb6a7 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -431,6 +425,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>  	} /* switch (a->type) */
>  }
>  
> +/**
> + * dump_common_audit_data - helper to dump common audit data
> + * @ab : the audit buffer
> + * @a : common audit data
> + */

I was tempted to remark on the unusual documentation style with the
extra space before the colon, but I see that it has prior art in the
same file...

> +static void dump_common_audit_data(struct audit_buffer *ab,
> +				   const struct common_audit_data *a)
> +{
> +	char comm[sizeof(current->comm)];
> +
> +	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
> +	audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +	audit_log_lsm_data(ab, a);
> +}
> +
>  /**
>   * common_lsm_audit - generic LSM auditing function
>   * @a:  auxiliary audit data
> -- 
> 2.49.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

