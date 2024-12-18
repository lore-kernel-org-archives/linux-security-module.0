Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E191DDC2A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562723; cv=none; b=iaxGIRCKzGqs/Fz6x/iXPhzG6wMhEP2uilIa1A28vClXyVjP6GEcwcqKEO4X0d4Dk28qFWYpRDh848Z5/PXGZgU2d9fGf9fPcqAwjhsI9nONXgT+aFV992fmWoRfhtjAmuHp1EJxxd2MyBzKwFayup6IZ6MCRDnuoTFf9HGQMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562723; c=relaxed/simple;
	bh=7zTRh9WChwHznVT2uyjcq3GuYdGzsRQW4jp4lj2yhoM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=u3jwpHbRHhxYSKdXFbhLxquc1F+cf9JRQqe+9TU7Xep54S2cpRzritf5yqHCABoKEuA7l8VT+GgJBiFOIgaUJo5g5CEAWgjcRgmcIg3crVRBKoN8geIOBz8zT/b3zQkd6HJ13iqinPXJKW2MPq2kQ64rqSxMTePA9XsXoeTrdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ReoBgrEC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ReoBgrEC"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f0afda3fso11903385a.2
        for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734562720; x=1735167520; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgmnWXJMlIfgKvaYXpKZGEl1Rqe9wYgXYNdDsllL8W8=;
        b=ReoBgrECpIIwW3IW5T39vcSqTUy3Ouomb9KjKPuHr8589NpUtE6KUEOXov+PVlG26F
         lcfNIqIHjvTCKum/Q4i7asnXZCW107s7qhwIE39YHHqfKqvKjKHZeuO8NzM94cYhaSt9
         pMQO5nErPXXGY5OurC38iA7laLeAKcp24ZJ8FAT3I31e9hQSMKdXrXCNvXPj9oZkbJiT
         4M0sQPmjQqHtpdw/kPV4mBf8hKZkqIzBQ94jlWckpQ6Fd9Lu+wJTBkFZs3luofDSdOki
         GrQgSYz6+3YINSe/U7q+UXtttBTRga61gjjkPdTvWZ1lwAdfsgknkSxfF0OcoaxJZyLY
         2zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734562720; x=1735167520;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TgmnWXJMlIfgKvaYXpKZGEl1Rqe9wYgXYNdDsllL8W8=;
        b=AD0uKTkAeB1l0ZKGBdWd/byjdyB85jSZS9XauV5bwfsIrfvZU5N1BFY2DWWC6ZiFY4
         0snPUxZDUr0sE8aBbVtubA4Kymm0v60UCx42wmSPiATCJIQJWSi9T8p4WC8bfqtHyzbc
         NBdRIJ5wdr6jEuaT1IYPbKpAcpBvFLoINBVx+Lnax3bFAbBFoOZIWKMG0WX/qiHPCCNJ
         eEunU8mnj5OOG8FcBjLT1bCl+cLALyOYDoT3PHwssFXGsA6VDfOEd7zNXc+O3sIEyGoa
         Q2VhrI5RVLTjw9nXFcly2LhNTGdwrdkeU9nH8vyJBRb1GO8LNdDbxSwZxjgsO/OsN/VN
         01dw==
X-Forwarded-Encrypted: i=1; AJvYcCXziE73j0YoX5AnsDFy/pkZ2PoDw0+JEzFwOYsxRmBFaqWHxOKUkIPh+Mw9BDvqHfyAIDI3+zVH+5PbgHiFe8POqRfYg4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkvMmx49SHjhqTvyfJDRzb/7g85gluSApOADXrjvJczKJ10lB
	7e6hyNHC8fMXxqZeu3ONRJtcqPlB8mpftTj2wm6chtzB10XUIvGFypLn5USKng==
