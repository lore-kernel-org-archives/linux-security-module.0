Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8B412267
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983117; cv=none; b=rDges1AZxpM/7ilqNuaA2M+BNm5zm3sleAU8NoSk2ALI3t99Mk2Ud9E0gNmLc92+k0Pwr5yE+svgdja2bNS9R+v63XVlvhFHf3bYC+Ovn81eeMl4J4yinKv7fGsMXV88yFFvBaSEedHBQF8qFcr3iJm1S8NV/DUuWZhtkqpYQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983117; c=relaxed/simple;
	bh=1wX+Oc7KLHnXLghNaOjRIzBWrebHuANifYCxyiNRkYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSdUb0u2kQa41cH0mou40ayIgc3jJfBuU+66fe10dW6v0CypZkmg74/tegvoQPbEP42fy1Q48dvOt0+d2Jf7kgsh2gPqBMFm2/cSkamrFjnGefvahbCXBVy24QikcinV4sDfcm7LUToB1HRIJNqIY32LmqKW6m/GNVIBjWs192M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U7C+FvIH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7C+FvIH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493be1b9564so11476205e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782983113; x=1783587913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hmuUhY+/SyHoulYX74aD4uP5B6Iz9sPzf0IAjdpyq8w=;
        b=U7C+FvIHhc/DNBsoKgCXnLRmJVoc31wWQCHHW67Rs23rPeYT1t6PM3tNMjTChc7qj8
         ArAb0uZnVzUENoxzpNExlGab5QSNQNX6FkfSy0p6kzBRItmJiaob2DiaFtaDFA8N1mKi
         DReWg6MuOiB3u2tvH6SDwafZmrUDw249+WOAy63KLJBFH/9V47w5eHQHO/iq5k2iHZh0
         BUd+NwvTPEfo9YF7U5AjKTLEnngv7fknoPUa7HBu0MKsQ3ObFyBa8XEfUQ48dUxgmtIL
         qoG5w+FykhVUye2d6gSrXLGBRrgaUp/rPEltWmShwJRYx1ueW79EIuL7BhDaTa4xsBX1
         9F7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983113; x=1783587913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmuUhY+/SyHoulYX74aD4uP5B6Iz9sPzf0IAjdpyq8w=;
        b=Ko2SJRYr0WFHV2b3ynLKbqlD3A2TBW6nrBz8lmpMmnBbxyTna9+dk5U8oG6MB14FHu
         hxlNiMLQ3tc1cfVeumDchfbNlheo/3xtMqgeP07pV0Vh/eBXZiaL5eIpbHRNzX65Imz0
         PDuMPF+BgQSqM8IHY/3QVNJwZcKCKHz3Tr/0O1bhIQWQ1rlaWApqi0QUnaqc9Yy568t0
         FSFVOTSSkqep0CMwDsF+z6gc/Bb+Gde7zRhds5XPpguI8wUh57qcNKaPj9DcoDmR1TPd
         K2XqEzBEUzpZ0AWUoc/xMc2U5RDRybdAcDXm2OH/FImxUuK5S/FS3+ibp9NwlJTa9N+L
         veUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YZUiSJH1vgtJVAIm1AQ4maiRmQnmqU/+2H9CNu9EymTwAFObJULK6oJQEBs+4npE2OP8CP1jFd3aH+UWUNs6Cv4JF8cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvwNkIINXE8Ah+E60TCqmdTfI3Yvs6gSv8wI7rfjsUmu88ejN
	jbS/vjeJfSyXneUDQ+dzQILJudFx5sT9XMY8AU4z/SFjkR9eVfGxgAtmcz+cX2wkP+czs2CEYw/
	5opXR434J
X-Gm-Gg: AfdE7cl7fTnsU2Hy/WcAnGgzwsh2psDBTxdnnZoDZm9+2gchwP80k+ztZywmL/2F9Qz
	7jHlIB8A16oDI8ZSaZnC72MaVRry6jvERLFX9mgjMgGhwKc4NF/8UYcNj73iQMnokcnrvu9zEYM
	vczboJ8HdAqcoPPjiXSrLvkbX89LkTVMF0+b3FOU0EXiTgejNbVlJO3xkr595IJz2pWYYTpqGha
	OZMLSgbgkOypl47dHcV8QDxv9ZXtQ2gNml/DpefN2vs0+hfkK3ae2EhCqj7aV56PuhZn070GXza
	QN4sG80xiqTNttDBbtzI7l/VZaMBuqHZB4ArhhaUMPMxMPTV/9PnOFNpsc0HYfu/FIIL/IuqmyQ
	BasJh7S84apYOT9nXO+wW/0vD50SfPMW13mrmxAMTzKROwPQ9MD6TfrB0u0RFzo+NEFVq395gCK
	Z0v75NcdY/USoyEM5S1D72AnzNF3ORijio/8ilSnVikETcgmKDcsnX
X-Received: by 2002:a05:600c:4e4c:b0:493:a909:8c71 with SMTP id 5b1f17b1804b1-493c3cd58a7mr58223075e9.7.1782983112525;
        Thu, 02 Jul 2026 02:05:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:9765:f926:b0c:82f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cb59sm7450027f8f.18.2026.07.02.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:05:11 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:05:06 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Wang Yan <wangyan01@kylinos.cn>
Cc: mic@digikod.net, shuah@kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/landlock: fix spelling error in fs_test
 comment
Message-ID: <akYpwjtjm4iuKv5Z@google.com>
References: <20260702015823.368529-1-wangyan01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702015823.368529-1-wangyan01@kylinos.cn>

On Thu, Jul 02, 2026 at 09:58:23AM +0800, Wang Yan wrote:
> Fix typo "allowes" -> "allows" in Landlock filesystem test comment.
> 
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 86e08aa6e0a7..e672089e9329 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -6927,7 +6927,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
>  		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
>  	}
>  
> -	/* Only allowes access to the merge hierarchy. */
> +	/* Only allows access to the merge hierarchy. */
>  	enforce_fs(_metadata, ACCESS_RW, layer5_merge_only);
>  
>  	/* Checks new accesses on lower layer. */
> -- 
> 2.25.1
> 

Reviewed-by: Günther Noack <gnoack@google.com>
