Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5E3A2540
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451643; cv=none; b=FRNkQJUXi3EVOrpWuHDCtHhvhwZkn1KApWpELdXPsAKgPj0aBh3Edoag711YK5xyi/abHx3PujAwg44x23deXoLIAlWClySX3KedhCB+//2TSJnoZB1cLsDZ/EcI4t8WEmkeMQfEAM7j3TBygDfQ06r5udOZHPeD11JG/Kmm+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451643; c=relaxed/simple;
	bh=Q0yebGwL8eWx1vNOrVrrq1jpOqA3B/QDaiR5qfl5as8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=CsFbgv8eVh8LJU+KL1Fk0DpFOI6OygIZpUrVIy2bmcB6kzR+d0bKpWSksUUkHr74iQExJFTA0qghJ3vkFQVnNK/fbxUMwyBap57GpSzOJohZUG4iZ6bpxGCBjm4xcfH3iM8fs7Eueqgf9H2nWinxvoDoz9OFwkh9olvx9FAqdik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GRmR70lc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GRmR70lc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9217d13c276so1685085a.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783451640; x=1784056440; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGfDZeEdLGeen0qW0nrFDO6a/FMS/fYRJh5VUHrysIk=;
        b=GRmR70lczsMV8NilnhewKXlOJqrtkmcEsfcu7rEYi/zAiio08xkrPeUoHb+AtS3hBj
         nRqAIsGV6+YyHkJdFC3WSFGvSUSaVLzkxykuPo48EOiGPQchnS4bHoZAWl5vtFQOyt7b
         65IHe3/lIwhc2Q4acrnQNwGT9uoaN03byQY+zthYe92pvfuzZXTzOPDhKrofQy2kMd6L
         RmQ1p3NCvrEJgPQmvqmSKCr4148hqTcMIHI7vn0fW2QdHoKkzN1UCFj2r6hGSECBzTvj
         qI9n/CGjHFKLFjc/j6Y3KvEjoZF33Cvkf1RA0x7iDW5ezyuaIZ5rpXbJ4cgP8WVpO3Az
         bwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783451640; x=1784056440;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGfDZeEdLGeen0qW0nrFDO6a/FMS/fYRJh5VUHrysIk=;
        b=rKGKmeL6OjaTv2lddpZazk+INge3AExgeLBSG+sqRQ9IA+NA9VRm0V1CT7aIn/Plzs
         co1jh2Ri1v07CxqqOeIzbQrSmZf7LhfPBRSTUlXqr/E/tJY3+3WpxRNZCRv9Yocw2AJJ
         1KLcwvZdGPmfr9Kgz0sYPntD6rSHBJGIdw9n4aC09kgqX0cvbimwvITXw4dL5JTefSYP
         09o+0WOTtLGt1kGMY9juVLfGFNlwDyspeevjKKOITq/sm3gNsaup7kY4bqi+cM0Uq+9F
         kdQxbek9rkpTSMaMrhG3rr/82AFLanuQI5NZf/1rEV1GrBP4NLEg4kcGiimYw9dUR1Xo
         EHAg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq7qG4UD8v8m73s0MkgwwUFa7Lh+0eu1XcnHuTZufPmIw46+6TGFEUoBqQ0wyA4ekkpix+GK+AYnEyki8FR5I5Y9xUj/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfShGb54E7befntvAEywpCmIl+l+kAObECk4VdJ23aAm38VLRg
	t4IpaAm6P0Osh2F5GRyWP+HoUYDTT+MERv8RFGgWUxXxKw+Qh/oi07Byj8HT4UzpQg==
X-Gm-Gg: AfdE7ckygtlz3/zzfu7a/PuFqeCBt/pO6Bj3VzzpSSpPPZZzb6Gk/FgPf0lI8dLYqi1
	itHqAqrYiqTapWghQORTGjA0Q42HrO1F+QRPpYoMABQ0MEQJ8p/cbB+HYVVJEj8VDfnqH1e9peB
	KEyMO1t24TdCasDPvEEmTQ+mYBD3I3cxQLTgrncsz3nN4c+iimt/WvaTl6mh8lNMo/MJ3Bs7Hpa
	wJm4vTZnd0xraA/k+p3JwFW5ldgY7WWNSNoHdQUf5Z5Wu/YxBxg8wUPgKiIpKtpjVmg+dXJufAh
	op7I/+Q5OlZm0tbUJMnfTWbqERnIJTxaCuI2Ew8GRv+z4lMuCu6j/V7Wa4WT1M9SFVj9pNsIynM
	2FrU9LdQI5gofKG3gtCg00PJ226g+Uac4kopp0Qh7qEsvPgv6o/dPXCiq6imH3H+BOlqtz+97nN
	l+DLT2/Hb6axWhpXM4s5cEDieMCvcKxE0ZtvtO93u1DLa67/AXRdO4LxeuYA==
X-Received: by 2002:a05:620a:4515:b0:915:7fe4:cac5 with SMTP id af79cd13be357-92ebb57dfcbmr743131685a.49.1783451640236;
        Tue, 07 Jul 2026 12:14:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba4209sm1318251385a.12.2026.07.07.12.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:13:58 -0700 (PDT)
Date: Tue, 07 Jul 2026 15:13:58 -0400
Message-ID: <14023e3368d98072f369e6fe1607c7d5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260707_1504/pstg-lib:20260707_1258/pstg-pwork:20260707_1504
From: Paul Moore <paul@paul-moore.com>
To: Wang Yan <wangyan01@kylinos.cn>, bill.c.roberts@gmail.com
Cc: casey@schaufler-ca.com, jmorris@namei.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, mic@digikod.net, serge@hallyn.com, shuah@kernel.org, wangyan01@kylinos.cn
Subject: Re: [PATCH v2] selftests/lsm: Fix memory leak in attr_lsm_count
References: <20260703120951.1622491-1-wangyan01@kylinos.cn>
In-Reply-To: <20260703120951.1622491-1-wangyan01@kylinos.cn>

On Jul  3, 2026 Wang Yan <wangyan01@kylinos.cn> wrote:
> 
> The calloc-allocated buffer in attr_lsm_count() is never released on
> any exit path, including both the normal return path and the early
> return when read_sysfs_lsms fails, resulting in a heap memory leak.
> 
> Add free() for the buffer on all return branches to fix the leak.
> 
> Fixes: d3d929a8b0cd ("LSM: selftests for Linux Security Module syscalls")
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
> Reviewed-by: William Roberts <bill.c.roberts@gmail.com>
> Tested-by: William Roberts <bill.c.roberts@gmail.com>
> ---
>  tools/testing/selftests/lsm/common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Merged into lsm/dev, thanks!

--
paul-moore.com