X-Gm-Gg: ASbGnct+13YweTM2E8W401mNbCwfJt5GQ2ggEZ+D+uWuPi0m7i7W03bOLB+QrCMOslT
	U1/iMNqP+8txvKerfYti4SRKQcU0BirGwXMNVc8EL77Bw+spPyA6Otruut8x9F2zGRdAoy7lE8h
	m1oq8Ql0NSXM2+uo016gj4Vou7U4PDCVp/QYIpkl/TMnnpcI1pUPwPYsFktS0NVtmZz2dSawguc
	IN9kAM4JNww3ngf1SLzsV5yzcqkqw3ihnixrTRvUo7dXcm8Jvg=
X-Google-Smtp-Source: AGHT+IHPbF4Xrxru8NoOlx4rDsgwQu8glHU2FYFB/VqEysgk4esuQAY4ypS+RgD2BO0l18yW1s7X/w==
X-Received: by 2002:a05:620a:1a24:b0:7b6:d8aa:7ef9 with SMTP id af79cd13be357-7b8637550e8mr814324785a.32.1734562720134;
        Wed, 18 Dec 2024 14:58:40 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc1d4sm5379085a.9.2024.12.18.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 14:58:39 -0800 (PST)
Date: Wed, 18 Dec 2024 17:58:39 -0500
Message-ID: <d3606724c102694b06da8f8135212ec7@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241218_1749/pstg-lib:20241217_2346/pstg-pwork:20241218_1749
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, LSM List <linux-security-module@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Karol Przybylski <karprzy7@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] net: corrections for security_secid_to_secctx returns
References: <a5ac15fc-440e-4483-825a-2d6f08083af3@schaufler-ca.com>
In-Reply-To: <a5ac15fc-440e-4483-825a-2d6f08083af3@schaufler-ca.com>

On Dec 10, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> security_secid_to_secctx() returns the size of the new context,
> whereas previous versions provided that via a pointer parameter.
> Correct the type of the value returned in nfqnl_get_sk_secctx()
> and the check for error in netlbl_unlhsh_add().
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  net/netfilter/nfnetlink_queue.c   | 8 ++++----
>  net/netlabel/netlabel_unlabeled.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

This should also have a fixes tag for 2d470c778120 ("lsm: replace context+len
with lsm_context"), what do you think?

> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index 5110f29b2f40..6ae6cdc5fa5b 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -470,9 +470,9 @@ static int nfqnl_put_sk_classid(struct sk_buff *skb, struct sock *sk)
>  	return 0;
>  }
>  
> -static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsm_context *ctx)
> +static int nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsm_context *ctx)
>  {
> -	u32 seclen = 0;
> +	int seclen = 0;
>  #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
>  
>  	if (!skb || !sk_fullsock(skb->sk))
> @@ -568,7 +568,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	const struct nfnl_ct_hook *nfnl_ct;
>  	bool csum_verify;
>  	struct lsm_context ctx;
> -	u32 seclen = 0;
> +	int seclen = 0;
>  	ktime_t tstamp;
>  
>  	size = nlmsg_total_size(sizeof(struct nfgenmsg))
> @@ -782,7 +782,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	if (nfqnl_put_sk_classid(skb, entskb->sk) < 0)
>  		goto nla_put_failure;
>  
> -	if (seclen && nla_put(skb, NFQA_SECCTX, ctx.len, ctx.context))
> +	if (seclen > 0 && nla_put(skb, NFQA_SECCTX, ctx.len, ctx.context))
>  		goto nla_put_failure;
>  
>  	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)

In addition to the changes above, I think we should also have some
protection logic when we first call nfqnl_get_sk_secctx() and then
use the return value to calculate the nla's size.  Untested snippet
below:

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index d2773ce9b585..3abc132e7223 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -643,6 +643,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 
        if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
                seclen = nfqnl_get_sk_secctx(entskb, &secdata);
+               if (seclen < 0)
+                       return NULL;
                if (seclen)
                        size += nla_total_size(seclen);
        }

--
paul-moore.com
