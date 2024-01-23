Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46C6ADE
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jan 2024 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049619; cv=none; b=e8jmV5ghyCjupGPe+uGWAvhwXAOqoy1JnnbWhYsRQurO9Le50Xs00+8u2w3GpcqJ26JoNInTIsMBeKvEE7gHeydCKJYqWSm9IWe9xLivUEioWK5jZdO5xaPnhUSuWY9SZeiSJA7urL2BBASwNUMn9RKD1od7Nqqrqr13aB6p4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049619; c=relaxed/simple;
	bh=dDmiAyTd6I1WoQ1JHmDV+Aim3uCnxncV333lDUyp4KM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=DAsJNqpndmbt/zNmBsSu7D/FGzgSf1c+8WPLT6YztnOuE7O3je9QbPq5scGnQHeK4nnQgN+5UlzAAMGxspxyfIArG0ChXME3m/UpDqKuh/wm/EdXL1NBSAruiaTysBC1oggeWdiATPPhOEslvWCoKtV0ahprWgj0TGZUbVLKeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ejpJjxYP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ejpJjxYP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-58962bf3f89so735861a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jan 2024 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706049617; x=1706654417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uK4AqgzTPBnmXYr2iScowkm9axVe1AfckM6HmRvPGe8=;
        b=ejpJjxYPS88nedXdRnZ4fAoA4+A7Itj4vdNj863LG5jTJHBN47MlwbW1bYVYRkA+cS
         jxxtayRJ+1YmZ4NumPpFbvymix2b8ITEcJs6b3TO4uPTGPADe8b56MH/Np5oKU3UG7hi
         4vDDoIyKDmOQ0nQj+4Zyv5H5l9cVPwmWmlmxkPcTxMKMpcS3/7GDN5GRWa5qCA1Muis2
         /HxROM+P7dWBBE6J+CCenAfphCPEMd4Cc2rtdhWMRrzDZa40eyeRW4vSuPrpmtp7KuyR
         pHoxNkRGHlffin++9vQZox1ASri5qP0VscQlFECzAPMIOCwKynhFPngBWrSgZBV5Oikq
         qr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049617; x=1706654417;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uK4AqgzTPBnmXYr2iScowkm9axVe1AfckM6HmRvPGe8=;
        b=pygDpst0vLTNngB0qiI1diO2lMFmi+A9668al/S8gxg2jlwo8kaX3EhcLcS/333QSi
         uGv+MeePlme+JcMHkxxy8aHfkYL/dq5qaYFK2svA0DUZFH5YjYzvlGGdJgSxn74vOTOz
         wstaap9Zv/RbORfXor8cOH371VEfPt81ozTNsDgZkGSdUmNEyGgtrHxx69BASV1n8ths
         B54nkakb72dpsQgQ56i6e0AF5k28y4Y7/MMtK6n4833JDr1kzjvbC3ja2pXxKRsFKAz6
         Sh0OEIha5uUtibGh/Sjl3VGKlh5Q23U74fgiMhSy+N+F6nEkVb2QsSRNmRP8NjNyZWVq
         jSSw==
X-Gm-Message-State: AOJu0Yx6f8GnASLpBsHMgyB5fNuZqLZ3SM4nJaptfqExs/CXEDFgM8XV
	nOAEMv8SmvcnSfNui86v2HZSIIrps9k0N+I98asBj9wO/6QLRzsvh/87Ht1Y03o=
X-Google-Smtp-Source: AGHT+IEHrhNprAGub+wfj4V1kCK8kl1gmykQV7Hc5rqYq2gCCzlHqlLOCPh2W3ZGllBpORaFaqkJ5g==
X-Received: by 2002:a17:90a:88f:b0:290:239b:8f8e with SMTP id v15-20020a17090a088f00b00290239b8f8emr9500004pjc.4.1706049617331;
        Tue, 23 Jan 2024 14:40:17 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id qc12-20020a17090b288c00b00290a26531f5sm4882355pjb.7.2024.01.23.14.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 14:40:16 -0800 (PST)
Message-ID: <e785d5df-9873-46ab-8b8a-7135da6ed273@kernel.dk>
Date: Tue, 23 Jan 2024 15:40:15 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: enable audit and restrict cred override for
 IORING_OP_FIXED_FD_INSTALL
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, audit@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>
References: <20240123215501.289566-2-paul@paul-moore.com>
 <170604930501.2065523.10114697425588415558.b4-ty@kernel.dk>
In-Reply-To: <170604930501.2065523.10114697425588415558.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 3:35 PM, Jens Axboe wrote:
> 
> On Tue, 23 Jan 2024 16:55:02 -0500, Paul Moore wrote:
>> We need to correct some aspects of the IORING_OP_FIXED_FD_INSTALL
>> command to take into account the security implications of making an
>> io_uring-private file descriptor generally accessible to a userspace
>> task.
>>
>> The first change in this patch is to enable auditing of the FD_INSTALL
>> operation as installing a file descriptor into a task's file descriptor
>> table is a security relevant operation and something that admins/users
>> may want to audit.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] io_uring: enable audit and restrict cred override for IORING_OP_FIXED_FD_INSTALL
>       commit: 16bae3e1377846734ec6b87eee459c0f3551692c

So after doing that and writing the test case and testing it, it dawned
on me that we should potentially allow the current task creds. And to
make matters worse, this is indeed what happens if eg the application
would submit this with IOSQE_ASYNC or if it was part of a linked series
and we marked it async.

While I originally reasoned for why this is fine as it'd be silly to
register your current creds and then proceed to pass in that personality,
I do think that we should probably handle that case and clearly separate
the case of "we assigned creds from the submitting task because we're
handing it to a thread" vs "the submitting task asked for other creds
that were previously registered".

I'll take a look and see what works the best here.

-- 
Jens Axboe


