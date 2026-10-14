Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103F41B8F1
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954826; cv=none; b=k0etCbnWE659kp039ggbhFD5RiTK+oP6wHuhSqFi23C+lTG9NxSO8UTx9Ovzkql0uN5Xjb44/R2JCaSUNEp5IANiGLLlof7nPCmCCRiYS2weZB2a8hf004l1Ea8xAKgGe1dZHmec6dVSa+YQ16AE/iWuZ3b4JVPisEY5WFsQX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954826; c=relaxed/simple;
	bh=n7UQH2dAB6e7eCUTrqRrbBz4vi+fqy9kbHXf2oy+oxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L63jbLxY+dmsymDZhPGSGY+26PqEyWzDjHJKlFPb+SyZ2ary15id7krccTD9ucvUotZJ6hoDHXk9PrEu8W6MUJn7X5PMwU42920tB3eIrjsU22IXYlqkRL4X3NY+a9tiaFwAC7XPOdwXZ1lRBTRh96pMlMYdka+Vym/Fue4GC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COF4KTh0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COF4KTh0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48af27fe287so81587f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954823; x=1792559623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A6eKNCXYVr5WLXmMwH40qQ+TRWBdLnu+ATms5IRKfPU=;
        b=COF4KTh0QFNnsgOWChRemx5BxnOZmm9w83wVE2mgw4KIXBjNVnPBpYaBMplLBJLUAz
         gzbAOXZWGm47RFT5nbtOoeCIQqreDyg7Ndy64yNGHi5RkAZXdciVmMYd1Rlq6znDISHz
         +yTT2TL1ejtdlrvChuR8qr5OerCs4C++05orvYmZLNLkHCHVkPwinx2y5UgluMWIabbg
         YVYERDshXTMY2uP9jnYiqSvUDpQLDhZPYVJfm2TKZdHZTRaK8V9XlJdShGvi3ti0W3Th
         0PZPTxbJIycX2Z4dyGAcqJLuUcqcZT+YNscv+sM/6+un0B3qi8Pc2G+ypNe40S3I9vzs
         jpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954823; x=1792559623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A6eKNCXYVr5WLXmMwH40qQ+TRWBdLnu+ATms5IRKfPU=;
        b=napbh5NYqeShynVF+1t3FDLL0uc53wd27IZNRNnBH8pV3nIn2LD4dXqaQUsyLJhrka
         S6S959vkJ+YQEmTlQq8BSJaBlhwmmGRgyAUtonAytJPF3/HF8FDNImqplDab0WppuNka
         wMB/JuCh4BP1xhyMyKY9sJiHIUzRhYmpPvH6A0adAVUbWPfHhqaXDeCFLghc5iXs10Tq
         Z3Sg4/9vzi6eHGpSKOijoTn5thKPQF09m4vQOniodr869ilx3mNjIuWJDvS5Uf2ycM6k
         6jRWNKP3U68h84eSmBgecuNfiWNu4O/0N94rETHm8cJ6K0ydtR7yMlo/Ib4+JE3UsgS4
         E4AQ==
X-Forwarded-Encrypted: i=1; AKwUvBySwFtixSt1geOKx8d/OvyvP+R7nBH0bNgSnyeRp47U60LE28D+JnrRpatokCsg+KtcmcMQRXX0zQ3pYiR/jaJn8WhNjFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX2+mBVJanOnBXrZTZ6C/y4Mxr0vEyvdwCpN+pI/EzxIYqXlIW
	lOZMUJuCkrzQVVc6fAkzUTnXka06gL8sCLJJP30xm6rGkCESBE+ervy7yXrJn3wO
X-Gm-Gg: AYBFou3j42dJdpfEOMbDf0uH+Tm75EAU6hoBYowIGYlqCs+bRl90TZkIkTKigxqchfy
	EZB4B8nWReIFVpRfqXwGO6BrdzXyXYA7ChRWbkorX3a3HSTxKe4h3KyZoSV58VZA/EuTeEwUVfa
	CfM8Uj0MgOaOpQ0Ie+afgMLgThXVvZedFzyPSbVqVdXyAxOBvpIr0ER9C0AxUMZCuIv6MpJHUR8
	KQ241XirEQzjm6Nx+SMNl3LNK8JaRNv68ovedkiENqnWpDiALqJD9P25yVmS1sq2stGolL3YTv+
	/WH+qqetEZuRbWgQOpT2yoQFZSTFxdCi2vfZaDocJ/Gs8ZD+0EfwPoGauQb5g16eZ5qVzMF2ekb
	e+roKLqidnR0oAB20W3NztWgN4AGNNqj/DN8IDsLdBHM6Ld0bYg8uptWax8Otkb5JWwdVNP4TGf
	vOA6g8N/G38jx/8sxRBap2N/THoI98UpUp4VmUqylRKkUcKcgyxwzcnht1vYO0FRF4FLSMcYNLs
	8iW0a9fICFpWLsJcSi0Uk0=
X-Received: by 2002:a05:6000:288a:b0:488:8568:bb02 with SMTP id ffacd0b85a97d-48dba9e6727mr26830117f8f.23.1791954823039;
        Tue, 13 Oct 2026 22:13:43 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaad1sm9155942f8f.17.2026.10.13.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:42 -0700 (PDT)
Date: Wed, 14 Oct 2026 07:13:36 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
	linux-security-module@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: add msk_is_mptcp() helper
Message-ID: <20261014.8253317f0919@gnoack.org>
References: <cover.1791873760.git.tanggeliang@kylinos.cn>
 <1b21558a40905ae312d2ac987de4db0a04db3c02.1791873760.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b21558a40905ae312d2ac987de4db0a04db3c02.1791873760.git.tanggeliang@kylinos.cn>

On Tue, Oct 13, 2026 at 02:56:46PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Introduce msk_is_mptcp() to check whether a socket is an MPTCP socket
> (IPPROTO_MPTCP on SOCK_STREAM), modeled after sk_is_tcp(). Unlike
> sk_is_mptcp() which tests a subflow socket, this helper takes an
> MPTCP parent socket directly.
> 
> The naming follows the convention of rsk_is_mptcp() to distinguish it
> from sk_is_mptcp(). This helper will be used in net/core/sock_map.c
> alongside sk_is_tcp() to add MPTCP support for BPF sockmap, and in
> other places where MPTCP parent socket type checking is needed.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 30f0e8ba88a8..8943d9f2b48b 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct request_sock *req)
>  	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
>  }
>  
> +static inline bool msk_is_mptcp(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_MPTCP;
> +}
> +
>  void mptcp_space(const struct sock *ssk, int *space, int *full_space);
>  bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  		       unsigned int *size, struct mptcp_out_options *opts);
> @@ -261,6 +268,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
>  	return false;
>  }
>  
> +static inline bool msk_is_mptcp(const struct sock *sk)
> +{
> +	return false;
> +}
> +
>  static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  				     unsigned int *size,
>  				     struct mptcp_out_options *opts)
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thank you Geliang!  This is exactly the helper we'd need for the
Landlock MPTCP patch as well, and I'll happily rebase my patch set on
that and use this more central helper!

(Landlock is currently a bit bottlenecked on code reviews, so that
review is moving a bit slower, but we'll get to it.)

–Günther
