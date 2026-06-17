Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD16286D60
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781664301; cv=none; b=Q16JBV2Gx1X+ofna4wxz0992tSoLgjGQ2O9o0b+TZVQAtt2HfxTiHnYOIr0EhguDdc/tExS2HVElzwSUtjmecene1Xl42sNJzGWZx+H0GiYR8CPkPy++67k/F3qfv1nMMlEP6VPDREvUVqtJ0iyJnDu8JD7fzle9ARcNB1KRPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781664301; c=relaxed/simple;
	bh=V5Lj0a8nSmlkBIMP6eQIAf74fBET5cZyYPV0CAI0UIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfFwCbTHnnxaxSUsDEAQOlZZYTZpOwxlexmTW6wdStUyx4YIOYXUV2K5/kEwsnwVibD45fdwe7SrgDGPLqBlQNxdWaPtR/UtKhHAmPMEX7bnoiP6QkQplYYuHSueAhu0rHnmw8aYZFWzGKUVtTm/kbGoDSwEEdmuOtlvExpZVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=CGrNHpc0; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="CGrNHpc0"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69e8a8608d7so3137392eaf.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781664298; x=1782269098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+ij2DnbBH9qYHL3SbwUU73OxRWd82W4gvllOMbdGj8=;
        b=CGrNHpc09mV92OTUvFYs8OUNtlaVCkJZr1dIMDF/ob7wEtsm0KkuJG4HNzNu1EN1GW
         LRo3OU+qAYTl5uErF7sxhVapWWk1t1/6xp2+2O9rtKyukkzQd+mlIDWz2fT+mViL2/mQ
         BBBwJOzS18F+1N6PJeyIIktfLCHJUMq2miDFCKq8YgMY363zpFBfzBpOL2lW2zclVuba
         5zGy8Rdv5xH1fKV32Vx01lpeRXvsRwfo05GRuh8Yy2P+5/yV1GbVEk8Ho2fObpzHjgZZ
         eGWRLZe9pscnEFrxReUKwj27t1Q5n+JXRmkZ9tYRewIFQZwBbDMxMeJX6UczT4JDz9JI
         4shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781664298; x=1782269098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+ij2DnbBH9qYHL3SbwUU73OxRWd82W4gvllOMbdGj8=;
        b=dLWf69y/K1ZqnPjiwnyNpiDxtwTYQu+GrxR8r9ir1AZ5E/upChJ/TBbJ8KyT4JPphq
         ugWs0FKx19NCzM25+qtfHY9ZW2gPIkNWMV5Ssv3YSWjPbbXeJy6LYvg2xXH0LGyC+10I
         yTYV+ZJf4/DSVdbDTbruaxQXrOT2qj3TI/wCQbUAXW5FEwdGkk98sVUsgrl2HtvY2LUH
         RoWhOWDN7HQJlLYhNp75abQY1iEmiJJWADBWNuRI7yR5t+9QzlzlcSCjWvj+ONo+d6RI
         8TU6qa6233S5blVHUQdjC89RDUQdep1+feB/5q7xlt5qSSi0CddDfEZjg1DcTFAufDRm
         Rheg==
X-Forwarded-Encrypted: i=1; AFNElJ8PBAeRrQ/IVOCExMNB6xznG+HlJurn8ofrSd/eh3y+Lv4gbvJA6bSdI0ac9XMJscBv1fAlSs8fMFNob/lSyHI551LZqNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3ZmAXkX7/8TiYLdsqe76QQQQInADx5sIrJd/T70hH/cT686t
	bb/A42zWijvRJxyenfQzIT/kVyzFBTRH1/gvQBfkmRDpQyxVb1RoFyLM4P0aqGKibFY=
X-Gm-Gg: Acq92OFJyufMycYfKindQbAIHXZCleVlB9qJrQBOZleaWrQOsIM2doI6qtVklrH3EmE
	l5X+WRcnkPAcZqQgdB0pAtK14NTLjkM9VA4hQN7bOA1Ll0ea3/z7Nu+U9B7iFpBNm81ywQxEM9v
	dvA+o2bKh8AyTG478Dk4hMU+Bo8HkbADUpDDAj0nh9ZxV4xi8WUzkmtrDru38oz9oQRHwvoUgZa
	H3b5nWic8olEZTc2AKlsyeROoHz7Ry2+Rn3nURiIJG0c0NGlJJoNdUWtCp6wEYcTlamfH3AWkzE
	lA20KmhM3JixQK/dqI+w7Yk6U+or33zSKQ1Z2qlHZwUdlkYSr7F2zSd5uUC8znmroiNo1FeOfU/
	vhxym2TtOFYnP7vRiWNFT+WfsgpyxamuMUqdaWpdQzJotoG04ketzvv0HXgWHrs8yqLYaMArsmT
	JyICR3GXPao4cJHUB3RE6eFYONYBmPplTbDKYRZYZq6woG8k+DIKIshr+CatQ0eYrZXxdN1g8=
X-Received: by 2002:a05:6820:220c:b0:69d:82e6:69d8 with SMTP id 006d021491bc7-6a0b624b4a3mr1347275eaf.52.1781664298162;
        Tue, 16 Jun 2026 19:44:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00ce1f67sm6138199eaf.2.2026.06.16.19.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 19:44:57 -0700 (PDT)
Message-ID: <209b76b4-e028-4af7-bdcb-b5813fef32fc@kernel.dk>
Date: Tue, 16 Jun 2026 20:44:55 -0600
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
 <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
 <20260617022541.328550-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260617022541.328550-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 8:25 PM, Bryam Vargas wrote:
> Thanks Jens ? noted, the fix belongs in Landlock. Micka?l has the full
> report.

Indeed - and hence no need to bother anyone else with it by blasting it
wide. I've already explained this multiple times, but on the private
security list, when the occasional AI report comes in on things like
this. Hence why it's a bit tiring to see the same stuff come across,
once again.

For the landlock folks, I'd suggest taking a look at what hooks already
exists (and existed, when landlock was merged) for selinux etc, that'd
be a really good hint on the existing surface covered.

-- 
Jens Axboe
