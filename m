Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A918627
	for <linux-security-module@vger.kernel.org>; Sat,  2 Mar 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395291; cv=none; b=Bs1LojGQEFMP47yKxCT8iUwFBrz0ZL1hv/RvZ72ndhPpKrWaGuNgDk0+k49HSQ77rEPUwnlQBri21mhBxMP3vgFTCAkKgYUi/UzBucFAK9fWEophGIP4XaZGoU+IVNdtAi+u1Od8pP23B0eqoRJIUXhcHv17Y/BynZBcEtRDoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395291; c=relaxed/simple;
	bh=LFiAtGjubDWpNLUQxtbJ/E7SHByKNPAdC4jbSr77kCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbo7frBjrrZjhw3+C/zO5Qh2qadX27AC7q7z9VbIKVDiQtR2rPfGlp/o+q7o8VOkee31q1pbjCygbVZlrKmno5Prb9ra1sgT6xNYx70iuD5TcmXZDFpDsBXvfaDHGpUTmOYgG2uGbSjbD54sSgjbWAzgHqS4CtTkCHy0Dly1rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68f9e399c91so24601936d6.2
        for <linux-security-module@vger.kernel.org>; Sat, 02 Mar 2024 08:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709395288; x=1710000088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XenCVyPUGE/ocH2LizUOZPuh6vZd/WYCNYixpMDiLyI=;
        b=ktSXyI9oTTwUMexAJNzDeq+QxVx89weWP6m9jpD0pZICVu/ENuswvaoHe7P89h0pTN
         oquWeIbDiIU2Fe1Yj07Rsm8Fa3MO53adT6iOIX3sMxqYg+AYyuuw7IAeWulsasQn7zAK
         6F2QbT4bu42yqQJsU7WEx7ULBOfN0lzIAPXAOSxgK0bvT5qddulq0XgITmZ9ojXN1lWF
         MarsI05OWF2nNqY0CRrJLfkfscWQc56poYzNN6AhZDHBtvLEv+rz3n9ocpfEaeDEdm5T
         oAl4zotemyrgl0XIeacu75I5N5YBRWom4VhmvCdSAq8aqbjZrtpjl47RaMVX3gSTh+4h
         98lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3XOMHCjCcdIUWTkzrpKBqR7DkECRwkkvNXj8VjRSsNxZniIA8K+OAqHRtwJTv9O6FJ0M3hS/fK6pqMXYeUJDWISXlnYLseBfUNuI99rpO6mm9HUj5
X-Gm-Message-State: AOJu0YwKtTk2FyxlRjWcAuhPSAk/61tB/aaiHUR3ed0PyY5tPCYPnOZZ
	mVtL+s2e+nBHvOv0XqdidUhrfw8ZPO45dMtbFtAp+lCHxU/sQ9oZESh+ssJNjw==
X-Google-Smtp-Source: AGHT+IGzvxitZoqsBYuFgO2HzG9/T+9mfzbc+Y/oQjpPYffJx1lNgpS1DLq5H2YZNnh++/V9NyR/5Q==
X-Received: by 2002:a05:6214:57cc:b0:690:6b94:67fb with SMTP id lw12-20020a05621457cc00b006906b9467fbmr9186qvb.21.1709395288340;
        Sat, 02 Mar 2024 08:01:28 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id me19-20020a0562145d1300b0068f85706ecfsm3064940qvb.104.2024.03.02.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 08:01:27 -0800 (PST)
Date: Sat, 2 Mar 2024 11:01:25 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
	axboe@kernel.dk, agk@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v13 12/20] dm verity: set DM_TARGET_SINGLETON feature
 flag
Message-ID: <ZeNNVWxkhki8lX55@redhat.com>
References: <1709168102-7677-1-git-send-email-wufan@linux.microsoft.com>
 <1709168102-7677-13-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709168102-7677-13-git-send-email-wufan@linux.microsoft.com>

On Wed, Feb 28 2024 at  7:54P -0500,
Fan Wu <wufan@linux.microsoft.com> wrote:

> The device-mapper has a flag to mark targets as singleton, which is a
> required flag for immutable targets. Without this flag, multiple
> dm-verity targets can be added to a mapped device, which has no
> practical use cases. Also from dm_table_get_immutable_target(),
> it documented that "Immutable target is implicitly a singleton".
> 
> This patch adds the missing flag, restricting only one
> dm-verity target per mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

FYI, I have picked this one up and staged it in dm-6.9 and linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.9&id=9356fcfe0ac4a8545f9fc32f2e404524e1115ee6

Mike
