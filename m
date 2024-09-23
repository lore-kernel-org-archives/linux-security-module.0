Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806579CC
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121219; cv=none; b=RBsxeAKjh/fmyMfxHQCViY7p5B/fYWj8od3Jxsj3xNgY8Y6fJHqxBAzZOiqOcARRG75qiA6YuHBIKmUGDxYgbC6RBgSreyXlSp9jNizObTMWW94xga+2jpf1Ur5q9JxomhPe49fVnupJZovhVS9ndQE0DYWVAoA1YEg3wvK7/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121219; c=relaxed/simple;
	bh=deZIlRwr9MjW6pszPZG0mminhXw8RdDxiI4OqxAaV/I=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=dJwHD6EqM9V1y521BArmrcLZaRONBkQCxTDu/gPysH8qAfbG2Nd+0fd4s4y33DNAaZp71c3RYe5SHcGuEPqZ21kiNgsbptdic7PgGRUeVOO0GHOSF8TVBtv8AGltMGHPGd5dRE4eq2nbfHA9Rgw288Fa8ae6r2vBTnS579/oO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TCOra/PQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TCOra/PQ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c51d1df755so39012826d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727121217; x=1727726017; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MH/lfr64odg7IIk5zQ7fDXQq/NRQz0Gg/qhKBjs5LKY=;
        b=TCOra/PQhC/9eYKxw753y8/o6IYBUr/5af9/aZnK8xYgglX9DM653Qx+WxM0Ph8FgL
         v0u4dfW+lUUGpZT51HhQwFF/FiSX95mKj90GQozvWg+ZypX5269OIdUocsEPXRbjPjHz
         8hF4tnHFQyVNPFnEXDG7Dofa4t+76aXi4JePIGe1Kaur8M/D8i5p2qd+hry3qVAgLGl5
         cgBwxK+8x7RkxCPDAWbnwzo7/EaiuNuUALkV9RAmrNIYQf0gi4RQz0lgwuTrGGsC3AZh
         3+yp4ghBpyQEJqmYSPvKth5mjvsbaumz8JuNZ+11pL4lnwnbyRSyYWhLqdc7tCNzREQU
         rEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727121217; x=1727726017;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MH/lfr64odg7IIk5zQ7fDXQq/NRQz0Gg/qhKBjs5LKY=;
        b=rXtaw7OC0yIl7GvMaPem64NvEr3fZjA8G4Ra4m7aaHbXqcyC+pF9Es6/53cjCekXkE
         DrL9BTqU76HKOXK2sDEVleCQKT6qtCK6Kiklhqj8zPc2vqONcCW9otroTi9tcrObIoGU
         liOXnU9cVt7o/MLisajtqAPPEld7etHTGm/pxu5dDDt1xYpluRZN+Rj64FeQfklmVIHr
         Vnt5lQUJQFpO/b1VoD4kY/B6nyVAX1zwH87x9M+AddZU2o/3gdL3hz0KoQwBDscQ5lf/
         uDnxFls9XYz+IzMaNEQXoNvUI7KGFlPDDYJ4PP2tFsZy2gLDV6FMR/qWlcrvJpAVWZnp
         zh8g==
X-Gm-Message-State: AOJu0YzNud6EQJc046fE0wTa00eFXbAvTnjgKw4kSfUcXpi3QUfzXBxM
	uVvS9HEG2uLnGYtfNd1ujVprbea4ioyw+6JD3vNfirwYnWxsqwHhVjp8idnZ/A==
X-Google-Smtp-Source: AGHT+IHFW9xNBvbhiH5cDVb1FY/rbkAnvM+MZRpocjHqsvJoehxzGmbLycvHKjogmurwT6GvBm1Bew==
X-Received: by 2002:a05:6214:5f0c:b0:6c5:b886:ebe8 with SMTP id 6a1803df08f44-6c7bd59d816mr179462856d6.38.1727121216850;
        Mon, 23 Sep 2024 12:53:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e586b42sm50380286d6.138.2024.09.23.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 12:53:36 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:53:35 -0400
Message-ID: <9ea74820c1d8524319692483583546d3@paul-moore.com>
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
To: Guenter Roeck <linux@roeck-us.net>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH] ipe: Add missing terminator to list of unit tests
References: <20240922145226.491815-1-linux@roeck-us.net>
In-Reply-To: <20240922145226.491815-1-linux@roeck-us.net>

On Sep 22, 2024 Guenter Roeck <linux@roeck-us.net> wrote:
> 
> Add missing terminator to list of unit tests to avoid random crashes seen
> when running the test.
> 
> Fixes: 10ca05a76065 ("ipe: kunit test for parser")
> Cc: Deven Bowers <deven.desai@linux.microsoft.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Fan Wu <wufan@linux.microsoft.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Fan Wu <wufan@linux.microsoft.com>
> ---
>  security/ipe/policy_tests.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, merged into lsm/stable-6.12.

--
paul-moore.com
