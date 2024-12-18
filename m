Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9E158D6A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516000; cv=none; b=Ey9gzA7HZWRUvGrbtFDVoQdcpGzR0pVvnl37Mnqs2rNMQbcS2oWwuDt5aiVYTGUAd3cjfxNtpjwYwG9JhDQomRnyETkhPKjNtouSCy28154ZLCTq8rcO9UMT/jkH2JAA7qkCM+sMry6au9azGNNgsSoJxBBOnVAfWNjt4yzU4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516000; c=relaxed/simple;
	bh=NfNuGTG6GaQJoL86rxCIM9miYsmabLasE31fv9sh4AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZD3fWvP8RchnEvP9l/+v/pnc8pC7Pq8bFnAC+MKSrw71cFjWYOxHxj1qQUnHN/qjZYFSSgWT7tA914xmfrJfQWsFH0Xlt8dKslsEHzFGDay+K9zYfwceuHyTajb8I8J4yhdfJ7xQSDszQR28quWqzyUmWSyMdVTUYFRB+8v5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hBi5Zlzo; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hBi5Zlzo"
Message-ID: <92368a18-b340-4fec-b392-d68880efd219@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734515985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMhv48KETjm5fGzTwJkLLEIlBXzSQrFF51Ky9Ra6Tm4=;
	b=hBi5ZlzoNg3byX/j8q15ckXumHe7tcFAgpDMWbUdv9T0gFXHElKeOLvX9ErVHEne+IaCe4
	oa5hT7cPShegM39O2sWfAf5QKpk+hvCKUZe3ntpOcx9nnzWJitF3muYAJdRyy0tT4PmGsg
	RLNGtkMAoGWy1ESLn+djIkEPJP4HwlA=
Date: Wed, 18 Dec 2024 17:59:37 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] docs/zh_CN: Add security index Chinese translation
To: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>, alexs@kernel.org,
 corbet@lwn.net
Cc: dzm91@hust.edu.cn, mic@digikod.net, gnoack@google.com,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
References: <cover.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
 <89ad67b4b4e12a52581cfa0f87f194e1aee3e526.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <89ad67b4b4e12a52581cfa0f87f194e1aee3e526.1734414723.git.zhaoyuehui@cqsoftware.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/12/17 14:46, Yuehui Zhao 写道:
> Translate .../security/index.rst into Chinese.
>
> Signed-off-by: Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
>   .../translations/zh_CN/security/index.rst     | 33 +++++++++++++++++++
>   .../translations/zh_CN/subsystem-apis.rst     |  2 +-
>   2 files changed, 34 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/security/index.rst
>
> diff --git a/Documentation/translations/zh_CN/security/index.rst b/Documentation/translations/zh_CN/security/index.rst
> new file mode 100644
> index 000000000000..6b56b4f87315
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/security/index.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/security/index.rst
> +
> +:翻译:
> +
> + 赵岳辉 Yuehui Zhao <zhaoyuehui@cqsoftware.com.cn>
> +
> +========
> +安全文档
> +========
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +TODOLIST:
> +* credentials
> +* snp-tdx-threat-model
> +* IMA-templates
> +* keys/index
> +* lsm
> +* lsm-development
> +* sak
> +* SCTP
> +* self-protection
> +* siphash
> +* tpm/index
> +* digsig
> +* landlock
> +* secrets/index
> +* ipe
> diff --git a/Documentation/translations/zh_CN/subsystem-apis.rst b/Documentation/translations/zh_CN/subsystem-apis.rst
> index 47780bb0772f..8b646c1010be 100644
> --- a/Documentation/translations/zh_CN/subsystem-apis.rst
> +++ b/Documentation/translations/zh_CN/subsystem-apis.rst
> @@ -88,6 +88,7 @@ TODOList:
>      cpu-freq/index
>      iio/index
>      virt/index
> +   security/index
>      PCI/index
>      peci/index
>   
> @@ -102,7 +103,6 @@ TODOList:
>   * watchdog/index
>   * hwmon/index
>   * accel/index
> -* security/index
>   * crypto/index
>   * bpf/index
>   * usb/index

