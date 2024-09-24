Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354519C568
	for <linux-security-module@vger.kernel.org>; Tue, 24 Sep 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174618; cv=none; b=bdGXSsTzQCjb4NEmg99j6l8NRsKki5skxMnXOj4GQo9AK5sWlocdqUQ0v5XkcI+ZMXq6/NxNWJiBVDiTxG7aYUnnhH3NHsDwyie/TgOqswXnLbB13B1lY37LkG/IlqENeE8MybZJLk8s6LXy9Rp0GB4WpaWh4FNwXyhcTbeTw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174618; c=relaxed/simple;
	bh=pS0OnUnMHt3x+dQfCCd9DYG82rNOAah6rAoIW93soDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgAsdiQ0Gg0eemp/yeolk7cnmxY7yssLyBu/BhdG8H+VNPdG1CGLDKxw4Wio8ND7lMkf+blGh16A7liQE0qaCTbhZj5m0MWo48BxxtezoR2GAtcbjyPhZVjK9SXCY0p2mXlNYkEcUGHk7y85AP22sHHJgIn3isytLD1aPvJSz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUHEyvQT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUHEyvQT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727174615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNkidy8tP2V0t8BDHsPRxDHfoz+Gz1VvYutaJSQeq0A=;
	b=iUHEyvQTk/yDm5C+DISNvP6D61b/pv75EjnEWfLa/1FN7KAZX4MdCk1d71JqSFgMkwsQL/
	rH0tBdUjLvw9FBKJ+1xcqa+8M+N3pXWAmsT0cU0nf/1o1fVsp1h5GLYFbng3qKUxm/Kx1C
	xveS9ieW0nzcvz355ZQece42A5WKiKc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-j6gxG7_YNi2Ke0G7KZg-wg-1; Tue, 24 Sep 2024 06:43:33 -0400
X-MC-Unique: j6gxG7_YNi2Ke0G7KZg-wg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bfc57e2aso2787607f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 24 Sep 2024 03:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727174612; x=1727779412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNkidy8tP2V0t8BDHsPRxDHfoz+Gz1VvYutaJSQeq0A=;
        b=vVcLlXPFOBq9zJ1MygPNqAYXTUS7zbJRgsbY3pWtFQFb8wG6W8oxEXxeXT2zeoMZXl
         0vLZXDuVIo+dVrJ9psBXXeUpMMjwqf0zaEC/Pzcu23iDC+Pu/fSvc3D5re6TgahzuMxb
         veHDljXeMnrw0I4ZPerGfqvtDiv73FLBDsUDY/b6gM4+fKmsfvZ7L+0nzmxJasM8UM4y
         1QClGzmEbjuOUkUxNNXmAqVO/cdv/8JyA2f2wKtaJVMtAbO6UEs17/nNlEoHqRHW3yg3
         gKOQcjtxLQr7tpPIdvuPiBSa0F0AadJXLTz37jkW/znKwASf9SwZyXpS0pX0J/Esi2h9
         0xKg==
X-Forwarded-Encrypted: i=1; AJvYcCVDEJC/E5G/k3G79My5KODGgUahtzPxo4H37wpQyrIlggmLYi97K08sWiy8MUzXJ6LpjZcFL7N+UQaz3RwiwU3KB9JTyhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXynnuj24qlRtDaGh0t6NuJlNisnGRIJvCNoanA/UKKisdpVQ
	QcYVUvjiMft3UHR/WdShrCIlYkpwHxr9haca6GcghjpRukMdN8+bRxKR1PQPEs4hMTkjeidZh5p
	9h5SlGEKhAnuBX/A0WoSLnNUbIpdIPLiWowTGcN2ywebSt5xekMumBH4+R9xICj1XgMd+M5Zr1A
	==
X-Received: by 2002:a5d:58e2:0:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37a42354020mr8608148f8f.43.1727174612669;
        Tue, 24 Sep 2024 03:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0dKgHWPlUM08f7dDvngustiUt9pe6+/LWynepDnxeXHhHsyb0kH/Zt/TQc3YFg2cXenoicg==
X-Received: by 2002:a5d:58e2:0:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37a42354020mr8608130f8f.43.1727174612216;
        Tue, 24 Sep 2024 03:43:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8c37sm1230316f8f.23.2024.09.24.03.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 03:43:31 -0700 (PDT)
Message-ID: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
Date: Tue, 24 Sep 2024 12:43:30 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] netlabel: Add missing comment to struct field
To: George Guo <dongtai.guo@linux.dev>, paul@paul-moore.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
References: <20240923080733.2914087-1-dongtai.guo@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240923080733.2914087-1-dongtai.guo@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 10:07, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> add a comment to doi_remove in struct netlbl_calipso_ops.
> 
> Flagged by ./scripts/kernel-doc -none.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

## Form letter - net-next-closed

The merge window for v6.12 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

