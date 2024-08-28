Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1084D0D
	for <linux-security-module@vger.kernel.org>; Wed, 28 Aug 2024 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819279; cv=none; b=pbYrYvgzquAFI7FkELe/yMIhwLyjB8yB0tdyblHiDBhyvSEpU3IiMV2GMv7eaWCCVGNvvVcCwIACtvL2gHdPA6lEIVDmkDtPXKyBXktw9vpS4kqKEtpNs5v5l3SLqGhNthE7BeI7a66DAlaJBpIzlJ9jqaI2D+MOPvezlQHHOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819279; c=relaxed/simple;
	bh=ZlMPopBn96w/wp5PbfqgFb+71Z0K3fsuwD0T/IVa/dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLvSLYuiZZ83NmyT2/qbL7vO1EezkT2JDKx18yM4QxiGe/zaemz9tbD3A0atsWfqy1mynhOA5eHn6IL4Q6u4T83syzYz7Jcw8vE4Ipdc0yrzXw20Hg8NMQLhzf0WVUq/h3XrLpdnBrv9TLH6tmF5NPLvO8PcvyhZRlEs35SJbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JpRRRx5g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JpRRRx5g"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-202146e9538so56487965ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 21:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724819277; x=1725424077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLKoOoZWQgRDxe64D4pf1IqVkTX7eHcZrMx3Ug8cC6Q=;
        b=JpRRRx5g8vSG59bMgJ4mGDXeMZitcUwBZWvB1l3NDpPuQiktdM7AsVtpzQto7+9Utt
         +3MQXRDIbUcK62u/2WZxK+WQCFF7KAeicFrt6vTJPBofb+wulTyr1WMC7J77+T7stfU9
         rzGhHduaRZPigEAOShpGhUOfYm/1zyP3fvFzOFCCfzbYup5/9bLPYCBMVrQX9xDdhOO+
         MpCozZqkN0XIvXlcB1v+VGbWZB9nHg/lWGRP20dQyyPijNMvwm0+RKK3xfCjM4n4Al8y
         xF51hmIjxX66DdadStbF50XfcJdqgWx6GCMfLGfHRONqt8g7d3wBld+HIRA+CQxTaMF1
         N3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724819277; x=1725424077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLKoOoZWQgRDxe64D4pf1IqVkTX7eHcZrMx3Ug8cC6Q=;
        b=O+XaPHpvKd0yuVTXzU4nBINqmrBkO1RrdBaofnXSZIuyTA88j0RGXUJ3I3mbJaWCVS
         gNdX4GiADQDGsUvE1FjcOQadRiKSupHNwkzwVqIHfJX3x48G3i4hQO3/h0TXNCXEKvNr
         84HaYmRo6fZrM+22NebaJtBgBt5G6v5TNB/pI10nUhKZsovQQYPE/7i8eg3R+xpUDLSi
         KzwRdc1b9PH6Nx5Y5rWsCiffRkAmLXAaBy6NhWHL33oSgKvJIx+50PygG9v32RTA3E08
         BAF+UpGFqOdASpGJM2f23qYx3ySlNaDi/qV2LYWw8M/Um0QASzICPjOHzWKdUmimlhen
         V6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVSSGZRoonpZ8zC/Sg6fnodjX8dS6acDOPZF6nbh0jvBndSdOMtpUUjfxe6ppdCXgLk/8Gx7mjYFBig2i18NefjHmL028w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYUk3coIQlYw4feZ84HaafDQ9rWYHCxklDmyTNJCp5UxxAJqE
	+66lJcnueeO3uoOCD+fzRKVIUZJOOsIkzwhGbewhAGCXgHhGrSPV/3zIVVSm9Nw=
X-Google-Smtp-Source: AGHT+IG5A/pCpM7IMY/kGxijzm+NVIWr1BVWJeft0Hf7TZAyR5DmmphX2dEVoYsNjBgMuW+9RUOLcQ==
X-Received: by 2002:a17:90a:cc14:b0:2cd:40ef:4763 with SMTP id 98e67ed59e1d1-2d646bcc060mr16030603a91.15.1724819277264;
        Tue, 27 Aug 2024 21:27:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445d8afdsm469664a91.2.2024.08.27.21.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 21:27:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjAHh-00FKuw-36;
	Wed, 28 Aug 2024 14:27:53 +1000
Date: Wed, 28 Aug 2024 14:27:53 +1000
From: Dave Chinner <david@fromorbit.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <Zs6nSe1cwmoWu5RD@dread.disaster.area>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827014108.222719-1-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> Many mainstream file systems already support the GETVERSION ioctl,
> and their implementations are completely the same, essentially
> just obtain the value of i_generation. We think this ioctl can be
> implemented at the VFS layer, so the file systems do not need to
> implement it individually.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Nope. No. Definitely not.

I definitely do not want unprivileged users to be able to construct
arbitrary file handles in userspace.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
