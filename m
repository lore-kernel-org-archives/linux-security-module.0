Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CA2C6B6
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607964; cv=none; b=ba1rElJYJu19043GOYm117kmUZM9K/9FV87cH+MQ8PSJcrY/0biTIJI3e5RwySBbK9Wu4DJwTGtjG+cV5wp5esNwK+zLucVlJh+3xZbNuho6PLxosAXzMwj4PS2zgjFYUCcxCfXKj7SfwOpcJW9lQ9KjojDdS/TLLxXFBJuaYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607964; c=relaxed/simple;
	bh=iM/Zrr6xg5+bDVZfSFnEORtiFT+7aRXqsnR+cnaan98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDYhHLm+F9ZYchWHJ1sfbIo8wZGpTleQSqvQiUYQf8DPuDD2Xco/CwqICQkq8YXO6hB1GMezNPT49NkduNyPB1hIBOa0/6h1hZROPf8wtwahK94+pOSqE78hrhIsbI2cEbH2kmXEyuKN8wQ7ftFQ2Vc4Epa4a2Ws1bNV3KhyXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oZfORKNH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZfORKNH"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-515a86daf09so689856e87.3
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 23:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711607960; x=1712212760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqD6QFkv4RcPR01vWVUf1wMB4qAMJiEap/VS8LtfkEg=;
        b=oZfORKNH2WFA7aM0WqvWbeFYIug6TpgxrzFUXjnjv9MOq9lorH5F+9Dc3DgsHlMkBq
         PNWZm2xP++LJzPeLnn5jCjmCPS8BFSjRTbfVTZsBqw3bA55uOiWWZT3+T+LSJ7zSpkCc
         zTgbf7LRNKi5lR1DfppJ3ciiAEBOwHqgXwS59CV+44oeoRbu2rtRW6Rv5rSBw/SplwUS
         nzcWudALQVXE0Jr19T6gxRNXJ0WASTDN+KdKp709HnA0U9DVTvwZcLDyXi0s8NRbGavr
         p0GDdSjbu5O/BOXasa5KgZ+k+b183zfa7mNNTVtQADdPA71mAOShbRA4hSPwzgbSShJu
         SpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711607960; x=1712212760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqD6QFkv4RcPR01vWVUf1wMB4qAMJiEap/VS8LtfkEg=;
        b=w8HrzWMumPBDRyyJGbKY2/oLyelILioeRTHYNDg/2U2JZcd4/KhUiTQevgEhWbB7FK
         hfMxIyXB9x+JcMT7t4SIX8mTPZy9kcAncY/LvTIatWMLYJ+kYR0WyEBYA8HtuCaSV88c
         +RlygXxVivKFOfNNkReUd669HEdfQCwNlVNsv/guHUa7yt6PFO0i4aCh+Eb12KR1u8/2
         pzeE/7n2OVvgF3R6wjHAhljgqi+KnGdA0Y5BvO4waw5iv91PpX85h8zQUeLTWPT3RGmg
         4PfqXxSRTmilqVRtphOJ/cbdqex110Q+xxftnEkKUWKq4a8I6YgyfCo4gBIJeUfrVVHg
         QL2w==
X-Forwarded-Encrypted: i=1; AJvYcCUGt+uR7uKhc1JZXn+oMfR/VeVaO8QVLCOSYXsJZ1lTk/NqKcj2mYWSTGi58mzL1WAXOav5G/Zo9f8JC6Tqt0m2ZdKSumSe5OxHgDplCkeWtMHKZTEx
X-Gm-Message-State: AOJu0YwWaXZ0FgUiyiXaAK4HGf3ZUhSEgL2cdigMMQ9nJDsdGwfzYmKN
	r25dI1x7FpE0HicrSsdduBJ1hlc7DhgRA2c+kUZKJFdL2X1dK/wYON4LixINQOM=
X-Google-Smtp-Source: AGHT+IHWJOoEo7pRzUGI3H9oyAn6IMRYBaACNvS/9pjMj7sskPE2i+M+a3M7zfiBUiKyrs+HJVaBkg==
X-Received: by 2002:ac2:4823:0:b0:513:9e44:c68c with SMTP id 3-20020ac24823000000b005139e44c68cmr1172033lft.6.1711607959469;
        Wed, 27 Mar 2024 23:39:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fd6-20020a056402388600b0056c53ea5affsm217009edb.77.2024.03.27.23.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 23:39:19 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:39:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <dfa6ddcb-9a2d-49ac-90b7-bb30b23e32c4@moroto.mountain>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Thu, Mar 28, 2024 at 04:55:57AM +0530, Ayush Tiwari wrote:
> Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> struct landlock_object and update the related dependencies.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

Is there some advantage to doing this?  You need to re-write the commit
message to give us some clue why you are doing this.

regards,
dan carpenter

