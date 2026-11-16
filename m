Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789955;
	b=q1Qjy4F7rVwMHwFjRn8q0MbY1AtQgAxg6yzvXe7TB4gtye5m3aA998CqHqNCRIHnh2lo
	 rNZST50uxt402wQ6OkU4AZH+cOijoOwUZu3Rf+hifflYDT7PBLPs/mKhQIUspd2GElRCN
	 nUgyXmIH4pwavXe13cMsMMFlRYQIIg9KzMsWmmjeexCZvcOq8YtSvBe+AY5NpIWmVtIFN
	 tnOO+b5DFuiDuh3znxkMCdlaebDj+albQXPfkZbz5gsexrwDGm3n659RuEew8Tn1wpI7R
	 5jpxMkOeo2gnT5YKbL8fbPaVCFOU3veDbukR9KMP6p88dB5Sab3mergvyh2FU/0xwyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789955;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1lqpfWmFNO+IPzDZOTeSkeocT8IzMciOLZoXlngybMo=;
	b=yT4OjwXcHLTl88mMI9D9nlbmf8Xl3T3vChZR3x7RUBPOeANnsdOfGaGswdCHxSqsi5RI
	 lJ4La1Jl+2/dBUPatwJeB1qjquJ8OogK7aqjTpg26c1Dd4t3uiUxpfmIIbstb8AdDPlxn
	 KCAWuR321a91MsIJiI6xoNuD3WVMfMjjyk3xEGsKjKShxQH6e9RRKK186G6fN1lwtMRrF
	 mJzSC3E1a7mBLWgAvXxwDz40aF1/PMUwoTkH/0vdiTLq11BYfmgsHZUXZrBeBHx1DYDT2
	 BcaMHT71uxQrqHxPmH106LUAsRS80y+II06wxhnM1CgJw86a3SPMu0PHP0/wRVxolfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	dkim=pass header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=iI3JyNFL;
	arc=none smtp.remote-ip=91.218.175.55
Received: from mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB2606A323
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EB2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=iI3JyNFL
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5+X2NsETxlOuobpMC6dt7hnhS7nmMASohV8S69odI28=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794789951; v=1; x=1795394751;
 b=iI3JyNFLgDeuZf+huBFw4lkUQmz22e4t8E0FXuMA12qHc2HN7/64cJgZyOFhwoYRx/4rlQB+
 eFxPQoJuB1oJRPPLsmCjebCFOmcjf500SVQ4dgHbqzSJiZ8KePFX17KfS5KW22WehMIh/AJQhGA
 N/JksgVOgeHN59vQDdrFcs1zrqyVH/IKyCDvb59Q0Rot/eP888k/PHIfBnaPH9rYUmfnaNumRKk
 VpVd08RDCO98ycwoaARfTuX55JPEL1cJEuKRmTu4o7WkqTXCxW5/97OqB7HCZFiy74VO9JCfABC
 /OmyCLg6hEjgh4+gba9ijmZ/6LyK3480TQL8HP3tp2amg==
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 37c433cf24952b21;
	Mon, 16 Nov 2026 00:45:51 +0000
X-Mizu-Trace-ID: 37c433cf24952b21
X-Migadu-Flow: FLOW_OUT
Date: Mon, 16 Nov 2026 08:45:41 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Yan Zhu <zhuyan2015@qq.com>
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net,
	dzm91@hust.edu.cn, skhan@linuxfoundation.org, gnoack@google.com,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/10] docs/zh_CN: add LSM admin-guide Chinese translation
Message-ID: <avpSNfL7FCDVyTK4@wyuan.org>
References: <tencent_5E314704B7770A972FCB82AC81BB91A39307@qq.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5E314704B7770A972FCB82AC81BB91A39307@qq.com>

On Sun, Nov 15, 2026 at 11:19:56PM +0800, Yan Zhu wrote:
> This patch series adds the Chinese translation for the Linux Security Module
> (LSM) admin-guide documentation, including the main index and all ten
> sub-pages: apparmor, LoadPin, SELinux, Smack, tomoyo, Yama, SafeSetID,
> ipe, and landlock.  The admin-guide toctree is also updated to list the
> newly translated LSM/index.
> 
> The original English documentation was restructured into reStructuredText
> by Kees Cook in commit 504f231cda56 ("doc: ReSTify and split LSM.txt"),
> and each sub-page has been kept up-to-date with subsequent mainline changes.
> 
> base: https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git docs-next
> 
> Yan Zhu (10):
>   docs/zh_CN: add LSM/index Chinese translation
>   docs/zh_CN: add LSM/apparmor Chinese translation
>   docs/zh_CN: add LSM/LoadPin Chinese translation
>   docs/zh_CN: add LSM/SELinux Chinese translation
>   docs/zh_CN: add LSM/Smack Chinese translation
>   docs/zh_CN: add LSM/tomoyo Chinese translation
>   docs/zh_CN: add LSM/Yama Chinese translation
>   docs/zh_CN: add LSM/SafeSetID Chinese translation
>   docs/zh_CN: add LSM/ipe Chinese translation
>   docs/zh_CN: add LSM/landlock Chinese translation

They are still confusingly threaded, and you forgot to name them v2. ;)
But anyway..

By the way, the 'Assisted-by' trailer is no longer needed, but the
disclosure is very much appreciated.

Thanks.
