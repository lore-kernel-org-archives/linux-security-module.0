Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449928F8
	for <linux-security-module@vger.kernel.org>; Thu, 22 Feb 2024 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560219; cv=none; b=p+gJJUNoS6z7Lu9K9G/sPA/S09iPnsyHxzD1gz6PQy6yzyVmC5yKilEctOllAIAt5zONzz4D9A/W7odkmy4auMoXwS7insWv7W0Jgb6oObFr88DLAZ6aznONXcm3GGw5Mhb6he8i71kTtrc0HKJZKADodqONVjSoILO+OyLX7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560219; c=relaxed/simple;
	bh=CUHAvM9TBOBSGIeXrGaqW9poJoi3l306rHYdGLQmack=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=s9grFne0GtTyN2Q6Um/X/doq2CwkA4gC2Z39sPTEtepi9m6MNk9Xu6EaNxRxdb0mbhuPm4FiC+4Qv/QNoc76hjML+n85EviQc9HVG68llCsyvYiAKeO8cXoyvDPCU4x9nY/Oa0+JyssZF7GBFS98jzdrS4oSEJD+Nc5w7SC3f0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HMjGNXyK; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HMjGNXyK"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2f12059f4so3615101a34.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Feb 2024 16:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708560215; x=1709165015; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KUJ35hEQ/dpB50QPavQbMY8BuIMgUZWkF4Rx+INF3EA=;
        b=HMjGNXyKkz8vE+w/qqACWEzKUdKfNMiEOd6/16fLa3Uknj7b+b3TkxuvvfyRHODZF6
         kwv7BipGGe/dk5CoWf4nbZx1JchXGV26is20bUZt7v0oKPV/LkcQFU+CLvVO27la/140
         KS93fe/X+V5NrAUunCc10rglAPjltC2kMHFgMi0LwBkE7LZtDBJLIHaSNb91MdBQBxbt
         CtH551fO1ec9fB1OfvP9qqzL/I0/lFIKrPiLxghGxTFr3CSsKfqzQcxV93wrOQDKf+IC
         FVya05pooWajPet0UKz+gLfYspckuZAfveYkbm6LpVvikVu60lP9QOE8hmppKsf2+q2x
         0NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560215; x=1709165015;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUJ35hEQ/dpB50QPavQbMY8BuIMgUZWkF4Rx+INF3EA=;
        b=rBX9fqo1P16pZudRSPnJxL7ptxOXJ1lBSZDv2zxyIvQEWUZC1YZnD10oGEF6kbfArF
         JHjChX2YrSMBmxpIZa5n1ag82gRddle8ZnQ+qdXLrGQeYJ/CEOAQuvPmpkcmEulzjqV7
         h7z4B2LnEsbHnuOoTcY9uEwFBGwvzL75e03/fKiUIZSkOfRu/c/OGahXCZWROQSbGeH4
         8Cy7/TLQI6tVcstrm7VRxQS+ffd+8zx3KQdyhUhSckhHK8tRavTTj7EJD/AsAnL0lZNF
         L6hZyRejkfBfUDHt8+EpDgFfvQMc7clkV20S6rK2CtXZ1eXJwyQnD1wV1Mq5SbcHaswB
         ynew==
X-Forwarded-Encrypted: i=1; AJvYcCVn5eEeqSt1Xcmwil3uibgjJgM7flb8OFhdybbOKWTl2aFttFTP8TR2xgekf4w7CtEpp2Sz+rS3hB2k1xDgakdO4Db/pu3BIBrXj5k1ny8KjWp16W4l
X-Gm-Message-State: AOJu0YwalgzH6/rrm0zd1QDGWgX58DXJdPXQDGpT8Nf2UBF7i+XGtGOE
	QEa7LBWlXBe0ctOCLl/faXEp8rZV2Lsej4fyxfVuUxyI7MVv3oeL4Z/DbbX71g==
X-Google-Smtp-Source: AGHT+IHLyOG4MwwtHs06DLmn5fZMM7YdjPSbb/US79bK/6ILGjHlbvPthFQhi3Ojtpg+Ahhrbn6S/A==
X-Received: by 2002:a9d:4814:0:b0:6e4:3247:8244 with SMTP id c20-20020a9d4814000000b006e432478244mr18197851otf.37.1708560215346;
        Wed, 21 Feb 2024 16:03:35 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d9-20020a05622a05c900b0042ddde7c415sm4856546qtb.9.2024.02.21.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:03:34 -0800 (PST)
Date: Wed, 21 Feb 2024 19:03:34 -0500
Message-ID: <86532a709c172423ea200c1cabffa9f3@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Pairman Guo <pairmanxlr@gmail.com>
Cc: jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Pairman Guo <pairmanxlr@gmail.com>
Subject: Re: [PATCH] LSM: Fix typos in security/security.c comment headers
References: <20240217133504.4534-1-pairmanxlr@gmail.com>
In-Reply-To: <20240217133504.4534-1-pairmanxlr@gmail.com>

On Feb 17, 2024 Pairman Guo <pairmanxlr@gmail.com> wrote:
> 
> This commit fixes several typos in comment headers in security/security.c
> where "Check is" should be "Check if".
> 
> Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
> ---
>  security/security.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
