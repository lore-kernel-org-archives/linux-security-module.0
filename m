Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152041CFA9
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037331; cv=none; b=s7UMzglYHtM8tx2T4EidPH7b2jIP5jkd/zHYaiBFUB2jNLLXHi8D0P+wP0FdYaNj4a/88+/GydkQYyBMfHaIhN+HKv71BomY0H+5iGG+lzF1Hr5BlbBz8Xh3lGZoYCVxsJQ3mQ8HQ2w1T/8iyehxL/l/R7blqQvDp6GbiXfmNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037331; c=relaxed/simple;
	bh=LqQjNtAJzV/gp8gce32yqi56pdn76UnZ3HyAMC87ntA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy/oZ07oqldG61nRfj/qEyai5haEJPZ48LbqOMhmH4PRTS/OefaRDeeWrx1r6lmY332WKr3v2j+NkCnFNS2zhXqBtVuNHhD2Y079qtkBpCTep9PXAZ4JuE02fBo/WDWI4O6rldjoYfDjJ0FLMysJkvgSd1vF+0PRSvRtODHVQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uObex2rW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uObex2rW"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso55930451fa.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709037328; x=1709642128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqQjNtAJzV/gp8gce32yqi56pdn76UnZ3HyAMC87ntA=;
        b=uObex2rW201aM7ZqwwO9pCHCkJjgcAPFhwkT13/XIhNXSAHWuzgsLT8xGGpr/9hoXQ
         1olbPDn+1S/G51wV0NyeInwNDidQTYRFDXhgUDkfVg4gFP9e2EKgalJf0ZXd89coLv/R
         AgVDPvNp2qdNlNWe1MVMMrIt+APNxWG2MD/aVklw5Zr+WodZKhSdsT78XjWo3bgW8AaS
         0S8/Ia0l/iSYG6TCMiO+VPVPtbwlI+/pgOa/9T5trNSmAB0mbwc3hd/Dwg4hYrBbUUpj
         tZplOWaKLohoevIHsfENhBokSxi5g3YPOulbnpTtq0wfX5wNlJWfKiQ6l167Cjs/RRjm
         At0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037328; x=1709642128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqQjNtAJzV/gp8gce32yqi56pdn76UnZ3HyAMC87ntA=;
        b=WEwALZSgSmeFyRlSZfUzBzC/RxsJeFXTPlc+ObeI8sdSN71HuggD/1WaJqJ0rFNcgJ
         H7M5BPePKwu44vkXcgeuzIf9rROVFQYAjqWrpbdKlILrGnCEWSokUemLXeK/CEJqaCzC
         w+zdYVq8qcIwfQgZ3s8IXS/G/usJ5azVt87FmJRzUGJVOab9qAAxpPKK39fleruenR1X
         zETqAw0l4g1lC4ef4zl6neXRgyYxEz3gUmrNAbNWGODVKOW2xge8Rb6kIs6N+DrYxIwG
         qJQUaMcsT14dikIP2vAd/S27MkZxxrYPxl7AFQ82oT1O3fkGO2YAkf0lkTZ+QLeblSXg
         jbww==
X-Forwarded-Encrypted: i=1; AJvYcCX85JpzlEa5nizrKHamd1d++n8M3O75mSQgDJTWRTKHqMoTxnlQs6R6KbjT2DxR2UWyCIKKEvSg9HcY4+7Q/UY7R16Cs5I1gOlUx8qs/bS4zAdw5Mht
X-Gm-Message-State: AOJu0YyWAX1ysDwIP6WipeRXg+j56obzhxyNRrYzK3lnhZubvByUGKNR
	LdfbPlnLDj0lo2RXkiJIDTggWx/lVyFSU1+eol3kzFWtyMbx9cRlvWwg/nUVVT8=
X-Google-Smtp-Source: AGHT+IGtVbQM40FX1l0FwsCKabOK5Fl9BQdKbcv5HV0cfoBXNg6iZRnkx6VgegUeOQlFiKpghYbRFQ==
X-Received: by 2002:a2e:9ad4:0:b0:2d2:4160:bb6e with SMTP id p20-20020a2e9ad4000000b002d24160bb6emr6176296ljj.27.1709037328163;
        Tue, 27 Feb 2024 04:35:28 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9f52000000b002d0a98330b3sm1182269ljk.108.2024.02.27.04.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:35:27 -0800 (PST)
Date: Tue, 27 Feb 2024 13:35:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] netlabel: remove impossible return value in
 netlbl_bitmap_walk
Message-ID: <Zd3XDMRqN088oSQW@nanopsycho>
References: <20240227093604.3574241-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227093604.3574241-1-shaozhengchao@huawei.com>

Tue, Feb 27, 2024 at 10:36:04AM CET, shaozhengchao@huawei.com wrote:
>Since commit 446fda4f2682 ("[NetLabel]: CIPSOv4 engine"), *bitmap_walk
>function only returns -1. Nearly 18 years have passed, -2 scenes never
>come up, so there's no need to consider it.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
