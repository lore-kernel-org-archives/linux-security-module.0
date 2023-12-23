Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E81D52D
	for <linux-security-module@vger.kernel.org>; Sat, 23 Dec 2023 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fdde8b58so359390839f.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 Dec 2023 15:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703373442; x=1703978242;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUZpK4dHEqnEesO3MJLqD1Yf+ic5Z6+dFQBYzrg0joE=;
        b=DzAIa/nO3YuzJJC5cCOMbZksY9XWFwTtMBW3LPybYmEY3LBSLFocqhlCyM9TTrUVTk
         06WT2qPyDDAAomLBEzeJ0FTAQukbGBbBomUBJSvlRbo41YjI3kUVcLcUKtS4UG0vWYJ6
         zGYvti2s1fjbK/OdmJk7MtNVznTFZF0NDVzCOQ3JsFYUHEB6unbWflabmMn6nLASzXTK
         OHnSfFVrN5aJn9ABmHXoX0dyGmskX145bqoFx62xPQEL6HUaEsCJF+av09SLJVZV3bck
         ZQ2Gc4CElDVL1kHKnAWSmgzlT4IfFN6rexUOr+vKSothWFRlTXtNTOvq+THKYWU6QbBA
         Q5xg==
X-Gm-Message-State: AOJu0YycQureSucSJcxwBkiNYTFqQ3Oj0ZlBS5yItABjD8m6fCWpOCQu
	Vzbl4z+1+3WppQwg96sXP5CLv0Ird50BgiOKdHNEwr3xT5rF
X-Google-Smtp-Source: AGHT+IHXWjhzq5UX73UJ2Svrl/Lqi/8ZJ7ThNCsst+jNgaqcVzGKDEiQwZy6MgHE5E7M3QOiHQEDc7a4HbTzfF7igPd97frRll+/
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:35f:ebc7:6065 with SMTP id
 j10-20020a056e02218a00b0035febc76065mr240526ila.1.1703373442281; Sat, 23 Dec
 2023 15:17:22 -0800 (PST)
Date: Sat, 23 Dec 2023 15:17:22 -0800
In-Reply-To: <2591733.1703373433@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f27a0d060d358835@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From: syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
To: dhowells@redhat.com
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index 2a6d363763a2..f18ca02aa95a 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
>  static int
>  dns_resolver_preparse(struct key_preparsed_payload *prep)
>  {
> -	const struct dns_server_list_v1_header *v1;
> -	const struct dns_payload_header *bin;
>  	struct user_key_payload *upayload;
>  	unsigned long derrno;
>  	int ret;
> @@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  		return -EINVAL;
>  
>  	if (data[0] == 0) {
> +		const struct dns_server_list_v1_header *v1;
> +
>  		/* It may be a server list. */
> -		if (datalen <= sizeof(*bin))
> +		if (datalen <= sizeof(*v1))
>  			return -EINVAL;
>  
> -		bin = (const struct dns_payload_header *)data;
> -		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
> -		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
> +		v1 = (const struct dns_server_list_v1_header *)data;
> +		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
> +		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
>  			pr_warn_ratelimited(
>  				"dns_resolver: Unsupported content type (%u)\n",
> -				bin->content);
> +				v1->hdr.content);
>  			return -EINVAL;
>  		}
>  
> -		if (bin->version != 1) {
> +		if (v1->hdr.version != 1) {
>  			pr_warn_ratelimited(
>  				"dns_resolver: Unsupported server list version (%u)\n",
> -				bin->version);
> +				v1->hdr.version);
>  			return -EINVAL;
>  		}
>  
> -		v1 = (const struct dns_server_list_v1_header *)bin;
>  		if ((v1->status != DNS_LOOKUP_GOOD &&
>  		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
>  			if (prep->expiry == TIME64_MAX)
>
